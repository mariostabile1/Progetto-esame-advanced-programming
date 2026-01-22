import '../style.css';
import { Camera } from './core/Camera.js';
import { Detector } from './core/Detector.js';
import { Renderer } from './ui/Renderer.js';
import { UIManager } from './ui/UIManager.js';

const app = {
  camera: null,
  detector: null,
  renderer: null,
  ui: null,
  lastFrameTime: 0,
  frameCount: 0,
  fps: 0,
  lastFpsUpdate: 0,

  async init() {
    // Initialize UI
    this.ui = new UIManager();
    this.ui.setLoading(true);

    // Initialize Components
    const videoElement = document.getElementById('webcam');
    const canvasElement = document.getElementById('output-canvas');

    this.camera = new Camera(videoElement);
    this.renderer = new Renderer(canvasElement);
    this.detector = new Detector();

    // Load AI Models
    try {
      await this.detector.initialize();
      this.ui.setLoading(false);

      // Start Camera
      await this.camera.start();

      // Bind Events
      this.ui.onToggle = (isEnabled) => {
        console.log(`Detection ${isEnabled ? 'enabled' : 'disabled'}`);
      };

      this.ui.onScreenshot = () => {
        this.takeScreenshot();
      };

      // Start Loop
      requestAnimationFrame((time) => this.loop(time));

    } catch (error) {
      console.error("Initialization failed:", error);
      alert("Failed to initialize. Check console for details.");
    }
  },

  loop(timestamp) {
    if (!this.lastFrameTime) this.lastFrameTime = timestamp;
    const deltaTime = timestamp - this.lastFrameTime;
    this.lastFrameTime = timestamp;

    // Calculate FPS
    this.frameCount++;
    if (timestamp - this.lastFpsUpdate >= 1000) {
      this.fps = this.frameCount;
      this.frameCount = 0;
      this.lastFpsUpdate = timestamp;
    }

    const video = this.camera.getVideo();

    if (video.readyState === 4) { // HAVE_ENOUGH_DATA
      // Ensure canvas size matches video
      if (this.renderer.width !== video.videoWidth || this.renderer.height !== video.videoHeight) {
        this.renderer.setSize(video.videoWidth, video.videoHeight);
      }

      let detections = [];
      if (this.ui.isDetectionEnabled) {
        detections = this.detector.detect(video, timestamp);
      }

      this.renderer.draw(video, detections);
      this.ui.updateStats(this.fps, detections.length);
    }

    requestAnimationFrame((time) => this.loop(time));
  },

  takeScreenshot() {
    const canvas = this.renderer.getCanvas();
    const link = document.createElement('a');
    link.download = `face-detection-${new Date().toISOString()}.png`;
    link.href = canvas.toDataURL();
    link.click();
  }
};

window.addEventListener('DOMContentLoaded', () => {
  app.init();
});
