class Key {
  PApplet papplet;
  int keyX, keyY;
  int kframe = 0;
  int ktime = 0;
  Key(PApplet p, int keyX, int keyY) {
    this.papplet = p;
    this.keyX = keyX;
    this.keyY = keyY;
  }

  void keyDraw(int windowX, int windowY) {
    ktime++;
    if (ktime >= 10) {
      kframe++;
      ktime = 0;
    }
    if (kframe == 6) {
      kframe = 0;
    }
    papplet.stroke(0);
    papplet.imageMode(PApplet.CENTER);
    papplet.image(Key[kframe], keyX-windowX, keyY-windowY, 30, 30);
  }

void gotKey() {
  int keySize = 30; 
  boolean colX = playerposX + playerSize/2 > keyX - keySize/2 && playerposX - playerSize/2 < keyX + keySize/2;
  boolean colY = playerposY + playerSize/2 > keyY - keySize/2 && playerposY - playerSize/2 < keyY + keySize/2;
  
  if (colX && colY) {
    hasKey = true;
    println("GOT KEY");
  }
}
}
