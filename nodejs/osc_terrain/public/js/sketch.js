var socket = io.connect(window.location.origin);

// data types:
// '/1/fader5'
// '/1/fader1', '/1/fader2', '/1/fader3', '/1/fader4'
// '/1/toggle1', '/1/toggle2', '/1/toggle3', '/1/toggle4'

// let x, y, w, h;

let cols, rows;
let w, h;
let scl = 20;
let noiseinc = 0.1;
let flyingspeed = 0.03;
// Give these values an initial value
let zmag = 50;
let ndetail = 1;
let angleX, angleY, angleZ;

let terrain = [];
let flying = 0;

socket.on('mysocket', function(data){
  console.log(data[0]+ " " + data[1]);
  if(data[1] !== null) {
    switch(data[0]){
      // Top bar
      case '/1/fader5':
        angleX = data[1];
      // case '/1/fader1':
      //   angleY = data[1];
      // case '/1/fader2':
      //   angleZ = data[1];
      case '/1/fader3':
        zmag = map(data[1], 0, 1, 20, 140);
      case '/1/fader4':
        ndetail = floor(map(data[1], 0, 1, 2, 10));
    }
  }
});

function setup(){
  // Initialize angleX
  if (angleX === undefined) {
    angleX = PI/3;
  }
  // if (angleY === undefined) {
  //   angleY = 0;
  // }
  // if (angleZ === undefined) {
  //   angleZ = 0;
  // }
  createCanvas(windowWidth, windowHeight, WEBGL);
  w = windowWidth * 1.6;
  h = windowHeight * 1.2;
  cols = floor(w / scl);
  rows = floor(h / scl);

  angleX = map(angleX, 0, 1, PI/6, PI/3);
  // angleY = map(angleY, 0, 1, 0, PI/3);
  // angleZ = map(angleZ, 0, 1, 0, PI/3);

  // initialize terrain
  for( let x = 0; x < cols; x ++) {
    terrain[x] = [];
    for (let y = 0; y < rows; y ++) {
      terrain[x][y] = 0;
    }
  }
}

function draw(){
  background(0);
  fill(255);
  // var dirX = (mouseX / width - 0.5) * 2;
  // var dirY = (mouseY / height - 0.5) * 2;
  // directionalLight(250, 250, 250, -dirX, -dirY, 0.25);
  // ambientMaterial(250);

  flying -= flyingspeed;
  let yoff = flying;
  for( let y = 0; y < rows; y ++){
    let xoff = 0;
    for (let x = 0; x < cols; x ++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -zmag, zmag);
      xoff += noiseinc;
    }
    yoff += noiseinc;
  }

  noiseDetail(ndetail);
  rotateX(angleX);

  translate(-w/2, -h/2-50);

  for( let y = 0; y < rows; y ++){
    beginShape(TRIANGLE_STRIP);
    for (let x = 0; x < cols; x ++) {
      vertex(x * scl, y * scl, terrain[x][y]);
      vertex(x * scl, (y + 1) * scl, terrain[x][y+1]);
    }
    endShape();
  }}
