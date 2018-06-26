float bg;
 
void setup(){
  setTimeout("test",2000);
  setInterval("tick",1000);
}
void draw(){
  background(bg);
}
void test(){
  println("test");
}
void tick(){
  bg = random(255);
}
void mouseReleased(){
  clearInterval("tick");
}
