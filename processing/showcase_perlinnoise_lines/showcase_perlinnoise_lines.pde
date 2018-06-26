int SEGMENTS = 100;
float ANGLE_PER_SEGMENT = TWO_PI / SEGMENTS;
int INNER_RADIUS = 20;
float RADIUS_VARIATION = 50;

int amount = 20;
float noiseScale = 0.2;

void setup(){
  size(600, 600);
}

void draw(){
  translate(width / 2, height / 2);
  
  background(255);
  noFill();
  // stroke(0);
  strokeWeight(2);
  println(frameRate);
  
  for(int i = 0; i < amount; i ++){
    stroke(255/amount * i);
    translate(2, 5);
    rotate(0.1);
    beginShape();
    for(int j = 0; j < SEGMENTS; j++){
      float angle = ANGLE_PER_SEGMENT * j;
      
      float cosA = cos(angle);
      float sinA = sin(angle);
      
      float time = frameCount * 0.03;
      float noiseValue = noise(noiseScale * cosA + noiseScale,
                                noiseScale * sinA + noiseScale,
                                time);
      // float radius = 30 * (8 - i) + (RADIUS_VARIATION * noiseValue);
      float radius = 10 + (RADIUS_VARIATION * (i + 1)) * noiseValue;
      
      vertex(radius * cosA, radius * sinA);
    }
    endShape(CLOSE);
  }
}
