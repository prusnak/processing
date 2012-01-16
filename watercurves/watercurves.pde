ArrayList<Ent> ents;

int curveID = 0;

void setup()
{
  size(400,400);
  frameRate(60);
  fill(0,192);
  noStroke();
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
  for (i = 0; i < ents.size()-1; i++) {
    ents.get(i).draw(ents.get(i+1));
  }
}

class Ent {
  float x, y;
  float dx, dy;
  float w;
  boolean dead;
  int cid;
  Ent(float x, float y)
  {
    this.x = x;
    this.y = y;
    float d = sqrt(x*x + y*y);
    dx = x/d;
    dy = y/d;
    dead = false;
    w = 4;
    cid = curveID;
  }
  void calc()
  {
    x += dx;
    y += dy;
    if (abs(x)>width || abs(y)>height) dead = true;
  }
  void draw(Ent n)
  {
    if (cid != n.cid) return;
    beginShape();
    vertex(x+width/2-dx*w,y+height/2-dy*w);
    vertex(x+width/2+dx*w,y+height/2+dy*w);
    vertex(n.x+width/2+n.dx*n.w,n.y+height/2+n.dy*n.w);
    vertex(n.x+width/2-n.dx*n.w,n.y+height/2-n.dy*n.w);
    endShape(CLOSE);
  }
}

void mouseReleased()
{
  curveID++;
}

void mouseDragged()
{
  ents.add(new Ent(mouseX-width/2, mouseY-height/2));
}
