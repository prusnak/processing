ArrayList<Ent> ents;

void setup()
{
  size(400,400);
  frameRate(60);
  noFill();
  strokeWeight(3);
  ents = new ArrayList<Ent>();
}

void draw()
{
  background(255);
  int i = 0;
  while (i < ents.size()) {
    if (ents.get(i).dead) {
      ents.remove(i);
    } else {
      ents.get(i).calc();
      i++;
    }
  }
  for (i = 0; i < ents.size(); i++) {
    ents.get(i).draw();
  }
}

class Ent {
  float x, y;
  float dx, dy;
  boolean dead;
  Ent(float x, float y)
  {
    this.x = x;
    this.y = y;
    float d = sqrt(x*x + y*y);
    dx = x/d;
    dy = y/d;
    dead = false;
  }
  void calc()
  {
    x += dx;
    y += dy;
    if (abs(x)>width || abs(y)>height) dead = true;
  }
  void draw()
  {
    line(x+width/2-dx*4,y+height/2-dy*4,x+width/2+dx*4,y+height/2+dy*4);
  }
}

void mousePressed()
{
  ents.add(new Ent(mouseX-width/2, mouseY-height/2));
}

void mouseDragged()
{
  ents.add(new Ent(mouseX-width/2, mouseY-height/2));
}
