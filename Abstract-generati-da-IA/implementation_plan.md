# Implementation Plan - AI-Assisted Face Detector

## Goal Description
Develop a browser-based, client-side face detection application using JavaScript and MediaPipe. The app will feature live camera input, real-time bounding box visualization, performance statistics, and privacy-focused local processing.

## Proposed Changes

### Tech Stack
- **Build Tool**: Vite (Vanilla JS template)
- **Language**: JavaScript (ES Modules)
- **Styling**: Vanilla CSS (CSS Variables for theming)
- **AI Library**: MediaPipe Tasks Vision (`@mediapipe/tasks-vision`)

### Architecture
The application will use a modular structure:
- **`main.js`**: Entry point, initializes the app.
- **`Camera.js`**: Handles `getUserMedia` and video stream management.
- **`Detector.js`**: Encapsulates MediaPipe FaceDetector logic.
- **`Renderer.js`**: Handles Canvas 2D drawing (video frame + bounding boxes).
- **`UIManager.js`**: Manages DOM elements (buttons, stats, sidebar).

### Directory Structure
```
/
├── index.html          # Main HTML structure
├── style.css           # Global styles (Dark theme)
├── src/
│   ├── main.js         # Application bootstrap
│   ├── core/
│   │   ├── Camera.js
│   │   └── Detector.js
│   └── ui/
│       ├── Renderer.js
│       └── UIManager.js
└── package.json
```

### [Root]
#### [NEW] [index.html](file:///home/mario/Desktop/Unipi/Magistrale/advanced-programming/Progetto-esame/AI-Web-Face-Detector-V2/index.html)
- Define the grid layout corresponding to the wireframe:
    - Header (80px height)
    - Sidebar (Controls & Info)
    - Main Content (Canvas/Video Container)

#### [NEW] [style.css](file:///home/mario/Desktop/Unipi/Magistrale/advanced-programming/Progetto-esame/AI-Web-Face-Detector-V2/style.css)
- Implement CSS Grid/Flexbox layout.
- Define Dark Mode color palette (root variables).
- Responsive adjustments.

### [Source]
#### [NEW] [main.js](file:///home/mario/Desktop/Unipi/Magistrale/advanced-programming/Progetto-esame/AI-Web-Face-Detector-V2/src/main.js)
- Coordinate `Camera`, `Detector`, and `UIManager`.
- Main animation loop (`requestAnimationFrame`).

#### [NEW] [Camera.js](file:///home/mario/Desktop/Unipi/Magistrale/advanced-programming/Progetto-esame/AI-Web-Face-Detector-V2/src/core/Camera.js)
- `start()`: Requests camera access.
- `stop()`: Stops tracks.
- `getVideoElement()`: Returns the video DOM element.

#### [NEW] [Detector.js](file:///home/mario/Desktop/Unipi/Magistrale/advanced-programming/Progetto-esame/AI-Web-Face-Detector-V2/src/core/Detector.js)
- Initialize `FaceDetector` from `@mediapipe/tasks-vision`.
- `detect(videoElement)` method returning results.

#### [NEW] [Renderer.js](file:///home/mario/Desktop/Unipi/Magistrale/advanced-programming/Progetto-esame/AI-Web-Face-Detector-V2/src/ui/Renderer.js)
- Draw video frame to canvas.
- Draw bounding boxes based on detection results.
- Handle resizing.

#### [NEW] [UIManager.js](file:///home/mario/Desktop/Unipi/Magistrale/advanced-programming/Progetto-esame/AI-Web-Face-Detector-V2/src/ui/UIManager.js)
- Event listeners for "Toggle Detection" and "Screenshot".
- Update FPS and Face Count displays.

## Verification Plan

### Automated Tests
- None planned for this visual/interactive demo (unless unit tests are requested).

### Manual Verification
1.  **Layout Check**: Verify the UI matches the wireframe (Header, Sidebar, Main Area) and is responsive.
2.  **Camera Permissions**: Ensure browser asks for and receives camera permissions.
3.  **Detection Quality**: Move face in front of camera, verify bounding boxes track accurately.
4.  **Performance**: Check FPS counter remains stable (aiming for >30fps).
5.  **Features**:
    - Toggle Detection ON/OFF stops/starts the AI inference.
    - Screenshot button downloads an image.
