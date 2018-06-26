// Code from: https://processing.org/examples/flocking.html

Flock flock;

void setup() {
  size(600, 600);
  
  flock = new Flock();
  for (int i = 0; i < 40; i ++){
    flock.addBoid(new Boid(random(0, width), random(0, height), floor(random(25, 50))));
  }
}

void draw() {
  background(255);
  flock.run();
  println(frameRate);
}

void mousePressed() {
  flock.addBoid(new Boid(mouseX, mouseY, floor(random(3, 20))));
}
