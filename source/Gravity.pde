class Gravity {
  int lastinWindow;
  int globalhighestWindow;
  int globalhighestWindowid;
  int localhighestWindow;
  int inhowmanyWindows;
  boolean notinWindows;
  boolean inmultWindows;

  void gravityConditions() {
    inhowmanyWindows = 0;
    globalhighestWindow = displayHeight + 1000;
    globalhighestWindowid = -1;
    int minY = displayHeight + 1000;

    for (int i = 0; i < WindowArray.size(); i++) {
      Window window = WindowArray.get(i);
      if (window != null && window.inWindow) {
        inhowmanyWindows++;
        lastinWindow = window.windowid;
        if (window.windowY + window.height < globalhighestWindow) {
          globalhighestWindow = window.windowY + window.height;
          globalhighestWindowid = window.windowid;
        }
        if (window.inWindow && window.windowY + window.height < minY) {
          minY = window.windowY + window.height;
          localhighestWindow = window.windowid;
        }
        if (window.windowid == globalhighestWindowid) {
          globalhighestWindowid = window.windowid;
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


  void windowGravity(Window window) {
    if (estados.estados >= 100 && estados.estados <= 100.3) {
      if (window.onlyinthisWindow || (inmultWindows && window.windowid == localhighestWindow && toggleWindowMove == false) || (notinWindows && window.windowid == lastinWindow) || (inmultWindows && toggleWindowMove && window.windowid == lastinid)) {
        velocidadY += 1;
        playerposY += velocidadY;
        if (playerposY >= window.windowY + window.height-105) {
          playerposY = window.windowY + window.height-105;
          velocidadY = 0;
        }

        if (w && playerposY == window.windowY + window.height - 105) {
          velocidadY = -15;
        }
      }
    } else {
      boolean downdash =  s && window.bottouch && !u;
      if (window.onlyinthisWindow || (inmultWindows && window.windowid == localhighestWindow && toggleWindowMove == false) || (notinWindows && window.windowid == lastinWindow) || (inmultWindows && toggleWindowMove && window.windowid == lastinid)) {
        velocidadY += 1;
        playerposY += velocidadY;
        if (!downdash && playerposY >= window.windowY + window.height - playerSize/2) {
          playerposY = window.windowY + window.height - playerSize/2;
          velocidadY = 0;
        }
      }
      if (w && velocidadY == 0 && playerposY == window.windowY + window.height - playerSize/2 && !u) {
        velocidadY = -15;
      }

      if (downdash && playerposY == window.windowY + window.height - playerSize/2 && !u) velocidadY = 15;
      if (w) s = false;
    }
  }
}
