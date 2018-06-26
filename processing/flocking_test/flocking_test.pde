Flock flock;

void setup() {
  size(640, 360);
  
  flock = new Flock();
  // Add an initial set of boids into the system
  for (int i = 0; i < 80; i++) {
    flock.addBoid(new Boid(width/2,height/2));
  }
}

void draw() {
  background(0, 0, 0);
  // background(34, 117, 249);
  flock.run();
}

// Add a new boid into the System
void mousePressed() {
  flock.addBoid(new Boid(mouseX,mouseY));
}
