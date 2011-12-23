int flakes = 10000;

Flake[] F = new Flake[flakes];
PImage img;
byte b[];

void setup() {
  size(800, 600);
  img = loadImage("snowflake.png");
  b = loadBytes("brmlab.bits"); 
  for (int i = 0; i < flakes; ++i) {
    F[i] = new Flake();
  }
  frameRate(30);
}

void draw() {
  background(0);
  fill(255,255,255);
  for (int i = 0; i < flakes; ++i) {
    F[i].update();
  }
  for (int i = 0; i < flakes; ++i) {
    F[i].draw();
  }
}

class Flake {
  float xpos, ypos;
  float xspd, yspd;
  boolean special;
  Flake() {
    xpos = random(width*1.5)-width*0.25;
    ypos = random(height*2.0)-height*2.1;
    xspd = 0.0;
    yspd = 0.0;
  }
  void update() {
    xpos += xspd;
    ypos += yspd;
    if (ypos > height) {
      xpos = random(width*1.5)-width*0.25;
      ypos = -10.0;
    }
    xspd = random(-2+(1.0+(mouseX*2.0-width)/width), 2-(1.0-(mouseX*2.0-width)/width));
    yspd = random(0, 8);
    special = false;
    if (xpos >= 0 && xpos < width && ypos >= 0 && ypos < height) {
      int idx = int(xpos)/8 + int(ypos)*(width/8);
      int bit = int(xpos)%8;
      special = (b[idx] & (1<<bit)) > 0;
    }
    if (special) yspd /= 6.0;
  }
  void draw() {
    if (special) {
      tint(255,255,255,255);
    } else {
      tint(255,255,255,192);
    }
    image(img, xpos, ypos);
  }
}

