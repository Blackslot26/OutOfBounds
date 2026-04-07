class AnimacionInicio {
  ErrorWindows[] errorWindows = new ErrorWindows[15];
  float delay = errorWindows.length*100;
  int estado = 1;
  int ventana = 0;
  int tiempo = millis();

  int estadoAnim2 = 0;
  long tiempoAnim2 = 0;
  int i_anim2 = 0; 


  void estadoInicio() {
    if (estado == 1) animacion1();
    if (estado == 2) animacion2();
    if (estado == 3) animacion3();
  }

  void animacion1() {                                     // estado en el que ocurre la animacion de los errores
    if (ventana < errorWindows.length) {
      if (millis()-tiempo >= delay) {
        errorWindows[ventana] = new ErrorWindows(int (random(0, displayWidth-400)), int (random(200, displayHeight-400)), "Error", 0);
        ventana++;
        delay = delay*0.8;
        tiempo = millis();
      }
    }
    if (ventana == errorWindows.length) {
      estado = 2;
    }
  }

// REEMPLAZA TU VIEJA animacion2() CON ESTA
void animacion2() {
  switch (estadoAnim2) {
    case 0: // Espera inicial
      if (tiempoAnim2 == 0) tiempoAnim2 = millis(); // Iniciar temporizador
      if (millis() - tiempoAnim2 > 500) {
        // Reposicionar todas las ventanas a la vez
        for (int i = errorWindows.length - 1; i >= 0; i--) {
          if (errorWindows[i] != null) {
            for (int p = 0; p < error.length; p++) {
              errorWindows[i].windowsWidth[p] = 128;
              errorWindows[i].windowsHeight[p] = 128;
              errorWindows[i].opacidad = 255;
            }
          }
        }
        boom.play();
        estadoAnim2++;
        tiempoAnim2 = millis(); // Resetear temporizador
      }
      break;

    case 1: // Pausa después del boom
      if (millis() - tiempoAnim2 > 2000) {
        i_anim2 = 0; // Iniciar el índice del bucle
        estadoAnim2++;
        tiempoAnim2 = millis();
      }
      break;

    case 2: // Mover ventanas una por una
      if (i_anim2 < errorWindows.length) {
        if (millis() - tiempoAnim2 > 125) {
          if (errorWindows[i_anim2] != null) {
            errorWindows[i_anim2].posX = displayWidth / 2 - 64;
            errorWindows[i_anim2].posY = displayHeight / 2 - 64;
            errorSfx[4].play();
          }
          i_anim2++; // Siguiente ventana
          tiempoAnim2 = millis();
        }
      } else {
        estadoAnim2++; // Termina el bucle
        tiempoAnim2 = millis();
      }
      break;

    case 3: // Pausa final
      if (millis() - tiempoAnim2 > 750) {
        estado = 3; // Transición a la animación 3
      }
      break;
  }
}

  void animacion3() {                     // estado en el que se abre el menu
    delay(500);
    for (int i = 0; i < ventana; i++) {
      if (errorWindows[i] != null) {
        errorWindows[i].frame.setVisible(false);
        errorWindows[i].Close();
        errorWindows[i] = null;
      }
    }
    estados.estados = 0.1;
  }
}
