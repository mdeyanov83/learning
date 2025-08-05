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


function createVao(gl, positionBuffer, positionAttribLocation) {
    const vao = gl
}


function main() {

    const mainCanvas = document.getElementById("main-canvas");
    if (!mainCanvas) {
        showError("Cannot get main canvas reference");
        return;
    }

    const gl = getContext(mainCanvas);

    // Set up buffer and send it to the GPU
    // const triangleVerticesCpuBuffer = new Float32Array(triangleVertices); // Create Float32Array
    const vbo = gl.createBuffer(); // Create a buffer on the GPU
    gl.bindBuffer(gl.ARRAY_BUFFER, vbo); // Attach buffer to a WebGL attachment point
    gl.bufferData(gl.ARRAY_BUFFER, quadVertices, gl.STATIC_DRAW);


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
    gl.enableVertexAttribArray(vertexPositionAttribLocation);

    // Input assembler
    gl.bindBuffer(gl.ARRAY_BUFFER, vbo);
    gl.vertexAttribPointer(
        vertexPositionAttribLocation, // index: which attribute to use
        2, // size: number of components in the attribute
        gl.FLOAT, // type: what is the data type stored in the GPU buffer for this attribute
        false, // normalized?
        2 * Float32Array.BYTES_PER_ELEMENT, // stride: bytes between starting byte of attribute for a vertex and the same attrib for the next vertex
        0, // offset: bytes between the start of the buffer and the firt byte of the attribute
    )

    // Draw call
    gl.drawArrays(gl.TRIANGLE_STRIP, 0, 4);
}

try {
    main();
} catch (e) {
    showError(`Uncaught JavaScript exception: ${e}`);
}
