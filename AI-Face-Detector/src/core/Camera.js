export class Camera {
    constructor(videoElement) {
        this.video = videoElement;
        this.stream = null;
    }

    async start() {
        if (this.stream) return;

        try {
            this.stream = await navigator.mediaDevices.getUserMedia({
                video: {
                    width: { ideal: 1280 },
                    height: { ideal: 720 },
                    facingMode: 'user'
                },
                audio: false
            });

            this.video.srcObject = this.stream;

            return new Promise((resolve) => {
                this.video.onloadedmetadata = () => {
                    this.video.play();
                    resolve(true);
                };
            });
        } catch (error) {
            console.error('Error accessing camera:', error);
            throw error;
        }
    }

    stop() {
        if (!this.stream) return;

        this.stream.getTracks().forEach(track => track.stop());
        this.video.srcObject = null;
        this.stream = null;
    }

    getVideo() {
        return this.video;
    }
}
