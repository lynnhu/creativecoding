void setup(){
  size(400, 400);
  
  background(0);
  ellipseMode(CENTER);
  noStroke();
  translate(width / 2, height / 2);
  
  for(int i = 0; i < 8; i ++){
    translate(1, 2);
    fill( 255 / 8 * (8 - i));
    ellipse(0, 0, 30 * (8 - i), 40 * (8 - i));
  }
  
  noLoop();
}

void draw(){

}
