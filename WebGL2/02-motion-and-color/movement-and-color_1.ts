// Display an error message to the DOM, beneath the demo element
function showError(errorText: string) {
    console.error(errorText);
    const errorBoxDiv = document.getElementById("error-box");
    if (errorBoxDiv === null) {
        return;
    }
    const errorElement = document.createElement("p");
    errorElement.innerText = errorText;
    errorBoxDiv.appendChild(errorElement);
}


// New: the values are not defined in clip-space anymore, because of the uniforms
// And we build the Float32 array in the definitions
const trianglePositions = new Float32Array([ 0, 1, -1, -1, 1, -1 ]);
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
        } else {
            showError("This browser does not support WebGL 2 - this demo will not work!");
        }
        return;
    }

    // Set up buffer and send it to the GPU
    const triangleGeoBuffer = gl.createBuffer(); // Create a buffer on the GPU, create a WebGL buffer type
    gl.bindBuffer(gl.ARRAY_BUFFER, triangleGeoBuffer); // Attach the buffer to a WEBGL attachment point
    gl.bufferData(gl.ARRAY_BUFFER, trianglePositions, gl.STATIC_DRAW); // The thing thats bound to the attachment point - give it this data

    // Set up the color buffers
    const rgbTriangleColorBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, rgbTriangleColorBuffer);
    gl.bufferData(gl.ARRAY_BUFFER, rgbTriangleColors, gl.STATIC_DRAW);

    const fireyTriangleColorBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, fireyTriangleColorBuffer);
    gl.bufferData(gl.ARRAY_BUFFER, fireyTriangleColors, gl.STATIC_DRAW);



    // Create the vertex and fragment shaders fot this demo. GLSL shader code is
    // written as a plain JS string, attached to a shader, and compiled
    // with the "compileShader" call.
    // If both shaders compile successfully, attach hem to a WebGLProgram
    // instance - vertex and fragment shaders must be used together in a draw
    // call, and a WebGLProgram represents the combination of shaders to be used.

    // Set up Vertex and Fragment shaders

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

    // Fragment shader
    const fragmentShaderSourceCode = `#version 300 es
    precision mediump float;

    in vec3 fragmentColor;
    out vec4 outputColor;

    void main() {
        outputColor = vec4(fragmentColor, 1.0);
    }`;

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
    gl.linkProgram(helloTriangleProgram) // make sure the vertex and fragment shaders are compatible with eachother

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

    // All of the above should be done into a sort of a loading screen. It needs to be done ahead of time, getting the information
    // over to the GPU. Once shaders and geometry are ON the GPU they can be used very efficiently in drawing commands.

    // Render a frame!
    // Of the below steps, the order is unimportant and up to the application developer
    // The order below is what makes general sense.
    // The only order-sensitive thing is that the draw call (gl.drawArrays) must be made
    // after all of the other pipeline state has been set up correctly, since it dispatches
    // the draw commands to the GPU using the current state.


    // We first need to configure the graphics pipeline and once it is configured with the state, shaders and geometry we want to use
    // tell WebGL to draw the triangle.

    // The pipeline stages that need to be configured are as follows.
    // The order doesn't affect the final image, but matters for performance

    // Output merger - how to merge the shaded pixel fragment with the existing output image
    // Rasterizer - which output pixels are covered by a triangle?
    // Vertex shader - how to place those vertices on the screen, in clip space
    // Fragment shader - what color a pixel should be
    // Input assembler - how to read vertices from our GPU trinagle buffer
    // Primitive assembly - how to make triangles from those vertices


    // Output merger
    canvas.width = canvas.clientWidth; // Set the width/height properties of the canvas to the actual HTML element size
    canvas.height = canvas.clientHeight; // It doesn't necessary have to be this way, if not we can craete an image that is stretched or shrunk to the elemnet size.
    // Set clear color
    gl.clearColor(0.08, 0.08, 0.08, 1); // we tell gl what we want the clear color to be. Inputs are normalized R G B Alpha(Opacity)
    gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT); // call to clear both the color and depth buffers

    // Rasterizer
    // parameters - x, y, width, height. x and y are the bottom left corner of the viewposrt relative to the canvas element
    gl.viewport(0, 0, canvas.width, canvas.height);

    // GPU program (vertex + fragment shader pair)
    gl.useProgram(helloTriangleProgram);
    gl.enableVertexAttribArray(vertexPositionAttributeLocation); // Enable the attributes we want to use
    gl.enableVertexAttribArray(vertexColorAttributeLocation); // Enable the color attribute



    // Input assembler - tell WebGL for each input attribute in the vetex shader which buffer are we going to read from and
    // how to read that information into the vec2
    gl.bindBuffer(gl.ARRAY_BUFFER, triangleGeoBuffer); // make sure that the buffer we are pulling data form in bound to that array buffer slot
    gl.vertexAttribPointer(
        /* index: which attribute to use */
        vertexPositionAttributeLocation,
        /* size: number of components in the attribute */
        2,
        /* type: what is the data type stored in the GPU buffer for this attribute? */
        gl.FLOAT,
        /* normalized: if type=float and is writing to a vec(n) float input, should WebGL normalize the data ints first? */
        false,
        /* stride: bytes between starting byte of attribute for a vertex and the same attrib for the next vertex
        0 - WebGL to figure it out, based on how many components are in the attribute and what type they are */
        2 * Float32Array.BYTES_PER_ELEMENT,
        /* offset: bytes between the start of the buffer and the first byte of the attribute,
        how many bytes should the input assembler skip into the buffer when reading attributes */
        0,
    )

    // New: set uniforms values !!
    // New: set canvas size uniform
    gl.uniform2f(canvasSizeUniform, canvas.width, canvas.height);



    // Draw call (also configures Primitive assembly)
    // Takes 3 parameters:
    // 1. tell the input assembler how to organize the triangles together
    // 2. what is the first vertex to look at
    // 3. how many vertices to process

    // New: Set the first triangle color buffer
    gl.bindBuffer(gl.ARRAY_BUFFER, rgbTriangleColorBuffer);
    gl.vertexAttribPointer(
        vertexColorAttributeLocation,
        3, gl.UNSIGNED_BYTE, true, 0, 0);

    // Draw 1st triangle
    // New need to set shape location and shape size uniforms for each triangle before the draw call
    gl.uniform1f(shapeSizeUniform, 200);
    gl.uniform2f(shapeLocationUniform, 300, 600);
    gl.drawArrays(gl.TRIANGLES, 0, 3);


    // New: Set the second triangle color buffer
    gl.bindBuffer(gl.ARRAY_BUFFER, fireyTriangleColorBuffer);
    gl.vertexAttribPointer(
        vertexColorAttributeLocation,
        3, gl.UNSIGNED_BYTE, true, 0, 0);

    // New: draw the second triangle
    gl.uniform1f(shapeSizeUniform, 100);
    gl.uniform2f(shapeLocationUniform, 650, 300);
    gl.drawArrays(gl.TRIANGLES, 0, 3);
}


try {
    movementAndColorDemo();
} catch (e) {
    showError(`Uncaught JavaScript exception: ${e}`);
}
