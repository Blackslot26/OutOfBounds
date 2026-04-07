class ErrorWindows extends PApplet {
  String windowName;
  int posX, posY;
  float R, G, B;
  int[] windowsWidth = new int[error.length];
  int[] windowsHeight = new int[error.length];
  int tipoVentana;
  int opacidad;
  int imagenElegida;
  JFrame frame;
  ErrorWindows(int posX, int posY, String windowName, int opacidad) {
    this.posX = posX;
    this.posY = posY;
    this.windowName = windowName;
    for (int i = 0; i < error.length; i++) {
      windowsWidth[i] = error[i].width;
      windowsHeight[i] = error[i].height;
    }
    this.opacidad = opacidad;
    imagenElegida = int(random(1, 6.99));

    PApplet.runSketch(new String[] { this.getClass().getName() }, this);
    PSurfaceAWT.SmoothCanvas canvas = (PSurfaceAWT.SmoothCanvas) surface.getNative();
    frame = (JFrame) canvas.getFrame();
  }


  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  void settings() {
    size(windowsWidth[imagenElegida], windowsHeight[imagenElegida]);
    errorSfx[imagenElegida].play();
  }
  void setup() {
  }

  void draw() {
    if (keyPressed && key == ' ') {
      estados.velocidadAperturaX = round((displayWidth*0.75)/70);
      estados.velocidadAperturaY = round((displayHeight*0.75)/70);
      delay(200);
      animacionStart.estado = 3;
    }
    noStroke();
    fondo();
    fill(0, 0, 0, opacidad);
    rect(0, 0, windowsWidth[imagenElegida], windowsHeight[imagenElegida]);
    if (opacidad == 255) image(infected, 0, 0);
    surface.setLocation(posX, posY);

  }

  void fondo() {
    for (int i = 0; i < error.length; i++) {
      if (imagenElegida == i) {
        surface.setSize(windowsWidth[i], windowsHeight[i]);
        image(error[i], 0, 0);
        surface.setTitle(windowName);
      }
    }
  }
  void Close(){
    noLoop();
    stop();
    delay(10);
    frame.dispose();
  }
}
