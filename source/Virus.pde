class Virus {   // el virus va a ser el efecto de glitch que remplaza a los pinches y mata al jugador al contacto.
  PApplet a;

  int virusX, virusY;
  int virusW, virusH;

  Virus(PApplet b, int virusX, int virusY, int virusW, int virusH) {
    this.a = b;
    this.virusX = virusX;
    this.virusY = virusY;
    this.virusW = virusW;
    this.virusH = virusH;
  }

  void virusDraw(int windowX, int windowY) {
    //a.fill(#D81C4F);
    //a.rectMode(CENTER);
    //a.strokeWeight(1);
    //a.stroke(0);
    //a.rect(virusX-windowX, virusY-windowY, virusW, virusH);
    a.imageMode(CENTER);
    a.image(virus, virusX-windowX, virusY-windowY, virusW, virusH);
  }

  void virusKill() {
    boolean virusColision = (playerposX+playerSize/2 >= virusX-virusW/2 &&
      playerposX-playerSize/2 <= virusX+virusW/2 &&
      playerposY+playerSize/2 >= virusY-virusH/2 &&
      playerposY-playerSize <= virusY+virusH/2);
    if (virusColision && alive) {
      respawnTimer = millis();
      hasKey = false;
      alive = false;
    }
  }
}
