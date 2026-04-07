class Door {
  PApplet p;
  int doorX, doorY;
  int doorW = 30, doorH = 50;
  boolean keyNotRequired;
  Door(PApplet p, int posX, int posY, boolean doesntNeedKey) {
    this.keyNotRequired = doesntNeedKey;
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
    /*

    */
  }

  void nextLevel() {
    boolean colisionX = (playerposX + playerSize/2 >= doorX - doorW/2) && 
                        (playerposX - playerSize/2 <= doorX + doorW/2);
    boolean colisionY = (playerposY + playerSize/2 >= doorY - doorH/2) && 
                        (playerposY - playerSize/2 <= doorY + doorH/2);
    
    /**/
    if (colisionX && colisionY) {
      if (keyNotRequired || (!keyNotRequired && hasKey)) {
        println("¡Nivel Completado!");
        estados.nextLevel = true;
        println(estados.nextLevel);
        println(estados.estados);
      }
    }
  }
}
