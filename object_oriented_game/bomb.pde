class Bomb
{
  //default vars
  PVector pos;
  PVector targetPos = new PVector(0,0);
  color myColor;
  float targetTimer=0;
  float targetTimerLength=70;
  boolean grabbed=false;

  //constructor
  Bomb()
  {
    pos= new PVector(200, 450);
    targetPos.x=(random(50, 350));
    targetPos.y=(random(200, 350));
    
    myColor = allColors[int(random(0, allColors.length))];
  }

  //class functions
  void drawSelf()
  {//draw self
    fill(myColor);
    ellipse(pos.x, pos.y, 48, 48);
  }

  void step()
  {//every frame do this
    pickNewTarget();
    if (!grabbed)
    {//move to targetted position when not grabbed
      pos.x=lerp(pos.x, targetPos.x, .03);
      pos.y=lerp(pos.y, targetPos.y, .03);
    }
    else
    {//grabbed
      pos.x=mouseX;
      pos.y=mouseY;
    }
  }

  void pickNewTarget()
  {
    
    targetTimer++;
    if (targetTimer>=targetTimerLength)
    {
      //choose new point to move to
      targetPos.x=(random(50, 350));
      targetPos.y=(random(200, 350));
      targetTimerLength=random(60, 100);
      targetTimer=0;
    }
  }
  
  void pickup()
  {
    grabbed=true;
  }
  
  void dropoff()
  {
    grabbed=false; 
  }
}
