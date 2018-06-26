import codeanticode.syphon.*;

PGraphics canvas;
SyphonServer server;

void setup(){
  size(400, 400, P3D);
  canvas = createGraphics(400, 400, P3D);

  server = new SyphonServer(this, "Processing Syphon");
}

void draw(){
  canvas.beginDraw();
  canvas.background(0);
  canvas.fill(255);
  canvas.noStroke();
  canvas.ellipse(mouseX, mouseY, 10, 10);
  canvas.endDraw();
  image(canvas, 0, 0);
  
  server.sendImage(canvas);
}
