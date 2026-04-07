class Menu extends PApplet {
  PGraphics bt; // buffer temporal para solucionar error de parpadeo
  int posX, posY;
  int surfaceX, surfaceY;
  int targetSizeX;
  int targetSizeY;
  boolean cambioTamanio = false;
  float fadeIn = 0;
  boolean fadeA = false;
  boolean videoStarted;
  int velocidadAperturaX;
  int velocidadAperturaY;
  PImage backgroundGlitch;
  int estado = 1;
  float playW = play.width/3, playH = play.height/4;
  int expand = 0;
  boolean expandB = false;


  int textT;
  String storyText1;
  String storyText2;
  String storyText3;
  String storyText4;
  String storyText5;
  String storyText6;
  JFrame frame;
  Menu(int velocidadAperturaX, int velocidadAperturaY) {
    this.velocidadAperturaX = velocidadAperturaX;
    this.velocidadAperturaY = velocidadAperturaY;
    posX = displayWidth/2;
    posY = displayHeight/2;
    surfaceX = 128;
    surfaceY = 128;
    videoStarted = false;
    PApplet.runSketch(new String[] { this.getClass().getName() }, this);
    PSurfaceAWT.SmoothCanvas canvas = (PSurfaceAWT.SmoothCanvas) surface.getNative();
    frame = (JFrame) canvas.getFrame();



    storyText1 = "Desde los inicios del codigo, los procesos de defensa han combatido en silencio las amenazas del sistema\n\n";
    storyText1 += "Pero ya nadie recuerda su existencia\n\n";
    storyText1 += "Las luces se apagan. Las rutas están corrompidas. Y el nucleo...\n\n";
    storyText1 += "...contaminado.";

    storyText2 = "Un susurro binario, una grieta sin parche.\n";
    storyText2 += "El virus llego disfrazado de ayuda.\n";
    storyText2 += "Un trojano antiguo, mutado. Inteligente.\n";
    storyText2 += "Letal.";

    storyText3 = "Tu no eres un usuario.\n";
    storyText3 += "Eres un eco de los protocolos antiguos.\n";
    storyText3 += "Un fragmento de codigo olvidado, reactivado por emergencia.\n";
    storyText3 += "Eres una defensa autonoma";

    storyText4 = "El virus cree que eres un archivo comun.\n";
    storyText4 += "Te guia. Te entrena. Te llama 'companiero'.\n";
    storyText4 += "Y tu... sigues el juego.\n";

    storyText5 = "Los archivos desaparecen uno a uno.\n";
    storyText5 += "El virus sospecha.\n";
    storyText5 += "Empieza a cambiar el codigo.\n";
    storyText5 += "Te busca. Te teme.";

    storyText6 = "Ahora te llama traidor.\n";
    storyText6 += "Te caza con procesos corruptos, te bloquea rutas, te encierra en bucles.\n";
    storyText6 += "Pero tu continuas, porque no hay mas defensa.\n";
    storyText6 += "Eres el ultimo protocolo.";
  }
  void settings() {
    size(surfaceX, surfaceY);
  }

  void setup() {
    delay(100);
    surface.setLocation(posX, posY);
    backgroundGlitch = glitch.copy();
    backgroundGlitch.resize(surfaceX, surfaceY);
    background(backgroundGlitch);
    surface.setLocation(posX, posY);
    targetSizeX =  round(displayWidth*0.75);
    targetSizeY = round(displayHeight*0.75);
  }
  void draw() {
    if (estados.estados == 0.1) {
      if (estado == 1) animacion();
      if (estado == 2) menu();
      if (estado == 3) {
        estados.estados = 1;
        surface.setVisible(false);
      }
      if (estado == 4) historia();
      if (estado == 5) controles();
      if (estado == 6) Exit();
    }
  }

  void animacion() {
    if (!videoStarted) {
      menuAnimacion.play();
      videoStarted = true;
    }
    backgroundGlitch = glitch.copy();           // se copia y expande la imagen de "glitch" que se setea de fondo, esto es para que no se vea mal porque a processing no le da la
    backgroundGlitch.resize(surfaceX, surfaceY);  // velocidad para expandir la imagen a tiempo y por unos milisegundos se ve el background asi que usamos este metodo para que no quede tan mal
    background(backgroundGlitch);

    if (surfaceX < targetSizeX) {
      surfaceX += velocidadAperturaX;
      cambioTamanio = true;
    }
    if (surfaceY < targetSizeY) {
      surfaceY += velocidadAperturaY;
      cambioTamanio = true;
    }
    if (surfaceX > targetSizeX) surfaceX = targetSizeX;
    if (surfaceY > targetSizeY) surfaceY = targetSizeY;
    if (cambioTamanio) {
      surface.setLocation(displayWidth/2 - surfaceX/2, displayHeight/2 - surfaceY/2);
      surface.setSize(surfaceX, surfaceY);
      cambioTamanio = false;
    }
    if (videoStarted) {
      if (menuAnimacion.available()) {
        menuAnimacion.read();
      }
      int x = frame.getX();
      int y = frame.getY();
      int z = (displayWidth-targetSizeX)/2;
      int w = (displayHeight-targetSizeY)/2;
      image(menuAnimacion, z-x, w-y, targetSizeX, targetSizeY);
    }
    if (menuAnimacion.duration()-menuAnimacion.time() <= 0.2) estado = 2;
  }


  void menu() {

    imageMode(CORNER);
    fill(255);
    rect(width*0.3, height*0.4, 100, 40);
    imageMode(CORNER);
    if (background.available()) background.read();
    image(background, 0, 0, targetSizeX, targetSizeY);


    imageMode(CENTER);
    image(play, width*0.2, height*0.5, 350, 60);
    image(historia, width*0.2, height*0.5+80, 350, 60);
    image(controles, width*0.2, height*0.5+160, 350, 60);
    image(exit, width*0.2, height*0.5+240, 350, 60);
    if (mouseX >= width*0.2-175 && mouseX <= width*0.2+175 && mouseY >= height*0.5-30 && mouseY <= height*0.5+30 && mousePressed) { // colision play
      estado = 3;
    }
    if (mouseX >= width*0.2-175 && mouseX <= width*0.2+175 && mouseY >= height*0.5+80-30 && mouseY <= height*0.5+80+30 && mousePressed) {  // colision historia
      estado = 4;
    }
    if (mouseX >= width*0.2-175 && mouseX <= width*0.2+175 && mouseY >= height*0.5+160-30 && mouseY <= height*0.5+160+30 && mousePressed) {  // colision controles
      estado = 5;
    }
    if (mouseX >= width*0.2-175 && mouseX <= width*0.2+175 && mouseY >= height*0.5+240-30 && mouseY <= height*0.5+240+30 && mousePressed) {  //colision exit
      estado = 6;
    }
  }

  void keyPressed() {
    if (this.key == 'w') w = true;
    if (this.key == 'a') a = true;
    if (this.key == 's') s = true;
    if (this.key == 'd') d = true;
  }

  void keyReleased() {
    if (this.key == 'w') w = false;
    if (this.key == 'a') a = false;
    if (this.key == 's') s = false;
    if (this.key == 'd') d = false;
  }



  void niveles() {
    estados.estados = 1;
  }

  void controles() {
    keyboard.resize(width, height);
    background(keyboard);
    image(back, 50, 50, 50, 50);
    if (mouseX >= 25 && mouseX <= 75 && mouseY >= 25 && mouseY <= 75 && mousePressed) {
      estado = 2;
    }
  }

  void historia() {
    background(0, 0, 0);
    textFont(pixelsF);
    fill(0, 255, 0);
    textSize(30);
    textAlign(CENTER);
    textT++;
    if (textT < 400) {
      text(storyText1, width/2, height/2);
    }
    if (textT > 400 && textT < 800) {
      text(storyText2, width/2, height/2);
    }
    if (textT > 800 && textT < 1200) {
      text(storyText3, width/2, height/2);
    }
    if (textT > 1200 && textT < 1600) {
      text(storyText4, width/2, height/2);
    }
    if (textT > 1600) {
      text(storyText4, width/2, height/2);
    }
    
    image(back, 50, 50, 50, 50);
    if (mouseX >= 25 && mouseX <= 75 && mouseY >= 25 && mouseY <= 75 && mousePressed) {
      estado = 2;
    }
  }
  void Exit() {
    exit();
  }
}
