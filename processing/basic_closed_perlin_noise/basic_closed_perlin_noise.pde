int   SEGMENTS          = 100;
float ANGLE_PER_SEGMENT = TWO_PI / SEGMENTS;
int   INNER_RADIUS      = 20;
float RADIUS_VARIATION  = 100;

void setup() {
  size(500, 500);
 }

PVector PointForIndex(int i) {
  float angle = ANGLE_PER_SEGMENT * i;
  
  float cosAngle = cos(angle);
  float sinAngle = sin(angle);
  
  float noiseScale = 0.5;
  float time = frameCount * 0.01;
  float noiseValue = noise(noiseScale * cosAngle + noiseScale,
                           noiseScale * sinAngle + noiseScale,
                           time);
                           
  float radius = INNER_RADIUS + (RADIUS_VARIATION * noiseValue);
  
  return new PVector(radius * cosAngle, radius * sinAngle);
}

void draw() {
  translate(width / 2, height / 2);

  background(0);
  fill(255);
  
  beginShape();
  for (int i = 0; i < SEGMENTS; ++ i){
    vertex(PointForIndex(i).x, PointForIndex(i).y);
  }
  endShape();
  //translate(width / 2, height / 2);
  
  //for (int i = 0; i < SEGMENTS; ++i) {
  //  PVector p0 = PointForIndex(i);
  //  PVector p1 = PointForIndex(i + 1);
    
  //  line(p0.x, p0.y, p1.x, p1.y);
  //}
}
