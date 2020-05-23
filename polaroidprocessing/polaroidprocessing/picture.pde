class Picture {
  float[] instCameraRotation, placeRotation;
  float farthestZ, offsetX, offsetZ, masterRotation;
  PShape leftBox, rightBox, topBox, bottomBox, backBox, box2, leftTestBox, masterShape;
  PShape floorBox;
  PVector closeBottomLeft, closeBottomRight, farBottomLeft, farBottomRight, closeTopLeft, closeTopRight, farTopLeft, farTopRight;
  PVector floorBottomRight, floorBottomLeft, masterPosX, posMove;
  boolean placed, taken, useShapeList;
  color boxColor, testColor;
  PShape[] shapeList;
  PVector[] shapePositionList;
  color[] colorList;
  PVector[] rotateList;
  int objectsUsed = 0;
  Picture() {
    taken = false;
    placed = false;
    offsetX = 0.1;
    offsetZ = 83;
    posMove = new PVector();
    boxColor = color(0, 0, 10, 255);
    testColor = color(0, 0, 10, 255);
    useShapeList = false;
    if (level == 1) {
      shapeList = new PShape[50];
      shapePositionList = new PVector[50];
      rotateList = new PVector[50];
      colorList = new color[50];
    }
  }

  void customShapeArea(PShape[] inputShapes, PVector[] inputPositions, PVector[] rotationXList, color[] colorXList) {
    useShapeList = true;
    shapeList = inputShapes;
    shapePositionList = inputPositions;
    rotateList = rotationXList;
    colorList = colorXList;
  }

  void takePhoto(float Z, float[] rotation) {
    farthestZ = Z;
    instCameraRotation = rotation;
    taken = true;

    placeRotation = rotation;
    pictureBox();
    masterPosX = new PVector();
    masterPosX.set(playerPos);

    if (placeRotation[0] >= 0) { 
      masterRotation = placeRotation[1];
    } else { 
      masterRotation = -placeRotation[1] + PI;
    }

    if (level == 1) {
      findShapesLevel1(masterRotation, closeBottomLeft, farBottomLeft, closeBottomRight, farBottomRight, masterPosX);
    }
  }

  void place(float[] rotationx, PVector pos) {
    if (!placed) {
      placeRotation = rotationx;
      pictureBox();
      placed = true;
      masterPosX = new PVector();
      masterPosX.set(pos);

      if (placeRotation[0] >= 0) { 
        masterRotation = placeRotation[1];
      } else { 
        masterRotation = -placeRotation[1] + PI;
      }

      doorPositionLevel0.set(0, 1450);
      doorPositionLevel0.rotate(-masterRotation);
      doorPositionLevel0.add(masterPosX.x, masterPosX.z);

      if (level == 1) {
        findShapesLevel1(masterRotation, closeBottomLeft, farBottomLeft, closeBottomRight, farBottomRight, masterPosX);
      }
    }
  }

  void findShapesLevel1(float masterRotation, PVector leftLineCloseE, PVector leftLineFarE, PVector rightLineCloseE, PVector rightLineFarE, PVector masterPosX) {
    PVector leftLineClose = new PVector(leftLineCloseE.x, leftLineCloseE.z);
    PVector leftLineFar = new PVector(leftLineFarE.x, leftLineFarE.z);
    PVector rightLineClose = new PVector(rightLineCloseE.x, rightLineCloseE.z);
    PVector rightLineFar = new PVector(rightLineFarE.x, rightLineFarE.z);
    leftLineClose.rotate(-masterRotation);
    leftLineFar.rotate(-masterRotation);
    rightLineClose.rotate(-masterRotation);
    rightLineFar.rotate(-masterRotation);
    leftLineClose.add(masterPosX.x, masterPosX.z);
    leftLineFar.add(masterPosX.x, masterPosX.z);
    rightLineFar.add(masterPosX.x, masterPosX.z);
    rightLineClose.add(masterPosX.x, masterPosX.z);

    println("Starting to find level one shapes");

    for (int i = 1; i < masterShapesLevel1.length; i++) {
      if (implicitLine(leftLineClose.x, leftLineClose.y, leftLineFar.x, leftLineFar.y, -masterPositionsLevel1[i].x, -masterPositionsLevel1[i].z) < 0 &&
        implicitLine(rightLineClose.x, rightLineClose.y, rightLineFar.x, rightLineFar.y, -masterPositionsLevel1[i].x, -masterPositionsLevel1[i].z) > 0) {
        println("OBJECT " + i + " IS IN THE RANGE");
        shapeList[objectsUsed] = masterShapesLevel1[i];
        shapePositionList[objectsUsed] = new PVector(masterPosX.x + masterPositionsLevel1[i].x, masterPosX.y + masterPositionsLevel1[i].y, masterPosX.z + masterPositionsLevel1[i].z);
        rotateList[objectsUsed] = new PVector(0, -masterRotation, 0);
        colorList[objectsUsed] = masterColorsLevel1[i];
        useShapeList = true;
        objectsUsed += 1;
      } else println("OBJECT " + i + " IS NOT IN THE RANGE");
    }
    println("Done finding level one shapes");
    println("-");
    println("Outputting shapeList data");
    println("Using shapeList? " + useShapeList);
    println(shapeList);
    println(shapePositionList);
    println("-");
  }

  void pictureBox() {
    closeBottomLeft = new PVector(-ViewfinderDisplacement - alignFov * boxDistanceClose, ViewfinderDisplacement + alignFov * boxDistanceClose, boxDistanceClose + rectHUDDistance);
    closeBottomRight = new PVector(ViewfinderDisplacement + alignFov * boxDistanceClose, ViewfinderDisplacement + alignFov * boxDistanceClose, boxDistanceClose + rectHUDDistance);
    farBottomLeft = new PVector(-ViewfinderDisplacement - alignFov * farthestZ, ViewfinderDisplacement + alignFov * farthestZ, rectHUDDistance + farthestZ);
    farBottomRight = new PVector(ViewfinderDisplacement + alignFov * farthestZ, ViewfinderDisplacement + alignFov * farthestZ, rectHUDDistance + farthestZ);
    closeTopLeft = new PVector(-ViewfinderDisplacement - alignFov * boxDistanceClose, -ViewfinderDisplacement - alignFov * boxDistanceClose, boxDistanceClose + rectHUDDistance);
    closeTopRight = new PVector(ViewfinderDisplacement + alignFov * boxDistanceClose, -ViewfinderDisplacement - alignFov * boxDistanceClose, boxDistanceClose + rectHUDDistance);
    farTopLeft = new PVector(-ViewfinderDisplacement - alignFov * farthestZ, -ViewfinderDisplacement - alignFov * farthestZ, rectHUDDistance + farthestZ);
    farTopRight = new PVector(ViewfinderDisplacement + alignFov * farthestZ, -ViewfinderDisplacement - alignFov * farthestZ, rectHUDDistance + farthestZ);
    floorBottomLeft = new PVector(-ViewfinderDisplacement - alignFov * farthestZ, ViewfinderDisplacement + alignFov * boxDistanceClose, rectHUDDistance + farthestZ);
    floorBottomRight = new PVector(ViewfinderDisplacement + alignFov * farthestZ, ViewfinderDisplacement + alignFov * boxDistanceClose, rectHUDDistance + farthestZ);

    //floorBox = createShape(); //ORIGINAL VERSION WITH FLOOR TEXTURE MAPPING
    //floorBox.beginShape(QUAD); //left side box
    //floorBox.textureMode(IMAGE);
    //floorBox.texture(floorTexture2);
    //floorBox.fill(floorColor);
    //floorBox.vertex(closeBottomLeft.x, closeBottomLeft.y, closeBottomLeft.z, closeBottomLeft.x + offsetX, closeBottomLeft.z + offsetZ);
    //floorBox.vertex(closeBottomRight.x, closeBottomRight.y, closeBottomRight.z, closeBottomRight.x + offsetX, closeBottomRight.z + offsetZ);
    //floorBox.vertex(floorBottomRight.x, floorBottomRight.y, floorBottomRight.z, floorBottomRight.x + offsetX, floorBottomRight.z + offsetZ);
    //floorBox.vertex(floorBottomLeft.x, floorBottomLeft.y, floorBottomLeft.z, floorBottomLeft.x + offsetX, floorBottomLeft.z + offsetZ);
    ////floorBox.vertex(closeBottomLeft.x, closeBottomLeft.y, closeBottomLeft.z);
    //floorBox.endShape();

    floorBox = createShape(); //NEW VERSION WITHOUT FLOOR TEXTURE MAPPING
    floorBox.beginShape(QUAD); //left side box
    floorBox.textureMode(IMAGE);
    if (level == 0) {
      floorBox.texture(floorTexture2);
    }
    floorBox.fill(floorColor);
    floorBox.vertex(closeBottomLeft.x, closeBottomLeft.y, closeBottomLeft.z, -94 + offsetX, -480 + offsetZ);
    floorBox.vertex(closeBottomRight.x, closeBottomRight.y, closeBottomRight.z, 94 + offsetX, -480 + offsetZ);
    floorBox.vertex(floorBottomRight.x, floorBottomRight.y, floorBottomRight.z, 500 + offsetX, -2230 + offsetZ);
    floorBox.vertex(floorBottomLeft.x, floorBottomLeft.y, floorBottomLeft.z, -500 + offsetX, -2230 + offsetZ);
    //floorBox.vertex(closeBottomLeft.x, closeBottomLeft.y, closeBottomLeft.z);
    floorBox.endShape();

    bottomBox = createShape();
    bottomBox.beginShape(); //left side box
    bottomBox.fill(boxColor);
    bottomBox.vertex(closeBottomLeft.x, closeBottomLeft.y, closeBottomLeft.z);
    bottomBox.vertex(closeBottomRight.x, closeBottomRight.y, closeBottomRight.z);
    bottomBox.vertex(farBottomRight.x, farBottomRight.y, farBottomRight.z);
    bottomBox.vertex(farBottomLeft.x, farBottomLeft.y, farBottomLeft.z);
    bottomBox.vertex(closeBottomLeft.x, closeBottomLeft.y, closeBottomLeft.z);
    bottomBox.endShape();

    topBox = createShape();
    topBox.beginShape(); //left side box
    topBox.fill(boxColor);
    topBox.vertex(closeTopLeft.x, closeTopLeft.y, closeTopLeft.z);
    topBox.vertex(closeTopRight.x, closeTopRight.y, closeTopRight.z);
    topBox.vertex(farTopRight.x, farTopRight.y, farTopRight.z);
    topBox.vertex(farTopLeft.x, farTopLeft.y, farTopLeft.z);
    topBox.vertex(closeTopLeft.x, closeTopLeft.y, closeTopLeft.z);
    topBox.endShape();

    backBox = createShape();
    backBox.beginShape(); //left side box
    backBox.fill(150);
    backBox.vertex(farBottomLeft.x, farBottomLeft.y, farBottomLeft.z);
    backBox.vertex(farBottomRight.x, farBottomRight.y, farBottomRight.z);
    backBox.vertex(farTopRight.x, farTopRight.y, farTopRight.z);
    backBox.vertex(farTopLeft.x, farTopLeft.y, farTopLeft.z);
    backBox.vertex(farBottomLeft.x, farBottomLeft.y, farBottomLeft.z);
    backBox.endShape();

    leftBox = createShape();
    leftBox.beginShape(); //left side box
    leftBox.fill(boxColor);
    leftBox.vertex(closeBottomLeft.x, closeBottomLeft.y, closeBottomLeft.z);
    leftBox.vertex(closeTopLeft.x, closeTopLeft.y, closeTopLeft.z);
    leftBox.vertex(farTopLeft.x, farTopLeft.y, farTopLeft.z);
    leftBox.vertex(farBottomLeft.x, farBottomLeft.y, farBottomLeft.z);
    leftBox.vertex(closeBottomLeft.x, closeBottomLeft.y, closeBottomLeft.z);
    leftBox.endShape();

    rightBox = createShape();
    rightBox.beginShape(); //left side box
    rightBox.fill(boxColor);
    rightBox.vertex(closeBottomRight.x, closeBottomRight.y, closeBottomRight.z);
    rightBox.vertex(closeTopRight.x, closeTopRight.y, closeTopRight.z);
    rightBox.vertex(farTopRight.x, farTopRight.y, farTopRight.z);
    rightBox.vertex(farBottomRight.x, farBottomRight.y, farBottomRight.z);
    rightBox.vertex(closeBottomRight.x, closeBottomRight.y, closeBottomRight.z);
    rightBox.endShape();

    leftTestBox = createShape();
    leftTestBox.beginShape(); //left side box
    leftTestBox.fill(testColor);
    leftTestBox.vertex(closeBottomLeft.x, closeBottomLeft.y, closeBottomLeft.z);
    leftTestBox.vertex(closeTopLeft.x, closeTopLeft.y, closeTopLeft.z);
    leftTestBox.vertex(farTopLeft.x, farTopLeft.y, farTopLeft.z);
    leftTestBox.vertex(farBottomLeft.x, farBottomLeft.y, farBottomLeft.z);
    leftTestBox.vertex(closeBottomLeft.x, closeBottomLeft.y, closeBottomLeft.z);
    leftTestBox.endShape();
  }

  void render() {
    if (placed) {
      collisionDetection();
      pushMatrix();
      translate(-masterPosX.x, -masterPosX.y, -masterPosX.z);
      translate(playerPos.x, playerPos.y, playerPos.z);
      rotateY(masterRotation);

      shape(topBox);
      shape(bottomBox);

      shape(leftBox);
      shape(rightBox);

      if (level == 0) {
        shape(backBox);
        shape(floorBox);
      }

      if (level == 0) {
        if (useShapeList) {
          for (int g = 0; g < objectsUsed; g++) {
            pushMatrix();
            translate(shapePositionList[g].x, shapePositionList[g].y, shapePositionList[g].z);
            shapeList[g].setFill(colorList[g]);
            rotateX(rotateList[g].x);
            rotateY(rotateList[g].y);
            rotateZ(rotateList[g].z);
            shape(shapeList[g]);
            popMatrix();
          }
        }
      }

      popMatrix();

      if (level == 1) {
        if (useShapeList) {
          for (int g = 0; g < objectsUsed; g++) {
            pushMatrix();
            translate(-masterPosX.x, -masterPosX.y, -masterPosX.z);
            translate(playerPos.x, playerPos.y, playerPos.z);
            rotateY(masterRotation + rotateList[g].y);
            translate(shapePositionList[g].x, shapePositionList[g].y, shapePositionList[g].z);
            shapeList[g].setFill(colorList[g]);
            shape(shapeList[g]);
            popMatrix();
          }
        }
      }
    }
  }

  void collisionDetection() {
    boolean collisionDetectedLocal = false;
    if (useShapeList && objectsUsed > 0) {
      PVector playerCollisionPosition = new PVector(-playerPos.x + playerCollisionPoint.x, playerPos.y + playerCollisionPoint.y, -playerPos.z + playerCollisionPoint.z);
      for (int g = 0; g < objectsUsed; g++) {
        if (cubeCollision(playerCollisionPosition, new PVector(shapePositionList[g].x - 40, shapePositionList[g].y - 40, shapePositionList[g].z - 40), new PVector(shapePositionList[g].x + 40, shapePositionList[g].y + 40, shapePositionList[g].z + 40))) {
          playerHeight = 80;
          collisionDetectedLocal = true;
          println("first test passed");
        }
      }
      if (!collisionDetectedLocal) {
        playerHeight = 0;
      }
    }
  }
}

boolean cubeCollision(PVector point, PVector boxMin, PVector boxMax) {
  return (point.x >= boxMin.x && point.x <= boxMax.x) && 
    (point.z >= boxMin.z && point.z <= boxMax.z)
    //&& (point.y >= boxMin.y && point.y <= boxMax.y)
    ;
}
