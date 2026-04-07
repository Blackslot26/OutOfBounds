class Background{
  PApplet p;
  PImage imagen;
  int x, y, w, h;
  Background(PApplet p, PImage imagen, int x,int y,int w,int h){
    this.imagen = imagen;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.p = p;
  }
  
  void backImage(int windowX, int windowY){
    p.imageMode(CORNER);
    p.image(imagen, x-windowX, y-windowY, w, h);
    
  }
  
  
 
}
