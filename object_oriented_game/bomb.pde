class Bomb
{
  //default vars
  PVector pos;
  PVector targetPos = new PVector(0, 0);
  color myColor;
  float targetTimer=0;
  float targetTimerLength=70;
  float fuseTimer=0;
  float fuseTimerLength=250;

  float drawScale=1;

  int imgIndex=0;

  boolean grabbed=false;
  boolean active=true;
  boolean exploded=false;

  //constructor
  Bomb()
  {
    pos= new PVector(width/2, height+50); //initial position
    targetPos.x=(random(100, width-100)); //initial targetpos
    targetPos.y=(random(height/2, height-150)); //initial targetpos

    myColor = allColors[int(round(random(0, allColors.length-1)))]; //initial color, chosen at random
  }

  //class functions
  void drawSelf()
  {//draw self
    //update image index
    if (frameCount % 10 == 0) {
      imgIndex = (imgIndex + 1) %  bombWalkA.length;
    }

    pushMatrix();
    //always stay centered
    translate(pos.x-((bombWid*drawScale)/2), pos.y-((bombWid*drawScale)/2));
    //size based on drawing scale
    scale(drawScale, drawScale);
    //draw sprites based on state
    if (exploded)
    {
      image(bombExplode[imgIndex], 0, 0);
    } else if (!active)
    {
      image(bombSleep, 0, 0);
    } else if (myColor==color(0, 0, 255))
    { //blue bomb
      if (grabbed)
      {
        image(bombGrabA, 0, 0);
      } else
      {
        image(bombWalkA[imgIndex], 0, 0);
      }
    } else
    {//red bomb
      if (grabbed)
      {
        image(bombGrabB, 0, 0);
      } else
      {
        image(bombWalkB[imgIndex], 0, 0);
      }
    }
    popMatrix();
  }// end drawSelf

  void step()
  {//every frame do this
    pickNewTarget(); //timer to pick new movement target
    handleFuseTimer(); //timer for exploding!
    if (!grabbed)
    {//move to targetted position when not grabbed
      if (active && !exploded)
      {//if fuse is lit / active
        pos.x=lerp(pos.x, targetPos.x, .01);
        pos.y=lerp(pos.y, targetPos.y, .01);
      }
    } else
    {//grabbed, follow mouse
      pos.x=mouseX;
      pos.y=mouseY;
    }
  }//end Step



  void pickNewTarget()
  {//pick a new movement position to target after a randomized timer

    targetTimer++;

    if (targetTimer>=targetTimerLength)
    {//timer is up
      //choose new point to move to
      targetPos.x=(random(100, width-100));
      targetPos.y=(random(height/2, height-150));
      targetTimerLength=random(60, 100);
      targetTimer=0;
    }
  }//end pickNewTarget function

  void pickup()
  {//on mouse pickup
    if (active && !exploded && !gameOver)
    {
      grabbed=true;
    }
  }//end pickup function

  void dropoff()
  {//on mouse dropoff
    grabbed=false;

    if (!exploded && !gameOver && active)
    {
      //detect sorter and act accordingly
      for (int i = 0; i < sorters.size(); i++)
      {//look through every sorter
        Sorter curSorter = sorters.get(i); //get current sorter
        if (  pos.x>=curSorter.pos.x && pos.x<=(curSorter.pos.x+curSorter.wid)  &&  pos.y>=curSorter.pos.y && pos.y<=(curSorter.pos.y+curSorter.hgt)  )
        { //position of bomb is within bounds of sorter rectangle
          if (curSorter.myColor==myColor)
          {//color matches sorter color
            defuse();
          } else
          {
            explode();
          }
        }//end collision check
      }//end sorter loop
    }
  }//end dropoff function

  void defuse()
  {//called when correctly sorted
    active=false;
    myColor=(255);
    score++;
  }//end defuse function

  void explode()
  {//explode! after timer is up or placed wrongly
    gameOver=true;
    exploded=true;
    for (int i = 0; i < 25; i++)
    {
      particles.add(new Particle(pos.x, pos.y));
    }
  }

  void handleFuseTimer()
  {
    drawScale=map(fuseTimer, 0, fuseTimerLength, 1, 1.5);
    if (!exploded && active && !gameOver && !grabbed)
    {
      fuseTimer++;
      if (fuseTimer>=fuseTimerLength)
      {//timer is up
        //explode now!
        explode();
      }
    }
  }
}//end Bomb class
