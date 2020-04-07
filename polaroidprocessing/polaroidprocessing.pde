import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;
import peasy.*;
import processing.io.*;

PVector cameraPos, playerPos, centerPos, lookVector;
PVector floorLocation = new PVector(0, 100, 0);
PVector ceilingLocation = new PVector(0, 0, 0);
PVector rightWall = new PVector(0, 0, 0);
PVector leftWall = new PVector(0, 0, 0);
PVector forwardWall = new PVector(0, 0, 0);
PVector backWall = new PVector(0, 0, 0);
int tick, side, speedInitial, speed, viewfinderSize, rectHUDDistance;
boolean[] keys;
boolean  renderPhoto, renderHUD, useCameraHUD;
float rotationAngle, elevationAngle, strafeReduction;
PShape floor, wallRight, wallForward, ceiling;
PImage floorTexture, wallTexture, viewFinder;

int[] photoRegister = new int[6];
PVector photoRegisterPosition;
PVector lookDirection;

PeasyCam cam;

void setup() {
  size(1000, 1000, P3D);
  cam = new PeasyCam(this, 100);
  setupvariables();
  config();
}

void draw() {
  hint(ENABLE_DEPTH_TEST);
  background(150);
  fill(255);
  math();
  tick += 1;
  render();
  movement();
  printFunctions();

  //hint(DISABLE_DEPTH_TEST);
  //pg.beginDraw();
  //pg.background(51);
  //pg.noFill();
  //pg.stroke(255);
  //pg.ellipse(mouseX-120, mouseY-60, 60, 60);
  //pg.endDraw();

  //image(pg, 120, 60);
}

void math() {
  rotationAngle = cam.getRotations()[1];
  side = cam.getRotations()[0] < 0 ? -1 : 1;
  lookVector.set(sin(rotationAngle), 0, side * cos(rotationAngle));
}


void config() {
  colorMode(HSB);
  speedInitial = 9;
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(60);
  //cam.setSuppressRollRotationMode();
  //cam.setYawRotationMode();
  textureWrap(REPEAT);
  rectMode(CENTER); 
  hint(DISABLE_DEPTH_TEST);
  strokeWeight(1);
  viewfinderSize = 400;
  strokeJoin(ROUND);
  strafeReduction = 0.5;
  rectHUDDistance = -100;
}

void setupvariables() {
  floorTexture = loadImage("floor.png");
  wallTexture = loadImage("wall.jpeg");
  cameraPos = new PVector(0, 0, 0);
  playerPos = new PVector(0, 0, 0);
  keys = new boolean[9];
  floor = createShape(BOX, 2000, 10, 2000);
  ceiling = createShape(BOX, 2000, 10, 2000);
  floor.setTexture(floorTexture);
  lookVector = new PVector(0, 0, 0);
  renderPhoto = false;
  wallRight = createShape(BOX, 2000, 400, 10);
  wallForward = createShape(BOX, 10, 400, 2000);
  renderHUD = true;
  useCameraHUD = false;
}

void printFunctions() {
  println(cam.getRotations());
  //println(tick);
  //printArray(LED.list());
  //println(cam.getDistance());
  //println(cam.getLookAt());
  //println(playerPos);
  //println(key);
}
