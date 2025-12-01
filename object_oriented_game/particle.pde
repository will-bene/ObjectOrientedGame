class Particle
{
  //default vars
  PVector pos; //position
  PVector vel = new PVector(0, 0); //velocity
  PVector acc = new PVector(0, 0.1); //acceleration / gravity
  float partWid=8;

  //constructor
  Particle(float spawnX, float spawnY)
  {
    pos = new PVector(spawnX+random(-10, 10), spawnY+-random(-10, 10)); //randomize starting position slightly
    acc.x=random(-0.05, 0.05);//randomize horizontal acceleration slightly to seperate pieces
    vel.y=random(-3, -1); //randomize vertical velocity upwards to better show gravity
    partWid = random(8, 48);
  }

  //class functions
  void drawSelf()
  {
    fill(90, 90, 90);
    ellipse(pos.x, pos.y, partWid, partWid);
  }

  void step()
  {//every frame, do this
    vel.add(acc); //add acceleration / gravity to velocity
    pos.add(vel); //add velocity to position
  }
}
