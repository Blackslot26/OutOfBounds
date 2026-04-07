class Window extends PApplet {

  JFrame frame;
  Player player = new Player(this);
  ArrayList<Platform> PlatArray = new ArrayList<Platform>();
  ArrayList<StillPlatform> StillPlatArray = new ArrayList<StillPlatform>();
  ArrayList<Key> Key = new ArrayList<Key>();
  ArrayList<Door> Door = new ArrayList<Door>();
  ArrayList<Virus> Virus = new ArrayList<Virus>();
  ArrayList<Switch> Switch = new ArrayList<Switch>();
  ArrayList<Background> BackgroundArray = new ArrayList<Background>();

  String windowname;
  int windowX, windowY;
  int windowWidth, windowHeight;
  int windowid;
  int windowtype;

  boolean isReady = false;

  int baseWindowType; // window type con el que se inicializa la clase en el constructor, se usa para volver al estado original con los toggles.
  float delayTime = 120;

  boolean inWindow;
  boolean onlyinthisWindow;

  boolean toggleMoveActive = true;
  boolean toggleGhostActive = true;
  boolean toggleGravityChangeActive = true;

  boolean lefttouch, righttouch;
  boolean toptouch, bottouch;

  int targetX1, targetY1;
  int targetX2, targetY2;
  float X, Y, windowDist;
  float velX, velY;
  int moveSpeed;
  int targetX, targetY;
  int targetNum;
  int time;

  boolean keyRequired;



  String[] creditsLines = {
    "CREDITOS:",
    "",
    "Un juego creado por:",
    "Joaquin Forni y Mathias Schneider…",
    "",
    "Musica:",
    "CORE                   Toby Fox;",
    "Barrier                 Toby Fox;",
    "Still Alive               Valve;",
    "Greenpath              Christopher Larkin;",
    "System Corruption      Harry Callaghan;",
    "",
    "Inspiraciones:",
    "Fireboy and Watergirl   Oslo Albet;",
    "Celeste                Maddy Makes Games;",
    "Undertale              Toby Fox;",
    "Balatro                LocalThunk;",
    "Pico Park              TECOPARK;",
    "Window Kill             Torkado;",
    "Portal 2               Valve;",
    "ULTRAKILL              Hakita;",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "                                 GRACIAS POR JUGAR…"
  };

  int currentLine = 0;
  int currentChar = 0;
  int charDelay = 30;  // ms between letters
  int lastCharTime = 0;
  String[] visibleLines;
  float scrollY = 0;
  float scrollSpeed = 0.5;



  Window(String windowname, int windowWidth, int windowHeight, int windowX, int windowY, int windowid, int windowtype) {
    // LocalVariable = InputVarible (VariableExterno)
    this.windowname = windowname;
    this.windowWidth = windowWidth;
    this.windowHeight = windowHeight;
    this.windowX = windowX;
    this.windowY = windowY;
    this.windowid = windowid;
    this.windowtype = windowtype;
    this.baseWindowType = windowtype;

    // Other Variables
    onlyinthisWindow = false;

    // Create Window
    PApplet.runSketch(new String[] { this.getClass().getName() }, this);
  }

  void settings() {
    size(windowWidth, windowHeight);
  }

  void setup() {
    delay(300);

    Object nativeSurface = surface.getNative();
    if (nativeSurface instanceof PSurfaceAWT.SmoothCanvas) {
      PSurfaceAWT.SmoothCanvas canvas = (PSurfaceAWT.SmoothCanvas) nativeSurface;
      java.awt.Component c = canvas.getFrame();
      if (c instanceof JFrame) {
        frame = (JFrame) c;
      }
    }

    surface.setLocation(windowX, windowY);
    surface.setTitle(windowname);


    isReady = true;
  }

  void draw() {
    if (!isReady) return;
    if (frame != null && frame.isDisplayable()) {
      background(0);
      surface.setSize(windowWidth, windowHeight);
      surface.setLocation(windowX, windowY);
      if (onlyinthisWindow && frame.isFocused() == false) {  // poner la ventana en la que esta el jugador por delante de las demas
        frame.toFront();
      }

      windowX = frame.getX();
      windowY = frame.getY();
      inWindow = playerposX+playerSize/2 > windowX && playerposX-playerSize/2 < windowX+width && playerposY+playerSize/2 > windowY && playerposY-playerSize/2 < windowY+height;

      if (windowtype == 0) blueWindow();      // ventana normal que permite activar el modo para empujar ventanas
      if (windowtype == 1) redWindow();       // ventana roja (falta programar)
      if (windowtype == 2) greenWindow();     // ventana verde, permite traspasar las paredes
      if (windowtype == 3 && onlyinthisWindow) lightblueWindow();    // ventana azul claro, no permite activar la ventana verde ni azul
      if (windowtype == 4) purpleWindow();    // ventana violeta que se mueve sola


      if (windowid == 1) room();


      for (Window window : WindowArray) {
        if (y) {
          window.windowtype = 2;
        } else if (!y) {
          windowtype = baseWindowType;
        }
      }
      if (t && (onlyinthisWindow && windowtype == 0 || lastinid == this.windowid && windowtype == 0)) toggleWindowMove = true;
      if (t && onlyinthisWindow && windowtype != 0) t = false;
      if (t == false && toggleWindowMove) toggleWindowMove = false;

      // Lastinid
      if (onlyinthisWindow) lastinid = windowid;


      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      for (Background b : BackgroundArray) {
        b.backImage(windowX, windowY);
      }
      for (Switch Switch : Switch) {
        Switch.SwitchDraw(windowX, windowY);
        Switch.SwitchColision();
      }

      for (Key Key : Key) {
        if (hasKey == false) {
          Key.keyDraw(windowX, windowY);
        }
        Key.gotKey();
      }
      for (Door Door : Door) {
        Door.doorDraw(windowX, windowY);
        Door.nextLevel();
      }

      for (Virus virus : Virus) {
        virus.virusDraw(windowX, windowY);
        virus.virusKill();
      }

      if (!u) {
        if (alive) {
          gravity.windowGravity(this);
        }
      } else {
        if (alive) {
          antigravity.antiwindowGravity(this);
        }
      }

      if (!(playerposX-windowX > 620 && estados.estados == 100.3) && !(estados.estados > 100.3)) player.playerDraw(windowX, windowY);
      player.playerDeathAnimation();

      for (Platform plat : PlatArray) {
        plat.platGravity(this);
        plat.platformDraw(windowX, windowY);
      }

      for (StillPlatform a : StillPlatArray) {
        if (windowid == a.platLink) {
          if (frame.isFocused()) {
            a.stillPlatformDraw();
            a.stillPlatGravity(this, windowX, windowY);
          }
        }
      }

      if (toggleWindowMove && windowtype == 0) {
        rectMode(CORNER);
        noStroke();
        fill(0, 255, 255);
        rect(0, 0, 5, height);
        rect(0, 0, width, 5);
        rect(width-5, 0, 5, height);
        rect(0, height-5, width, 5);
      }


      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


      righttouch = false;
      lefttouch = false;
      toptouch = false;
      bottouch = false;



      for (Window window : WindowArray) {
        if (this != window) {
          lefttouch = lefttouch  || (windowX  == window.windowX + window.width && playerposY+playerSize/2 <= window.windowY+window.height+5 && playerposY-playerSize/2 >= window.windowY-5);
          righttouch = righttouch  || (windowX + width == window.windowX && playerposY+playerSize/2 <= window.windowY+window.height+5 && playerposY-playerSize/2 >= window.windowY-5);
          toptouch = toptouch   || (windowY  == window.windowY + window.height && playerposX+playerSize/2 <= window.windowX+window.width && playerposX-playerSize/2 >= window.windowX && windowX <= window.windowX + window.width && windowX+width >= window.windowX);
          bottouch = bottouch  || (windowY + height  == window.windowY && playerposX+playerSize/2 <= window.windowX+window.width && playerposX-playerSize/2 >= window.windowX && windowX <= window.windowX + window.width && windowX+width >= window.windowX);
        }
      }




      for (Window window : WindowArray) {
        if (window != null && window != this) {
          if (t == false && y == false) {
            // Block exit unless touching
            if (onlyinthisWindow) {
              if (playerposX-playerSize/2 <= windowX && !(gravity.inmultWindows || lefttouch)) {
                playerposX = windowX+playerSize/2;
                if (playerposX == windowX+playerSize/2) {
                  if (a && !(gravity.inmultWindows || lefttouch)) playerVelL = 0;
                }
              }
              if (playerposX+playerSize/2 >= windowX+width && !(gravity.inmultWindows || righttouch)) {
                playerposX = windowX+width-playerSize/2;
                if (playerposX == windowX+width-playerSize/2) {
                  if (d && !(gravity.inmultWindows || righttouch)) playerVelR = 0;
                }
              }
            }
          }
        }
      }


      // Reset velocities (always active)
      if (onlyinthisWindow || lastinid == this.windowid || gravity.notinWindows) {
        if (!((playerposX-playerSize/2 <= windowX)||(playerposX+playerSize/2 >= windowX+width)) && playerposY+playerSize/2 <= windowY+height && playerposY-playerSize/2 >= windowY) {
          playerVelL = globalplayerVel;
          playerVelR = globalplayerVel;
        }
      }

      if (!toggleWindowMove) {
        if (playerposX == windowX+playerSize/2 && lefttouch) if (a && (gravity.inmultWindows || lefttouch)) playerVelL = globalplayerVel;
        if (playerposX == windowX+width-playerSize/2 && lefttouch) if (d && (gravity.inmultWindows || righttouch)) playerVelR = globalplayerVel;

        if (lefttouch) playerVelL = globalplayerVel;
        if (righttouch) playerVelR = globalplayerVel;
      }

      /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

      // end
    }
  }

  void blueWindow() {
    player.mode = false;
    // IF TMODE ON
    if (toggleWindowMove) {
      // Window Move
      if (lastinid == this.windowid) {
        if (playerposX-playerSize/2 <= this.windowX) {
          playerVelL = windowVel;
          if (a) this.windowX = playerposX-playerSize/2;
        }

        if (playerposX+playerSize/2 >= this.windowX+this.width) {
          playerVelR = windowVel;
          if (d) this.windowX = playerposX+playerSize/2-this.width;
        }
      }
      // Window PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH PUSH
      for (Window window : WindowArray) {
        if (this != window && window.windowtype == 0) {
          // Push Right
          if ((windowX+width >= window.windowX && windowX+width/2 <= window.windowX) && (windowY <= window.windowY+window.height-1 && windowY+height >= window.windowY+1)) {
            window.windowX = windowX+width;
            window.surface.setLocation(window.windowX, window.windowY);
          }
          // Push Left
          if ((windowX <= window.windowX+window.width && windowX+width/2 >= window.windowX+window.width) && (windowY <= window.windowY+window.height-1 && windowY+height >= window.windowY+1)) {
            window.windowX = windowX-window.width;
            window.surface.setLocation(window.windowX, window.windowY);
          }
        }
      }

      // Set location
      surface.setLocation(windowX, windowY);
    }
  }

  void redWindow() {  // tipo 1
    background(255, 0, 0);
  }

  void greenWindow() {  // tipo 2
    player.mode = true;
  }

  void lightblueWindow() { //tipo 3
    player.mode = false;
    toggleMoveActive = false;
    toggleGhostActive = false;
    if (onlyinthisWindow) {
      u = false;
    }
  }

  void purpleWindow() {    // tipo 4. Se mueve dinamicamente
    background(128, 0, 128); // Set a purple background for purpleWindow
    if (alive) {
      toggleMoveActive = false;
      toggleGhostActive = false;
      if (targetNum == 1) {
        targetX = targetX1;
        targetY = targetY1;
      }
      if (targetNum == 2) {
        targetX = targetX2;
        targetY = targetY2;
      }

      windowDist = dist(windowX, windowY, targetX, targetY);
      X = targetX - windowX;
      Y = targetY - windowY;
      velX = (X/windowDist) * moveSpeed;
      velY = (Y/windowDist) * moveSpeed;

      if (windowDist > moveSpeed) {
        windowX += velX;
        windowY += velY;
        surface.setLocation(windowX, windowY);
      } else {
        time++;
        windowX = targetX;
        windowY = targetY;
        if (time >= delayTime) {
          if (targetNum == 1) {
            targetNum = 2;
          } else {
            targetNum = 1;
          }
          time = 0;
        }
      }
    }
    // end
  }

  void room() {
    if (estados.estados == 100.1) {
      if (!(h < 51 && playerposX-windowX > 300)) {
        barrier.play();
        barrier.loop();
        estados.estados = 100.2;
      }
    }

    if (estados.estados == 100.2) {
      if (h < 51 && playerposX-windowX > 300) {
        barrier.stop();
        if (h == 0) door.play();
        globalplayerVel = 0;
        a = false;
        d = false;
        w = false;
        h = h+0.4;
        fill(255);
        quad(620, 90, 620, 190, 660, 207, 660, 107);
        rectMode(CENTER);
        fill(0);
        rect(620-h, 90, 100, 230);
      }

      if (h > 15) {
        image(floor3, 295, 75);
        fill(255);
        quad(620, 90, 620, 190, 660, 207, 660, 107);
        rectMode(CENTER);
        fill(0);
        rect(620-h, 90-h/5, 100, 230);
      }

      if (h > 25) {
        image(floor4, 295, 75);
        fill(255);
        quad(620, 90, 620, 190, 660, 207, 660, 107);
        rectMode(CENTER);
        fill(0);
        rect(620-h, 90-h/5, 100, 230);
      }

      if (h > 35) {
        image(floor5, 295, 75);
        fill(255);
        quad(620, 90, 620, 190, 660, 207, 660, 107);
        rectMode(CENTER);
        fill(0);
        rect(620-h, 90-h/5, 100, 230);
      }


      if (h > 40) {
        image(floor6, 295, 75);
        fill(255);
        quad(620, 90, 620, 190, 660, 207, 660, 107);
        rectMode(CENTER);
        fill(0);
        rect(620-h, 90-h/5, 100, 230);
      }


      if (h > 51 && h < 52) {
        stillalive.loop();
        globalplayerVel = 2;
        h = 100;
        frameCount = 0;
        estados.estados = 100.3;
      }
    }

    if (estados.estados == 100.3) {
      if (frameCount < 20) {
        image(floor1, 295, 75);
      }
      if (frameCount >= 20 && frameCount < 40) {
        image(floor2, 295, 75);
      }
      if (frameCount > 38) frameCount = 0;
      fill(255);
      quad(620, 90, 620, 190, 660, 207, 660, 107);



      if (playerposX-windowX > 620) {
        stillalive.stop();
        playerposY = 0;
        playerposX = 0;
        estados.estados = 100.4;
      }
    }

    if (estados.estados == 100.4) {
      windowX = windowX - 5;
      windowWidth = windowWidth + 10;
      windowY = windowY - 8;
      windowHeight = windowHeight + 13;
      surface.setLocation(windowX, windowY);
      windowResize(windowWidth, windowHeight);


      if (windowWidth == 1000) estados.estados = 100.5;
    }

    if (estados.estados == 100.5) {
      stillAliveC.play();
      textFont(pixelsF); // ← Your font must be already loaded
      textSize(30);
      textAlign(LEFT);
      visibleLines = new String[creditsLines.length];
      for (int i = 0; i < visibleLines.length; i++) {
        visibleLines[i] = "";
      }
      estados.estados = 100.6;
    }

    if (estados.estados == 100.6) {
      // Reveal letters one by one
      if (currentLine < creditsLines.length) {
        if (millis() - lastCharTime > charDelay) {
          String fullLine = creditsLines[currentLine];
          if (currentChar < fullLine.length()) {
            visibleLines[currentLine] += fullLine.charAt(currentChar);
            currentChar++;
            lastCharTime = millis();
          } else {
            currentLine++;
            currentChar = 0;
            lastCharTime = millis() + 300;  // pause between lines
          }
        }
      }

      // Start scrolling after line 14 is shown
      if (currentLine >= 14) {
        scrollY += scrollSpeed;
      }

      // Draw all visible lines with scrollY offset
      for (int i = 0; i <= currentLine && i < visibleLines.length; i++) {
        float y = 60 + i * 35 - scrollY;
        if (y > -30 && y < height + 30) { // only draw lines on-screen
          text(visibleLines[i], 50, y);
        }
      }
    }

    if (credtime == 3000) {
      estados.estados = 100.7;
    }

    if (credtime == 3500) {
      java.io.File file = new java.io.File(sketchPath(saveFile));
      if (file.exists()) {
        boolean deleted = file.delete();
        println("Debug mode: save file deleted = " + deleted);
      }
      exit();
    }
    if(estados.estados >= 100.6){
     credtime++; 
    }






    // end
  }


  void keyPressed() {
    player.keyPressed();
    if (this.key == 't' && toggleMoveActive) t = !t;
    if (this.key == 'y' && toggleGhostActive) y = !y;

    if (keyCode == ' ' && focusedWindow == 2) {
      focusedWindow--;
    } else if (keyCode == ' ') {
      focusedWindow++;
    }
    if (this.key == 'n') n = true;
  }

  void keyReleased() {
    player.keyReleased();
  }
}
