class Bomb
{
  //default vars
  PVector pos;
  PVector targetPos = new PVector(0, 0);
  color myColor;
  float targetTimer=0;
  float targetTimerLength=70;
  boolean grabbed=false;
  boolean active=true;
  
  //constructor
  Bomb()
  {
    pos= new PVector(200, 450); //initial position
    targetPos.x=(random(50, 350)); //initial targetpos
    targetPos.y=(random(200, 350)); //initial targetpos

    myColor = allColors[int(random(0, allColors.length))]; //initial color
  }

  //class functions
  void drawSelf()
  {//draw self
    fill(myColor);
    ellipse(pos.x, pos.y, 48, 48);
  }

  void step()
  {//every frame do this
    pickNewTarget(); //timer to pick new movement target
    if (!grabbed)
    {//move to targetted position when not grabbed
      if (active)
      {//if fuse is lit / active
        pos.x=lerp(pos.x, targetPos.x, .03);
        pos.y=lerp(pos.y, targetPos.y, .03);
      }
    } else
    {//grabbed, follow mouse
      pos.x=mouseX;
      pos.y=mouseY;
    }
  }

  void pickNewTarget()
  {//pick a new movement position to target after a randomized timer

    targetTimer++;
    if (targetTimer>=targetTimerLength)
    {//timer is up
      //choose new point to move to
      targetPos.x=(random(50, 350));
      targetPos.y=(random(200, 350));
      targetTimerLength=random(60, 100);
      targetTimer=0;
    }//end timer check
  }//end pickNewTarget function

  void pickup()
  {//on mouse pickup
    if (active)
    {
      grabbed=true;
    }
  }//end pickup function

  void dropoff()
  {//on mouse dropoff
    grabbed=false;

    //detect sorter and act accordingly
    for (int i = 0; i < sorters.size(); i++)
    {//look through every sorter
      Sorter curSorter = sorters.get(i); //get current sorter
      if (  pos.x>=curSorter.pos.x && pos.x<=(curSorter.pos.x+curSorter.wid)  &&  pos.y>=curSorter.pos.y && pos.y<=(curSorter.pos.y+curSorter.hgt)  )
      { //position of bomb is within bounds of sorter rectangle
        if (curSorter.myColor==myColor)
        {//color matches sorter color
          score++;
          defuse();
        }//end color check
      }//end collision check
    }//end sorter loop
  }//end dropoff function
  
  void defuse()
  {//called when correctly sorted
      active=false;
      myColor=(255);
      score++;
  }//end defuse function  
  
  
}//end Bomb class
