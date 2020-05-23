
void render() {
  cam.lookAt(cameraPos.x, cameraPos.y, cameraPos.z);
}

void renderHUD() {
  cam.beginHUD();
  if (fadeOutEffect) {
    fill(255);
    rect(width/2, height/2, width, height);
    image(level0text6, width/2, height/8);
  }

  if (tick % 10 == 0 && switchPolaroidsBool && !fadeOutEffect) {
    photoStorageGIF++;
    if (photoStorageGIF >= 9) {
      switchPolaroidsBool = false;
      photoStorageGIF = 0;
    }
  }

  image(photoStorage[photoStorageGIF], width/8, 7*height/8);
  tint(255, HUDtransparency);
  if (showHUDImage) {
    image(HUDimage1, width/2, 1*height/8);
  }
  cam.endHUD();
  tint(255, 255);

  if (!fadeOutEffect) {
    pushMatrix();
    noFill();
    if (cam.getRotations()[0] >= 0) {
      rotateY(cam.getRotations()[1]);
    } else rotateY(-cam.getRotations()[1] + PI);
    translate(0, 0, rectHUDDistance);
    rect(0, 0, 0.1825 * viewfinderSize + 1, 0.1825 * viewfinderSize + 1); //73 correlates to 400
    popMatrix();
  }




  if (renderPhoto) set(width/2 - viewfinderSize/2, height/2 - viewfinderSize/2, viewFinder);
}
