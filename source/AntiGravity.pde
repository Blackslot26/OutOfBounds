class AntiGravity {
  int lastinWindow;
  int locallowestWindow;
  int inhowmanyWindows;
  boolean notinWindows;
  boolean inmultWindows;

  void antigravityConditions() {
    inhowmanyWindows = 0;
    int maxY = 0;

    for (int i = 0; i < WindowArray.size(); i++) {
      Window window = WindowArray.get(i);
      if (window != null && window.inWindow) {
        inhowmanyWindows++;
        lastinWindow = window.windowid;
        if (window.inWindow && window.windowY + window.height > maxY) {
          maxY = window.windowY + window.height;
          locallowestWindow = window.windowid;
        }
      }
    }

    for (int i = 0; i < WindowArray.size(); i++) {
      Window window = WindowArray.get(i);
      if (window != null) {
        window.onlyinthisWindow = (inhowmanyWindows == 1 && window.inWindow);
      }
    }

    notinWindows = (inhowmanyWindows == 0);
    inmultWindows = (inhowmanyWindows > 1);
    if (t && inhowmanyWindows == 0) t = false;
  }


  void antiwindowGravity(Window window) {
    boolean updash =  w && window.toptouch && u;
    if (window.onlyinthisWindow || (inmultWindows && window.windowid == locallowestWindow && toggleWindowMove == false) || (notinWindows && window.windowid == lastinWindow) || (inmultWindows && toggleWindowMove && window.windowid == lastinid)) {
      velocidadY -= 1;
      playerposY += velocidadY;
      if (!updash && playerposY <= window.windowY + playerSize/2) {
        playerposY = window.windowY + playerSize/2;
        velocidadY = 0;
      }
    }
    if (s && velocidadY == 0 && playerposY == window.windowY + playerSize/2 && u) {
      velocidadY = 15;
    }
    
    if (updash && playerposY == window.windowY + playerSize/2 && u) velocidadY = -15;
    if (s) w = false;
  }
}
