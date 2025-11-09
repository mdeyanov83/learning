"use strict";
/** Demo configuration constants */
const SPAWN_RATE = 0.08;
const MIN_SHAPE_TIME = 0.25;
const MAX_SHAPE_TIME = 6;
const MIN_SHAPE_SPEED = 125;
const MAX_SHAPE_SPEED = 250;
const MIN_SHAPE_SIZE = 2;
const MAX_SHAPE_SIZE = 50;
const MAX_SHAPE_COUNT = 250;
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
const trianglePositions = new Float32Array([0, 1, -1, -1, 1, -1]);
const squarePositions = new Float32Array([-1, 1, -1, -1, 1, -1, -1, 1, 1, -1, 1, 1]);
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
const indigoGradientSquareColors = new Uint8Array([
    // Top: "Tropical Indigo" - A799FF
    167, 153, 255,
    // Bottom: "Eminence" - 583E7A
    88, 62, 122,
    88, 62, 122,
    167, 153, 255,
    88, 62, 122,
    167, 153, 255,
]);
const graySquareColors = new Uint8Array([
    45, 45, 45,
    45, 45, 45,
    45, 45, 45,
    45, 45, 45,
    45, 45, 45,
    45, 45, 45,
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
function getRandomInRange(min, max) {
    return Math.random() * (max - min) + min;
}
class MovingShape {
    constructor(position, velocity, size, timeRemaining, vao, numVertices) {
        this.position = position;
        this.velocity = velocity;
        this.size = size;
        this.timeRemaining = timeRemaining;
        this.vao = vao;
        this.numVertices = numVertices;
    }
    isAlive() {
        return this.timeRemaining > 0;
    }
    update(dt) {
        this.position[0] += this.velocity[0] * dt;
        this.position[1] += this.velocity[1] * dt;
        this.timeRemaining -= dt;
    }
}
function movementAndColorDemo() {
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
    const squareGeoBuffer = createStaticVertexBuffer(gl, squarePositions);
    const indigoGradientSquareColorBuffer = createStaticVertexBuffer(gl, indigoGradientSquareColors);
    const graySquareColorBuffer = createStaticVertexBuffer(gl, graySquareColors);
    if (!triangleGeoBuffer || !rgbTriangleColorBuffer || !fireyTriangleColorBuffer ||
        !squareGeoBuffer || !indigoGradientSquareColorBuffer || !graySquareColorBuffer) {
        showError(`Failed to create vertex buffers (triangle pos=${!!triangleGeoBuffer},`
            + `, rgb tri color=${!!rgbTriangleColorBuffer},`
            + `, firey tri color=${!!fireyTriangleColorBuffer})`
            + `, square geo=${!!squareGeoBuffer})`
            + `, indigo square color=${!!indigoGradientSquareColorBuffer})`
            + `, gray square color=${!!graySquareColorBuffer})`);
        return null;
    }
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
    const indigoSquareVao = createTwoBufferVao(gl, squareGeoBuffer, indigoGradientSquareColorBuffer, vertexPositionAttributeLocation, vertexColorAttributeLocation);
    const graySquareVao = createTwoBufferVao(gl, squareGeoBuffer, graySquareColorBuffer, vertexPositionAttributeLocation, vertexColorAttributeLocation);
    if (!rgbTriangleVao || !fireyTriangleVao || !indigoSquareVao || !graySquareVao) {
        showError(`Failed to create VAOs: (`
            + `rgbTriangle=${!!rgbTriangleVao},`
            + `fireyTriangle=${!!fireyTriangleVao})`
            + `indigoSquare=${!!indigoSquareVao})`
            + `graySquare=${!!graySquareVao})`);
        return;
    }
    const geometryList = [
        { vao: rgbTriangleVao, numVertices: 3 },
        { vao: fireyTriangleVao, numVertices: 3 },
        { vao: indigoSquareVao, numVertices: 6 },
        { vao: graySquareVao, numVertices: 6 },
    ];
    // Set up logical objects
    let shapes = [];
    let timeToNextSpawn = SPAWN_RATE;
    let lastFrameTime = performance.now();
    const frame = function () {
        const thisFrameTime = performance.now();
        const dt = (thisFrameTime - lastFrameTime) / 1000;
        lastFrameTime = thisFrameTime;
        // Update shapes
        timeToNextSpawn -= dt;
        while (timeToNextSpawn < 0) {
            timeToNextSpawn += SPAWN_RATE;
            const movementAngle = getRandomInRange(0, 2 * Math.PI);
            const movementSpeed = getRandomInRange(MIN_SHAPE_SPEED, MAX_SHAPE_SPEED);
            const position = [canvas.width / 2, canvas.height / 2];
            const velocity = [
                Math.sin(movementAngle) * movementSpeed,
                Math.cos(movementAngle) * movementSpeed,
            ];
            const size = getRandomInRange(MIN_SHAPE_SIZE, MAX_SHAPE_SIZE);
            const timeRemaining = getRandomInRange(MIN_SHAPE_TIME, MAX_SHAPE_TIME);
            const geometryIdx = Math.floor(getRandomInRange(0, geometryList.length));
            const geometry = geometryList[geometryIdx];
            const shape = new MovingShape(position, velocity, size, timeRemaining, geometry.vao, geometry.numVertices);
            shapes.push(shape);
        }
        for (let i = 0; i < shapes.length; i++) {
            shapes[i].update(dt);
        }
        shapes = shapes.filter((shape) => shape.isAlive()).slice(0, MAX_SHAPE_COUNT);
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
        // Draw the shapes
        for (let i = 0; i < shapes.length; i++) {
            gl.uniform1f(shapeSizeUniform, shapes[i].size);
            gl.uniform2f(shapeLocationUniform, shapes[i].position[0], shapes[i].position[1]);
            gl.bindVertexArray(shapes[i].vao);
            gl.drawArrays(gl.TRIANGLES, 0, shapes[i].numVertices);
        }
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
