class StillPlatform {
  PApplet papplet;

  int platX, platY;
  int platW, platH;
  int playerstillposX, playerstillposY;
  int platLink;


  StillPlatform(PApplet p, int platX, int platY, int platW, int platH, int platLink) {
    this.papplet = p;
    this.platX = platX;
    this.platY = platY;
    this.platW = platW;
    this.platH = platH;
    this.platLink = platLink;
  }

  void stillPlatformDraw() {
    papplet.strokeWeight(1);
    papplet.stroke(0);
    papplet.rectMode(PApplet.CENTER);
    papplet.fill(255, 0, 0);
    papplet.rect(platX, platY, platW, platH);
  }

  void stillPlatGravity(Window window, int windowsX, int windowsY) {

    playerstillposX = playerposX-windowsX;
    playerstillposY = playerposY-windowsY;
    // Check for collision with the platform
    int nextPlayerPosY = playerstillposY + (int)velocidadY;
    boolean colliding = (playerstillposX + playerSize/2 > platX - platW/2 &&
      playerstillposX - playerSize/2 < platX + platW/2 &&
      nextPlayerPosY + playerSize/2 > platY - platH/2 &&
      nextPlayerPosY - playerSize/2 < platY + platH/2);

    if (colliding) {
      // Calculate previous player position
      int prevPlayerPosY = playerstillposY - (int)velocidadY;

      // **PRIORITIZE VERTICAL COLLISION (LANDING)**
      // Check if player was above the platform in the previous frame and is now colliding vertically
      if (prevPlayerPosY + playerSize/2 <= platY - platH/2) {
        playerposY = ((platY - platH/2 - playerSize/2)+windowsY); // Snap to top of platform
        velocidadY = 0; // Stop vertical movement
      }
      // Handle collision from below (hitting head on platform)
      else if (prevPlayerPosY - playerSize/2 >= platY + platH/2 && velocidadY < 0) {
        playerposY = (platY + platH/2 + playerSize/2)+windowsY; // Snap to bottom of platform
        velocidadY = 0; // Reverse vertical movement
      }
      // **THEN HANDLE HORIZONTAL COLLISION**
      else {
        // Determine the direction of collision and resolve
        float overlapX = min((playerstillposX + playerSize/2) - (platX - platW/2), (platX + platW/2) - (playerstillposX - playerSize/2));
        float overlapY = min((playerstillposY + playerSize/2) - (platY - platH/2), (platY + platH/2) - (playerstillposY - playerSize/2));

        // If the player is deeper horizontally than vertically, resolve horizontally
        if (overlapX < overlapY) {
          // RIGHT side collision
          if (playerstillposX < platX) { // Player is to the left of the platform center
            playerposX = int((platX - platW/2 - playerSize/2)+windowsX);
          }
          // LEFT side collision
          else { // Player is to the right of the platform center
            playerposX = int((platX + platW/2 + playerSize/2)+windowsX);
          }
          // Stop horizontal movement against the platform
          playerVelL = 0;
          playerVelR = 0;
        }
      }
    }

    // Restore horizontal velocity if not colliding horizontally with *this* platform
    // This needs to be outside the 'if (colliding)' block to allow movement after moving off an edge
    if ((!colliding || (colliding && playerstillposY + playerSize/2 < platY - platH/2) || (colliding && playerstillposY - playerSize/2 > platY + platH/2)) && !((playerposX-playerSize/2 <= window.windowX) || (playerposX+playerSize/2 >= window.windowX+window.width))) {
      playerVelL = globalplayerVel;
      playerVelR = globalplayerVel;
    }

    if ((playerstillposX == int((platX+platW/2) + playerSize/2)) && (playerstillposY+playerSize/2 > platY-platH/2 && playerstillposY-playerSize/2 < platY+platH/2)) playerVelL = 0;
    if ((playerstillposX == int((platX-platW/2) - playerSize/2)) && (playerstillposY+playerSize/2 > platY-platH/2 && playerstillposY-playerSize/2 < platY+platH/2)) playerVelR = 0;

    if ((playerstillposX != int((platX+platW/2) + playerSize/2)) && (playerstillposY+playerSize/2 > platY-platH/2 && playerstillposY-playerSize/2 < platY+platH/2)) playerVelL = globalplayerVel;
    if ((playerstillposX != int((platX-platW/2) - playerSize/2)) && (playerstillposY+playerSize/2 > platY-platH/2 && playerstillposY-playerSize/2 < platY+platH/2)) playerVelR = globalplayerVel;
    if ((playerstillposX == int((platX+platW/2) + playerSize/2)) && !(playerstillposY+playerSize/2 > platY-platH/2 && playerstillposY-playerSize/2 < platY+platH/2)) playerVelL = globalplayerVel;
    if ((playerstillposX == int((platX-platW/2) - playerSize/2)) && !(playerstillposY+playerSize/2 > platY-platH/2 && playerstillposY-playerSize/2 < platY+platH/2)) playerVelR = globalplayerVel;


    // JUMP
    // This should ideally check if player is *on* the platform, not just at the same Y.
    // The `velocidadY = 0` check in the vertical collision handling already ensures this.
    if (w && velocidadY == 0 &&
      (playerstillposX + playerSize/2 > platX - platW/2 &&
      playerstillposX - playerSize/2 < platX + platW/2) &&
      playerstillposY + playerSize/2 == platY - platH/2) {
      velocidadY = -15;
    }
  }
}
