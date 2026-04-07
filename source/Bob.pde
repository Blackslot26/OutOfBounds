class Bob extends PApplet {

  JFrame frame;

  String windowname;
  int windowWidth, windowHeight;
  int windowid;
  int totalNpcCount;
  boolean isLastWindow;
  ArrayList<PImage> caras;

  int delay = 0;
  float bobX, bobY;
  float targetX, targetY;
  float velX, velY;
  float X, Y, H;

  int c;
  int count = 0;
  int speed;

  Bob(String windowname, int windowWidth, int windowHeight, int windowid, int totalNpcCount, ArrayList<PImage> caras, boolean isLastWindow, int speed, float bobX, float bobY) {
    this.windowname = windowname;
    this.windowWidth = windowWidth;
    this.windowHeight = windowHeight;
    this.windowid = windowid;
    this.totalNpcCount = totalNpcCount;
    this.caras = caras;
    this.isLastWindow = isLastWindow;
    this.speed = speed;
    this.bobX = bobX;
    this.bobY = bobY;

    PApplet.runSketch(new String[] { this.getClass().getName() }, this);
  }

  void settings() {
    size(windowWidth, windowHeight);
  }

  void setup() {
    surface.setLocation(round(bobX), round(bobY));
    surface.setTitle(windowname);
    newTarget();

    c = round(map(windowid, 0, totalNpcCount - 1, 50, 190));
    PSurfaceAWT.SmoothCanvas canvas = (PSurfaceAWT.SmoothCanvas) surface.getNative();
    frame = (JFrame) canvas.getFrame();
  }

  void draw() {
    background(0, c, c);
    faceAnimation(1, 2);
  }

  void newTarget() {
    newT++;
    X = targetX - bobX;
    Y = targetY - bobY;
    H = dist(bobX, bobY, targetX, targetY);
    velX = (X / H) * speed;
    velY = (Y / H) * speed;
  }

  void bobMove() {
    surface.setLocation(round(bobX), round(bobY));
    H = dist(bobX, bobY, targetX, targetY);
    if (H > speed) {
      bobX += velX;
      bobY += velY;
    }
  }


  void faceAnimation(int cara1, int cara2) {
    if (isLastWindow && caras != null && caras.size() >= 7) {
      count++;
      imageMode(CENTER);
      if (count <= 10) {
        image(caras.get(cara1), width / 2, height / 2, 128, 128);
      } else if (count <= 20) {
        image(caras.get(cara2), width / 2, height / 2, 128, 128);
      } else {
        count = 0;
      }
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
