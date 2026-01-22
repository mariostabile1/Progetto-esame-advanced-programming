== Primo prompt

Project Title: AI-Assisted Face Detector Web Application

Context:
This is a web application that consist in an browser based face detection application that runs entirelly on client side.
This project is part of a University exam.

Main Goal:
design and implement a browser-based face detection application that runs entirely client-side
(e.g. using JavaScript, WebAssembly, or existing in-browser ML libraries),
supporting live camera input and basic visualization of detected faces (bounding boxes).

What is important:
- The software must recognize faces efficiently and quickly
- It must be a web application (in the browser)
- Everything must work within the browser, without external servers
- It must work on all major browsers
- It must respect privacy; nothing goes outside the browser, everything must remain local

Design:
- is a web app designed for desktop (16:9)
- dark palette for the theme
- for the component layout refer to the linked image

Features:
- button for screenshots of the output of the webcam with the bounding boxes
- a button to toggle on and off face detection
- some statistics

Ask me any questions you may have.
#figure(
  image("AI-FACE-DETECTOR-WIREFRAME.png"),
  caption: [Immagine del layout linkata (non generata da IA)]
)
=== Risposta al primo prompt

I have created a task list and an implementation plan for the Face Detector application.

Please review the Implementation Plan to confirm the architecture (Vite + Vanilla JS + MediaPipe) and the features (Camera, Detection, Bounding Boxes, Stats, Screenshot).

If this looks good, I will proceed with initializing the project.

== Secondo prompt

I have notice that the bounding box label are mirrored and are painted with a color that is difficult to see.
mirror back the label on the bounding box and add in the top center what the % value mean
than change the bounding box color to something still visible but also more readable

=== Risposta al secondo prompt

I have updated the application with the requested UI improvements:

Readable Text: The bounding box text is no longer mirrored and has a background for better contrast.
New Colors: Changed the bounding box color to Cyan `(#00FFFF)`for better visibility.
Legend: Added a "Values indicate Confidence Score %" label at the top.
The text mirroring was fixed by handling the flip manually in the renderer instead of using CSS on the canvas.

You can verify the changes by running npm run dev.

== Terzo prompt
Answer some questions: the vision model run on cpu or gpu? and if it runs on gpu, it can anyway work on every laptop?

=== Risposta al terzo prompt
Based on the current implementation in
src/core/Detector.js, here are the answers to your questions:

1. Does the vision model run on CPU or GPU? It is currently configured to run on the GPU. The code explicitly sets delegate: 'GPU' when initializing the FaceDetector.

2. If it runs on GPU, does it work on every laptop? Yes, for the vast majority of cases.

How it works: The "GPU" mode in the browser uses WebGL (or WebGPU), which is a standard web technology supported by all major browsers (Chrome, Firefox, Edge, Safari) and works on almost all modern laptops, including those with integrated graphics (like Intel HD/UHD Graphics or Apple Silicon).
Privacy: Even on the GPU, everything runs entirely client-side. No images are sent to a server.
Compatibility Edge Cases: If a laptop is extremely old (10+ years), lacks valid graphics drivers, or has hardware acceleration disabled in the browser settings, the GPU mode might fail.
Recommendation: If you want to guarantee 100% reliability even on problematic hardware, we could add a fallback mechanism: try to initialize with GPU first, and if that fails, automatically restart with CPU. Would you like me to implement this fallback logic?
