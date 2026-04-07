
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////     ██████╗ ██╗   ██╗████████╗     ██████╗ ███████╗    ██████╗  ██████╗ ██╗   ██╗███╗   ██╗██████╗ ███████╗    /////////////////////////
/////////////////////////    ██╔═══██╗██║   ██║╚══██╔══╝    ██╔═══██╗██╔════╝    ██╔══██╗██╔═══██╗██║   ██║████╗  ██║██╔══██╗██╔════╝    /////////////////////////
/////////////////////////    ██║   ██║██║   ██║   ██║       ██║   ██║█████╗      ██████╔╝██║   ██║██║   ██║██╔██╗ ██║██║  ██║███████╗    /////////////////////////
/////////////////////////    ██║   ██║██║   ██║   ██║       ██║   ██║██╔══╝      ██╔══██╗██║   ██║██║   ██║██║╚██╗██║██║  ██║╚════██║    /////////////////////////
/////////////////////////    ╚██████╔╝╚██████╔╝   ██║       ╚██████╔╝██║         ██████╔╝╚██████╔╝╚██████╔╝██║ ╚████║██████╔╝███████║    /////////////////////////
/////////////////////////     ╚═════╝  ╚═════╝    ╚═╝        ╚═════╝ ╚═╝         ╚═════╝  ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚══════╝    /////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
import processing.video.*;
import processing.core.*;
import processing.awt.*;
import javax.swing.*;
import processing.sound.*;


ArrayList<Window> WindowArray = new ArrayList<Window>();
Gravity gravity = new Gravity();
AntiGravity antigravity = new AntiGravity();
Estados estados = new Estados(); //<>//
AnimacionInicio animacionStart = new AnimacionInicio();
int playerposX, playerposY;
float velocidadY = 1;
int playerSize = 30;
int playerVelL, playerVelR;
int globalplayerVel = 6;
boolean alive = true;

long respawnTimer = 0;

int focusedWindow = 1;
int lastinid;
int windowVel = 3;

boolean musiclayer1 = false;
boolean musiclayer2 = false;
SoundFile greenpath;
int newT;
float DT;
int credtime;

float h;
float value;

boolean w = false, a = false, s = false, d = false, g = false, t = false, y = false, u = false, n = false;
boolean toggleWindowMove = false;
boolean hasKey = false;
boolean keyRequired = false;
boolean gravedad = true;
int globalLastToggleTime = 0;
int gravityToggleCooldown = 500;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
String saveFile = "niveles.json";
boolean resetLevels = false;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////// media
Movie menuAnimacion;
Movie background;
SoundFile Music1;
SoundFile[] errorSfx;
SoundFile boom;
SoundFile stillAliveC;
PImage[] error = new PImage[7];
PFont pixelsF;
PFont titleF;
PImage infected;
PImage play;
PImage controles;
PImage keyboard;
PImage back;
PImage glitch;
PImage historia;
PImage exit;
PImage lvl2;
PImage lvl3;
PImage lvl4;
PImage lvl5;
PImage doorimg;
PImage[] windows = new PImage[4];

PImage[] Key = new PImage[6];

ArrayList<PImage> caras;
ArrayList<Bob> BobArray = new ArrayList<Bob>();
int arraySize = 10;

ArrayList<Text> TextArray = new ArrayList<Text>();

boolean bobCreated = false;

PImage floor1;
PImage floor2;
PImage floor3;
PImage floor4;
PImage floor5;
PImage floor6;
PImage virus;
PImage platform;

SoundFile door;
SoundFile barrier;
SoundFile stillalive;
SoundFile systemcorruption;
/////////////////////////////////////////////////////////////////

void setup() {
  size(128, 128);
  surface.setVisible(false);
  if (resetLevels) {
    java.io.File file = new java.io.File(sketchPath(saveFile));
    if (file.exists()) {
      boolean deleted = file.delete();
      println("Debug mode: save file deleted = " + deleted);
    }
  }

  loadLevel();
  imageMode(CORNER);
  //death = new Movie(this, "death.mp4");
  delay(200);
  noStroke();
  surface.setLocation(displayWidth/2-width/2, displayHeight/2-height/2);
  rectMode(CENTER);
  playerposX = displayWidth/2+200;
  playerposY = displayHeight/2;

  playerVelL = globalplayerVel;
  playerVelR = globalplayerVel;
  //////////////////////
  for (int i = 0; i < Key.length; i++) {
    Key[i] = loadImage("Key"+(i+1)+".png");
  }
  menuAnimacion = new Movie(this, "menuAnimacion9.mp4");
  background = new Movie(this, "background7.mp4");
  background.loop();
  stillAliveC = new SoundFile(this, "stillAliveC.mp3");
  errorSfx = new SoundFile[error.length];
  errorSfx[0] = new SoundFile(this, "errorSfx1.mp3");
  errorSfx[1] = new SoundFile(this, "errorSfx2.mp3");
  errorSfx[2] = new SoundFile(this, "errorSfx3.mp3");
  errorSfx[3] = new SoundFile(this, "errorSfx4.mp3");
  errorSfx[4] = new SoundFile(this, "errorSfx5.mp3");
  errorSfx[5] = new SoundFile(this, "errorSfx6.mp3");
  errorSfx[6] = new SoundFile(this, "errorSfx7.mp3");
  greenpath = new SoundFile(this, "greenpath.mp3");
  Music1 = new SoundFile(this, "Music1.mp3");
  boom = new SoundFile(this, "boom.mp3");
  lvl3 = loadImage("lvl3.png");
  lvl4 = loadImage("lvl4.png");
  lvl5 = loadImage("lvl5.png");
  play = loadImage("play2.png");
  back = loadImage("back.png");
  doorimg = loadImage("doorimg.png");
  platform = loadImage("platform.png");
  virus = loadImage("virus.png");
  exit = loadImage("exit.png");
  keyboard = loadImage("keyboard.png");
  glitch = loadImage("glitch.png");
  historia = loadImage("historia.png");
  infected = loadImage("infected.png");
  lvl2 = loadImage("lvl2.png");
  controles = loadImage("controles.png");
  for (int i = 0; i < windows.length; i++) {
    windows[i] = loadImage("window"+(i+1)+".png");
  }
  pixelsF = createFont("pixel.otf", 30);
  titleF = createFont("titlefont.ttf", 50);
  /////
  error[0] = loadImage("error1.png");
  error[1] = loadImage("error2.jpeg");
  error[2] = loadImage("error3.png");
  error[3] = loadImage("error4.png");
  error[4] = loadImage("error5.png");
  error[5] = loadImage("error6.png");
  error[6] = loadImage("error7.png");




  floor1 = loadImage("floor1.png");
  floor2 = loadImage("floor2.png");
  floor3 = loadImage("floor3.png");
  floor4 = loadImage("floor4.png");
  floor5 = loadImage("floor5.png");
  floor6 = loadImage("floor6.png");

  door = new SoundFile(this, "door.mp3");
  barrier = new SoundFile(this, "barrier.mp3");
  stillalive = new SoundFile(this, "stillalive.wav");
  systemcorruption = new SoundFile(this, "systemcorruption.mp3");
  systemcorruption.amp(0.5);

  caras = new ArrayList<PImage>();
  for (int i = 0; i < 17; i++) {
    PImage img = loadImage(i + 1 + ".png");
    caras.add(img);
  }
}

void draw() {
  moveBob();
  if (alive) {
    background(255);
    gravity.gravityConditions();
    antigravity.antigravityConditions();
    estados.estados();
    playerMove();
  } else {
    if (millis() - respawnTimer >= 3000) {
      velocidadY = 0;
      respawnTimer = millis();

      hasKey = false;
      for (Window w : WindowArray) {
        w.onlyinthisWindow = false;
        if (w.windowtype == 4) {
          playerposX = estados.respawnPointX;
          playerposY = estados.respawnPointY;
        }
      }
      lastinid = -1;
      alive = true;
    }
  }


  //for (Window window : WindowArray) {
  //  //println(window.windowid);
  //  //println("X", window.windowX, "Y", window.windowY);
  //  //println("width", window.width);
  //  //println("left", window.lefttouch, "right", window.righttouch);
  //  //println(playerVelL, playerVelR);
  //  //println(playerposX, playerposY);
  //  //println(window.onlyinthisWindow);
  //  //println("s", s);
  //  //println(velocidadY);
  //  //println("==========================");
  //}
  //println(credtime);
  //println(estados.estados);
 // println(newT);
}

void playerMove() {
  if (a) playerposX -= playerVelL;
  if (d) playerposX += playerVelR;
}

void saveLevel() {
  JSONObject data = new JSONObject();
  data.setFloat("nivel", estados.estados);
  saveJSONObject(data, saveFile);
}

void loadLevel() {
  JSONObject data = null;
  try {
    data = loadJSONObject(saveFile);
    estados.estados = data.getFloat("nivel");
  }
  catch (Exception e) {
    println("No save file found. Starting new game.");
    estados.estados = 0;
  }
}

void moveBob() {
  if (BobArray.size() < arraySize) return;

  BobArray.get(BobArray.size() - 1).bobMove();
  for (int i = 0; i < BobArray.size() - 1; i++) {
    BobArray.get(i).bobX = BobArray.get(i + 1).bobX;
    BobArray.get(i).bobY = BobArray.get(i + 1).bobY;
    BobArray.get(i + 1).bobMove();
    if (i == 0) BobArray.get(0).bobMove();
  }
}



//
