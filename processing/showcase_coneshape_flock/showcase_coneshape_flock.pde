ArrayList<BodySection> blobs = new ArrayList<BodySection>();
// Blob b1;

int amount = 10;
int[] colors = {0, 255};

void setup() {
  size(800, 800);
  ellipseMode(RADIUS);
  noStroke();
  //fill(0, 0, 0, 200);
  
  for (int i = 0; i < amount; i ++){
    blobs.add(new BodySection(width / 2, height / 2));
  }
  // b1 = new Blob(0, 0);
}

void draw() {
  background(255);
  for (int i = amount; i > 0; i --){
    PVector destination = new PVector(mouseX, mouseY);
    BodySection section = blobs.get(amount - i);
    PVector delta = destination.sub(section.ppos);
    PVector force = delta.div(20 + i * 3);
    section.applyForce(force);
    section.update();
    fill(66, 244, 200, floor(255/ (amount)) * (amount - i));
    // fill(colors[i%2]);
    // section.display(1 + i / 2);
    section.display(8);
  }
}
