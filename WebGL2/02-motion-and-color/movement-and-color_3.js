"use strict";
// Display an error message to the DOM, beneath the demo element
function showError(errorText) {
    console.error(errorText);
    const errorBoxDiv = document.getElementById("error-box");
    if (errorBoxDiv === null) {
        return;
    }
    const errorElement = document.createElement("p");
    errorElement.innerText = errorText;
    errorBoxDiv.appendChild(errorElement);
}
// Vertex shader
const vertexShaderSourceCode = `#version 300 es
precision mediump float;

in vec2 vertexPosition;
in vec3 vertexColor;

out vec3 fragmentColor;

uniform vec2 canvasSize;
uniform vec2 shapeLocation;
uniform float shapeSize;

void main() {
    fragmentColor = vertexColor;

    vec2 finalVertexPosition = vertexPosition * shapeSize + shapeLocation;
    vec2 clipPosition = (finalVertexPosition / canvasSize) * 2.0 - 1.0;

    gl_Position = vec4(clipPosition, 0.0, 1.0);
}`;
// Fragment shader
const fragmentShaderSourceCode = `#version 300 es
 precision mediump float;

 in vec3 fragmentColor;
 out vec4 outputColor;

 void main() {
     outputColor = vec4(fragmentColor, 1.0);
 }`;
// New: the values are not defined in clip-space anymore, because of the uniforms
// And we build the Float32 array in the definitions
const trianglePositions = new Float32Array([0, 1, -1, -1, 1, -1]);
// Add 2 sets of colors for our triangles
// make no sense to define colors using 32bit float as most displays use 8bit per channel
// we can use unsigned 8bit integer (0-255) and normalize to values between 0-1
const rgbTriangleColors = new Uint8Array([
    255, 0, 0,
    0, 255, 0,
    0, 0, 255,
]);
const fireyTriangleColors = new Uint8Array([
    // Chili red - E52F0F
    229, 47, 15,
    // Jonquil - F6CE1D
    246, 206, 29,
    // Gamboge - E99A1A
    233, 154, 26,
]);
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
function createTwoBufferVao(gl, positionBuffer, colorBuffer, positionAttribLocation, colorAttribLocation) {
    const vao = gl.createVertexArray();
    if (!vao) {
        showError("Failed to allocate VAO for two buffers");
    }
    gl.bindVertexArray(vao);
    gl.enableVertexAttribArray(positionAttribLocation);
    gl.enableVertexAttribArray(colorAttribLocation);
    gl.bindBuffer(gl.ARRAY_BUFFER, positionBuffer);
    gl.vertexAttribPointer(positionAttribLocation, 2, gl.FLOAT, false, 0, 0);
    gl.bindBuffer(gl.ARRAY_BUFFER, colorBuffer);
    gl.vertexAttribPointer(colorAttribLocation, 3, gl.UNSIGNED_BYTE, true, 0, 0);
    gl.bindBuffer(gl.ARRAY_BUFFER, null);
    gl.bindVertexArray(null);
    return vao;
}
class MovingShape {
    constructor(position, velocity, size, vao) {
        this.position = position;
        this.velocity = velocity;
        this.size = size;
        this.vao = vao;
    }
    update(dt) {
        this.position[0] += this.velocity[0] * dt;
        this.position[1] += this.velocity[1] * dt;
    }
}
function movementAndColorDemo() {
    // Setup Step 1: Get the WebGL rendering context for our HTML canvas rendering area
    // The WebGL context is the object used to generate images via the WebGL API, and
    // the canvas it is associated with is an area where those generated images will
    // be placed by the browser once the JS code is done working on it
    const canvas = document.getElementById("demo-canvas");
    if (!canvas || !(canvas instanceof HTMLCanvasElement)) {
        showError("Cannot get demo-canvas reference - check for typos or loading script too early in HTML");
        return;
    }
    const gl = canvas.getContext("webgl2");
    if (!gl) {
        const isWebGl1Supported = !!canvas.getContext("webgl");
        if (isWebGl1Supported) {
            showError("This browser supports WebGL 1 but not WebGL 2 - make sure WebGL 2 isn't disabled in your browser");
        }
        else {
            showError("This browser does not support WebGL 2 - this demo will not work!");
        }
        return;
    }
    // New: Set up buffers
    const triangleGeoBuffer = createStaticVertexBuffer(gl, trianglePositions);
    const rgbTriangleColorBuffer = createStaticVertexBuffer(gl, rgbTriangleColors);
    const fireyTriangleColorBuffer = createStaticVertexBuffer(gl, fireyTriangleColors);
    if (!triangleGeoBuffer || !rgbTriangleColorBuffer || !fireyTriangleColorBuffer) {
        showError(`Failed to create vertex buffers (triangle pos=${!!triangleGeoBuffer},`
            + `, rgb tri color=${!!rgbTriangleColorBuffer},`
            + `, firey tri color=${!!fireyTriangleColorBuffer})`);
        return;
    }
    // Create the vertex and fragment shaders fot this demo. GLSL shader code is
    // written as a plain JS string, attached to a shader, and compiled
    // with the "compileShader" call.
    // If both shaders compile successfully, attach them to a WebGLProgram
    // instance - vertex and fragment shaders must be used together in a draw
    // call, and a WebGLProgram represents the combination of shaders to be used.
    // Send it over to the GPU - Create a shader, send the source code and compile
    const vertexShader = gl.createShader(gl.VERTEX_SHADER);
    if (vertexShader === null) {
        showError("Could not allocate vertex shader");
        return;
    }
    gl.shaderSource(vertexShader, vertexShaderSourceCode);
    gl.compileShader(vertexShader);
    // Check for compilation problems due to typing errors in the shader source code
    // since it just a string, so code formattion will not catch typos
    if (!gl.getShaderParameter(vertexShader, gl.COMPILE_STATUS)) {
        const compileError = gl.getShaderInfoLog(vertexShader);
        showError(`Failed to COMPILE vertex shader - ${compileError}`);
        return;
    }
    // Create shader, send the source code and compile
    const fragmentShader = gl.createShader(gl.FRAGMENT_SHADER);
    if (fragmentShader === null) {
        showError("Could not allocate fragment shader");
        return;
    }
    gl.shaderSource(fragmentShader, fragmentShaderSourceCode);
    gl.compileShader(fragmentShader);
    // Check for compilation errors
    if (!gl.getShaderParameter(fragmentShader, gl.COMPILE_STATUS)) {
        const compileError = gl.getShaderInfoLog(fragmentShader);
        showError(`Failed to COMPILE fragment shader - ${compileError}`);
        return;
    }
    // We never use the Vertex or Fragment shaders independently, they are always combined into using a
    // combined object - WebGL Program
    const helloTriangleProgram = gl.createProgram();
    if (helloTriangleProgram === null) {
        showError("Could not allocate program");
        return;
    }
    gl.attachShader(helloTriangleProgram, vertexShader);
    gl.attachShader(helloTriangleProgram, fragmentShader);
    gl.linkProgram(helloTriangleProgram); // make sure the vertex and fragment shaders are compatible with eachother
    // Check for link error, similarly to checking for compile errors previously
    if (!gl.getProgramParameter(helloTriangleProgram, gl.LINK_STATUS)) {
        const linkError = gl.getProgramInfoLog(helloTriangleProgram);
        showError(`Failed to LINK shaders - ${linkError}`);
        return;
    }
    // Attribute locations allow us to talk about which shader input should
    // read from which GPU buffer in the later "vetexAttribPointer" call.
    // We need to get a handle on the vertex shader input (vertexPosition) so we can tell WebGL how to read this data later
    // we get the "attribute location" of this input. It is a number, starting at 0 indicating which attribute is it
    // in this case it is only 1, so value is 0. But still it is a good idea to ask:
    const vertexPositionAttributeLocation = gl.getAttribLocation(helloTriangleProgram, "vertexPosition");
    const vertexColorAttributeLocation = gl.getAttribLocation(helloTriangleProgram, "vertexColor");
    // Error check if the variable is at least 0. it will be -1 if the call fails
    if (vertexPositionAttributeLocation < 0 || vertexColorAttributeLocation < 0) {
        showError(`Failed to get attribute locations: (pos=${vertexPositionAttributeLocation}, color=${vertexColorAttributeLocation})`);
        return;
    }
    // NEW: Get the uniform locations to set uniform values
    const shapeLocationUniform = gl.getUniformLocation(helloTriangleProgram, "shapeLocation");
    const shapeSizeUniform = gl.getUniformLocation(helloTriangleProgram, "shapeSize");
    const canvasSizeUniform = gl.getUniformLocation(helloTriangleProgram, "canvasSize");
    // New: Error check
    if (shapeLocationUniform === null || shapeSizeUniform === null || canvasSizeUniform === null) {
        showError(`Failed to get uniform locations (shapeLocation=${!!shapeLocationUniform}`
            + `, shapeSize=${!!shapeSizeUniform}`
            + `, canvasSize=${!!canvasSizeUniform})`);
        return;
    }
    // New: Create VAOs
    const rgbTriangleVao = createTwoBufferVao(gl, triangleGeoBuffer, rgbTriangleColorBuffer, vertexPositionAttributeLocation, vertexColorAttributeLocation);
    const fireyTriangleVao = createTwoBufferVao(gl, triangleGeoBuffer, fireyTriangleColorBuffer, vertexPositionAttributeLocation, vertexColorAttributeLocation);
    if (!rgbTriangleVao || !fireyTriangleVao) {
        showError(`Failed to create VAOs: (`
            + `rgbTriangle=${!!rgbTriangleVao},`
            + `fireyTriangle=${!!fireyTriangleVao})`);
        return;
    }
    // Set up logical objects
    const triangle1 = new MovingShape([300, 600], [50, 5], 200, rgbTriangleVao);
    const triangle2 = new MovingShape([650, 300], [-50, -5], 100, fireyTriangleVao);
    let lastFrameTime = performance.now();
    const frame = function () {
        const thisFrameTime = performance.now();
        const dt = (thisFrameTime - lastFrameTime) / 1000;
        lastFrameTime = thisFrameTime;
        // Update shapes
        triangle1.update(dt);
        triangle2.update(dt);
        // Render a frame!
        // Output merger
        canvas.width = canvas.clientWidth; // Set the width/height properties of the canvas to the actual HTML element size
        canvas.height = canvas.clientHeight; // It doesn't necessary have to be this way, if not we can craete an image that is stretched or shrunk to the elemnet size.
        gl.clearColor(0.08, 0.08, 0.08, 1); // we tell gl what we want the clear color to be. Inputs are normalized R G B Alpha(Opacity)
        gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT); // call to clear both the color and depth buffers
        gl.viewport(0, 0, canvas.width, canvas.height); // Rasterizer, parameters - x, y, width, height. x and y are the bottom left corner of the viewposrt relative to the canvas element
        gl.useProgram(helloTriangleProgram); // GPU program (vertex + fragment shader pair)
        // Set uniforms shared across frame...
        gl.uniform2f(canvasSizeUniform, canvas.width, canvas.height);
        // First Triangle
        gl.uniform1f(shapeSizeUniform, triangle1.size);
        gl.uniform2f(shapeLocationUniform, triangle1.position[0], triangle1.position[1]);
        gl.bindVertexArray(rgbTriangleVao);
        gl.drawArrays(gl.TRIANGLES, 0, 3);
        // Second Triangle
        gl.uniform1f(shapeSizeUniform, triangle2.size);
        gl.uniform2f(shapeLocationUniform, triangle2.position[0], triangle2.position[1]);
        gl.bindVertexArray(fireyTriangleVao);
        gl.drawArrays(gl.TRIANGLES, 0, 3);
        requestAnimationFrame(frame);
    };
    requestAnimationFrame(frame);
}
try {
    movementAndColorDemo();
}
catch (e) {
    showError(`Uncaught JavaScript exception: ${e}`);
}
