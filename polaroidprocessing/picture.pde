class Picture {
  float[] instCameraRotation, placeRotation;
  float farthestZ;
  PShape leftBox, rightBox, topBox, bottomBox, backBox;
  boolean placed, taken;
  Picture() {
    taken = false;
    placed = false;
  }

  void takePhoto(float Z, float[] rotation) {
    farthestZ = Z;
    instCameraRotation = rotation;
    taken = true;
  }

  void place(float[] rotation) {
    pictureBox();
    placed = true;
    placeRotation = rotation;
  }

  void pictureBox() {
    leftBox = createShape();
    leftBox.fill(140);
    leftBox.beginShape(); //left side box
    leftBox.vertex(-ViewfinderDisplacement - playerPos.x, ViewfinderDisplacement - playerPos.y, rectHUDDistance - playerPos.z);
    leftBox.vertex(-ViewfinderDisplacement - playerPos.x, -ViewfinderDisplacement - playerPos.y, rectHUDDistance - playerPos.z);
    leftBox.vertex(-ViewfinderDisplacement - playerPos.x - alignFov * distaceToWalls(), -ViewfinderDisplacement - playerPos.y - alignFov * distaceToWalls(), rectHUDDistance + farthestZ - playerPos.z);
    leftBox.vertex(-ViewfinderDisplacement - playerPos.x - alignFov * distaceToWalls(), ViewfinderDisplacement - playerPos.y + alignFov * distaceToWalls(), rectHUDDistance + farthestZ - playerPos.z);
    leftBox.vertex(-ViewfinderDisplacement - playerPos.x, ViewfinderDisplacement - playerPos.y, rectHUDDistance - playerPos.z);
    leftBox.endShape();

    rightBox = createShape();
    rightBox.fill(140);
    rightBox.beginShape(); //left side box
    rightBox.vertex(ViewfinderDisplacement - playerPos.x, ViewfinderDisplacement - playerPos.y, rectHUDDistance - playerPos.z);
    rightBox.vertex(ViewfinderDisplacement - playerPos.x, -ViewfinderDisplacement - playerPos.y, rectHUDDistance - playerPos.z);
    rightBox.vertex(ViewfinderDisplacement - playerPos.x + alignFov * distaceToWalls(), -ViewfinderDisplacement - playerPos.y - alignFov * distaceToWalls(), rectHUDDistance + farthestZ - playerPos.z);
    rightBox.vertex(ViewfinderDisplacement - playerPos.x + alignFov * distaceToWalls(), ViewfinderDisplacement - playerPos.y + alignFov * distaceToWalls(), rectHUDDistance + farthestZ - playerPos.z);
    rightBox.vertex(ViewfinderDisplacement - playerPos.x, ViewfinderDisplacement - playerPos.y, rectHUDDistance - playerPos.z);
    rightBox.endShape();

    bottomBox = createShape();
    bottomBox.fill(140);
    bottomBox.beginShape(); //left side box
    bottomBox.vertex(ViewfinderDisplacement - playerPos.x, ViewfinderDisplacement - playerPos.y, rectHUDDistance - playerPos.z);
    bottomBox.vertex(-ViewfinderDisplacement - playerPos.x, ViewfinderDisplacement - playerPos.y, rectHUDDistance - playerPos.z);
    bottomBox.vertex(-ViewfinderDisplacement - playerPos.x - alignFov * distaceToWalls(), ViewfinderDisplacement - playerPos.y + alignFov * distaceToWalls(), rectHUDDistance + farthestZ - playerPos.z);
    bottomBox.vertex(ViewfinderDisplacement - playerPos.x + alignFov * distaceToWalls(), ViewfinderDisplacement - playerPos.y + alignFov * distaceToWalls(), rectHUDDistance + farthestZ - playerPos.z);
    bottomBox.vertex(ViewfinderDisplacement - playerPos.x, ViewfinderDisplacement - playerPos.y, rectHUDDistance - playerPos.z);
    bottomBox.endShape();
    
    topBox = createShape();
    topBox.fill(140);
    topBox.beginShape(); //left side box
    topBox.vertex(ViewfinderDisplacement - playerPos.x, -ViewfinderDisplacement - playerPos.y, rectHUDDistance - playerPos.z);
    topBox.vertex(-ViewfinderDisplacement - playerPos.x, -ViewfinderDisplacement - playerPos.y, rectHUDDistance - playerPos.z);
    topBox.vertex(-ViewfinderDisplacement - playerPos.x - alignFov * distaceToWalls(), -ViewfinderDisplacement - playerPos.y - alignFov * distaceToWalls(), rectHUDDistance + farthestZ - playerPos.z);
    topBox.vertex(ViewfinderDisplacement - playerPos.x + alignFov * distaceToWalls(), -ViewfinderDisplacement - playerPos.y - alignFov * distaceToWalls(), rectHUDDistance + farthestZ - playerPos.z);
    topBox.vertex(ViewfinderDisplacement - playerPos.x, -ViewfinderDisplacement - playerPos.y, rectHUDDistance - playerPos.z);
    topBox.endShape();

    backBox = createShape();
    backBox.fill(140);
    backBox.beginShape(); //left side box
    backBox.vertex(-ViewfinderDisplacement - playerPos.x - alignFov * distaceToWalls(), -ViewfinderDisplacement - playerPos.y - alignFov * distaceToWalls(), rectHUDDistance + farthestZ - playerPos.z);
    backBox.vertex(-ViewfinderDisplacement - playerPos.x - alignFov * distaceToWalls(), ViewfinderDisplacement - playerPos.y + alignFov * distaceToWalls(), rectHUDDistance + farthestZ - playerPos.z);
    backBox.vertex(ViewfinderDisplacement - playerPos.x + alignFov * distaceToWalls(), ViewfinderDisplacement - playerPos.y + alignFov * distaceToWalls(), rectHUDDistance + farthestZ - playerPos.z);
    backBox.vertex(ViewfinderDisplacement - playerPos.x + alignFov * distaceToWalls(), -ViewfinderDisplacement - playerPos.y - alignFov * distaceToWalls(), rectHUDDistance + farthestZ - playerPos.z);
    backBox.vertex(-ViewfinderDisplacement - playerPos.x - alignFov * distaceToWalls(), -ViewfinderDisplacement - playerPos.y - alignFov * distaceToWalls(), rectHUDDistance + farthestZ - playerPos.z);
    backBox.endShape();
  }

  void render() {
    if (placed) {
      pushMatrix();
      translate(playerPos.x, playerPos.y, playerPos.z);
      if (placeRotation[0] >= 0) {
        rotateY(placeRotation[1]);
      } else rotateY(-placeRotation[1] + PI);
      fill(140, 99, 99);
      shape(leftBox);
      shape(rightBox);
      shape(backBox);
      shape(topBox);
      shape(bottomBox);
      popMatrix();
    }
  }
}
