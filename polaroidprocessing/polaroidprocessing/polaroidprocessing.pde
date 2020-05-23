//import ch.bildspur.postfx.builder.*;
//import ch.bildspur.postfx.pass.*;
//import ch.bildspur.postfx.*;
import peasy.*;
//import processing.io.*;

PVector cameraPos, playerPos, centerPos, lookVector;
PVector floorLocation = new PVector(0, 100, 0);
PVector ceilingLocation = new PVector(0, 0, 0);
PVector rightWall = new PVector(0, 0, 0);
PVector leftWall = new PVector(0, 0, 0);
PVector forwardWall = new PVector(0, 0, 0);
PVector backWall = new PVector(0, 0, 0);
int tick, side, speedInitial, speed, viewfinderSize, rectHUDDistance;
boolean[] keys;
boolean  renderPhoto, renderHUD, useCameraHUD, placing;
float rotationAngle, elevationAngle, strafeReduction;
PShape floor, wallRight, wallForward, ceiling, pictureBoxLeft, rectangle, collisionBox;
PImage floorTexture, wallTexture, viewFinder, floorTexture2, forgottenPolaroidTest;
PVector finderRayLeftBottom, finderRayRightBottom, finderRayRightTop, finderRayLeftTop;
int[] photoRegister = new int[6];
PVector photoRegisterPosition, diffencePos;
PVector lookDirection, HUDDirection;
float ViewfinderDisplacement, boxDistanceClose, boxDistanceFar;
Picture[] pictures = new Picture[50];
int pictureCounter = 0;
boolean listenForPlace = false;
float alignFov = -46.3/200;
int level;
int initializedPicture0x1;
int moveABit = 0;
color floorColor = color(100, 100, 100);
int picture01 = 0;
int timer = 0;
PImage levelZeroPicture, level0text1, level0text2, level0text3, level0text4, level0text5, level0text6, HUDimage1, HUDimage2;
PShape polaroidPictureFloor;
float HUDtransparency = 255;
PVector doorPositionLevel0 = new PVector(0, 0);
boolean fadeOutEffect = false;
int fadeOutInt = 0;
PImage[] photoStorage = new PImage[9];
int photoStorageGIF = 0;
boolean showHUDImage = false;
int availablePolaroids = 0;
boolean switchPolaroidsBool = false;
int currentPolaroid = 0;
PVector playerVelocity = new PVector(0, 0, 0);
float newFriction = 0.9;
PeasyCam cam;
PVector speedCap = new PVector(6, 6, 6);
float gravity = 0.2;
final PVector playerCollisionPoint = new PVector(0,50,0);
float playerHeight = 0;
boolean collisionDetected = false;

void setup() {
  size(1000, 1000, P3D);
  //fullScreen(P3D, 2);
  cam = new PeasyCam(this, 100);
  setupvariables();
  config();
  level = 1;
  setupPictures();
  levelSetup();
}

void draw() {
  background(150);
  fill(255);
  levelFunction();
  math();
  tick += 1;
  movement();
  physics();
  render();
  drawPictures();
  
  printFunctions();
  renderHUD();
  if (timer > 0) { 
    timer -= 1;
  }
}

void levelSetup() {
  if (level == 0) {
    setupLevel0();
  }
  if (level == 1) {
    setupLevel1();
  }
}

void physics() {
  if (usePerfectMovement) {
    playerPos.add(playerVelocity);
    if (playerPos.y > 0 + playerHeight) {
      playerVelocity.add(0, -gravity, 0);
    }
    if (playerPos.y < 0 + playerHeight && (onFloor || playerHeight > 0)) {
      playerPos.y = 0 + playerHeight;
    }
    //println(playerHeight);
  } else {
    playerPos.add(playerVelocity);
    float xVelocity = abs(playerVelocity.x);
    float yVelocity = abs(playerVelocity.y);
    float zVelocity = abs(playerVelocity.z);
    //capping player's max speed
    if (xVelocity > speedCap.x) {
      playerVelocity.set(speedCap.x * playerVelocity.x/xVelocity, playerVelocity.y, playerVelocity.z);
    }
    if (zVelocity > speedCap.z) {
      playerVelocity.set(playerVelocity.x, playerVelocity.y, speedCap.z * playerVelocity.z/zVelocity);
    }
    //friction calculations
    if (xVelocity > newFriction) {
      playerVelocity.add(-newFriction * playerVelocity.x/xVelocity, 0, 0);
    }
    if (xVelocity < newFriction) {
      playerVelocity.add(-1 * playerVelocity.x, 0, 0);
    }
    if (zVelocity > newFriction) {
      playerVelocity.add(0, 0, -newFriction * playerVelocity.z/zVelocity);
    }
    if (zVelocity < newFriction) {
      playerVelocity.add(0, 0, -1 * playerVelocity.z);
    }

    if (playerPos.y > 0) {
      playerVelocity.add(0, -gravity, 0);
    }
    if (playerPos.y < 0) {
      playerPos.y = 0;
    }
  }
}

void levelFunction() {
  if (level == 0) {
    renderLevel0();
    renderLevelTest();
    collisionlevel0();
    renderTextLevel0();
  }
  if (level == 1) {

    renderLevel1();
  }
}

void math() {
  rotationAngle = cam.getRotations()[1];
  side = cam.getRotations()[0] < 0 ? -1 : 1;
  lookVector.set(sin(rotationAngle), 0, side * cos(rotationAngle));
  HUDDirection.set(multVector(lookVector, rectHUDDistance));
}


void config() {
  colorMode(HSB);
  speedInitial = 9;
  cam.setMinimumDistance(60);
  cam.setMaximumDistance(60);
  //cam.setSuppressRollRotationMode();
  cam.setYawRotationMode();
  textureWrap(REPEAT);
  rectMode(CENTER); 
  strokeWeight(2);
  strokeJoin(ROUND);
  strafeReduction = 0.5;
  rectHUDDistance = -100;
  textureMode(IMAGE);
  imageMode(CENTER);
  speed = speedInitial;
}

void setupvariables() {
  level0text1 = loadImage("titlecredit.png");
  level0text2 = loadImage("movewith.png");
  level0text3 = loadImage("findthedoor.png");
  level0text4 = loadImage("woahyoufoundapolaroid.png");
  level0text5 = loadImage("placeitwithc.png");
  level0text6 = loadImage("thanksforplaying.png");
  level0text1.resize(0, 200);
  level0text2.resize(0, 200);
  level0text3.resize(0, 200);
  level0text4.resize(0, 200);
  level0text5.resize(0, 200);
  level0text6.resize(0, 200);
  HUDimage1 = level0text1;
  polaroidPictureFloor = createShape(BOX, 20, 5, 20);
  levelZeroPicture = loadImage("levelzerocluev3.png");
  floorTexture = loadImage("floor2.png");
  floorTexture2 = loadImage("floor2.png");
  floorTexture2.resize(2000, 2000);
  wallTexture = loadImage("viewBoxTesting.png");
  wallTexture = loadImage("testing4.png");
  forgottenPolaroidTest = loadImage("test.png");
  polaroidPictureFloor.setTexture(levelZeroPicture);
  cameraPos = new PVector(0, 0, 0);
  playerPos = new PVector(0, 0, 0);
  HUDDirection = new PVector(0, 0, 0);
  keys = new boolean[15];
  floor = createShape(BOX, 2000, 10, 2000);
  ceiling = createShape(BOX, 2000, 10, 2000);
  //floor.setTexture(floorTexture);
  floor.setFill(floorColor);
  lookVector = new PVector(0, 0, 0);
  renderPhoto = false;
  wallRight = createShape(BOX, 2000, 400, 10);
  wallForward = createShape(BOX, 10, 400, 2000);
  renderHUD = true;
  useCameraHUD = false;
  finderRayLeftBottom = new PVector(-viewfinderSize/2, viewfinderSize/2, rectHUDDistance);
  finderRayRightBottom = new PVector(viewfinderSize/2, viewfinderSize/2, rectHUDDistance);
  finderRayLeftTop = new PVector(-viewfinderSize/2, -viewfinderSize/2, rectHUDDistance);
  finderRayRightTop = new PVector(viewfinderSize/2, -viewfinderSize/2, rectHUDDistance);
  diffencePos = new PVector(0, 0, 0);
  viewfinderSize = 400;
  ViewfinderDisplacement = 37;
  boxDistanceFar = -2000;
  boxDistanceClose = -250;  
  level = 0;
  for (int i = 0; i < 9; i++) {
    String filename = "photoStorage" + nf(i+1, 4) + ".png";
    photoStorage[i] = loadImage(filename);
    photoStorage[i].resize(0, 200);
  }
}


void printFunctions() {
  //println(cam.getRotations());
  //println("playerpos");
  //println(playerPos);
  //println("doorpos");
  //println(doorPositionLevel0);
  //println(tick);
  //println(cam.getDistance());
  //println(cam.getLookAt());
  //println(playerPos);
  //println(key);
}
