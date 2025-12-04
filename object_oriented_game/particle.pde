class Particle
{
  //default vars
  PVector pos; //position
  PVector vel = new PVector(0, 0); //velocity
  PVector acc = new PVector(0, 0.2); //acceleration / gravity
  float partWid=8;
  float curAngle=0;
  float drawScale=1;
  int pType =0; //particle type for drawing

  color myColor;
  float alpha=100;

  //constructor
  Particle(float spawnX, float spawnY, int partType)
  {
    pos = new PVector(spawnX+random(-10, 10), spawnY+-random(-10, 10)); //randomize starting position slightly
    acc.x=random(-0.05, 0.05);//randomize horizontal acceleration slightly to seperate pieces
    vel.y=random(-3, -1); //randomize vertical velocity upwards to better show gravity
    partWid = random(8, 32);
    curAngle=random(0, 3);
    drawScale=random(1, 4);
    pType = partType;
    if (partType==2)
    {//smaller debris size when "good" particles
      drawScale=random(1, 2);
    }
  }

  //class functions
  void drawSelf()
  {
    pushMatrix();
    translate(pos.x+((partWid*drawScale)/2), pos.y-((partWid*drawScale)/2));
    scale(drawScale, drawScale);
    rotate(curAngle);
    if (pType==1)
    {
      image(particleA, 0, 0);
    }
    if (pType==2)
    {
      tint(255, 255, 255, 150);
      image(particleB, 0, 0);
      noTint();
    }

    popMatrix();
  }

  void step()
  {//every frame, do this
    curAngle+=0.01;
    vel.add(acc); //add acceleration / gravity to velocity
    pos.add(vel); //add velocity to position
  }
}
