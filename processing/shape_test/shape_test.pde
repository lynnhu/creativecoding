PShape p;
PImage pimg;

void setup(){
  size(800, 800, P3D);
  p = loadShape("p3.svg");
  p.disableStyle();
  PGraphics g = createGraphics(width, height);
  
  g.beginDraw();
  g.background(0, 0);
  g.fill(0, 0, 0, 50);
  g.noStroke();
  g.shape(p, 0, 0, p.width, p.height);
  g.endDraw();
  
  pimg = g.get(0, 0, ceil(p.width) + 1, ceil(p.height) + 1);
  
}

void draw(){
  background(255);
  imageMode(CENTER);
  
  //box(150);
  
  pushMatrix();
    translate(0, 0, -200);
    rotateX(radians(90));
    image(pimg, 0, 0, pimg.width, pimg.height);
  popMatrix();
  
  pushMatrix();
    translate(0, 0, 0);
    rotateX(radians(90));
    image(pimg, 0, 0, pimg.width, pimg.height);
  popMatrix();
  
  //camera(map(mouseX, 0, width, -100.0, 100.0), map(mouseY, 0, height, -100.0, 100.0), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
  
  camera(0, -200, (height / 2) / tan(PI / 6), 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);

  
  //shapeMode(CENTER);
  //p.disableStyle();
  //noStroke();
  
  //for(int i = 0; i < 10; i ++){
  //  fill( 255 / 10 * (10 - i));
  //  shape(s, width / 2, height / 2, s.width / 20 * (10 - i), s.height / 20 * (10 - i));
  //}
}
