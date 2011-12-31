int startcnt = 100;
ArrayList cells;
ArrayList newcells;
PImage img;
float food[][];

// String filename = "lena.png";
String filename = "natalie.png";
boolean inverted = true;

void setup()
{
  size(512,512);
  img = loadImage(filename);
  food = new float[512][512];
  for (int x = 0; x < 512; ++x)
    for (int y = 0; y < 512; ++y) {
      food[x][y] = ((img.pixels[x+y*512] >> 8) & 0xFF)/255.0;
      if (inverted) food[x][y] = 1-food[x][y];
    }
  if (inverted) {
    background(255);
  } else {
    background(0);
  }
  cells = new ArrayList();
  newcells = new ArrayList();
  for (int i = 0; i < startcnt; ++i) {
    cells.add(new Cell());
  }
  frameRate(30);
}

void draw()
{
  newcells.clear();
  loadPixels();
  Iterator<Cell> itr = cells.iterator();
  while (itr.hasNext()) {
    Cell c = itr.next();
    c.draw();
    c.update();
  }
  updatePixels();
  cells.addAll(newcells);
}

float feed(int x, int y, float thresh) {
  float r = 0.0;
  if (x >= 0 && x < 512 && y >= 0 && y < 512) {
    if (food[x][y] > thresh) {
      r = thresh;
      food[x][y] -= thresh;
    } else {
      r = food[x][y];
      food[x][y] = 0.0;
    }
  }
  return r;
}

class Cell {
  float xpos, ypos;
  float dir;
  float state;
  boolean active;
  Cell() {
    xpos = random(width);
    ypos = random(height);
    dir = random(2*PI);
    state = 0;
    active = true;
  }
  Cell(Cell c) {
    xpos = c.xpos;
    ypos = c.ypos;
    dir = c.dir;
    state = c.state;
    active = true;
  }
  void draw() {
    if (!active) return;
    if (xpos >= 0 && xpos < width && ypos >= 0 && ypos < height) {
      if (inverted) {
        pixels[ int(xpos) + int(ypos) * width ] = color(255-state*255);
      } else {
        pixels[ int(xpos) + int(ypos) * width ] = color(state*255);
      }
    }
  }
  void update()
  {
    if (!active) return;
    state += feed(int(xpos),int(ypos), 0.2) - 0.17;
    if (state < 0) active = false;
    xpos += cos(dir);
    ypos += sin(dir);
    dir += random(-0.3,0.3);
    if (state > 1) {
      divide();
    }
  }
  void divide() {
      Cell c1 = new Cell(this);
      Cell c2 = new Cell(this);
      c1.state /= 2;
      c2.state /= 2;
      float dd = random(0.3);
      c1.dir += dd;
      c2.dir -= dd;
      newcells.add(c1);
      newcells.add(c2);
      active = false;
  }
}
