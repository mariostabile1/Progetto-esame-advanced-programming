export class Renderer {
    constructor(canvasElement) {
        this.canvas = canvasElement;
        this.ctx = canvasElement.getContext('2d');
        this.width = 0;
        this.height = 0;
    }

    setSize(width, height) {
        this.width = width;
        this.height = height;
        this.canvas.width = width;
        this.canvas.height = height;
    }

    draw(videoElement, detections) {
        if (!this.width || !this.height) return;

        // Draw video frame mirrored
        this.ctx.save();
        this.ctx.scale(-1, 1);
        this.ctx.drawImage(videoElement, -this.width, 0, this.width, this.height);
        this.ctx.restore();

        // Draw Legend (Top Center)
        this.ctx.save();
        this.ctx.fillStyle = 'rgba(0, 0, 0, 0.5)';
        this.ctx.fillRect(this.width / 2 - 120, 10, 240, 30);
        this.ctx.fillStyle = '#FFFFFF';
        this.ctx.font = '14px Inter, sans-serif';
        this.ctx.textAlign = 'center';
        this.ctx.fillText('Values indicate Confidence Score %', this.width / 2, 30);
        this.ctx.restore();

        // Draw detections
        this.ctx.save();
        this.ctx.lineJoin = 'round';
        this.ctx.font = 'bold 18px monospace';

        detections.forEach(detection => {
            const { originX, originY, width, height } = detection.boundingBox;

            // Mirror coordinates for visual consistency
            // Original X is from left of raw frame. Mirrored X is from right.
            const mirroredX = this.width - originX - width;

            // Colors
            const boxColor = '#00FFFF'; // Cyan
            const textColor = '#000000';
            const textBgColor = '#00FFFF';

            // Draw box
            this.ctx.strokeStyle = boxColor;
            this.ctx.lineWidth = 4;
            this.ctx.beginPath();
            this.ctx.rect(mirroredX, originY, width, height);
            this.ctx.stroke();

            // Draw score
            if (detection.categories && detection.categories.length > 0) {
                const score = Math.round(detection.categories[0].score * 100);
                const label = `${score}%`;

                const textWidth = this.ctx.measureText(label).width;
                const textPad = 6;
                const textX = mirroredX;
                const textY = originY - 10;

                // Background for text
                this.ctx.fillStyle = textBgColor;
                this.ctx.fillRect(textX, textY - 18, textWidth + textPad * 2, 24);

                // Text
                this.ctx.fillStyle = textColor;
                this.ctx.fillText(label, textX + textPad, textY);
            }
        });

        this.ctx.restore();
    }

    getCanvas() {
        return this.canvas;
    }
}
