function showError(errorText) {
    const errorBoxDiv = document.getElementById("error-box");
    const errorTextElement = document.createElement("p");
    errorTextElement.innerText = errorText;
    errorBoxDiv.appendChild(errorTextElement);
    console.log(errorText);
}

function mandelbrotSet(ctx, width, height, centerX, centerY, zoom, maxIterations) {
    const imageData = ctx.getImageData(0, 0, width, height);
    const data = imageData.data;
    let aspectRatio = width / height; // Fix aspect ratio distortion

    for (let y = 0; y < height; y++) {
        for (let x = 0; x < width; x++) {
            let zx = 0, zy = 0;
            let cx = (x - width / 2) / (0.5 * zoom * width) * aspectRatio + centerX;
            let cy = (y - height / 2) / (0.5 * zoom * height) + centerY;
            let i;

            for (i = 0; i < maxIterations; i++) {
                let xtemp = zx * zx - zy * zy + cx;
                zy = 2.0 * zx * zy + cy;
                zx = xtemp;
                if (zx * zx + zy * zy > 4.0) break;
            }

            let norm = i / maxIterations;
            let color;
            if (norm < 0.33) {
                color = [0, norm * 255 / 0.33, 255];
            } else if (norm < 0.66) {
                color = [0, 255, 255 - ((norm - 0.33) * 255 / 0.33)];
            } else {
                color = [norm * 255, 255 - ((norm - 0.66) * 255 / 0.34), 0];
            }

            let index = (y * width + x) * 4;
            data[index] = color[0];
            data[index + 1] = color[1];
            data[index + 2] = color[2];
            data[index + 3] = 255;
        }
    }
    ctx.putImageData(imageData, 0, 0);
}

function main() {
    const mainCanvas = document.getElementById("main-canvas");
    if (!mainCanvas) {
        showError("Cannot get main canvas reference");
        return;
    }
    const ctx = mainCanvas.getContext("2d", { willReadFrequently: true });
    if (!ctx) {
        showError("Canvas 2D context not supported");
        return;
    }

    let centerX = -0.7, centerY = 0.0;
    let zoom = 1.0;
    let maxIterations = 500;

    mainCanvas.width = mainCanvas.clientWidth;
    mainCanvas.height = mainCanvas.clientHeight;

    function render() {
        mandelbrotSet(ctx, mainCanvas.width, mainCanvas.height, centerX, centerY, zoom, maxIterations);
    }

    mainCanvas.addEventListener("wheel", (e) => {
        e.preventDefault();
        zoom *= e.deltaY > 0 ? 0.8 : 1.2;
        mainCanvas.width = 200;
        mainCanvas.height = 150;
        render();
        console.log(zoom);
    });

    let scrollTimer;

    mainCanvas.addEventListener("wheel", () => {
        clearTimeout(scrollTimer); // Reset timer
        scrollTimer = setTimeout(() => {
            mainCanvas.width = mainCanvas.clientWidth;
            mainCanvas.height = mainCanvas.clientHeight;
            render();
        }, 200);
    });

    let isDragging = false, lastX, lastY;
    mainCanvas.addEventListener("mousedown", (e) => {
        isDragging = true;
        lastX = e.clientX;
        lastY = e.clientY;
        mainCanvas.width = 200;
        mainCanvas.height = 150;
        render();
    });
    mainCanvas.addEventListener("mousemove", (e) => {
        if (isDragging) {
            let dx = (e.clientX - lastX) / mainCanvas.width * (4.0 / zoom);
            let dy = (e.clientY - lastY) / mainCanvas.height * (4.0 / zoom);
            centerX -= dx;
            centerY -= dy;
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

    render();
}

document.addEventListener("DOMContentLoaded", () => {
    try {
        main();
    } catch (e) {
        showError(`Uncaught JavaScript exception: ${e}`);
    }
});
