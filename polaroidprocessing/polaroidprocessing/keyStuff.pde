void movement() {
  if (keys[1]) { //a key
    playerPos.add(cameraRotationalMove().z * strafeReduction, 0, -1 * cameraRotationalMove().x  * strafeReduction);
  } 
  if (keys[0]) { //w key
    playerPos.add(cameraRotationalMove());
  }
  if (keys[2]) { //s key
    playerPos.add(multVector(cameraRotationalMove(), -1));
  }
  if (keys[3]) { //d key
    playerPos.add(-1 * cameraRotationalMove().z * strafeReduction, 0, cameraRotationalMove().x * strafeReduction); //strafing is a bit to fast here so we're slowing it down with strafeReduction, default 0.5
  }

  if (keys[7] && !keys[8]) { //z key
    if (!listenForPlace) {
      pictures[pictureCounter].takePhoto(distaceToWalls(), cam.getRotations());
      listenForPlace = true;
    }
  }
  if (keys[6]) { //x key
    speed = 1;
  } else speed = speedInitial;

  //if (keys[8]) {
  //  cam.setPitchRotationMode();
  //} else cam.setYawRotationMode();

  if (keys[8] && !keys[7]) {
    if (listenForPlace) {
      pictures[pictureCounter].place(cam.getRotations());
      pictureCounter++;
      listenForPlace = false;
    }
  } 


  if (keys[5]) {
    savePictureData();
    viewFinder = get(width/2 - viewfinderSize/2, height/2 - viewfinderSize/2, viewfinderSize, viewfinderSize);
    renderPhoto = true;
    renderHUD = false;
  }
  if (keys[4]) {
    renderPhoto = false;
    renderHUD = true;
  }
  if (keys[9]) {
    setupPictures();
    pictureCounter = 0;
  }
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
  if (key=='x')
    keys[6]=true;
  if (key=='z')
    keys[7]=true;
  if (key=='1')
    keys[8]=true;
  if (key=='2')
    keys[9]=true;
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
  if (key=='x')
    keys[6]=false;
  if (key=='z')
    keys[7]=false;
  if (key=='1')
    keys[8]=false;
  if (key=='2')
    keys[9]=false;
}
