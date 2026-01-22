import { FaceDetector, FilesetResolver } from '@mediapipe/tasks-vision';
import faceModel from '../assets/models/face_detector.tflite';

export class Detector {
    constructor() {
        this.faceDetector = null;
        this.runningMode = 'VIDEO';
    }

    async initialize() {
        const vision = await FilesetResolver.forVisionTasks(
            './wasm' // Points to the copied local WASM directory
        );

        this.faceDetector = await FaceDetector.createFromOptions(vision, {
            baseOptions: {
                modelAssetPath: faceModel,
                delegate: 'GPU'
            },
            runningMode: this.runningMode
        });

        console.log('Face Detector initialized with offline assets');
    }

    detect(videoElement, startTimeMs) {
        if (!this.faceDetector) return [];

        const detections = this.faceDetector.detectForVideo(videoElement, startTimeMs);
        return detections.detections; // Returns array of Detection objects
    }
}
