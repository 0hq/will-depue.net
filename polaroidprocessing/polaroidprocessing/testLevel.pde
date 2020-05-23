void renderLevelTest() {
  shapeF(floor, color(130), floorLocation); 
  shapeF(floor, color(130), new PVector(0,-100,0)); 
  pushMatrix();
  translate(playerPos.x, playerPos.y, playerPos.z);
  translate(0, 99, 1000);
  fill(90);
  box(2000, 400, 10);
  translate(0, 1, -2000);
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
