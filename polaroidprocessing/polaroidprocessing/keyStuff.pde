boolean usePerfectMovement = true;
boolean useDebugPictureKeys = false;
boolean keyPictureTaken = false;

void movement() {
  if (keys[0]) { //w key
    if (usePerfectMovement) {
      playerPos.add(cameraRotationalMove());
    } else {
      playerVelocity.add(cameraRotationalMove());
    }
  }

  if (keys[1]) { //a key
    if (usePerfectMovement) {
      playerPos.add(cameraRotationalMove().z * strafeReduction, 0, -1 * cameraRotationalMove().x  * strafeReduction);
    } else {
      playerVelocity.add(cameraRotationalMove().z * strafeReduction, 0, -1 * cameraRotationalMove().x  * strafeReduction);
    }
  } 

  if (keys[2]) { //s key
    if (usePerfectMovement) {
      playerPos.add(multVector(cameraRotationalMove(), -1));
    } else {
      playerVelocity.add(multVector(cameraRotationalMove(), -1));
    }
  }
  if (keys[3]) { //d key
    if (usePerfectMovement) {
      playerPos.add(-1 * cameraRotationalMove().z * strafeReduction, 0, cameraRotationalMove().x * strafeReduction); //strafing is a bit to fast here so we're slowing it down with strafeReduction, default 0.5
    } else {
      playerVelocity.add(-1 * cameraRotationalMove().z * strafeReduction, 0, cameraRotationalMove().x * strafeReduction);
    }
  }

  if (keys[12] && timer == 0 && playerPos.y == playerHeight && onFloor) { //space key
    playerVelocity.add(0, 8, 0);
    timer = 30;
  }

  if (keys[7] && !keys[8]) { //z key
    if (useDebugPictureKeys) {
      if (!listenForPlace) {
        pictures[pictureCounter].takePhoto(distaceToWalls(), cam.getRotations());
        listenForPlace = true;
      }
    }
  }
  if (keys[6]) { //x key
    switchPolaroids();
  } 

  //if (keys[8]) {
  //  cam.setPitchRotationMode();
  //} else cam.setYawRotationMode();

  if (keys[8] && !keys[7]) { //number 1 key
    if (useDebugPictureKeys) {
      if (listenForPlace) {
        pictures[pictureCounter].place(cam.getRotations(), playerPos);
        pictureCounter++;
        listenForPlace = false;
      }
    }
  } 

  if (keys[10]) {
    //moveABit += 1;
    if (level == 0) {
      playerPos.set(2000, 0, 1150);
      picture01 = 0;
    }
  }

  if (keys[11] && picture01 == 1) {
    pictures[pictureCounter].takePhoto(distaceToWalls(), cam.getRotations());
    pictures[pictureCounter].place(cam.getRotations(), playerPos);
    picture01 = 2;
  }

  if (keys[5]) { // e key
    if (useDebugPictureKeys) {
      savePictureData();
      viewFinder = get(width/2 - viewfinderSize/2, height/2 - viewfinderSize/2, viewfinderSize, viewfinderSize);
      //viewFinder.save("levelzerocluev4.png");
      renderPhoto = true;
      renderHUD = false;
    } else {
      if (!keyPictureTaken && timer == 0) {
        savePictureData();
        viewFinder = get(width/2 - viewfinderSize/2, height/2 - viewfinderSize/2, viewfinderSize, viewfinderSize);
        //viewFinder.save("levelzerocluev4.png");
        renderPhoto = true;
        renderHUD = false;
        if (!listenForPlace) {
          pictures[pictureCounter].takePhoto(distaceToWalls(), cam.getRotations());
          listenForPlace = true;
        }
        keyPictureTaken = true;
        timer = 20;
        println("Picture has been taken");
      } else { 
        if (timer == 0) {
          if (listenForPlace ) {
            pictures[pictureCounter].place(cam.getRotations(), playerPos);
            pictureCounter++;
            listenForPlace = false;
          }
          renderPhoto = false;
          renderHUD = true;
          moveABit = 0;
          pictureCounter = 0;
          keyPictureTaken = false;
          timer = 20;
          println("Picture has been placed");
        }
      }
    }
  }
  if (keys[4]) { // q key
    if (useDebugPictureKeys) {
      renderPhoto = false;
      renderHUD = true;
      moveABit = 0;
      pictureCounter = 0;
    }
  }
  if (keys[9]) {
    setupPictures();
    if (level == 0) {
      setupLevel0();
    }
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
  if (key=='3')
    keys[10]=true;
  if (key=='c')
    keys[11]=true;
  if (key==' ')
    keys[12]=true;
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
  if (key=='3')
    keys[10]=false;
  if (key=='c')
    keys[11]=false;
  if (key==' ')
    keys[12]=false;
}
