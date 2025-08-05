document.addEventListener("DOMContentLoaded", () => {
    drawCanvas()
})

function drawCanvas() {

    /** @type {HTMLCanvasElement} */
    const canvas = document.getElementById("myCanvas");
    const ctx = canvas.getContext("2d");

    // Draw a solidrectangle (fill)
    ctx.fillStyle = "red";
    ctx.fillRect(0, 0, 150, 150);

    // Draw an outline rectangle (stroke)
    ctx.strokeStyle = "blue";
    ctx.lineWidth = 5;
    ctx.strokeRect(200, 0, 80, 120)

    // Draw a line

    ctx.beginPath();
    ctx.moveTo(0,300);
    ctx.lineTo(400,0);
    ctx.strokeStyle = "green"
    ctx.stroke();

    // Draw a circle
    ctx.beginPath();
    ctx.arc(200, 300, 100, 0, 2 * Math.PI);
    ctx.stroke()

}
