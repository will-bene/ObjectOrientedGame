class Particle
{
  //default vars
  PVector pos; //position
  PVector vel = new PVector(0, 0); //velocity
  PVector acc = new PVector(0, 0.1); //acceleration / gravity

  //constructor
  Particle(float spawnX, float spawnY)
  {
    pos = new PVector(spawnX, spawnY);
  }

  //class functions
  void drawSelf()
  {
    ellipse(pos.x, pos.y, 8, 8);
  }

  void doPhysics()
  {
    vel.add(acc);
    pos.add(vel);
  }
}
