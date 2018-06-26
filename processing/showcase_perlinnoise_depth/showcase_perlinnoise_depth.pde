// Algorithm from: https://forum.processing.org/one/topic/how-to-make-perlin-noise-loop.html

int SEGMENTS = 100;
float ANGLE_PER_SEGMENT = TWO_PI / SEGMENTS;
int INNER_RADIUS = 20;
float RADIUS_VARIATION = 50;

float noiseScale = 0.2;

void setup(){
  size(600, 600);
}

void draw(){
  translate(width / 2, height / 2);
  
  background(0);
  noStroke();
  println(frameRate);
  
  for(int i = 0; i < 8; i ++){
    fill(255/8 * (7 - i));
    translate(5, 5);
    rotate(0.2);
    beginShape();
    for(int j = 0; j < SEGMENTS; j++){
      float angle = ANGLE_PER_SEGMENT * j;
      
      float cosA = cos(angle);
      float sinA = sin(angle);
      
      float time = frameCount * 0.01;
      float noiseValue = noise(noiseScale * cosA + noiseScale,
                                noiseScale * sinA + noiseScale,
                                time);
      // float radius = 30 * (8 - i) + (RADIUS_VARIATION * noiseValue);
      float radius = 300 - (RADIUS_VARIATION * (i + 1)) * noiseValue;
      
      vertex(radius * cosA, radius * sinA);
    }
    endShape();
  }
}
