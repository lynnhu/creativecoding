// http://codingtra.in
// http://patreon.com/codingtrain
// Code for this video: https://youtu.be/BV9ny785UNc

// Written entirely based on
// http://www.karlsims.com/rd.html

// Also, for reference
// http://hg.postspectacular.com/toxiclibs/src/44d9932dbc9f9c69a170643e2d459f449562b750/src.sim/toxi/sim/grayscott/GrayScott.java?at=default

Cell[][] grid;
Cell[][] prev;
float [] feed;
float dA = 1.0;
float dB = 0.5;
float fMin = 0.02;
float fMax = 0.07;
float kMin = 0.05;
float kMax = 0.07;
float k = 0.062;

void setup(){
  size(400, 400);
  grid = new Cell[width][height];
  prev = new Cell[width][height];
  feed = new float[width];
    
  for (int i = 0; i < width; i ++){
    for (int j = 0; j < height; j ++) {
      float a = 1;
      float b = 0;
      grid[i][j] = new Cell(a, b);
      prev[i][j] = new Cell(a, b);
    }
    if ( i < width / 2) {
      feed[i] = map(i, 0.0, width/2, fMin, fMax);
    } else {
      feed[i] = map(i, width/2, width, fMax, fMin);
    } //<>//
  }
  
  // Seed a + b
  for (int i = 18; i < width-22; i += 25) {
    for (int n = 0; n < 3; n ++) {
      float a = 1;
      float b = 1;
      grid[i+n][199+n] = new Cell(a, b);
      grid[i+n][200+n] = new Cell(a, b);
      grid[i+n][201+n] = new Cell(a, b);
      
      prev[i+n][199+n] = new Cell(a, b);
      prev[i+n][200+n] = new Cell(a, b);
      prev[i+n][201+n] = new Cell(a, b);
    }
  }
}

class Cell {
  float a;
  float b;
  
  Cell(float a_, float b_){
    a = a_;
    b = b_;
  }
}

void update(){
 for (int i = 1; i < width - 1; i ++) {
   for (int j = 1; j < height - 1; j ++) {
     
     Cell spot = prev[i][j];
     Cell newspot = grid[i][j];
     
     float a = spot.a;
     float b = spot.b;
     
     float laplaceA = 0;
      laplaceA += a*-1;
      laplaceA += prev[i+1][j].a*0.2;
      laplaceA += prev[i-1][j].a*0.2;
      laplaceA += prev[i][j+1].a*0.2;
      laplaceA += prev[i][j-1].a*0.2;
      laplaceA += prev[i-1][j-1].a*0.05;
      laplaceA += prev[i+1][j-1].a*0.05;
      laplaceA += prev[i-1][j+1].a*0.05;
      laplaceA += prev[i+1][j+1].a*0.05;
      
      float laplaceB = 0;
      laplaceB += b*-1;
      laplaceB += prev[i+1][j].b*0.2;
      laplaceB += prev[i-1][j].b*0.2;
      laplaceB += prev[i][j+1].b*0.2;
      laplaceB += prev[i][j-1].b*0.2;
      laplaceB += prev[i-1][j-1].b*0.05;
      laplaceB += prev[i+1][j-1].b*0.05;
      laplaceB += prev[i-1][j+1].b*0.05;
      laplaceB += prev[i+1][j+1].b*0.05;
      
      newspot.a = a + (dA*laplaceA - a*b*b + feed[i]*(1 - a))*1.05; //<>//
      newspot.b = b + (dB*laplaceB + a*b*b - (k+feed[i])*b)*1.05;
      
      // Why contrain it?
      newspot.a = constrain(newspot.a, 0, 1);
      newspot.b = constrain(newspot.b, 0, 1);
    }
  }
}

void swap() {
  Cell[][] temp = prev;
  prev = grid;
  grid = temp;
}

void draw(){
  println(frameRate);
  background(0);
  
  // How many times do we update per cycle
  for(int i = 0; i < 10; i++){
    update();
    swap();
  }
  
  loadPixels();
  for (int i = 1; i < width - 1; i ++){
    for (int j = 1; j < height -1; j ++) {
      Cell spot = grid[i][j];
      float a = spot.a;
      float b = spot.b;
      int c;
      int pos = i + j * width;
      // Use black or white
      if ((1-a+b) < 0.7){
        c = 0;
      } else {
        c = 255;
      }
      //pixels[pos] = color((1-a+b)*255);
      pixels[pos] = color(c);
    }
  }
  updatePixels();
}
