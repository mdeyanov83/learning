/** Display an error in our little erorr text area */
function showError(errorText) {
    const errorBoxDiv = document.getElementById("error-box");
    const errorTextElement = document.createElement("p");
    errorTextElement.innerText = errorText;
    errorBoxDiv.appendChild(errorTextElement);
    console.log(errorText);
}

function helloTriangle() {

    // Setup Step 1: Get the WebGL rendering context for our HTML canvas rendering area
    // The WebGL context is the object used to generate images via the WebGL API, and
    // the canvas it is associated with is an area where those generated images will
    // be placed by the browser once the JS code is done working on it

    // the type annotation is a comment totally ignored by JS, but helps IDEs
    // figure out that the HTML element is a canvas, not a div, p, span etc.
    /** @type {HTMLCanvasElement|null}  */
    const canvas = document.getElementById("demo-canvas");
    if (!canvas) {
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

    // Creata  list of [X, Y] coordinates of the corners ("vertices") of the trinagle to be drawn
    // JS arrays aren't very WebGL-friendly, so create a friendlier Float32Array
    // The data is useless on the CPU, so send it over to a GPU buffer by using the
    // ARRAY_BUFFER binding point and gl.bufferdData WebGL call

    // Define the data that the GPU is going to use
    // Triangle definition - JS array that has the X and Y positions of each of the corners (in clip space -1 to 1)
    const triangleVertices = [
        // Top middle
        0.0, 0.5,
        // Bottom left
        -0.5, -0.5,
        // Bottom right
        0.5, -0.5
    ];

    // put the data in to a 32 bit float array which the GPU preffers, and also the values stored next to eachother in memory
    // so we pass 1 whole chunk of data that represents the vertices to the GPU
    const triangleVerticesCpuBuffer = new Float32Array(triangleVertices);

    // Set up buffer and send it to the GPU
    const triangleGeoBuffer = gl.createBuffer(); // Create a buffer on the GPU, create a WebGL buffer type
    gl.bindBuffer(gl.ARRAY_BUFFER, triangleGeoBuffer); // Attach the buffer to a WEBGL attachment point
    gl.bufferData(gl.ARRAY_BUFFER, triangleVerticesCpuBuffer, gl.STATIC_DRAW); // The thing thats bound to the attachment point - give it this data

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

    void main() {
        gl_Position = vec4(vertexPosition, 0.0, 1.0);
    }`;

    // Send it over to the GPU - Create a shader, send the source code and compile
    const vertexShader = gl.createShader(gl.VERTEX_SHADER);
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

    out vec4 outputColor;

    void main() {
        outputColor = vec4(0.294, 0.0, 0.51, 1.0);
    }`;

    // Create shader, send the source code and compile
    const fragmentShader = gl.createShader(gl.FRAGMENT_SHADER);
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
    const triangleShaderProgram = gl.createProgram();
    gl.attachShader(triangleShaderProgram, vertexShader);
    gl.attachShader(triangleShaderProgram, fragmentShader);
    gl.linkProgram(triangleShaderProgram) // make sure the vertex and fragment shaders are compatible with eachother

    // Check for link error, similarly to checking for compile errors previously
    if (!gl.getProgramParameter(triangleShaderProgram, gl.LINK_STATUS)) {
        const linkError = gl.getProgramInfoLog(triangleShaderProgram);
        showError(`Failed to LINK shaders - ${linkError}`);
        return;
    }

    // Attribute locations allow us to talk about which shader input should
    // read from which GPU buffer in the later "vetexAttribPointer" call.

    // We need to get a handle on the vertex shader input (vertexPosition) so we can tell WebGL how to read this data later
    // we get the "attribute location" of this input. It is a number, starting at 0 indicating which attribute is it
    // in this case it is only 1, so value is 0. But still it is a good idea to ask:
    const vertexPositionAttribLocation = gl.getAttribLocation(triangleShaderProgram, "vertexPosition");
    // Error check if the variable is at least 0. it will be -1 if the call fails
    if (vertexPositionAttribLocation < 0) {
        showError(`Failed to get attrib location for vertexPosition`);
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
    gl.useProgram(triangleShaderProgram);
    gl.enableVertexAttribArray(vertexPositionAttribLocation); // Enable the attributes we want to use

    // Input assembler - tell WebGL for each input attribute in the vetex shader which buffer are we going to read from and
    // how to read that information into the vec2
    gl.bindBuffer(gl.ARRAY_BUFFER, triangleGeoBuffer); // make sure that the buffer we are pulling data form is bound to that array buffer slot
    gl.vertexAttribPointer(
        /* index: which attribute to use */
        vertexPositionAttribLocation,
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

    // Draw call (also configures Primitive assembly)
    // Takes 3 parameters:
    // 1. tell the input assembler how to organize the triangles together
    // 2. what is the first vertex to look at
    // 3. how many vertices to process
    gl.drawArrays(gl.TRIANGLES, 0, 3);
}


try {
    helloTriangle();
} catch (e) {
    showError(`Uncaught JavaScript exception: ${e}`);
}
