class Switch {
  PApplet p;
  int switchX, switchY;
  int switchW, switchH;
  boolean colliding;

  Switch(PApplet p, int switchX, int switchY) {
    this.p = p;
    this.switchX = switchX;
    this.switchY = switchY;
    switchW = 25;
    switchH = 25;
  }

  void SwitchDraw(int windowX, int windowY) {
    if (!u) {
      p.strokeWeight(1);
      p.stroke(0);
      p.rectMode(PApplet.CENTER);
      p.fill(#6B19FA);
      p.rect(switchX-windowX, switchY-windowY, 25, 25);
      p.fill(#C5FA19);
      p.rect(switchX-windowX, switchY-windowY, 12, 12);
    } else {
      p.strokeWeight(1);
      p.stroke(0);
      p.rectMode(PApplet.CENTER);
      p.fill(#C5FA19);
      p.rect(switchX-windowX, switchY-windowY, 25, 25);
      p.fill(#6B19FA);
      p.rect(switchX-windowX, switchY-windowY, 12, 12);
    }
  }



  void SwitchColision() {
    boolean colliding = playerposX + playerSize / 2 > switchX - switchW / 2 &&
      playerposX - playerSize / 2 < switchX + switchW / 2 &&
      playerposY + playerSize / 2 > switchY - switchH / 2 &&
      playerposY - playerSize / 2 < switchY + switchH / 2;

    int now = millis();

    if (colliding && now - globalLastToggleTime > gravityToggleCooldown) {
      u = !u;
      globalLastToggleTime = now;
    }
  }
}
