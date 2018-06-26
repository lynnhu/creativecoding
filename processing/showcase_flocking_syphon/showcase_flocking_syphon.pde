// Code from: https://processing.org/examples/flocking.html
import codeanticode.syphon.*;
PGraphics canvas;
SyphonServer server;

Flock flock;

void setup() {
  size(600, 600, P3D);
  canvas = createGraphics(600, 600, P3D);
  
  server = new SyphonServer(this, "Processing Syphon");
  
  flock = new Flock();
  for (int i = 0; i < 80; i ++){
    flock.addBoid(new Boid(random(0, width), random(0, height), floor(random(30, 80))));
  }
}

void draw() {
  canvas.beginDraw();
  canvas.background(255, 238, 238);
  flock.run();
  canvas.endDraw();
  
  image(canvas, 0, 0);
  server.sendImage(canvas);
  
  println(frameRate);
}

void mousePressed() {
  flock.addBoid(new Boid(mouseX, mouseY, floor(random(3, 20))));
}
