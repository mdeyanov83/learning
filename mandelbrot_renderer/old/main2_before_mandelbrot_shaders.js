// Display an error message in the error text area
function showError(errorText) {
    const errorBoxDiv = document.getElementById("error-box");
    const errorTextElement = document.createElement("p");
    errorTextElement.innerText = errorText;
    errorBoxDiv.appendChild(errorTextElement);
    console.log(errorText);
}

// Quad definition
// Create Float32Array
const quadVertices = new Float32Array([
    -0.9, -0.9,
    0.9, -0.9,
    -0.9, 0.9,
    0.9, 0.9,
]);

// Vertex shader source
const vertexShaderSourceCode = `#version 300 es
precision mediump float;

in vec2 vertexPosition;

void main() {
    gl_Position = vec4(vertexPosition, 0.0, 1.0);
}`;

// Fragment shader source
const fragmentShaderSourceCode = `#version 300 es
precision mediump float;

out vec4 outputColor;

void main() {
    outputColor = vec4(0.294, 0.0, 0.51, 1.0);
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


    // Get attributes locations
    const vertexPositionAttribLocation = gl.getAttribLocation(mainShaderProgram, "vertexPosition");
    // Error check
    if (vertexPositionAttribLocation < 0) {
        showError("Failed to get attrib location for vertexPosition");
        return;
    }

    // Output merger
    mainCanvas.width = mainCanvas.clientWidth;
    mainCanvas.height = mainCanvas.clientHeight;

    // Set clear color
    gl.clearColor(0.08, 0.08, 0.08, 1);
    gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);

    // Rasterizer
    gl.viewport(0, 0, mainCanvas.width, mainCanvas.height);

    // GPU program
    gl.useProgram(mainShaderProgram);

    const mainVao = createVao(gl, mainQuadGeoBuffer, vertexPositionAttribLocation);
    gl.bindVertexArray(mainVao);

    // Draw call
    gl.drawArrays(gl.TRIANGLE_STRIP, 0, 4);
    gl.bindVertexArray(null);
}

try {
    main();
} catch (e) {
    showError(`Uncaught JavaScript exception: ${e}`);
}
