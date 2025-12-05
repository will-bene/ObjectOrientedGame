class Sorter
{
  //default vars
  PVector pos;
  float wid=300; //sorter width
  float hgt=300; //sorter height
  color myColor;

  //constructor
  Sorter(float sX, float sY, int colorType)
  {
    pos = new PVector(sX, sY);
    myColor = allColors[colorType];
  }

  //class functions
  void drawSelf()
  {//draw sorter
    //fill(myColor);

    //rect(pos.x, pos.y, wid, hgt);
    if (myColor==color(0, 0, 255))
    {//blue
      image(sorterA, pos.x, pos.y);
    } else
    {//red
      image(sorterB, pos.x, pos.y);
    }
  }
}
