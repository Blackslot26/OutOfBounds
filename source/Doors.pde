class Door {
  PApplet p;
  int doorX, doorY;
  int doorW = 30, doorH = 50;

  Door(PApplet p, int posX, int posY, boolean needKey) {
    keyRequired = needKey;
    this.p = p;
    doorX = posX;
    doorY = posY;
  }

  void doorDraw(int windowX, int windowY) {
    //p.rectMode(CENTER);
    //p.fill(#815205);
    //p.stroke(0);
    //p.strokeWeight(1);
    p.imageMode(CENTER);
    p.image(doorimg, doorX-windowX, doorY-windowY, doorW, doorH);
  }

  void nextLevel() {
    if (keyRequired == true) hasKey = true;
    if ((playerposX-playerSize/2 <= doorX+doorW/4) && (playerposX+playerSize/2 >= doorX-doorW/4) && (playerposY-playerSize/2 <= doorY+doorH/4) && (playerposY+playerSize/2 >= doorY-doorH/4) && hasKey) {
      estados.nextLevel = true;
    }
  }
}
