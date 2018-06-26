import codeanticode.syphon.*;
PGraphics canvas;
SyphonServer server;

//import processing.video.*;
//Movie sky;

Flock flock;

void setup(){
  // Create Syphon server
  size(800, 800, P3D);
  canvas = createGraphics(800, 800, P3D);
  server = new SyphonServer(this, "Processing Syphon");
  
  // Prepare movie
  //sky = new Movie(this, "sky.mov");
  //sky.loop();
  
  //Create flock
  flock = new Flock();
  for (int i = 0; i < 40; i ++){
    flock.addBoid(new Boid(random(0, width), random(0, height), floor(random(50, 80))));
  }
}

void draw() {
  canvas.beginDraw();
  
  // Draw movie frame
  //canvas.imageMode(CENTER);
  //canvas.image(sky, width / 2, height / 2);
  
  // Animate flock
  canvas.background(250);
  flock.run();
  
  canvas.endDraw();
  
  image(canvas, 0, 0);
  server.sendImage(canvas);
  
  println(frameRate);
}

//void movieEvent(Movie m){
//  m.read();
//}

void mousePressed() {
  flock.addBoid(new Boid(mouseX, mouseY, floor(random(50, 80))));
}
