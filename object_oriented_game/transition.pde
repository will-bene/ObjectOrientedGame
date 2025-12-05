class Transition
{//transition animation when restarting game
  PVector pos= new PVector(0, 0);
  boolean active=true;

  Transition()
  {//constructor
    pos.x=-width/2;
  }

  void drawSelf()
  {//drawing transition
    fill(0);
    rect(pos.x, 0, width/2, height);
    rect(width-(pos.x), 0, -width/2, height);
  }
  void step()
  {//every frame, do this
    pos.x=lerp(pos.x, width, .05);
  }
}
