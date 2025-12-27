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
    -0.95, -0.95,
    0.95, -0.95,
    -0.95, 0.95,
    0.95, 0.95,
]);

// Vertex shader source
const vertexShaderSourceCode = `#version 300 es
precision mediump float;

in vec2 vertexPosition;
out vec2 v_uv;

void main() {
    v_uv = (vertexPosition + 1.0) * 0.5;
    gl_Position = vec4(vertexPosition, 0.0, 1.0);
}`;

// Fragment shader source
const fragmentShaderSourceCode = `#version 300 es
precision mediump float;

out vec4 outputColor;
in vec2 v_uv;

uniform vec2 u_center;
uniform float u_zoom;
uniform int u_iterations;
uniform vec2 u_resolution;

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
    vec3 color;

    if (norm < 0.33) {
        color = mix(vec3(0.0, 0.0, 1.0), vec3(0.0, 1.0, 0.0), norm / 0.33); // Blue to Green
    } else if (norm < 0.66) {
        color = mix(vec3(0.0, 1.0, 0.0), vec3(1.0, 1.0, 0.0), (norm - 0.33) / 0.33); // Green to Yellow
    } else {
        color = mix(vec3(1.0, 1.0, 0.0), vec3(1.0, 0.0, 0.0), (norm - 0.66) / 0.34);  // Yellow to Red
    }

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
    gl.bindBuffer(gl.ARRAY_BUFFER, null);

    return buffer;
}


function createVao(gl, positionBuffer, positionAttribLocation) {

    const vao = gl.createVertexArray();
    // Error check
    if (!vao) {
        showError("Failed to allocate VAO")
        return null;
    }
    gl.bindVertexArray(vao);

    gl.enableVertexAttribArray(positionAttribLocation);

    gl.bindBuffer(gl.ARRAY_BUFFER, positionBuffer);
    gl.vertexAttribPointer(positionAttribLocation, 2, gl.FLOAT, false, 2 * Float32Array.BYTES_PER_ELEMENT, 0);

    gl.bindBuffer(gl.ARRAY_BUFFER, null);
    gl.bindVertexArray(null);

    return vao;
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

    // Get Uniform locations
    const resolutionLoc = gl.getUniformLocation(mainShaderProgram, "u_resolution");
    const centerLoc = gl.getUniformLocation(mainShaderProgram, "u_center");
    const zoomLoc = gl.getUniformLocation(mainShaderProgram, "u_zoom");
    const iterationsLoc = gl.getUniformLocation(mainShaderProgram, "u_iterations");

    // Initial fracal variables
    let centerX = -0.7, centerY = 0.0;
    let zoom = 1.0;
    let maxIterations = 100;

    // Output merger
    mainCanvas.width = mainCanvas.clientWidth;
    mainCanvas.height = mainCanvas.clientHeight;
    // Rasterizer
    gl.viewport(0, 0, mainCanvas.width, mainCanvas.height);


    // Set clear color
    gl.clearColor(0.08, 0.08, 0.08, 1);
    gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);

    // GPU program
    gl.useProgram(mainShaderProgram);

    // Create VAO
    const mainVao = createVao(gl, mainQuadGeoBuffer, vertexPositionAttribLocation);
    gl.bindVertexArray(mainVao);

    // Set uniform values
    gl.uniform2f(resolutionLoc, mainCanvas.width, mainCanvas.height);
    gl.uniform2f(centerLoc, centerX, centerY);
    gl.uniform1f(zoomLoc, zoom);
    gl.uniform1i(iterationsLoc, maxIterations);

    // Draw call
    gl.drawArrays(gl.TRIANGLE_STRIP, 0, 4);
    gl.bindVertexArray(null);
}

try {
    main();
} catch (e) {
    showError(`Uncaught JavaScript exception: ${e}`);
}
