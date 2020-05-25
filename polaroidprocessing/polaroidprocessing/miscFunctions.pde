void shapeF(PShape shape, color fill, PVector location) {
  pushMatrix();
  fill(130);
  translate(playerPos.x, playerPos.y, playerPos.z);
  translate(location.x, location.y, location.z);
  shape(shape);
  popMatrix();
}

PVector cameraRotationalMove() {
  return multVector(lookVector, speed);
}

void savePictureData() {
  photoRegisterPosition = playerPos;
  lookDirection = new PVector(cam.getRotations()[0], cam.getRotations()[1], cam.getRotations()[2]);
}

PVector multVector(PVector input, float var) {
  return new PVector(var * input.x, var * input.y, var * input.z);
}

PVector addVector(PVector input, PVector input2) {
  return new PVector(input2.x + input.x, input2.x + input.y, input2.x + input.z);
}

float distaceToWalls() { //needed distance for the picture to stretch out to needed distance;
  //return -2828.4271247462;
  return boxDistanceFar;
}

void setupPictures() { //generator for all the pictures
  for (int i = 0; i < pictures.length; i++) {
    pictures[i] = new Picture();
  }
}

void drawPictures() {
  for (int i = 0; i < pictures.length; i++) {
    pictures[i].render(); //renders pictures
  }
}

//void translateCalculate() {
//  PVector result = new PVector(0,0,0);
//  for (int i = 0; i < masterPositionsLevel0.length; i++) {
//    result.add(masterPositionsLevel0[i]);
//    print("new PVector(" + result.x + "," + result.y + ","  + result.z + "), " );
//  }

//}

void switchPolaroids() {
  switchPolaroidsBool = true;
  if (availablePolaroids > 0) {
    if (availablePolaroids >= currentPolaroid++) {
      currentPolaroid++;
    } else if (currentPolaroid == 3) {
      currentPolaroid = 0;
    }
  }
}

float implicitLine(float x0, float y0, float x1, float y1, float x, float y) {
  float result = ((y0 - y1) * x) + ((x1 - x0) * y) + (x0 * y1) - (x1 * y0); 
  return result;
}
