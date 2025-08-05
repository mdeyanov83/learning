// Display an error message to the DOM, beneath the demo element
export function showError(errorText: string) {
    console.error(errorText);
    const errorBoxDiv = document.getElementById("error-box");
    if (errorBoxDiv === null) {
        return;
    }
    const errorElement = document.createElement("p");
    errorElement.innerText = errorText;
    errorBoxDiv.appendChild(errorElement);
}


export function createStaticVertexBuffer(gl: WebGL2RenderingContext, data: ArrayBuffer) {
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


export function createStaticIndexBuffer(gl: WebGL2RenderingContext, data: ArrayBuffer) {
    const buffer = gl.createBuffer();
    if (!buffer) {
        showError("Failed to allocate buffer");
        return null;
    }

    gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, buffer);
    gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, data, gl.STATIC_DRAW);
    gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, null);

    return buffer;
}


export function createProgram(
    gl: WebGL2RenderingContext,
    vertexShaderSource: string,
    fragmentShaderSource: string) {

    // Send it over to the GPU - Create a shader, send the source code and compile
    const vertexShader = gl.createShader(gl.VERTEX_SHADER);
    const fragmentShader = gl.createShader(gl.FRAGMENT_SHADER);
    const program = gl.createProgram();

    if (!vertexShader || !fragmentShader || !program) {
        showError(`Failed to allocate GL objects (`
            + `vs=${!!vertexShader}, `
            + `fs=${!!fragmentShader}, `
            + `program=${!!program})`);
        return null;
    }

    gl.shaderSource(vertexShader, vertexShaderSource);
    gl.compileShader(vertexShader);
    // Check for compilation problems due to typing errors in the shader source code
    // since it just a string, so code formattion will not catch typos
    if (!gl.getShaderParameter(vertexShader, gl.COMPILE_STATUS)) {
        const compileError = gl.getShaderInfoLog(vertexShader);
        showError(`Failed to COMPILE vertex shader - ${compileError}`);
        return;
    }

    gl.shaderSource(fragmentShader, fragmentShaderSource);
    gl.compileShader(fragmentShader);
    // Check for compilation errors
    if (!gl.getShaderParameter(fragmentShader, gl.COMPILE_STATUS)) {
        const compileError = gl.getShaderInfoLog(fragmentShader);
        showError(`Failed to COMPILE fragment shader - ${compileError}`);
        return;
    }

    gl.attachShader(program, vertexShader);
    gl.attachShader(program, fragmentShader);
    gl.linkProgram(program) // make sure the vertex and fragment shaders are compatible with eachother

    // Check for link error, similarly to checking for compile errors previously
    if (!gl.getProgramParameter(program, gl.LINK_STATUS)) {
        const linkError = gl.getProgramInfoLog(program);
        showError(`Failed to LINK GPU program: ${linkError}`);
        return null;
    }

    return program;
}


export function getContext(canvas: HTMLCanvasElement) {

    const gl = canvas.getContext("webgl2");
    if (!gl) {
        const isWebGl1Supported = !!canvas.getContext("webgl");
        if (isWebGl1Supported) {
            throw new Error("This browser supports WebGL 1 but not WebGL 2 - make sure WebGL 2 isn't disabled in your browser");
        } else {
            throw new Error("This browser does not support WebGL 2 - this demo will not work!");
        }
    }
    return gl;
}


export function getRandomInRange(min: number, max: number) {
    return Math.random() * (max - min) + min;
}
