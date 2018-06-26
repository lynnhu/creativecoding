class BodySection {
  PVector pos;
  PVector vel;
  PVector accl;
  PVector ppos;
  float damping = 0.8;
  
  BodySection(float x, float y) {
    ppos = new PVector(x, y);
    pos = new PVector(x, y);
    vel = new PVector();
    accl = new PVector();
  }
  
  void update(){
    ppos = pos.copy();
    vel.add(accl);
    vel.mult(damping);
    pos.add(vel);
    accl.mult(0);
  }
  
  void applyForce(PVector force) {
    // Ignoring mass for now
    accl.add(force);
  }
  
  void display(float size){
    ellipse(pos.x, pos.y, size, size);
  }
}
