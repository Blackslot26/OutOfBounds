class Text extends PApplet {
  JFrame frame;

  String windowname;
  String dialogue;
  String subTextTop = "";
  String subTextBottom = "";

  int windowWidth, windowHeight, windowX, windowY;
  int mode; // 0 = single line, 1 = two-line mode

  String currentText = "";
  int textIndex = 0;
  int lastCharTime = 0;
  int charDelay = 50;

  Text(String windowname, int windowWidth, int windowHeight, int windowX, int windowY, String dialogue, int mode, String subTextTop, String subTextBottom) {
    this.windowname = windowname;
    this.windowWidth = windowWidth;
    this.windowHeight = windowHeight;
    this.windowX = windowX;
    this.windowY = windowY;
    this.dialogue = dialogue;
    this.mode = mode;
    this.subTextTop = subTextTop;
    this.subTextBottom = subTextBottom;

    PApplet.runSketch(new String[] { this.getClass().getName() }, this);
  }

  void settings() {
    size(windowWidth, windowHeight);
  }

  void setup() {
    surface.setLocation(windowX, windowY);
    surface.setTitle(windowname);
    delay(300);
    PSurfaceAWT.SmoothCanvas canvas = (PSurfaceAWT.SmoothCanvas) surface.getNative();
    frame = (JFrame) canvas.getFrame();
  }

  void draw() {
    background(0);
    displayText();
  }

  void displayText() {
    fill(255);
    textFont(pixelsF);
    textAlign(CENTER);
    textSize(35);

    if (millis() - lastCharTime > charDelay) {
      if (mode == 0 && textIndex < dialogue.length()) {
        currentText += dialogue.charAt(textIndex);
        textIndex++;
        lastCharTime = millis();
      } else if (mode == 1) {
        int totalLength = subTextTop.length() + subTextBottom.length();
        if (textIndex < totalLength) {
          textIndex++;
          lastCharTime = millis();
        }
      }
    }

    if (mode == 0) {
      // Single centered line
      text(currentText, windowWidth / 2, windowHeight / 2);
    } else if (mode == 1) {
      // Two lines, typewriter split across both
      String visibleTop = "";
      String visibleBottom = "";
      int lenTop = subTextTop.length();
      int lenBottom = subTextBottom.length();

      if (textIndex <= lenTop) {
        visibleTop = subTextTop.substring(0, textIndex);
      } else {
        visibleTop = subTextTop;
        int remaining = textIndex - lenTop;
        if (remaining > lenBottom) remaining = lenBottom;
        visibleBottom = subTextBottom.substring(0, remaining);
      }

      text(visibleTop, windowWidth / 2, windowHeight / 2 - 20);
      text(visibleBottom, windowWidth / 2, windowHeight / 2 + 20);
    }
  }

  void keyPressed() {
    if (key == 'w') w = true;
    if (key == 'a') a = true;
    if (key == 's') s = true;
    if (key == 'd') d = true;
  }

  void keyReleased() {
    if (key == 'w') w = false;
    if (key == 'a') a = false;
    if (key == 's') s = false;
    if (key == 'd') d = false;
  }
}
