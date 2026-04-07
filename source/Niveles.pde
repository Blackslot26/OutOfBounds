class Estados { //<>//
  float estados = 1;
  boolean nextLevel = false;
  int respawnPointX;
  int respawnPointY;
  ////
  Menu mainMenu;
  int velocidadAperturaX;
  int velocidadAperturaY;
  boolean menu = true;
  boolean changed = false;
  int bGlitch = 0;
  int bT = 0;
  void estados() {
    // Debug Setup
    //if (estados == 0) {
    //  // Windows
    //  saveLevel();
    //  WindowArray.add(new Window("", 400, 400, displayWidth/2-400, displayHeight/2-400/2, 1, 0));
    //  WindowArray.add(new Window("", 400, 400, displayWidth/2, displayHeight/2-400/2, 2, 0));
    //  WindowArray.add(new Window("", 300, 300, 100, 100, 3, 0));
    //  //WindowArray.add(new Window("", 300, 300, 100, 100, 4, 0));
    //  //WindowArray.add(new Window("", 300, 300, 100, 100, 5, 0));
    //  //WindowArray.add(new Window("", 300, 300, 100, 100, 6, 0));
    //  for (Window window : WindowArray) {
    //    if (window != null) {
    //      // Platforms
    //      if (window.PlatArray != null) {
    //        window.PlatArray.add(new Platform(window, displayWidth/2, displayHeight/2, 200, 40));
    //        window.PlatArray.add(new Platform(window, displayWidth/2 + 150, displayHeight/2 - 100, 100, 30));
    //      }
    //      // Key
    //      window.Key.add(new Key(window, displayWidth/2+100, displayHeight/2+150));
    //      //Door
    //      window.Door.add(new Door(window, displayWidth/2+300, displayHeight/2+150, false));
    //    }
    //  }
    //  estados = 0.1;
    //}

    //// Debug → Level 1
    //if (estados == 0.1 && nextLevel) {
    //  for (int i = WindowArray.size() - 1; i >= 0; i--) {
    //    Window window = WindowArray.get(i);
    //    if (window != null && window.frame != null && window.frame.isDisplayable()) {
    //      delay(200);
    //      window.PlatArray.clear();
    //      window.Key.clear();
    //      window.frame.dispose();
    //      WindowArray.remove(i);
    //    }
    //  }
    //  if (WindowArray.size() == 0) {
    //    w = false;
    //    a = false;
    //    s = false;
    //    d = false;
    //    y = false;
    //    hasKey = false;
    //    lastinid = -1;
    //    gravity.lastinWindow = -1;
    //    antigravity.lastinWindow = -1;

    //    estados = 1;
    //  }
    //  nextLevel = false;
    //}
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    //BOB
    //if (estados == int(estados) && !bobCreated) {
    //  for (int i = 0; i < arraySize; i++) {
    //    boolean isLast = (i == arraySize - 1);
    //    BobArray.add(new Bob("", 128 + i * 3, 128 + i * 3, i, arraySize, caras, isLast, 10, 0, 0));
    //  }

    //  for (Bob bob : BobArray) {
    //    bob.targetX = 0;
    //    bob.targetY = 0;
    //  }

    //  TextArray.add(new Text("", 400, 128, 700, 200, "ok", 1, "o", "k"));
    //  bobCreated = true;
    //}

    if ((estados == 1 || estados == 2 || estados == 3) && !musiclayer1) {
      greenpath.loop();
      musiclayer1 = true;
    } else if ((estados == 4 || estados == 5 || estados == 6 || estados == 7) && !musiclayer2) {
      systemcorruption.loop();
      systemcorruption.amp(0.5);
      musiclayer2 = true;
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if (estados == 0) {
      animacionStart.estadoInicio();
    }
    if (estados == 0.1) {
      if (menu) {
        velocidadAperturaX = int((displayWidth*0.75)/120);
        velocidadAperturaY = int((displayHeight*0.75)/120);
        mainMenu = new Menu(velocidadAperturaX, velocidadAperturaY);
        Music1.play();
        Music1.amp(0.5);
        menu = false;
      }
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Level 1 Setup
    if (estados == 1) {
      if (mainMenu != null) {
        Music1.stop();
        menuAnimacion.stop();
        menuAnimacion = null;
        mainMenu.dispose();
      }
      delay(200);


      saveLevel();
      playerposX = displayWidth/2-displayWidth/2/2;
      playerposY = displayHeight/2-300/2;
      WindowArray.add(new Window("", displayWidth/2, displayHeight, -10, -15, 1, 0));
      WindowArray.add(new Window("", displayWidth/2, displayHeight, displayWidth/2-10, -15, 2, 0));
      for (Window window : WindowArray) {
        window.BackgroundArray.add(new Background(window, windows[bGlitch], -10, -15, displayWidth, displayHeight));
        window.Key.add(new Key(window, displayWidth/2+350, displayHeight/2+200));
        window.Door.add(new Door(window, displayWidth/2-350, displayHeight/2+170, false));
      }

      delay(2000);
      estados = 1.1;
    }

    if (estados == 1.1) {
      changed = false;
      //println(WindowArray.get(0).windowWidth);
      //println(WindowArray.get(0).windowHeight);
      if (WindowArray.get(0).windowWidth > 450) {
        WindowArray.get(0).windowWidth -= 5;
        changed = true;
      }
      if (WindowArray.get(0).windowHeight > 450) {
        WindowArray.get(0).windowHeight -= 5;
        changed = true;
      }
      if (WindowArray.get(1).windowWidth > 450) {
        WindowArray.get(1).windowWidth -= 5;
        changed = true;
      }
      if (WindowArray.get(1).windowHeight > 450) {
        WindowArray.get(1).windowHeight -= 5;
        changed = true;
      }
      if (changed) {
        WindowArray.get(0).windowX = displayWidth/2 - displayWidth/4 - WindowArray.get(0).windowWidth/2;
        WindowArray.get(0).windowY = displayHeight/2-WindowArray.get(0).windowHeight/2;
        WindowArray.get(1).windowX = displayWidth/2 + displayWidth/4 - WindowArray.get(1).windowWidth/2;
        WindowArray.get(1).windowY = displayHeight/2-WindowArray.get(1).windowHeight/2;
      }
      if (WindowArray.get(0).windowWidth <= 460 && WindowArray.get(0).windowHeight <= 460 && WindowArray.get(1).windowWidth <= 460 && WindowArray.get(1).windowHeight <= 460) {

        
        for (Window w : WindowArray) {
          w.windowWidth = 450;
          w.windowHeight = 450;
        }

        WindowArray.get(0).windowX = displayWidth/2 - displayWidth/4 - 450/2;
        WindowArray.get(0).windowY = displayHeight/2 - 450/2;
        WindowArray.get(1).windowX = displayWidth/2 + displayWidth/4 - 450/2;
        WindowArray.get(1).windowY = displayHeight/2 - 450/2;
                                // SE SUPONE QUE ESTE BLOQUE DE CODIGO ES DE LA ANIMACION INICIAL DEL NIVEL 1. PERO CULPA DE LAS VENTANAS DE MIERDA DE WINDOWS ES POSIBLE QUE BUGUEE TODO EL CAMBIO DE NIVEL.
        estados = 1.2;        //AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
      }
    }

    if (int(estados) == 1) y = false;


    // Level 1 Draw
    if (estados == 1.2) {
      bT++;
      if (bT == 450) {
        bGlitch++;
        println(bGlitch);
        for (Window w : WindowArray) {
          w.BackgroundArray.get(0).imagen = windows[bGlitch];
        }
      }
      if (bT == 470) {
        bGlitch++;
        println(bGlitch);
        for (Window w : WindowArray) {
          w.BackgroundArray.get(0).imagen = windows[bGlitch];
        }
      }
      if (bT == 490) {
        bGlitch++;
        println(bGlitch);
        for (Window w : WindowArray) {
          w.BackgroundArray.get(0).imagen = windows[bGlitch];
        }
      }
      if (bT == 500) {
        bGlitch = 0;
        println(bGlitch);
        for (Window w : WindowArray) {
          w.BackgroundArray.get(0).imagen = windows[bGlitch];
        }
        bT = 0;
      }
    }

    if (estados == 1.2 && nextLevel) {
      for (int i = WindowArray.size() - 1; i >= 0; i--) {
        Window window = WindowArray.get(i);
        if (window != null && window.frame != null && window.frame.isDisplayable()) {
          window.noLoop();
          window.stop();
          delay(200);
          window.PlatArray.clear();
          window.Key.clear();
          window.Door.clear();
          window.frame.dispose();
          WindowArray.remove(i);
        }
      }
      if (WindowArray.size() == 0) {
        w = false;
        a = false;
        s = false;
        d = false;
        hasKey = false;
        y = false;
        lastinid = -1;
        gravity.lastinWindow = -1;
        antigravity.lastinWindow = -1;
        estados = 2;
        println("NIVEL 2 CARGADO CORRECTAMENTE");
      }
      nextLevel = false;
    }
    /**/
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    if (estados == 2) { //setup
      delay(200);
      saveLevel();
      playerposX = displayWidth/2-350;
      playerposY = displayHeight/2-75;
      WindowArray.add(new Window("", 300, 300, displayWidth/2-displayWidth/2/2-300/2, displayHeight/2-300/2, 1, 0));
      WindowArray.add(new Window("", 300, 300, displayWidth/2+displayWidth/2/2-300/2, displayHeight/2-300/2, 2, 0));
      WindowArray.add(new Window("", 128, 128, displayWidth/2-64, displayHeight/2+32, 3, 0));

      for (Window window : WindowArray) {
        window.BackgroundArray.add(new Background(window, windows[bGlitch], -10, -15, displayWidth, displayHeight));
        window.Key.add(new Key(window, displayWidth/2+350, displayHeight/2+125));
        window.Door.add(new Door(window, displayWidth/2, displayHeight/2+125, false));
      }
      estados = 2.1;
    }

    if (int(estados) == 2) t = false;


    if (estados == 2.1) {
      bT++;
      if (bT == 450) {
        bGlitch++;
        println(bGlitch);
        for (Window w : WindowArray) {
          w.BackgroundArray.get(0).imagen = windows[bGlitch];
        }
      }
      if (bT == 470) {
        bGlitch++;
        println(bGlitch);
        for (Window w : WindowArray) {
          w.BackgroundArray.get(0).imagen = windows[bGlitch];
        }
      }
      if (bT == 490) {
        bGlitch++;
        println(bGlitch);
        for (Window w : WindowArray) {
          w.BackgroundArray.get(0).imagen = windows[bGlitch];
        }
      }
      if (bT == 500) {
        bGlitch = 0;
        println(bGlitch);
        for (Window w : WindowArray) {
          w.BackgroundArray.get(0).imagen = windows[bGlitch];
        }
        bT = 0;
      }
    }

    if (estados == 2.1 && nextLevel) {
      for (int i = WindowArray.size() - 1; i >= 0; i--) {
        Window window = WindowArray.get(i);
        if (window != null && window.frame != null && window.frame.isDisplayable()) {
          window.noLoop();
          window.stop();
          delay(200);
          window.PlatArray.clear();
          window.Key.clear();
          window.Door.clear();
          window.frame.dispose();
          WindowArray.remove(i);
        }
      }
      if (WindowArray.size() == 0) {
        w = false;
        a = false;
        s = false;
        d = false;
        hasKey = false;
        lastinid = -1;
        gravity.lastinWindow = -1;
        antigravity.lastinWindow = -1;
        y = false;
        estados = 3;
      }
      nextLevel = false;
    }

    ////////////////////////////////////////wwwwww///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if (estados == 3) {
      saveLevel();
      WindowArray.add(new Window("", 650, 650, int(displayWidth/2-325), displayHeight/2-350, 1, 3));  // area principal
      WindowArray.add(new Window("", 300, 200, displayWidth/2+325, displayHeight/2-350, 2, 3)); // area llave
      WindowArray.add(new Window("", 300, 200, displayWidth/2-625, displayHeight/2+100, 3, 3)); // area puerta
      playerposX = int(displayWidth/2-400);
      playerposY = int(displayHeight/2+200);
      for (Window window : WindowArray) {
        window.BackgroundArray.add(new Background(window, windows[bGlitch], -10, -15, displayWidth, displayHeight));
        window.Key.add(new Key(window, int(displayWidth/2+400), displayHeight/2-250));
        window.Door.add(new Door(window, int(displayWidth/2-400), displayHeight/2+240, false));
        window.PlatArray.add(new Platform(window, int(displayWidth/2-220), displayHeight/2+230, 60, 50));  //plat1
        window.PlatArray.add(new Platform(window, int(displayWidth/2-120), displayHeight/2+160, 30, 15));  //plat2
        window.PlatArray.add(new Platform(window, int(displayWidth/2+50), displayHeight/2+175, 120, 50));  //plat3
        window.PlatArray.add(new Platform(window, int(displayWidth/2+180), displayHeight/2+250, 50, 20));  //play4
        window.PlatArray.add(new Platform(window, int(displayWidth/2+280), displayHeight/2+100, 90, 140)); //plat5
        window.PlatArray.add(new Platform(window, int(displayWidth/2+150), displayHeight/2+90, 30, 15));   //plat6
        window.PlatArray.add(new Platform(window, int(displayWidth/2+80), displayHeight/2-20, 60, 20));    //plat7
        window.PlatArray.add(new Platform(window, int(displayWidth/2-100), displayHeight/2-20, 60, 20));   //plat8
        window.PlatArray.add(new Platform(window, int(displayWidth/2-285), displayHeight/2+10, 80, 20));   //plat9
        window.PlatArray.add(new Platform(window, int(displayWidth/2-305), displayHeight/2-50, 40, 100));  //plat10
        window.PlatArray.add(new Platform(window, int(displayWidth/2-210), displayHeight/2-155, 30, 15));  //plat11
        window.PlatArray.add(new Platform(window, int(displayWidth/2-50), displayHeight/2-190, 150, 60));  //plat12
        window.PlatArray.add(new Platform(window, int(displayWidth/2+160), displayHeight/2-160, 60, 20));  //plat13
      }
      estados = 3.1;
    }

    if (estados == 3.1) {
      bT++;
      if (bT == 450) {
        bGlitch++;
        println(bGlitch);
        for (Window w : WindowArray) {
          w.BackgroundArray.get(0).imagen = windows[bGlitch];
        }
      }
      if (bT == 470) {
        bGlitch++;
        println(bGlitch);
        for (Window w : WindowArray) {
          w.BackgroundArray.get(0).imagen = windows[bGlitch];
        }
      }
      if (bT == 490) {
        bGlitch++;
        println(bGlitch);
        for (Window w : WindowArray) {
          w.BackgroundArray.get(0).imagen = windows[bGlitch];
        }
      }
      if (bT == 500) {
        bGlitch = 0;
        println(bGlitch);
        for (Window w : WindowArray) {
          w.BackgroundArray.get(0).imagen = windows[bGlitch];
        }
        bT = 0;
      }
    }

    if (estados == 3.1 && nextLevel) {
      for (int i = WindowArray.size() - 1; i >= 0; i--) {
        Window window = WindowArray.get(i);
        if (window != null && window.frame != null && window.frame.isDisplayable()) {
          window.noLoop();
          window.stop();
          delay(200);
          window.PlatArray.clear();
          window.Key.clear();
          window.Door.clear();
          window.frame.dispose();
          WindowArray.remove(i);
        }
      }
      if (WindowArray.size() == 0) {
        w = false;
        a = false;
        s = false;
        d = false;
        hasKey = false;
        lastinid = -1;
        gravity.lastinWindow = -1;
        antigravity.lastinWindow = -1;
        y = false;
        greenpath.stop();
        systemcorruption.loop();
        systemcorruption.amp(0.5);
        musiclayer2 = true;
        estados = 4;
      }
      nextLevel = false;
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    if (estados == 4) {
      delay(200);
      saveLevel();
      respawnPointX = displayWidth/2-500;
      respawnPointY = displayHeight/2+100;
      playerposX = displayWidth/2-500;
      playerposY = displayHeight/2+100;
      WindowArray.add(new Window("", 300, 300, displayWidth/2-688, displayHeight/2-150, 1, 3));
      WindowArray.add(new Window("", 300, 300, displayWidth/2+373, displayHeight/2-150, 2, 3));
      WindowArray.add(new Window("", 300, 400, displayWidth/2-150, displayHeight/2-200, 3, 4));
      for (Window window : WindowArray) {
        window.BackgroundArray.add(new Background(window, lvl2, -10, -15, displayWidth, displayHeight));
        window.Key.add(new Key(window, int(displayWidth/2+500), displayHeight/2+100));
        window.Door.add(new Door(window, int(displayWidth/2-500), displayHeight/2+100, false));
        window.PlatArray.add(new Platform(window, int(displayWidth/2-350), displayHeight/2+100, 60, 30));
        window.PlatArray.add(new Platform(window, int(displayWidth/2-200), displayHeight/2+50, 60, 30));
        window.PlatArray.add(new Platform(window, int(displayWidth/2-50), displayHeight/2, 60, 30));
        window.PlatArray.add(new Platform(window, int(displayWidth/2+50), displayHeight/2-150, 30, 300));  // pared bloqueo
        window.PlatArray.add(new Platform(window, int(displayWidth/2+35), displayHeight/2+100, 60, 30));
        window.PlatArray.add(new Platform(window, int(displayWidth/2+185), displayHeight/2+100, 60, 30));
        window.PlatArray.add(new Platform(window, int(displayWidth/2+335), displayHeight/2, 60, 30));
        window.PlatArray.add(new Platform(window, int(displayWidth/2+370), displayHeight/2+80, 15, 190));
        window.PlatArray.add(new Platform(window, int(displayWidth/2+430), displayHeight/2+80, 60, 30));
        window.Virus.add(new Virus(window, displayWidth/2-10, displayHeight/2+260, displayWidth, 200));


        if (window.windowid == 3) {
          window.moveSpeed = 3;
          window.targetX1 = displayWidth/2-388;
          window.targetY1 = displayHeight/2-200;
          window.targetX2 = displayWidth/2+73;
          window.targetY2 = displayHeight/2-200;

          window.targetX = window.targetX1;
          window.targetY = window.targetY1;
          window.targetNum = 1;
        }
      }

      estados = 4.1;
    }
    if (estados == 4.1 && nextLevel) {
      for (int i = WindowArray.size() - 1; i >= 0; i--) {
        Window window = WindowArray.get(i);
        if (window != null && window.frame != null && window.frame.isDisplayable()) {
          window.noLoop();
          window.stop();
          delay(200);
          window.PlatArray.clear();
          window.Key.clear();
          window.Door.clear();
          window.Virus.clear();
          window.frame.dispose();
          WindowArray.remove(i);
        }
      }
      if (WindowArray.size() == 0) {
        w = false;
        a = false;
        s = false;
        d = false;
        hasKey = false;
        lastinid = -1;
        gravity.lastinWindow = -1;
        antigravity.lastinWindow = -1;
        y = false;
        estados = 5;
      }
      nextLevel = false;
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    if (estados == 5) {
      delay(200);
      saveLevel();
      WindowArray.add(new Window("", int(displayHeight*0.25), int((displayHeight-66)*0.25), 0, 0, 1, 3));     // ultima ventana (puerta)
      WindowArray.add(new Window("", int(displayHeight*0.25), int((displayHeight-66)*0.25), displayWidth-int(displayHeight*0.25), 0, 2, 0));
      WindowArray.add(new Window("", int(displayHeight*0.25), round((displayHeight-66)*0.25), int(displayWidth*0.50), int((displayHeight-66)*0.25), 3, 0));
      WindowArray.add(new Window("", int(displayHeight*0.25), int((displayHeight-66)*0.25), int(displayWidth*0.10), int((displayHeight-66)*0.50), 4, 0));
      WindowArray.add(new Window("", int(displayHeight*0.25), int((displayHeight-66)*0.25), int(displayWidth*0.65), int((displayHeight-66)*0.75), 5, 0));   // primera ventana

      for (Window window : WindowArray) {
        window.BackgroundArray.add(new Background(window, lvl3, -10, -15, displayWidth, displayHeight));
        window.Door.add(new Door(window, displayWidth/2-800, displayHeight/2-350, true));
        window.PlatArray.add(new Platform(window, int(displayWidth/2-600), displayHeight/2+400, 60, 20));
        window.PlatArray.add(new Platform(window, int(displayWidth/2-650), displayHeight/2+300, 60, 20));
        window.PlatArray.add(new Platform(window, int(displayWidth/2+100), displayHeight/2+150, 60, 20));
        window.PlatArray.add(new Platform(window, int(displayWidth/2+150), displayHeight/2+50, 60, 20));
        window.PlatArray.add(new Platform(window, displayWidth/2+650, displayHeight/2-100, 60, 20));
        window.PlatArray.add(new Platform(window, displayWidth/2+700, displayHeight/2-200, 60, 20));
        
      }


      playerposX = int(displayWidth*0.60)+175;
      playerposY = int((displayHeight-66)*0.75)+50;


      estados = 5.1;
    }

    if (estados == 5.1 && nextLevel) {
      for (int i = WindowArray.size() - 1; i >= 0; i--) {
        Window window = WindowArray.get(i);
        if (window != null && window.frame != null && window.frame.isDisplayable()) {
          window.noLoop();
          window.stop();
          delay(200);
          window.PlatArray.clear();
          window.Key.clear();
          window.Door.clear();
          window.frame.dispose();
          WindowArray.remove(i);
        }
      }
      if (WindowArray.size() == 0) {
        w = false;
        a = false;
        s = false;
        d = false;
        hasKey = false;
        lastinid = -1;
        gravity.lastinWindow = -1;
        y = false;
        estados = 6;
      }
      nextLevel = false;
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    if (estados == 6) {
      saveLevel();
      WindowArray.add(new Window("", 200, displayHeight-80, -10, 0, 1, 3));
      WindowArray.add(new Window("", 200, displayHeight-80, displayWidth-200, 0, 2, 3));
      WindowArray.add(new Window("", int((displayHeight-80)*0.25), int((displayHeight-80)*0.25), displayWidth/2-int((displayHeight-80)*0.25)/2, displayHeight-int(displayHeight*0.25)-50, 3, 0));
      WindowArray.add(new Window("", int((displayHeight-80)*0.25), int((displayHeight-80)*0.25), 190, displayHeight-int((displayHeight-80)*0.25)*2-70, 4, 0));
      WindowArray.add(new Window("", int((displayHeight-80)*0.25), int((displayHeight-80)*0.25), displayWidth-200-int((displayHeight-80)*0.25), displayHeight-int((displayHeight-80)*0.25)*3-70, 5, 0));
      WindowArray.add(new Window("", int((displayHeight-80)*0.25), int((displayHeight-80)*0.25), displayWidth/2-int((displayHeight-80)*0.25)/2, displayHeight-int((displayHeight-80)*0.25)*4-70, 6, 0));

      velocidadY = 0;
      playerposX = int(displayWidth/2);
      playerposY = displayHeight-100;

      for (Window window : WindowArray) {
        window.BackgroundArray.add(new Background(window, lvl4, -10, -15, displayWidth, displayHeight));
        window.Door.add(new Door(window, displayWidth/2, displayHeight-int((displayHeight-80)*0.25)*4-40, true));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.10), int((displayHeight-66)*0.90), 60, 20));  // izquierda
        window.PlatArray.add(new Platform(window, int(displayWidth*0.05), int((displayHeight-66)*0.80), 60, 20));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.10), int((displayHeight-66)*0.70), 60, 20));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.05), int((displayHeight-66)*0.60), 60, 20));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.10), int((displayHeight-66)*0.50), 60, 20));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.05), int((displayHeight-66)*0.40), 60, 20));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.10), int((displayHeight-66)*0.30), 60, 20));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.05), int((displayHeight-66)*0.20), 60, 20));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.10), int((displayHeight-66)*0.10), 60, 20));
        window.PlatArray.add(new Platform(window, 200, int((displayHeight-66)*0.10), 20, 160));

        window.PlatArray.add(new Platform(window, int(displayWidth*0.90), int((displayHeight-66)*0.90), 60, 20));  // derecha
        window.PlatArray.add(new Platform(window, int(displayWidth*0.95), int((displayHeight-66)*0.80), 60, 20));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.90), int((displayHeight-66)*0.70), 60, 20));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.95), int((displayHeight-66)*0.60), 60, 20));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.90), int((displayHeight-66)*0.50), 60, 20));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.95), int((displayHeight-66)*0.40), 60, 20));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.90), int((displayHeight-66)*0.30), 60, 20));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.95), int((displayHeight-66)*0.20), 60, 20));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.90), int((displayHeight-66)*0.10), 60, 20));
        window.PlatArray.add(new Platform(window, displayWidth-210, int((displayHeight-66)*0.10), 20, 160));


        window.Switch.add(new Switch(window, (displayWidth/2), int(displayHeight*0.80)));
      }
      estados = 6.1;
    }

    if (estados == 6.1 && nextLevel) {
      for (int i = WindowArray.size() - 1; i >= 0; i--) {
        Window window = WindowArray.get(i);
        if (window != null && window.frame != null && window.frame.isDisplayable()) {
          window.noLoop();
          window.stop();
          delay(100);
          window.PlatArray.clear();
          window.Key.clear();
          window.Door.clear();
          window.frame.dispose();
          WindowArray.remove(i);
        }
      }
      if (WindowArray.size() == 0) {
        w = false;
        a = false;
        s = false;
        d = false;
        hasKey = false;
        lastinid = -1;
        y = false;
        estados = 7;
      }
      nextLevel = false;
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if (estados == 7) {
      saveLevel();
      playerposX = ((displayHeight-95)/4)/2;
      playerposY = displayHeight-80-25;
      respawnPointX = ((displayHeight-95)/4)/2;
      respawnPointY = displayHeight-80-25;
      WindowArray.add(new Window("", (displayHeight-95)/4, (displayHeight-95)/4, 0, displayHeight-80-(displayHeight-95)/4-20, 1, 3)); // primera ventana
      WindowArray.add(new Window("", (displayHeight-95)/4, (displayHeight-95)/4, (displayHeight-95)/4, displayHeight-80-(displayHeight-95)/4, 2, 4));  // ventana move 1
      WindowArray.add(new Window("", (displayHeight-95)/4, (displayHeight-95)/4, displayWidth-(displayHeight-95)/4, displayHeight-80-((displayHeight-95)/4)*2, 3, 3));   // primer check
      WindowArray.add(new Window("", (displayHeight-95)/4, (displayHeight-95)/4, 0, (displayHeight-95)/4, 4, 4)); // ventana move 2
      WindowArray.add(new Window("", (displayHeight-95)/4, (displayHeight-95)/4, 0, 0, 5, 3));  // check 2
      WindowArray.add(new Window("", (displayHeight-95)/4, (displayHeight-95)/4, (displayHeight-95)/4, -10, 6, 4)); // ventana move 3
      WindowArray.add(new Window("", (displayHeight-95)/4, (displayHeight-95)/4, displayWidth-(displayHeight-95)/4, 0, 7, 4)); // ventana move 4 la que tiene la inversion de gravedad


      for (Window window : WindowArray) {
        window.BackgroundArray.add(new Background(window, lvl5, -10, -15, displayWidth, displayHeight));
        window.Door.add(new Door(window, ((displayHeight-95)/4)/2, displayHeight-80-50, false));
        window.Key.add(new Key(window, displayWidth-((displayHeight-95)/4)/2, 80));

        window.Virus.add(new Virus(window, (displayWidth/2)+((displayHeight-95)/4)/2, displayHeight-75, (displayWidth)-(displayHeight-95)/4, 40)); // virus de el primer parkour
        window.Virus.add(new Virus(window, WindowArray.get(3).windowWidth/2, WindowArray.get(3).height*2, (displayHeight-95)/4, 20));

        window.Virus.add(new Virus(window, (displayWidth/2), ((displayHeight-95)/4)-30, (displayWidth)-((displayHeight-95)/4)*2-20, 10));

        window.PlatArray.add(new Platform(window, (displayHeight-95)/4+40, displayHeight-80-30, 90, 15));  // plataformas para ir al checkpoint 1
        window.PlatArray.add(new Platform(window, int(displayWidth*0.3), displayHeight-80-50, 90, 20));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.45), displayHeight-80-40, 70, 15));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.55), displayHeight-80-30, 80, 25));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.7), displayHeight-80-30, 100, 10));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.85), displayHeight-80-40, 80, 20));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.95), displayHeight-80-90, 80, 30));

        window.PlatArray.add(new Platform(window, displayWidth-(displayHeight-95)/4-60, (displayHeight-80-((displayHeight-95)/4)*2)+int(((displayHeight-95)/4)/1.2), 80, 15)); // plataformas de diagonal
        window.PlatArray.add(new Platform(window, int(displayWidth*0.75), int(displayHeight*0.57), 80, 15));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.65), int(displayHeight*0.48), 80, 15));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.55), int(displayHeight*0.46), 80, 15));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.45), int(displayHeight*0.42), 80, 15));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.35), int(displayHeight*0.41), 80, 15));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.25), int(displayHeight*0.40), 80, 15));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.15), int(displayHeight*0.39), 80, 15));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.05), int(displayHeight*0.38), 80, 15));
        window.PlatArray.add(new Platform(window, 0, int(displayHeight*0.3), 80, 15));

        window.PlatArray.add(new Platform(window, (displayHeight-95)/4+40, int(displayHeight*0.15), 60, 25)); //plataformas ultima etapa
        window.PlatArray.add(new Platform(window, int(displayWidth*0.25), int(displayHeight*0.13), 75, 15));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.4), int(displayHeight*0.10), 65, 20));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.55), int(displayHeight*0.12), 55, 30));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.7), int(displayHeight*0.15), 70, 27));
        window.PlatArray.add(new Platform(window, int(displayWidth*0.85), int(displayHeight*0.18), 80, 20));



        if (window.windowid == 2) {
          window.moveSpeed = 3;
          window.targetX1 = (displayHeight-95)/4;
          window.targetY1 = displayHeight-80-(displayHeight-95)/4;
          window.targetX2 = displayWidth-(displayHeight-95)/4;
          window.targetY2 = displayHeight-80-(displayHeight-95)/4;

          window.targetX = window.targetX1;
          window.targetY = window.targetY1;
          window.targetNum = 1;
        }
        if (window.windowid == 4) {
          window.moveSpeed = 3;
          window.targetX1 = displayWidth-((displayHeight-95)/4)*2;
          window.targetY1 = (displayHeight-80-((displayHeight-95)/4)*2)-20;
          window.targetX2 = 0;
          window.targetY2 = (displayHeight-95)/4;

          window.targetX = window.targetX1;
          window.targetY = window.targetY1;
          window.targetNum = 1;
        }
        if (window.windowid == 6) {
          window.moveSpeed = 3;
          window.targetX1 = (displayHeight-95)/4;
          window.targetY1 = -10;
          window.targetX2 = displayWidth-((displayHeight-95)/4)*2;
          window.targetY2 = -10;

          window.targetX = window.targetX1;
          window.targetY = window.targetY1;
          window.targetNum = 1;
        }
        if (window.windowid == 7) {
          window.moveSpeed = 2;
          window.targetX1 = displayWidth-(displayHeight-95)/4;
          window.targetY1 = 0;
          window.targetX2 = displayWidth-(displayHeight-95)/4;
          window.targetY2 = displayHeight-80-((displayHeight-95)/4)*3;

          window.targetX = window.targetX1;
          window.targetY = window.targetY1;
          window.targetNum = 1;
        }
      }
      estados = 7.1;
    }

    if (estados == 7.1) {
      for (Window window : WindowArray) {
        window.Virus.get(1).virusX = WindowArray.get(3).windowX+((displayHeight-95)/4)/2;
        window.Virus.get(1).virusY = WindowArray.get(3).windowY+((displayHeight-95)/4);
      }
    }



    if (estados == 7.1 && nextLevel) {
      for (int i = WindowArray.size() - 1; i >= 0; i--) {
        Window window = WindowArray.get(i);
        if (window != null && window.frame != null && window.frame.isDisplayable()) {
          window.noLoop();
          window.stop();
          delay(100);
          window.PlatArray.clear();
          window.Key.clear();
          window.Door.clear();
          window.frame.dispose();
          WindowArray.remove(i);
        }
      }
      if (WindowArray.size() == 0) {
        w = false;
        a = false;
        s = false;
        d = false;
        hasKey = false;
        lastinid = -1;
        y = false;
        systemcorruption.stop();
        estados = 100;
      }
      nextLevel = false;
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////

    if (estados == 8) {
      saveLevel();
      playerposX = displayWidth/2;
      playerposY = displayHeight/2-100;
      WindowArray.add(new Window("", 325, 150, displayWidth/2-500, displayHeight/2-350, 1, 0));
      WindowArray.add(new Window("", 175, 300, displayWidth/2+325, displayHeight/2-350, 2, 0));
      WindowArray.add(new Window("", 325, 150, displayWidth/2+175, displayHeight/2+150, 3, 0));
      WindowArray.add(new Window("", 175, 300, displayWidth/2-500, displayHeight/2, 4, 0));

      WindowArray.add(new Window("", 150, 150, displayWidth/2-500, displayHeight/2-200, 5, 4));
      WindowArray.add(new Window("", 150, 150, displayWidth/2+175, displayHeight/2-150, 6, 4));
      WindowArray.add(new Window("", 150, 150, displayWidth/2+350, displayHeight/2, 7, 4));
      WindowArray.add(new Window("", 150, 150, displayWidth/2-325, displayHeight/2+150, 8, 4));

      WindowArray.add(new Window("", 150, 150, displayWidth/2-75, displayHeight/2-200, 9, 3));

      for (Window window : WindowArray) {
        if (window.windowid == 5) {
          window.moveSpeed = 3;
          window.targetX1 = displayWidth/2-500;
          window.targetY1 = displayHeight/2-200;
          window.targetX2 = displayWidth/2+25;
          window.targetY2 = displayHeight/2-200;

          window.targetX = window.targetX1;
          window.targetY = window.targetY1;
          window.targetNum = 1;
          window.delayTime = 120;
        }
        if (window.windowid == 6) {
          window.moveSpeed = 3/(800/19);
          window.targetX2 = displayWidth/2+175;
          window.targetY2 = displayHeight/2-350;
          window.targetX1 = displayWidth/2+175;
          window.targetY1 = displayHeight/2-150;

          window.targetX = window.targetX1;
          window.targetY = window.targetY1;
          window.targetNum = 1;
          window.delayTime = 120;
        }
        if (window.windowid == 7) {
          window.moveSpeed = 3;
          window.targetX1 = displayWidth/2+350;
          window.targetY1 = displayHeight/2;
          window.targetX2 = displayWidth/2-175;
          window.targetY2 = displayHeight/2;

          window.targetX = window.targetX1;
          window.targetY = window.targetY1;
          window.targetNum = 1;
        }
        if (window.windowid == 8) {
          window.moveSpeed = 3;
          window.targetX1 = displayWidth/2-325;
          window.targetY1 = displayHeight/2+150;
          window.targetX2 = displayWidth/2-325;
          window.targetY2 = displayHeight/2-50;

          window.targetX = window.targetX1;
          window.targetY = window.targetY1;
          window.targetNum = 1;
        }
      }

      estados = 8.1;
    }



    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if (estados == 10) {
      WindowArray.add(new Window("", 700, 600, displayWidth/2-350, displayHeight/2-300, 2, 0));
      WindowArray.add(new Window("", 700, 600, displayWidth/2-350, displayHeight/2-300, 1, 0));

      for (Window window : WindowArray) {
        window.StillPlatArray.add(new StillPlatform(window, window.width/3, window.height-50, 100, 40, 1));     // primera plataforma fija
        window.PlatArray.add(new Platform(window, displayWidth/2+50, displayHeight/2+160, 100, 40));    // checkpoint no fijo
        window.StillPlatArray.add(new StillPlatform(window, round(window.width*0.75), displayHeight/2, 100, 40, 2)); // segunda plataforma fija de la ventana 2

        window.StillPlatArray.add(new StillPlatform(window, window.width/2, window.height-300, 100, 40, 1));
        window.PlatArray.add(new Platform(window, displayWidth/2+50, displayHeight/2+160, 100, 40));
        window.StillPlatArray.add(new StillPlatform(window, window.width/3, window.height-50, 100, 40, 1));
        window.Key.add(new Key(window, displayWidth/2+350, displayHeight/2+125));
      }
      estados = 10.1;
    }

    if (estados == 10.1 && nextLevel) {
      for (int i = WindowArray.size() - 1; i >= 0; i--) {
        Window window = WindowArray.get(i);
        if (window != null && window.frame != null && window.frame.isDisplayable()) {
          delay(100);
          window.PlatArray.clear();
          window.Key.clear();
          window.Door.clear();
          window.frame.dispose();
          WindowArray.remove(i);
        }
      }
      if (WindowArray.size() == 0) {
        hasKey = false;
        lastinid = -1;
        y = false;
        estados = 11;
      }
      nextLevel = false;
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    if (estados == 11) {

      estados = 11.1;
    }

    if (estados == 11.1 && nextLevel) {
      for (int i = WindowArray.size() - 1; i >= 0; i--) {
        Window window = WindowArray.get(i);
        if (window != null && window.frame != null && window.frame.isDisplayable()) {
          delay(100);
          window.PlatArray.clear();
          window.Key.clear();
          window.Door.clear();
          window.frame.dispose();
          WindowArray.remove(i);
        }
      }
      if (WindowArray.size() == 0) {
        hasKey = false;
        lastinid = -1;
        y = false;
        estados = 12;
      }
      nextLevel = false;
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // CREDITS
    if (estados == 100) {
      WindowArray.add(new Window("", 800, 300, displayWidth/2-400, displayHeight/2-150, 1, 3));

      playerposX = displayWidth/2-300;
      playerposY = displayHeight/2-50;
      globalplayerVel = 2;
      estados = 100.1;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////

    if (estados == 100.7) {
      //BOB
      for (int i = 0; i < arraySize; i++) {
        boolean isLast = (i == arraySize - 1);
        BobArray.add(new Bob("", 128 + i * 3, 128 + i * 3, i, arraySize, caras, isLast, 10, 0, 0));
      }

      for (Bob bob : BobArray) {
        bob.targetX = displayWidth/2-128+30;
        bob.targetY = displayHeight/2-128+30;
      }

      bobCreated = true;
      estados = 100.8;
    }

    if (estados == 100.8) {
      for (Bob bob : BobArray) {
        if (bob.H > bob.speed) estados = 100.9;
      }
    }
    if (estados == 100.9 && newT == 10) {
      TextArray.add(new Text("", 400, 128, displayWidth/2-200, displayHeight/2+100, "The end?", 0, "o", "k"));
      estados = 101;
    }
  }
}
