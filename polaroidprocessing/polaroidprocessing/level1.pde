PShape normalBox, normalSphere, floorBox;
PVector[] masterPositionsLevel1 = {new PVector(0, 101, 0), new PVector(0, 50, 0), new PVector(-100, 50, -80), new PVector(600, 50, -80), new PVector(300, 50, 0), new PVector(-300, 50, 80), new PVector(-300, 50, -80)};
color[] masterColorsLevel1 = {color(140), color(255), color(255), color(255), color(255), color(255), color(255)};
PShape[] masterShapesLevel1 = new PShape[2]; 
float[] masterRotationsLevel1 = {0, 0, 0, 0, 0, 0, 0};
boolean onFloor = true;
PVector playerCollisionPosition = new PVector(0,0,0);

void setupLevel1() {
  normalBox = createShape(BOX, 80);
  normalSphere = createShape(SPHERE, 40);
  floorBox = createShape(BOX, 8000, 10, 8000);
  masterShapesLevel1[0] = floorBox;
  masterShapesLevel1[1] = normalBox;
  //masterShapesLevel1[2] = normalBox;
  //masterShapesLevel1[3] = normalBox;
  //masterShapesLevel1[4] = normalSphere;
  //masterShapesLevel1[5] = normalSphere;
  //masterShapesLevel1[6] = normalSphere;
  println("Level one setup done");
  println("-");
}

void renderLevel1() {
  for (int g = 0; g < masterShapesLevel1.length; g++) {
    pushMatrix();
    fill(masterColorsLevel1[g]);
    translate(playerPos.x, playerPos.y, playerPos.z);
    rotateY(masterRotationsLevel1[g]);
    translate(masterPositionsLevel1[g].x, masterPositionsLevel1[g].y, masterPositionsLevel1[g].z);
    shape(masterShapesLevel1[g]);
    popMatrix();
  }
  playerCollisionPosition.set(playerPos.x + playerCollisionPoint.x, playerPos.y + playerCollisionPoint.y, playerPos.z + playerCollisionPoint.z);
  collisionDetectionLevel1();
}

void collisionDetectionLevel1() {
  //println(playerPos);
  onFloor = false;
  if (cubeCollision(playerCollisionPosition, new PVector(-4000, 96, -4000), new PVector(4000, 106, 4000)) && playerPos.y > -5) {
    playerHeight = 0;
    onFloor = true;
  }
  for (int g = 0; g < masterShapesLevel1.length; g++) {
    if (cubeCollision(playerCollisionPosition, new PVector(masterPositionsLevel1[g].x - 40, masterPositionsLevel1[g].y - 40, masterPositionsLevel1[g].z - 40), new PVector(masterPositionsLevel1[g].x + 40, masterPositionsLevel1[g].y + 40, masterPositionsLevel1[g].z + 40))) {
      playerHeight = 80;
    } 
  }
  //println(cubeCollision(new PVector(100,50,80), new PVector(masterPositionsLevel1[1].x - 40, masterPositionsLevel1[1].y - 40, masterPositionsLevel1[1].z - 40), new PVector(masterPositionsLevel1[1].x + 40, masterPositionsLevel1[1].y + 40, masterPositionsLevel1[1].z + 40)));
}
