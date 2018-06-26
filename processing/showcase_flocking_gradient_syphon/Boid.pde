// The Boid class

class Boid {

  PVector position;
  PVector velocity;
  PVector acceleration;
  
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  int segments;
  color c1;
  color c2;
  PVector[] history;

  Boid(float x, float y, int seg) {
    position = new PVector(x, y);
    velocity = PVector.random2D();
    acceleration = new PVector(0, 0);
    
    r = 2.0;
    maxspeed = 3;
    maxforce = 0.03;    
    segments = seg;
        
    colorMode(HSB, 360, 100, 100);
    c1 = color(random(200, 220), random(38, 42), random(34, 40));
    c2 = color(random(260, 280), random(20, 30), random(50, 70));
    
    history = new PVector[segments];
    for (int i = 0; i < segments; i ++){
      history[i] = position;
    }
  }
  color genColor(){
    colorMode(HSB, 360, 100, 100);
    color c;
    
    float r = random(1);
    if ( r > 0.5) {
      // Primary color
      // Light pink
      c = color(random(200, 220), random(38, 42), random(34, 40));
    } else if ((r <= 0.5) && (r > 0.35)) {
      // Secondary color
      // Salmon red
      c = color(random(340, 360), random(50, 60), random(90, 100));
    } else {
      // Accent color
      // Purple
      c = color(random(260, 280), random(20, 30), random(50, 70));
    }
    return c;
  }
  
  void render() {
    // Draw a triangle rotated in the direction of velocity
    // float theta = velocity.heading2D() + radians(90);
    // heading2D() above is now heading() but leaving old syntax until Processing.js catches up
    
    // canvas.fill(255, 255, 255, 100);
    canvas.ellipseMode(CENTER);
    canvas.noStroke();
    
    float step = 1 / segments;
    
    for (int i = 0; i < segments; i ++){
      canvas.fill(lerpColor(c1, c2, step * i));
      //fill(66, 244, 200, floor(255/ (segments)) * (segments - i));
      canvas.ellipse(history[i].x, history[i].y, 5 + i * 0.2, 5 + i * 0.2);
    }
  }
  
  void run(ArrayList<Boid> boids) {
    flock(boids);
    update();
    borders();
    render();
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList<Boid> boids) {
    PVector sep = separate(boids);   // Separation
    PVector ali = align(boids);      // Alignment
    PVector coh = cohesion(boids);   // Cohesion
    // Arbitrarily weight these forces
    sep.mult(0.5);
    ali.mult(0.5);
    coh.mult(0.5);
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }

  // Method to update position
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    position.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
    
    // Update history stack
    for (int i = segments - 2; i > 0; i --){
      history[i + 1] = history[i].copy(); //<>//
    }
    history[0] = position.copy();
  }

  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, position);  // A vector pointing from the position to the target
    // Scale to maximum speed

    desired.setMag(maxspeed);

    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    return steer;
  } //<>//

  // Wraparound
  void borders() {
    if (position.x < -r) position.x = width+r;
    if (position.y < -r) position.y = height+r;
    if (position.x > width+r) position.x = -r;
    if (position.y > height+r) position.y = -r;
  }

  // Separation
  // Method checks for nearby boids and steers away
  PVector separate (ArrayList<Boid> boids) {
    float desiredseparation = 25.0f;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      // steer.setMag(maxspeed);

      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  PVector align (ArrayList<Boid> boids) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      // sum.setMag(maxspeed);

      // Implement Reynolds: Steering = Desired - Velocity
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } 
    else {
      return new PVector(0, 0);
    }
  }

  // Cohesion
  // For the average position (i.e. center) of all nearby boids, calculate steering vector towards that position
  PVector cohesion (ArrayList<Boid> boids) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all positions
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.position); // Add position
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the position
    } 
    else {
      return new PVector(0, 0);
    }
  }
}
