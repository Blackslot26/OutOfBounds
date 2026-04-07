class Platform {
  PApplet papplet;

  int platX, platY;
  int platW, platH;

  Platform(PApplet p, int platX, int platY, int platW, int platH) {
    this.papplet = p;
    this.platX = platX;
    this.platY = platY;
    this.platW = platW;
    this.platH = platH;
  }

  void platformDraw(int windowX, int windowY) {
    //papplet.rectMode(PApplet.CENTER);
    //papplet.strokeWeight(1);
    //papplet.fill(255, 0, 0);
    //papplet.rect(platX-windowX, platY-windowY, platW, platH);
    papplet.imageMode(PApplet.CENTER);
    papplet.image(platform, platX-windowX, platY-windowY, platW, platH);
  }

  void platGravity(Window window) {
    boolean colliding = (playerposX + playerSize/2 > platX - platW/2 && playerposX - playerSize/2 < platX + platW/2 && playerposY + playerSize/2 > platY - platH/2 && playerposY - playerSize/2 < platY + platH/2);
    gravedad = true;
    if (colliding) {
      // Calculate previous player position
      gravedad = false;
      int prevPlayerPosY = playerposY - (int)velocidadY;
      if (prevPlayerPosY + playerSize/2 <= platY - platH/2) {
        gravedad = false;
        playerposY = platY - platH/2 - playerSize/2; // Snap to top of platform
        velocidadY = 0; // Stop vertical movement
      } else if (prevPlayerPosY - playerSize/2 >= platY + platH/2) {
        gravedad = false;
        playerposY = platY + platH/2 + playerSize/2; // Snap to bottom of platform
        velocidadY = 0; // Reverse vertical movement
      } else {
        gravedad = true;
        // Determine the direction of collision and resolve
        float overlapX = min((playerposX + playerSize/2) - (platX - platW/2), (platX + platW/2) - (playerposX - playerSize/2));
        float overlapY = min((playerposY + playerSize/2) - (platY - platH/2), (platY + platH/2) - (playerposY - playerSize/2));

        // If the player is deeper horizontally than vertically, resolve horizontally
        if (overlapX < overlapY) {
          // RIGHT side collision
          if (playerposX < platX) { // Player is to the left of the platform center
            playerposX = int(platX - platW/2 - playerSize/2);
          }
          // LEFT side collision
          else { // Player is to the right of the platform center
            playerposX = int(platX + platW/2 + playerSize/2);
          }
          // Stop horizontal movement against the platform
          if (!(window.lefttouch)) playerVelL = 0;
          if (!(window.righttouch)) playerVelR = 0;
        }
      }
    }

    if (!(playerposY+playerSize/2 > platY-platH/2 && playerposY-playerSize/2 < platY+platH/2)) {
      if (((colliding && playerposY + playerSize/2 < platY - platH/2) || (colliding && playerposY - playerSize/2 > platY + platH/2)) && !((playerposX-playerSize/2 <= window.windowX) || (playerposX+playerSize/2 >= window.windowX+window.width)) ) {
        playerVelL = globalplayerVel;
        playerVelR = globalplayerVel;
      }
    }


    if (!(window.lefttouch) && (playerposX == int((platX+platW/2) + playerSize/2)) && (playerposY+playerSize/2 > platY-platH/2 && playerposY-playerSize/2 < platY+platH/2)) playerVelL = 0;
    if (!(window.righttouch) && (playerposX == int((platX-platW/2) - playerSize/2)) && (playerposY+playerSize/2 > platY-platH/2 && playerposY-playerSize/2 < platY+platH/2)) playerVelR = 0;
    if ((playerposX == int((platX+platW/2) + playerSize/2)) && !(playerposY+playerSize/2 > platY-platH/2 && playerposY-playerSize/2 < platY+platH/2)) playerVelL = globalplayerVel;
    if ((playerposX == int((platX-platW/2) - playerSize/2)) && !(playerposY+playerSize/2 > platY-platH/2 && playerposY-playerSize/2 < platY+platH/2)) playerVelR = globalplayerVel;




    // JUMP
    if (!u) {
      if (w && velocidadY == 0 && (playerposX + playerSize/2 > platX - platW/2 && playerposX - playerSize/2 < platX + platW/2) && playerposY + playerSize/2 == platY - platH/2) {
        velocidadY = -15;
      }
    } else {
      if (s && velocidadY == 0 && (playerposX + playerSize/2 > platX - platW/2 && playerposX - playerSize/2 < platX + platW/2) && playerposY - playerSize/2 == platY + platH/2) {
        velocidadY = 15;
      }
    }
  }
}
