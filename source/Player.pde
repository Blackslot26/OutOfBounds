class Player {
  PApplet papplet;
  int playerX, playerY;
  boolean mode = false;

  int[] prevPX = new int[6];  // posicion anterior del jugador X
  int[] prevPY = new int[6];  // posicion anterior del jugador Y
  int kframe = 0;  // variable para controlar el glitch de la llave
  int timerkframe = 0;
  Player(PApplet p) {
    this.papplet = p;
    for (int i = 0; i < prevPX.length; i++) {
      prevPX[i] = 0;
      prevPY[i] = 0;
    }
  }

  void playerDraw(int windowX, int windowY) {
    papplet.rectMode(PApplet.CENTER);  // modo verde

    papplet.stroke(0);
    papplet.strokeWeight(1);
    if (mode) papplet.fill(0, 255, 0);
    if (!mode) papplet.fill(255);
    prevPX[prevPX.length-1] = playerX;
    prevPY[prevPY.length-1] = playerY;
    playerX = playerposX - windowX;
    playerY = playerposY - windowY;
    timerkframe++;
    if (timerkframe >= 10) {
      kframe++;
      timerkframe = 0;
    }
    if (kframe == 6) {
      kframe = 0;
    }
    if (alive) papplet.rect(playerX, playerY, playerSize, playerSize);


    if ((estados.estados < 100 || estados.estados > 100.4) && alive) papplet.rect(playerX, playerY, playerSize, playerSize);
    if (estados.estados >= 100 && estados.estados <= 100.3) {
      papplet.rect(playerX, playerY, playerSize, playerSize);
      papplet.quad(playerX-playerSize/2+12+value, playerY-playerSize/2-12, playerX-playerSize/2, playerY-playerSize/2, playerX+playerSize/2, playerY-playerSize/2, playerX+playerSize/2+12+value, playerY-playerSize/2-12);
      papplet.quad(playerX+playerSize/2, playerY-playerSize/2, playerX+playerSize/2, playerY+playerSize/2, playerX+playerSize/2+12+value, playerY+playerSize/2-12, playerX+playerSize/2+12+value, playerY-playerSize/2-12);


      value = constrain(value, -12, 0);
      if (a) value += 0.045;
      if (d) value -= 0.045;
    }



    if (hasKey && keyRequired == false) {

      for (int i = 0; i < prevPX.length-1; i++) {
        prevPX[i] = prevPX[i+1];
        prevPY[i] = prevPY[i+1];
        papplet.imageMode(CENTER);
        papplet.image(Key[kframe], prevPX[1], prevPY[1], 30, 30);
      }
      //papplet.fill(255, 255, 0);
      //papplet.rect(playerX, playerY, 10, 10);
    }
  }

  void playerDeathAnimation() {
    if (!alive) {
      // 120 frames
      DT += 0.25;

      if (DT < 60) {
        papplet.rect(playerX, playerY, playerSize, playerSize);
      }
      if (DT > 3 && DT < 60) {
        papplet.fill(0);
        papplet.strokeWeight(4);
        papplet.line(playerX-3, playerY+playerSize/2, playerX+3, playerY);
        papplet.line(playerX+3, playerY, playerX-playerSize/2, playerY-playerSize/2);
      }

      if (DT > 8 && DT < 60) {
        papplet.strokeWeight(3);
        papplet.line(playerX+3, playerY, playerX+playerSize/2, playerY);
        papplet.line(playerX-playerSize/2+round(dist(playerX+3, playerY, playerX-playerSize/2, playerY)/2), playerY-playerSize/2+round(dist(playerX+3, playerY, playerX+3, playerY-playerSize/2)/2), playerX+6, playerY-10);
      }

      if (DT > 10 && DT < 60) {
        papplet.strokeWeight(2);
        papplet.line(playerX+6, playerY-10, playerX+6, playerY-playerSize/2);
        papplet.line(playerX+6, playerY-10, playerX+playerSize/2, playerY-10);
      }


      if (DT > 60 && DT < 75) {
        papplet.rectMode(PApplet.CORNER);
        papplet.strokeWeight(1);
        papplet.fill(255);
        papplet.rect(playerX+DT-60, playerY-playerSize/2, playerSize/2, playerSize);
        papplet.fill(0);
        papplet.strokeWeight(4);
        papplet.line(playerX+DT-60, playerY+playerSize/2-7.5, playerX+3+DT-60, playerY);
        papplet.line(playerX+DT-60, playerY-1.5, playerX+3+DT-60, playerY);
        papplet.strokeWeight(3);
        papplet.line(playerX+3+DT-60, playerY, playerX+playerSize/2+DT-60, playerY);
        papplet.line(playerX-playerSize/2+round(dist(playerX+3, playerY, playerX-playerSize/2, playerY)/2)+6+DT-60, playerY-playerSize/2+round(dist(playerX+3, playerY, playerX+3, playerY-playerSize/2)/2)-1.5, playerX+6+DT-60, playerY-10);
        papplet.strokeWeight(2);
        papplet.line(playerX+6+DT-60, playerY-10, playerX+6+DT-60, playerY-playerSize/2);
        papplet.line(playerX+6+DT-60, playerY-10, playerX+playerSize/2+DT-60, playerY-10);


        papplet.fill(255);
        papplet.rect(playerX-playerSize/2-DT+60, playerY-playerSize/2, playerSize/2, playerSize);
        papplet.strokeWeight(4);
        papplet.line(playerX-3-DT+60, playerY+playerSize/2, playerX-DT+60, playerY+playerSize/2-7.5);
        papplet.line(playerX-playerSize/2-DT+60, playerY-playerSize/2, playerX-DT+60, playerY-2.5);
        papplet.strokeWeight(3);
        papplet.line(playerX-playerSize/2+round(dist(playerX+3, playerY, playerX-playerSize/2, playerY)/2)-DT+60, playerY-playerSize/2+round(dist(playerX+3, playerY, playerX+3, playerY-playerSize/2)/2), playerX-playerSize/2+round(dist(playerX+3, playerY, playerX-playerSize/2, playerY)/2)+6-DT+60, playerY-playerSize/2+round(dist(playerX+3, playerY, playerX+3, playerY-playerSize/2)/2)-1.5);
      }

      if (DT >= 75 && DT < 90) {
        papplet.rectMode(PApplet.CORNER);
        papplet.fill(255);
        papplet.strokeWeight(1);
        papplet.rect(playerX-playerSize/2-5, playerY-playerSize/2, 5, 5);
        papplet.rect(playerX-playerSize/2-5, playerY-playerSize/2+7, 5, 5);
        papplet.rect(playerX-playerSize/2-5, playerY-playerSize/2+14, 10, 10);
        papplet.rect(playerX-playerSize/2-5, playerY-playerSize/2+26, 5, 5);
        papplet.rect(playerX-playerSize/2-17, playerY, 5, 10);
        papplet.rect(playerX-playerSize/2-13, playerY-playerSize/2, 5, 7);

        papplet.rectMode(PApplet.CORNER);
        papplet.fill(255);
        papplet.strokeWeight(1);
        papplet.rect(playerX+playerSize/2, playerY-playerSize/2+3, 5, 5);
        papplet.rect(playerX+playerSize/2, playerY-playerSize/2+10, 5, 5);
        papplet.rect(playerX+playerSize/2-5, playerY-playerSize/2+17, 10, 10);
        papplet.rect(playerX+playerSize/2-12, playerY+3, 5, 10);
        papplet.rect(playerX+playerSize/2-8, playerY-playerSize/2+3, 5, 7);
      }

      if (DT > 90 && DT < 160) {
        papplet.rectMode(PApplet.CORNER);
        papplet.fill(255);
        papplet.strokeWeight(1);
        papplet.rect(playerX-playerSize/2-5-DT+90+0.4, playerY-playerSize/2+DT-90, 5, 5);
        papplet.rect(playerX-playerSize/2-5-DT+90-0.4, playerY-playerSize/2+7-DT+90, 5, 5);
        papplet.rect(playerX-playerSize/2-5-DT+90+0.2, playerY-playerSize/2+14-DT+90+0.1, 10, 10);
        papplet.rect(playerX-playerSize/2-5+DT-90, playerY-playerSize/2+26-DT+90-0.2, 5, 5);
        papplet.rect(playerX-playerSize/2-17-DT+90-DT+90, playerY, 5, 10);
        papplet.rect(playerX-playerSize/2-13+DT-90+0.4, playerY-playerSize/2+DT-90, 5, 7);

        papplet.rectMode(PApplet.CORNER);
        papplet.fill(255);
        papplet.strokeWeight(1);
        papplet.rect(playerX+playerSize/2+DT-90, playerY-playerSize/2+3+DT-90, 5, 5);
        papplet.rect(playerX+playerSize/2+DT-90, playerY-playerSize/2+10-DT+90-0.2, 5, 5);
        papplet.rect(playerX+playerSize/2-5+DT-90-0.2, playerY-playerSize/2+17+DT-90, 10, 10);
        papplet.rect(playerX+playerSize/2-12+DT-90, playerY+3+DT-90+0.7, 5, 10);
        papplet.rect(playerX+playerSize/2-8+DT-90, playerY-playerSize/2+3-DT+90-0.7, 5, 7);
      }
    } else DT = 0;
  }

  void keyPressed() {
    if (papplet.key == 'w') w = true;
    if (papplet.key == 'a') a = true;
    if (papplet.key == 's') s = true;
    if (papplet.key == 'd') d = true;

    if (papplet.key == 'g') g = true;
  }

  void keyReleased() {
    if (papplet.key == 'w') w = false;
    if (papplet.key == 'a') a = false;
    if (papplet.key == 's') s = false;
    if (papplet.key == 'd') d = false;

    if (papplet.key == 'g') g = false;
  }
}
