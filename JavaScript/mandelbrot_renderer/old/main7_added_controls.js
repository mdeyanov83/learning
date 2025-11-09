// Display an error message in the error text area
function showError(errorText) {
    const errorBoxDiv = document.getElementById("error-box");
    const errorTextElement = document.createElement("p");
    errorTextElement.innerText = errorText;
    errorBoxDiv.appendChild(errorTextElement);
    console.log(errorText);
}

// Quad definition, create Float32Array
const quadVertices = new Float32Array([
    -1.0, -1.0,
    1.0, -1.0,
    -1.0, 1.0,
    1.0, 1.0,
]);

// CONSTANTS
const MAX_ITERATIONS = 1500;
const MAX_ZOOM = 1000000;


// Vertex shader source
const vertexShaderSourceCode = `#version 300 es
precision highp float;

in vec2 vertexPosition;
out vec2 v_uv;

void main() {
    v_uv = (vertexPosition + 1.0) * 0.5;
    gl_Position = vec4(vertexPosition, 0.0, 1.0);
}`;

// Fragment shader source
const fragmentShaderSourceCode = `#version 300 es
precision highp float;

out vec4 outputColor;
in vec2 v_uv;

uniform highp vec2 u_center;
uniform highp float u_zoom;
uniform int u_iterations;
uniform vec2 u_resolution;

// Function to convert HSV to RGB
vec3 hsvToRgb(float h, float s, float v) {
    vec3 c = vec3(h * 6.0, s, v);
    vec3 rgb = clamp(abs(mod(c.x + vec3(0.0, 4.0, 2.0), 6.0) - 3.0) - 1.0, 0.0, 1.0);
    return c.z * mix(vec3(1.0), rgb, c.y);
}

void main() {
    vec2 aspectRatio = vec2(u_resolution.x / u_resolution.y, 1.0);
    vec2 c = (v_uv - vec2(0.5)) * (4.0 / u_zoom) * aspectRatio + u_center;
    vec2 z = vec2(0.0);

    int i;
    for (i = 0; i < u_iterations; i++) {
        if (dot(z, z) > 4.0) break;
        z = vec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y) + c;
    }

    float norm = float(i) / float(u_iterations); // Normalize iterations

    float hue = 0.66 - 0.66 * norm;  // Hue from blue (0.66) to red (0.0)
    float saturation = 1.0;
    float value = norm < 1.0 ? 1.0 : 0.0; // Smooth fade to black for convergence
    vec3 color = hsvToRgb(hue, saturation, norm);

    // vec3 color;
    // if (norm < 0.25) {
    //     color = mix(vec3(0.0, 0.0, 1.0), vec3(0.0, 1.0, 0.0), norm / 0.25); // Blue to Green
    // } else if (norm < 0.50) {
    //     color = mix(vec3(0.0, 1.0, 0.0), vec3(1.0, 1.0, 0.0), (norm - 0.25) / 0.25); // Green to Yellow
    // } else if (norm < 0.75) {
    //     color = mix(vec3(1.0, 1.0, 0.0), vec3(1.0, 0.0, 0.0), (norm - 0.50) / 0.25);  // Yellow to Red
    // } else {
    //     color = mix(vec3(1.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0), (norm - 0.75) / 0.26); // Red to Black
    // }

    outputColor = vec4(vec3(color), 1.0);
}`;


function getContext(canvas) {
    const gl = canvas.getContext("webgl2");
    if (!gl) {
        showError("Browser does not support WebGL2 - this demo will not work");
        return;
    }
    return gl;
}


function createProgram(gl, vertexShaderSource, fragmentShaderSource) {
    // Create vertex shader, fragment shader and program
    const vertexShader = gl.createShader(gl.VERTEX_SHADER);
    const fragmentShader = gl.createShader(gl.FRAGMENT_SHADER);
    const program = gl.createProgram();
    // Error check
    if (!vertexShader || !fragmentShader || !program) {
        showError(`Failed to allocate GL objects (`
            + `vs=${!!vertexShader}, `
            + `fs=${!!fragmentShader}, `
            + `program=${!!program})`);
        return null;
    }

    // Vertx shader compile
    gl.shaderSource(vertexShader, vertexShaderSource);
    gl.compileShader(vertexShader);
    // Check for compilation errors
    if (!gl.getShaderParameter(vertexShader, gl.COMPILE_STATUS)) {
        const compileError = gl.getShaderInfoLog(vertexShader);
        showError(`Failed to compile vertex shader - ${compileError}`);
        return null;
    }

    // Fragment shader compile
    gl.shaderSource(fragmentShader, fragmentShaderSource);
    gl.compileShader(fragmentShader);
    // Check for compilation errors
    if (!gl.getShaderParameter(fragmentShader, gl.COMPILE_STATUS)) {
        const compileError = gl.getShaderInfoLog(fragmentShader);
        showError(`Failed to compile fragment shader - ${compileError}`);
        return null;
    }

    // Link program
    gl.attachShader(program, vertexShader);
    gl.attachShader(program, fragmentShader);
    gl.linkProgram(program);
    // Check for link error
    if (!gl.getProgramParameter(program, gl.LINK_STATUS)) {
        const linkError = gl.getProgramInfoLog(program);
        showError(`Failed to link GPU program - ${linkError}`);
        return null;
    }
    return program;
}


function createStaticVertexBuffer(gl, data) {
    const buffer = gl.createBuffer();
    if (!buffer) {
        showError("Failed to allocate buffer");
        return null;
    }
    gl.bindBuffer(gl.ARRAY_BUFFER, buffer);
    gl.bufferData(gl.ARRAY_BUFFER, data, gl.STATIC_DRAW);

    return buffer;
}


function main() {

    const mainCanvas = document.getElementById("main-canvas");
    if (!mainCanvas) {
        showError("Cannot get main canvas reference");
        return;
    }

    const gl = getContext(mainCanvas);

    // Set up buffer and send it to the GPU
    const mainQuadGeoBuffer = createStaticVertexBuffer(gl, quadVertices);

    // Create program
    const mainShaderProgram = createProgram(gl, vertexShaderSourceCode, fragmentShaderSourceCode)

    // Get Attributes locations
    const vertexPositionAttribLocation = gl.getAttribLocation(mainShaderProgram, "vertexPosition");
    // Error check
    if (vertexPositionAttribLocation < 0) {
        showError("Failed to get attrib location for vertexPosition");
        return;
    }
    // Input assembler
    gl.enableVertexAttribArray(vertexPositionAttribLocation);
    gl.vertexAttribPointer(
        vertexPositionAttribLocation,
        2, gl.FLOAT, false,
        2 * Float32Array.BYTES_PER_ELEMENT, 0
    );

    // Get Uniform locations
    const resolutionLoc = gl.getUniformLocation(mainShaderProgram, "u_resolution");
    const centerLoc = gl.getUniformLocation(mainShaderProgram, "u_center");
    const zoomLoc = gl.getUniformLocation(mainShaderProgram, "u_zoom");
    const iterationsLoc = gl.getUniformLocation(mainShaderProgram, "u_iterations");

    // Initial fracal variables
    let centerX = -0.7, centerY = 0.0;
    let zoom = 1.0;
    let maxIterations = 250;

    // Output merger
    const dpr = window.devicePixelRatio || 1;
    mainCanvas.width = mainCanvas.clientWidth * dpr;
    mainCanvas.height = mainCanvas.clientHeight * dpr;

    // Rasterizer
    gl.viewport(0, 0, mainCanvas.width, mainCanvas.height);

    // Set clear color and clear color and depth buffers.
    // Not necessary in this case, more important in 3d rendering
    // gl.clearColor(0.08, 0.08, 0.08, 1);
    // gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);

    function render() {
        // Update details in html details field
        updateDetails(centerX, centerY, zoom, "center");

        // Rasterizer - needed when canvas width and height are reduced for smoother pan/zoom
        gl.viewport(0, 0, mainCanvas.width, mainCanvas.height);

        // Use GPU program
        gl.useProgram(mainShaderProgram);

        // Set uniform values
        gl.uniform2f(resolutionLoc, mainCanvas.width, mainCanvas.height);
        gl.uniform2f(centerLoc, centerX, centerY);
        gl.uniform1f(zoomLoc, zoom);
        gl.uniform1i(iterationsLoc, maxIterations);

        // Draw call
        gl.drawArrays(gl.TRIANGLE_STRIP, 0, 4);
    }

    // Event listeners for zoom and pan
    mainCanvas.addEventListener("wheel", (e) => {
        e.preventDefault();

        // Get mouse position relative to the canvas
        const rect = mainCanvas.getBoundingClientRect();
        const mouseX = (e.clientX - rect.left) / rect.width;
        const mouseY = (e.clientY - rect.top) / rect.height;

        let aspectRatio = mainCanvas.width / mainCanvas.height;

        // Convert screen space to Mandelbrot coordinate space (before zoom)
        let pixelOffsetX = (mouseX - 0.5) * (4.0 / zoom) * aspectRatio;
        let pixelOffsetY = (mouseY - 0.5) * (4.0 / zoom);

        let mouseReBefore = centerX + pixelOffsetX;
        let mouseImBefore = centerY + pixelOffsetY;

        // Zoom factor
        let zoomFactor = e.deltaY > 0 ? 0.8 : 1.2;
        if (zoom*zoomFactor <= MAX_ZOOM) {
            zoom *= zoomFactor;
        } else {
            zoom = MAX_ZOOM;
        }

        // Convert the same mouse position to Mandelbrot coordinates (after zoom)
        pixelOffsetX = (mouseX - 0.5) * (4.0 / zoom) * aspectRatio;
        pixelOffsetY = (mouseY - 0.5) * (4.0 / zoom);

        let mouseReAfter = centerX + pixelOffsetX;
        let mouseImAfter = centerY + pixelOffsetY;

        // Adjust center so the point after the cursor stays fixed
        centerX += (mouseReBefore - mouseReAfter);
        centerY -= (mouseImBefore - mouseImAfter);

        console.log(`Zoom: ${zoom}, Center: (${centerX}, ${centerY})`);

        render();
    });
    let isDragging = false, lastX, lastY;
    mainCanvas.addEventListener("mousedown", (e) => {
        isDragging = true;
        lastX = e.clientX;
        lastY = e.clientY;
        mainCanvas.width = 400;
        mainCanvas.height = 300;
        render();
    });
    mainCanvas.addEventListener("mousemove", (e) => {
        if (isDragging) {
            let dx = (e.clientX - lastX) / mainCanvas.width * (4.0 / zoom);
            let dy = (e.clientY - lastY) / mainCanvas.height * (4.0 / zoom);
            centerX -= dx;
            centerY += dy;
            lastX = e.clientX;
            lastY = e.clientY;
            render();
        }
    });
    mainCanvas.addEventListener("mouseup", () => {
        isDragging = false;
        mainCanvas.width = mainCanvas.clientWidth;
        mainCanvas.height = mainCanvas.clientHeight;
        render();
    });

    // Dynamically update maxIterations from input
    const itersInput = document.getElementById("iters-input");
    const itersSlider = document.getElementById("iters-slider");

    if (itersInput && itersSlider) {
        function changeIters(event) {
            if ((event.target.value > 0) && (event.target.value) <= MAX_ITERATIONS) {
                let newItersValue = Math.floor(event.target.value);
                itersInput.value = newItersValue;
                itersSlider.value = newItersValue;
                maxIterations = newItersValue;
                render();
            }
        }
        itersInput.addEventListener("input", changeIters);
        itersSlider.addEventListener("input", changeIters);
    }

    // Update details in HTML element function
    const detailsSource = document.getElementById("details-source");
    const xPosText = document.getElementById("x-pos-text");
    const yPosText = document.getElementById("y-pos-text");
    const iterCountText = document.getElementById("iter-count-text");
    const zoomText = document.getElementById("zoom-text");

    function updateDetails(xCoord, yCoord, zoomLevel, source) {
        detailsSource.innerText = source;
        xPosText.innerText = xCoord;
        yPosText.innerText = yCoord;
        iterCountText.innerText = getIterations(xCoord, yCoord);
        zoomText.innerText = zoomLevel;
    }

    // Event Listener for tracking mouse cursor in canvas element and
    // updating detils for cursor coordinates
    mainCanvas.addEventListener("mousemove", (e) => {
        // Get mouse position relative to the canvas
        const rect = mainCanvas.getBoundingClientRect();
        const mouseX = (e.clientX - rect.left) / rect.width;
        const mouseY = (e.clientY - rect.top) / rect.height;

        // Convert to clip space coordinates and account for center position
        let aspectRatio = mainCanvas.width / mainCanvas.height;
        let mouseXClip = (mouseX - 0.5) * (4.0 / zoom) * aspectRatio + centerX;
        let mouseYClip = (mouseY - 0.5) * (4.0 / zoom) - centerY;

        updateDetails(mouseXClip, mouseYClip, zoom, "cursor");
    });
    mainCanvas.addEventListener("mouseleave", () => {
        updateDetails(centerX, centerY, zoom, "center");
    });

    // Get iterations value at X, Y coordinates
    function getIterations(x, y) {
        let zx = 0, zy = 0;
        let cx = x; cy = y;
        let i;
        for (i = 0; i < maxIterations; i++) {
            let xtemp = zx * zx - zy * zy + cx;
            zy = 2.0 * zx * zy + cy;
            zx = xtemp;
            if (zx * zx + zy * zy > 4.0) break;
        }
        return (i === maxIterations ? "N/A" : i);
    }

    render();
}


try {
    main();
} catch (e) {
    showError(`Uncaught JavaScript exception: ${e}`);
}
