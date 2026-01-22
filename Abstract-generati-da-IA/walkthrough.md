# Walkthrough - AI Face Detector

I have successfully implemented the AI-Assisted Face Detector Web Application. The project is fully client-side, using Vite, Vanilla JS, and MediaPipe.

## Application Features

-   **Live Camera Input**: Automatically accesses the webcam (mirrored 16:9).
-   **Face Detection**: Real-time face detection using MediaPipe `BlazeFace` (short range).
-   **Visual Feedback**: Cyan bounding boxes with readable text background.
-   **Context**: Confidence score legend added to top center.
-   **Performance Stats**: Real-time FPS and Face Count display.
-   **Controls**:
    -   **Toggle Support**: Enable/Disable detection logic while keeping the camera running.
    -   **Screenshots**: Button to capture the current frame with bounding boxes.

## How to Run

1.  Open a terminal in the project directory:
    ```bash
    cd /home/mario/Desktop/Unipi/Magistrale/advanced-programming/Progetto-esame/AI-Web-Face-Detector
    ```
2.  Start the development server:
    ```bash
    npm run dev
    ```
    (This now runs `webpack serve`)
3.  Open the URL shown (usually `http://localhost:9000`) in your browser.
4.  Allow camera permissions when prompted.

## How to Run Production Build (`dist/`)

The `dist/` folder contains the standalone application. To run it, you must serve it via a web server (due to browser security restrictions on Camera/WASM):

**Using Python:**
```bash
cd dist
python3 -m http.server 8000
# Open http://localhost:8000
```

**Using Node:**
```bash
npx serve dist
```

## Implementation Details

-   **Bundling**: Migrated to **Webpack**.
-   **Offline Support**: WASM and TFLite models are bundled locally in `dist/assets` and `dist/wasm`.
-   **`src/core/Camera.js`**: Manages `getUserMedia` streams.

-   **`src/core/Detector.js`**: Wraps `@mediapipe/tasks-vision` for easy inference.
-   **`src/ui/Renderer.js`**: Handles the Canvas 2D context for drawing boxes over the video.
-   **`src/ui/UIManager.js`**: Manages the sidebar stats and buttons.
-   **`style.css`**: Dark theme with responsive Grid layout.

## Verification

-   [x] **Build Check**: `npm run build` completed successfully (Webpack).
-   [x] **Offline Assets**: `face_detector.tflite` and WASM binaries are included in the bundle.
-   [x] **Dependencies**: All packages installed (`webpack`, `@mediapipe/tasks-vision`).
-   [x] **Structure**: Follows the Controller-Model-View pattern as planned.
