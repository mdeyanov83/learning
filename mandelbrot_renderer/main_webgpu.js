// webgpu-fractals.js
// Reimplementation of your WebGL2 Mandelbrot + Julia demo using WebGPU (WGSL shaders).
// Drop this into a page that has the same DOM elements (main-canvas, julia-canvas, etc.)

// ---------- Utilities ----------
function showError(errorText) {
  const errorBoxDiv = document.getElementById("error-box");
  if (errorBoxDiv) {
    const errorTextElement = document.createElement("p");
    errorTextElement.innerText = errorText;
    errorBoxDiv.appendChild(errorTextElement);
  }
  console.error(errorText);
}

const quadVertices = new Float32Array([
  -1.0, -1.0, 1.0, -1.0, -1.0, 1.0, 1.0, 1.0,
]);

const MAX_ITERS_MAND = 1500;
const MAX_ITERS_JULIA = 250;
const MAX_ZOOM = 1_000_000;

// ---------- WGSL Shaders ----------
// Vertex WGSL: outputs uv (0..1) and positions
const vertexWGSL = `
struct VertexOut {
  @builtin(position) Position : vec4<f32>;
  @location(0) v_uv : vec2<f32>;
};

@vertex
fn main(@location(0) pos : vec2<f32>) -> VertexOut {
  var out : VertexOut;
  out.v_uv = (pos + vec2<f32>(1.0, 1.0)) * 0.5;
  out.Position = vec4<f32>(pos, 0.0, 1.0);
  return out;
}
`;

// Fragment WGSL for Mandelbrot. Uses two vec4 uniforms:
// u0.xy = center, u0.z = zoom, u0.w = iterations (as f32)
// u1.xy = resolution.x, resolution.y
const fragmentMandelWGSL = `
fn hsvToRgb(h: f32, s: f32, v: f32) -> vec3<f32> {
  let c = vec3<f32>(h * 6.0, s, v);
  let rgb = clamp(abs(mod(c.x + vec3<f32>(0.0, 4.0, 2.0), 6.0) - 3.0) - 1.0, vec3<f32>(0.0), vec3<f32>(1.0));
  return c.z * mix(vec3<f32>(1.0), rgb, c.y);
}

struct Uniforms {
  u0 : vec4<f32>; // center.xy, zoom, iterations(as float)
  u1 : vec4<f32>; // resolution.xy, unused, unused
};
@binding(0) @group(0) var<uniform> uniforms : Uniforms;

@fragment
fn main(@location(0) v_uv : vec2<f32>) -> @location(0) vec4<f32> {
  let center = uniforms.u0.xy;
  let zoom = uniforms.u0.z;
  let iterationsf = uniforms.u0.w;
  let iterations = u32(iterationsf);
  let res = uniforms.u1.xy;
  let aspect = vec2<f32>(res.x / res.y, 1.0);
  var c = (v_uv - vec2<f32>(0.5)) * (4.0 / zoom) * aspect + center;
  var z = vec2<f32>(0.0, 0.0);
  var i : u32 = 0u;
  loop {
    if (i >= iterations) {
      break;
    }
    if (dot(z, z) > 4.0) {
      break;
    }
    let zx = z.x * z.x - z.y * z.y + c.x;
    let zy = 2.0 * z.x * z.y + c.y;
    z = vec2<f32>(zx, zy);
    i = i + 1u;
  }
  let norm = f32(i) / max(1.0, f32(iterations));
  let hue = 0.66 - 0.66 * norm;
  let color = hsvToRgb(hue, 1.0, norm < 1.0 ? 1.0 : 0.0);
  return vec4<f32>(color, 1.0);
}
`;

// Fragment WGSL for Julia. Uniform layout same as above.
const fragmentJuliaWGSL = `
fn hsvToRgb(h: f32, s: f32, v: f32) -> vec3<f32> {
  let c = vec3<f32>(h * 6.0, s, v);
  let rgb = clamp(abs(mod(c.x + vec3<f32>(0.0, 4.0, 2.0), 6.0) - 3.0) - 1.0, vec3<f32>(0.0), vec3<f32>(1.0));
  return c.z * mix(vec3<f32>(1.0), rgb, c.y);
}

struct Uniforms {
  u0 : vec4<f32>; // center.xy (used as julia c), zoom, iterations
  u1 : vec4<f32>; // resolution.xy
};
@binding(0) @group(0) var<uniform> uniforms : Uniforms;

@fragment
fn main(@location(0) v_uv : vec2<f32>) -> @location(0) vec4<f32> {
  let c = uniforms.u0.xy;
  let zoom = uniforms.u0.z;
  let iterationsf = uniforms.u0.w;
  let iterations = u32(iterationsf);
  let res = uniforms.u1.xy;
  let aspect = vec2<f32>(res.x / res.y, 1.0);
  var z = (v_uv - vec2<f32>(0.5)) * (4.0 / zoom) * aspect;
  var i : u32 = 0u;
  loop {
    if (i >= iterations) { break; }
    if (dot(z, z) > 4.0) { break; }
    let zx = z.x * z.x - z.y * z.y + c.x;
    let zy = 2.0 * z.x * z.y + c.y;
    z = vec2<f32>(zx, zy);
    i = i + 1u;
  }
  let norm = f32(i) / max(1.0, f32(iterations));
  let hue = 0.66 - 0.66 * norm;
  let color = hsvToRgb(hue, 1.0, norm < 1.0 ? 1.0 : 0.0);
  return vec4<f32>(color, 1.0);
}
`;

// ---------- WebGPU Initialization and Helpers ----------
async function initWebGPU() {
  if (!navigator.gpu) {
    showError("WebGPU not supported in this browser.");
    return null;
  }
  const adapter = await navigator.gpu.requestAdapter();
  if (!adapter) {
    showError("Failed to request WebGPU adapter.");
    return null;
  }
  const device = await adapter.requestDevice();
  const queue = device.queue;
  return { device, queue };
}

function configureContext(canvas, device, format) {
  const context = canvas.getContext("webgpu");
  context.configure({
    device,
    format,
    alphaMode: "opaque",
  });
  return context;
}

// Create pipeline for a given fragment WGSL (vertex is shared)
function createRenderPipeline(device, format, fragmentCode) {
  const pipeline = device.createRenderPipeline({
    layout: "auto",
    vertex: {
      module: device.createShaderModule({ code: vertexWGSL }),
      entryPoint: "main",
      buffers: [
        {
          arrayStride: 2 * 4,
          attributes: [{ shaderLocation: 0, offset: 0, format: "float32x2" }],
        },
      ],
    },
    fragment: {
      module: device.createShaderModule({ code: fragmentCode }),
      entryPoint: "main",
      targets: [{ format }],
    },
    primitive: {
      topology: "triangle-strip",
      stripIndexFormat: undefined,
    },
  });
  return pipeline;
}

// ---------- Main ----------
async function main() {
  // DOM references
  const mainCanvas = document.getElementById("main-canvas");
  const juliaCanvas = document.getElementById("julia-canvas");
  if (!mainCanvas || !juliaCanvas) {
    showError("Cannot get canvas elements");
    return;
  }

  const gpu = await initWebGPU();
  if (!gpu) return;
  const device = gpu.device;
  const queue = gpu.queue;

  // choose preferred format
  const format = navigator.gpu.getPreferredCanvasFormat();

  // configure contexts
  configureCanvasSize(mainCanvas);
  configureCanvasSize(juliaCanvas);
  const mainContext = configureContext(mainCanvas, device, format);
  const juliaContext = configureContext(juliaCanvas, device, format);

  // create vertex buffer (static)
  const vertexBuffer = device.createBuffer({
    size: quadVertices.byteLength,
    usage: GPUBufferUsage.VERTEX | GPUBufferUsage.COPY_DST,
    mappedAtCreation: true,
  });
  new Float32Array(vertexBuffer.getMappedRange()).set(quadVertices);
  vertexBuffer.unmap();

  // create uniform buffers (one per pipeline/canvas)
  // We'll use 2 vec4<f32> = 8 floats = 32 bytes (must be multiple of 16)
  const uniformBufferSize = 8 * 4; // 8 floats * 4 bytes = 32
  const mainUniformBuffer = device.createBuffer({
    size: uniformBufferSize,
    usage: GPUBufferUsage.UNIFORM | GPUBufferUsage.COPY_DST,
  });
  const juliaUniformBuffer = device.createBuffer({
    size: uniformBufferSize,
    usage: GPUBufferUsage.UNIFORM | GPUBufferUsage.COPY_DST,
  });

  // create pipelines
  const mainPipeline = createRenderPipeline(device, format, fragmentMandelWGSL);
  const juliaPipeline = createRenderPipeline(device, format, fragmentJuliaWGSL);

  // create bind groups (auto layout)
  const mainBindGroup = device.createBindGroup({
    layout: mainPipeline.getBindGroupLayout(0),
    entries: [
      {
        binding: 0,
        resource: { buffer: mainUniformBuffer },
      },
    ],
  });
  const juliaBindGroup = device.createBindGroup({
    layout: juliaPipeline.getBindGroupLayout(0),
    entries: [
      {
        binding: 0,
        resource: { buffer: juliaUniformBuffer },
      },
    ],
  });

  // Initial fractal variables
  let centerX = -0.7,
    centerY = 0.0;
  let zoom = 1.0;
  let maxIterations = 150;
  let zoomJulia = 1.2;
  let maxIterationsJulia = 50;

  // DPR & canvas sizing
  const dpr = window.devicePixelRatio || 1;
  function configureCanvasSize(canvas) {
    // Already called earlier, but keep helper for resizes
    canvas.width = Math.floor(canvas.clientWidth * dpr);
    canvas.height = Math.floor(canvas.clientHeight * dpr);
  }
  // ensure canvases match display size
  configureCanvasSize(mainCanvas);
  configureCanvasSize(juliaCanvas);

  // helper: write uniforms as two vec4s: [cx, cy, zoom, iterations], [resx, resy, 0, 0]
  function updateUniformBuffer(
    buffer,
    cx,
    cy,
    zoomVal,
    iterationsVal,
    resX,
    resY
  ) {
    const data = new Float32Array(8);
    data[0] = cx;
    data[1] = cy;
    data[2] = zoomVal;
    data[3] = iterationsVal; // stored as float
    data[4] = resX;
    data[5] = resY;
    data[6] = 0.0;
    data[7] = 0.0;
    queue.writeBuffer(buffer, 0, data.buffer, data.byteOffset, data.byteLength);
  }

  // initial upload
  updateUniformBuffer(
    mainUniformBuffer,
    centerX,
    centerY,
    zoom,
    maxIterations,
    mainCanvas.width,
    mainCanvas.height
  );
  updateUniformBuffer(
    juliaUniformBuffer,
    centerX,
    centerY,
    zoomJulia,
    maxIterationsJulia,
    juliaCanvas.width,
    juliaCanvas.height
  );

  // drawing functions
  function renderMain() {
    // update UI details (kept same style)
    updateDetails(centerX, centerY, zoom, "center");

    configureCanvasSize(mainCanvas);
    // reconfigure context if size changed (some browsers require manual configure only once but safe to call)
    mainContext.configure({ device, format, alphaMode: "opaque" });

    // update uniform buffer
    updateUniformBuffer(
      mainUniformBuffer,
      centerX,
      centerY,
      zoom,
      maxIterations,
      mainCanvas.width,
      mainCanvas.height
    );

    const commandEncoder = device.createCommandEncoder();
    const textureView = mainContext.getCurrentTexture().createView();

    const renderPass = commandEncoder.beginRenderPass({
      colorAttachments: [
        {
          view: textureView,
          loadOp: "clear",
          storeOp: "store",
          clearValue: { r: 0.08, g: 0.08, b: 0.08, a: 1.0 },
        },
      ],
    });

    renderPass.setPipeline(mainPipeline);
    renderPass.setVertexBuffer(0, vertexBuffer);
    renderPass.setBindGroup(0, mainBindGroup);
    renderPass.draw(4, 1, 0, 0);
    renderPass.end();
    device.queue.submit([commandEncoder.finish()]);
  }

  function renderJulia(cx, cy) {
    configureCanvasSize(juliaCanvas);
    juliaContext.configure({ device, format, alphaMode: "opaque" });
    updateUniformBuffer(
      juliaUniformBuffer,
      cx,
      cy,
      zoomJulia,
      maxIterationsJulia,
      juliaCanvas.width,
      juliaCanvas.height
    );

    const commandEncoder = device.createCommandEncoder();
    const textureView = juliaContext.getCurrentTexture().createView();
    const renderPass = commandEncoder.beginRenderPass({
      colorAttachments: [
        {
          view: textureView,
          loadOp: "clear",
          storeOp: "store",
          clearValue: { r: 0.08, g: 0.08, b: 0.08, a: 1.0 },
        },
      ],
    });

    renderPass.setPipeline(juliaPipeline);
    renderPass.setVertexBuffer(0, vertexBuffer);
    renderPass.setBindGroup(0, juliaBindGroup);
    renderPass.draw(4, 1, 0, 0);
    renderPass.end();
    device.queue.submit([commandEncoder.finish()]);
  }

  // ---------- Interaction Logic (translated from original) ----------
  // Zoom handling on mainCanvas
  mainCanvas.addEventListener(
    "wheel",
    (e) => {
      e.preventDefault();
      const rect = mainCanvas.getBoundingClientRect();
      const mouseX = (e.clientX - rect.left) / rect.width;
      const mouseY = (e.clientY - rect.top) / rect.height;

      let aspectRatio = mainCanvas.width / mainCanvas.height;

      let pixelOffsetX = (mouseX - 0.5) * (4.0 / zoom) * aspectRatio;
      let pixelOffsetY = (0.5 - mouseY) * (4.0 / zoom);

      let mouseReBefore = centerX + pixelOffsetX;
      let mouseImBefore = centerY + pixelOffsetY;

      let zoomFactor = e.deltaY > 0 ? 0.8 : 1.2;
      if (zoom * zoomFactor <= MAX_ZOOM) {
        zoom *= zoomFactor;
      } else {
        zoom = MAX_ZOOM;
      }

      pixelOffsetX = (mouseX - 0.5) * (4.0 / zoom) * aspectRatio;
      pixelOffsetY = (0.5 - mouseY) * (4.0 / zoom);

      let mouseReAfter = centerX + pixelOffsetX;
      let mouseImAfter = centerY + pixelOffsetY;

      centerX += mouseReBefore - mouseReAfter;
      centerY += mouseImBefore - mouseImAfter;

      renderMain();
    },
    { passive: false }
  );

  // Pan
  let isDragging = false;
  let lastX = 0,
    lastY = 0;
  mainCanvas.addEventListener("mousedown", (e) => {
    isDragging = true;
    lastX = e.clientX;
    lastY = e.clientY;
    // reduce canvas resolution during drag for speed (same idea as original)
    mainCanvas.width = Math.floor((mainCanvas.clientWidth * dpr) / 2);
    mainCanvas.height = Math.floor((mainCanvas.clientHeight * dpr) / 2);
    renderMain();
  });
  window.addEventListener("mousemove", (e) => {
    if (!isDragging) return;
    let aspectRatio = mainCanvas.width / mainCanvas.height;
    let dx =
      (((e.clientX - lastX) / mainCanvas.width) *
        (4.0 / zoom) *
        aspectRatio *
        dpr) /
      2;
    let dy =
      (((lastY - e.clientY) / mainCanvas.height) * (4.0 / zoom) * dpr) / 2;
    centerX -= dx;
    centerY -= dy;
    lastX = e.clientX;
    lastY = e.clientY;
    renderMain();
  });
  window.addEventListener("mouseup", () => {
    if (!isDragging) return;
    isDragging = false;
    mainCanvas.width = Math.floor(mainCanvas.clientWidth * dpr);
    mainCanvas.height = Math.floor(mainCanvas.clientHeight * dpr);
    renderMain();
  });

  // Iteration inputs - main
  const itersInput = document.getElementById("iters-input");
  const itersSlider = document.getElementById("iters-slider");
  if (itersInput && itersSlider) {
    itersInput.value = maxIterations;
    itersSlider.value = maxIterations;
    function changeItersMain(event) {
      const val = Number(event.target.value);
      if (val > 0 && val <= MAX_ITERS_MAND) {
        const newItersValue = Math.floor(val);
        itersInput.value = newItersValue;
        itersSlider.value = newItersValue;
        maxIterations = newItersValue;
        renderMain();
      }
    }
    itersInput.addEventListener("input", changeItersMain);
    itersSlider.addEventListener("input", changeItersMain);
  }

  // Julia iterations
  const itersSliderJulia = document.getElementById("iters-slider-julia");
  const itersValueJulia = document.getElementById("iters-value-julia");
  if (itersValueJulia && itersSliderJulia) {
    itersValueJulia.innerText = maxIterationsJulia;
    itersSliderJulia.value = maxIterationsJulia;
    function changeItersJulia(event) {
      const val = Number(event.target.value);
      if (val > 0 && val <= MAX_ITERS_JULIA) {
        const newVal = Math.floor(val);
        itersValueJulia.innerText = newVal;
        maxIterationsJulia = newVal;
        renderJulia(centerX, centerY);
      }
    }
    itersSliderJulia.addEventListener("input", changeItersJulia);
  }

  // Update details UI elements (reuse your original element IDs)
  const detailsSource = document.getElementById("details-source");
  const xPosText = document.getElementById("x-pos-text");
  const yPosText = document.getElementById("y-pos-text");
  const iterCountText = document.getElementById("iter-count-text");
  const zoomText = document.getElementById("zoom-text");

  function updateDetails(xCoord, yCoord, zoomLevel, source) {
    if (detailsSource) detailsSource.innerText = source;
    if (xPosText) xPosText.innerText = xCoord;
    if (yPosText) yPosText.innerText = yCoord;
    if (iterCountText) iterCountText.innerText = getIterations(xCoord, yCoord);
    if (zoomText) zoomText.innerText = zoomLevel;
  }

  // Mouse move over main canvas - update cursor info & render Julia preview
  mainCanvas.addEventListener("mousemove", (e) => {
    const rect = mainCanvas.getBoundingClientRect();
    const mouseX = (e.clientX - rect.left) / rect.width;
    const mouseY = (e.clientY - rect.top) / rect.height;
    let aspectRatio = mainCanvas.width / mainCanvas.height;
    let mouseXClip = (mouseX - 0.5) * (4.0 / zoom) * aspectRatio + centerX;
    let mouseYClip = (0.5 - mouseY) * (4.0 / zoom) + centerY;
    updateDetails(mouseXClip, mouseYClip, zoom, "cursor");
    renderJulia(mouseXClip, mouseYClip);
  });

  mainCanvas.addEventListener("mouseleave", () => {
    updateDetails(centerX, centerY, zoom, "center");
    renderJulia(centerX, centerY);
  });

  // CPU-side iteration estimator (same code as before)
  function getIterations(x, y) {
    let zx = 0,
      zy = 0;
    let i;
    for (i = 0; i < maxIterations; i++) {
      let xtemp = zx * zx - zy * zy + x;
      zy = 2.0 * zx * zy + y;
      zx = xtemp;
      if (zx * zx + zy * zy > 4.0) break;
    }
    return i === maxIterations ? "N/A" : i;
  }

  // initial draw
  renderMain();
  renderJulia(centerX, centerY);
}

// ---------- Bootstrap ----------
try {
  main().catch((e) => {
    showError(`WebGPU initialization error: ${e}`);
  });
} catch (e) {
  showError(`Uncaught JavaScript exception: ${e}`);
}
