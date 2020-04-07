void render() {
  cam.lookAt(cameraPos.x, cameraPos.y, cameraPos.z);
  shapeF(floor, color(130), floorLocation); 
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
  sphere(180);
  translate(600, -40, 400);
  sphere(60);
  translate(0, 0, -400);
  box(70);
  translate(600, 0, 0);
  box(70);
  translate(0, 0, -400);
  box(70);
  popMatrix();
  
}

void renderHUD() {
  if (renderHUD) {
    if (useCameraHUD) {
      cam.beginHUD();
      noFill();
      rect(width/2, height/2, viewfinderSize + 1, viewfinderSize + 1);
      cam.endHUD();
    } else {
      pushMatrix();
      noFill();
      if (cam.getRotations()[0] >= 0) {
        rotateY(cam.getRotations()[1]);
      } else rotateY(-cam.getRotations()[1] + PI);
      translate(0, 0, rectHUDDistance);
      rect(0, 0, 0.1825 * viewfinderSize + 1, 0.1825 * viewfinderSize + 1); //73 correlates to 400
      popMatrix();
    }
  }
  
  if (renderPhoto) set(width/2 - viewfinderSize/2, height/2 - viewfinderSize/2, viewFinder);
}

void viewfinderRayCalc() {
  PVector finderRayLeftBottom = new PVector(-viewfinderSize/2, viewfinderSize/2, rectHUDDistance);
  PVector finderRayRightBottom = new PVector(viewfinderSize/2, viewfinderSize/2, rectHUDDistance);
  PVector finderRayLeftTop = new PVector(-viewfinderSize/2, -viewfinderSize/2, rectHUDDistance);
  PVector finderRayRightTop = new PVector(viewfinderSize/2, -viewfinderSize/2, rectHUDDistance);
  finderRayLeftBottom.mult(2/viewfinderSize);
  finderRayRightBottom.mult(2/viewfinderSize);
  finderRayLeftTop.mult(2/viewfinderSize);
  finderRayRightTop.mult(2/viewfinderSize);

}

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

void theSwitch() {
}

PVector multVector(PVector input, float var) {
  return new PVector(var * input.x, var * input.y, var * input.z);
}

PVector x3dRotation(PVector input, float theta) {
  PVector result = new PVector(input.x, cos(theta) * input.y -  sin(theta) * input.z, sin(theta) * input.y + cos(theta) * input.z);
  return result;
}

PVector y3dRotation(PVector input, float theta) {
  PVector result = new PVector(cos(theta) * input.x + sin(theta) * input.z, input.y, -sin(theta) * input.x + cos(theta) * input.z);
  return result;
}

PVector z3dRotation(PVector input, float theta) {
  PVector result = new PVector(cos(theta) * input.x - sin(theta) * input.y, sin(theta) * input.x + cos(theta) * input.y, input.z);
  return result;
}
