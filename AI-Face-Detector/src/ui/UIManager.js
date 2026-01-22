export class UIManager {
    constructor() {
        this.toggleBtn = document.getElementById('toggle-detection');
        this.screenshotBtn = document.getElementById('screenshot-btn');
        this.statusDisplay = document.getElementById('status-display');
        this.fpsDisplay = document.getElementById('fps-display');
        this.faceCountDisplay = document.getElementById('face-count-display');

        this.isDetectionEnabled = false;

        this.onToggle = null;
        this.onScreenshot = null;

        this.bindEvents();
    }

    bindEvents() {
        this.toggleBtn.addEventListener('click', () => {
            this.isDetectionEnabled = !this.isDetectionEnabled;
            this.updateToggleState();
            if (this.onToggle) this.onToggle(this.isDetectionEnabled);
        });

        this.screenshotBtn.addEventListener('click', () => {
            if (this.onScreenshot) this.onScreenshot();
        });
    }

    updateToggleState() {
        if (this.isDetectionEnabled) {
            this.toggleBtn.textContent = 'Disable Detection';
            this.toggleBtn.classList.remove('primary');
            this.toggleBtn.classList.add('secondary'); // or danger
            this.toggleBtn.style.backgroundColor = '#ff4d4d'; // Danger color manually if class not enough
            this.statusDisplay.textContent = 'Running';
            this.statusDisplay.style.color = '#00ff00';
        } else {
            this.toggleBtn.textContent = 'Enable Detection';
            this.toggleBtn.classList.remove('secondary');
            this.toggleBtn.classList.add('primary');
            this.toggleBtn.style.backgroundColor = ''; // Reset
            this.statusDisplay.textContent = 'Paused';
            this.statusDisplay.style.color = 'var(--text-secondary)';
            this.fpsDisplay.textContent = '0';
            this.faceCountDisplay.textContent = '0';
        }
    }

    setLoading(isLoading) {
        if (isLoading) {
            this.statusDisplay.textContent = 'Loading models...';
            this.toggleBtn.disabled = true;
        } else {
            this.statusDisplay.textContent = 'Ready';
            this.toggleBtn.disabled = false;
        }
    }

    updateStats(fps, faceCount) {
        if (this.isDetectionEnabled) {
            this.fpsDisplay.textContent = Math.round(fps);
            this.faceCountDisplay.textContent = faceCount;
        }
    }
}
