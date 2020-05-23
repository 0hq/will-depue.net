//PShape[] masterShapesLevel0 = {createShape(BOX, 200, 10, 2000), createShape(BOX, 10, 300, 2000), createShape(BOX, 10, 300, 2400), createShape(BOX, 200, 300, 10), createShape(BOX, 200, 10, 2000), createShape(BOX, 10, 300, 2000), createShape(BOX, 10, 300, 2200), createShape(BOX, 1200, 50, 800), createShape(BOX, 200, 10, 2000), createShape(BOX, 10, 300, 200)};
PVector[] masterTranslationsLevel0 = {new PVector(-2000, 101, -2000), new PVector(-100, -50, 0) , new PVector(200, 0, 0) , new PVector(-100, 0, 1000) , new PVector(0, 45, -1000) , new PVector(1100, 5, -900) , new PVector(-100, -50, -200) , new PVector(200, 0, 300) , new PVector(1200, 50, 800) , new PVector(-100, -50, 200) , new PVector(200, 0, -1100)};
PVector[] masterPositionsLevel0 = {new PVector(-2000.0,101.0,-2000.0), new PVector(-2100.0,51.0,-2000.0), new PVector(-1900.0,51.0,-2000.0), new PVector(-2000.0,51.0,-1000.0), new PVector(-900.0,101.0,-2900.0), new PVector(-1000.0,51.0,-3100.0), new PVector(-800.0,51.0,-2800.0), new PVector(400.0,101.0,-2000.0), new PVector(500.0,51.0,-2900.0)};
color[] masterColorsLevel0 = {color(0,0,254), color(0,0,240), color(0,0,240), color(0,0,240), color(0,0,254), color(0,0,240), color(0,0,240), color(0,0,254), color(0,0,240)};
PVector[] masterBoxLevel0 = {new PVector(200, 10, 2000), new PVector(10, 300, 2000), new PVector(10, 300, 2400) , new PVector(200, 300, 10) , new PVector(200, 10, 2000) , new PVector(10, 300, 2000) , new PVector(10, 300, 2200) , new PVector(200, 10, 2000) , new PVector(10, 300, 200)};
float[] masterRotationsLevel0 = {0, 0, 0, 0, 5*PI/2, 5*PI/2, 5*PI/2, PI/2, PI/2};


void setupLevel0() {
  PShape box1 = createShape(BOX, 50, 50, 50);
  PShape box2 = createShape(BOX, 50, 50, 50);
  PShape notDoor = createShape(BOX, 50, 100, 2);
  PShape backWall = createShape(BOX, 720, 540, 10);
  PShape fire = loadShape("firehydrant.obj");
  PShape theDoor = loadShape("door.obj");
  fire.scale(25);
  fire.strokeWeight(5);
  backWall.setTexture(floorTexture2);
  PShape[] outputShapes = {box1, fire, fire, backWall, theDoor, box2};
  PVector[] outputPositions = {new PVector(50, 70, -600), new PVector(200, 70, -1000), new PVector(-160, 95, -800), new PVector(0, -90, -1500), new PVector(0, 90, -1450), new PVector(-80, 95, -500)};
  PVector[] outputRotations = {new PVector(0, 0, 0), new PVector(PI/4, 0, PI), new PVector(0, 0, PI), new PVector(0, 0, 0), new PVector(PI/2, 0, PI), new PVector(0, 0, PI)};
  color[] outputColors = {color(40, 255, 220), color(240, 255, 220), color(40, 255, 220), color(0, 0, 140), color(0, 255, 140), color(200, 255, 220)};
  pictures[pictureCounter].customShapeArea(outputShapes, outputPositions, outputRotations, outputColors);
  initializedPicture0x1 = pictureCounter;
  playerPos.set(2000, 0, 1150);
  HUDimage1 = level0text1;
  showHUDImage = true;
  println("Level zero setup done");
  println("-");
}

void renderTextLevel0() {
  if (playerPos.z >= 1200 && playerPos.z <= 2000) {
    HUDimage1 = level0text1;
    HUDtransparency = map(playerPos.z, 1200, 2000, 255, 0);
  }
  if (playerPos.z >= 2000 && playerPos.z <= 3000) {
    HUDimage1 = level0text2;
    HUDtransparency = map(playerPos.z, 2000, 3000, 255, 0);
  }
  if (playerPos.x >= 1900 && playerPos.x <= 3000 && playerPos.z >= 3000 && playerPos.z <= 3200) {
    HUDimage1 = level0text3;
    HUDtransparency = map(playerPos.x, 2000, 3000, 255, 0);
  }
  if (playerPos.x >= 3000 && playerPos.x <= 4000 && playerPos.z >= 3000 && playerPos.z <= 3200) {
    HUDimage1 = level0text4;
    HUDtransparency = map(playerPos.x, 3000, 4000, 255, 0);
  }
  if (playerPos.z >= 3200 && playerPos.z <= 4000) {
    HUDimage1 = level0text5;
    HUDtransparency = map(playerPos.z, 3200, 4000, 255, 0);
  }
}

void collisionlevel0() {
  if (dist(playerPos.x, playerPos.z, 3094, 3097) < 50 && picture01 == 0) {
    picture01 = 1;
  }
  if (dist(playerPos.x, playerPos.z, doorPositionLevel0.x, doorPositionLevel0.y) < 100) {
    println("Win");
    fadeOutEffect = true;
  }

  if (playerPos.x < 1960) {
    playerPos.x = 1960;
  }

  if (playerPos.x > 2040 && playerPos.z < 3000 && playerPos.x < 2200) {
    playerPos.x = 2040;
  }
  if (playerPos.z < 1100 && playerPos.z < 3000) {
    playerPos.z = 1100;
  }

  if (playerPos.x > 2100 && playerPos.x < 4100 && playerPos.z > 3000 && playerPos.z < 3060) {
    playerPos.z = 3060;
  }

  if (playerPos.x > 1950 && playerPos.x < 3900 && playerPos.z > 3140 && playerPos.z < 3300) {
    playerPos.z = 3140;
  }

  if (playerPos.x > 4040 && playerPos.z < 3200 ) {
    playerPos.x = 4040;
  }
}

void renderLevel0() {

  pushMatrix();
  translate(playerPos.x, playerPos.y, playerPos.z);
  //first section of the path
  translate(-2000, 101, -2000);
  fill(254);
  box(200, 10, 2000);
  translate(-100, -50, 0);
  fill(240);
  box(10, 300, 2000);
  translate(200, 0, 0);
  box(10, 300, 2400);
  translate(-100, 0, 1000);
  box(200, 300, 10);
  translate(0, 45, -1000);
  rotateY(PI);

  //second section of the path
  rotateY(3*PI/2);
  translate(1100, 5, -900);
  fill(254);
  box(200, 10, 2000);
  translate(-100, -50, -200);
  fill(240);
  box(10, 300, 2000);
  translate(200, 0, 300);
  box(10, 300, 2200); 

  //third section of the path
  rotateY(PI/2);
  translate(1200, 50, 800);
  fill(254);
  box(200, 10, 2000);
  translate(-100, -50, 200);
  fill(240);
  translate(200, 0, -1100);
  box(10, 300, 200);
  popMatrix();

  pushMatrix();
  translate(playerPos.x, playerPos.y, playerPos.z);
  translate(-3094, 96, -3097);
  rotateY(5*PI/4);
  if (picture01 == 0) shape(polaroidPictureFloor);
  popMatrix();

  if (picture01 == 1) {
    set(width/2 - viewfinderSize/2, height/2 - viewfinderSize/2, levelZeroPicture);
  }
}
