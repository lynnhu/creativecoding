import codeanticode.syphon.*;

PGraphics canvas;
SyphonServer server;

Flock flock;

void setup() {
  size(640, 360, P3D);
  canvas = createGraphics(640, 360, P3D);
  
  server = new SyphonServer(this, "Processing Syphon");
  
  flock = new Flock();
  // Add an initial set of boids into the system
  for (int i = 0; i < 150; i++) {
    flock.addBoid(new Boid(width/2,height/2));
  }
}

void draw() {
  canvas.beginDraw();
  canvas.background(34, 117, 249);
  flock.run();
  canvas.endDraw();
  image(canvas, 0, 0);
  server.sendImage(canvas);
}

// Add a new boid into the System
void mousePressed() {
  flock.addBoid(new Boid(mouseX,mouseY));
}
