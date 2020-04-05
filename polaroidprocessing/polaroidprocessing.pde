import peasy.*;

PVector cameraPos, playerPos, centerPos;
int tick, speed;
boolean[] keys;
boolean side;
float rotationAngle, elevationAngle;
PShape floor;
PImage floorTexture;

PeasyCam cam;

void setup() {
  size(1000, 1000, P3D);
  cam = new PeasyCam(this, 100);
  setupvariables();
  config();
}

void config() {
  colorMode(HSB);
  speed = 9;
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(60);
  cam.setYawRotationMode();
  textureWrap(REPEAT);
}

void setupvariables() {
  floorTexture = loadImage("floor.png");
  cameraPos = new PVector(0, 0, 0);
  playerPos = new PVector(0, 0, 0);
  keys = new boolean[6];
  floor = createShape(BOX, 2000, 10, 2000);
  floor.setTexture(floorTexture);
}

void draw() {
  background(150);
  tick += 1;
  render();
  movement();
  printFunctions();
  math();
}

void printFunctions() {
  //println(cam.getRotations());
  //println(tick);
}

void math() {
  rotationAngle = cam.getRotations()[1];
  side = cam.getRotations()[0] < 0 ? true : false;
}


void render() {
  cam.lookAt(cameraPos.x, cameraPos.y, cameraPos.z);
  pushMatrix();
  translate(playerPos.x, playerPos.y, playerPos.z);
  fill(130);
  translate(0, 100, 0);
  shape(floor);
  fill(90);
  translate(0, 0, 1000);
  box(2000, 400, 10);
  translate(0, 0, -2000);
  box(2000, 400, 10);
  translate(1000, 0, 1000);
  box(10, 400, 2000);
  translate(-2000, 0, 0);
  box(10, 400, 2000);
  popMatrix();
}

void movement() {
  if (keys[0]) {
    playerPos.add(cameraRotationalMove());
  }
  if (keys[2]) {
    playerPos.add(cameraRotationalMove().mult(-1));
  }
  //if (keys[1]) {
  //  playerPos.add(0, 0, 5);
  //}
  //if (keys[3]) {
  //  playerPos.add(0, 0, -5);
  //}
}

PVector cameraRotationalMove() {
  PVector result;
  if (side) {
    result = new PVector(speed * sin(rotationAngle), 0, -speed * cos(rotationAngle));
  } else  result = new PVector(speed * sin(rotationAngle), 0, speed * cos(rotationAngle));
  return result;
}


void keyPressed() {
  if (key=='w')
    keys[0]=true;
  if (key=='a' || keyCode == LEFT)
    keys[1]=true;
  if (key=='s')
    keys[2]=true;
  if (key=='d' || keyCode == RIGHT)
    keys[3]=true;
  if (key=='q')
    keys[4]=true;
  if (key=='e')
    keys[5]=true;
}

void keyReleased() {
  if (key=='w')
    keys[0]=false;
  if (key=='a' || keyCode == LEFT)
    keys[1]=false;
  if (key=='s')
    keys[2]=false;
  if (key=='d' || keyCode == RIGHT)
    keys[3]=false;
  if (key=='q')
    keys[4]=false;
  if (key=='e')
    keys[5]=false;
}
