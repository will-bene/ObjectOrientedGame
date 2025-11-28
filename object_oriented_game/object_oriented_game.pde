//global vars
float bombTimer=0;
float bombTimerLength=80;

boolean gameOver=false;

int score=0;

//list of all colors used
color[] allColors = {color(255, 0, 0), color(0, 0, 255)};

//array lists of each class
ArrayList<Bomb> bombs = new ArrayList<Bomb>();
ArrayList<Sorter> sorters = new ArrayList<Sorter>();
ArrayList<Particle> particles = new ArrayList<Particle>();

//currently held bomb
Bomb heldBomb;

void setup()
{
  size(400, 400);
  ellipseMode(CENTER);
}

void draw()
{
  background(255);
  bombTimer++;
  if (bombTimer>=bombTimerLength)
  {
    //spawn bomb
    bombs.add(new Bomb());
    bombTimer=0;
  }
  
  for (Bomb bombs : bombs)
  {
    bombs.drawSelf();
    bombs.step();
  }
  
}

void mousePressed()
{
    findNearestBomb();//.myColor=(255);
}  

void findNearestBomb()
{
  float curDist=48;
  float bombRadius=48;//radius around mouse that bomb origin has to be in
  Bomb curClosest=null; //currently closest bomb
  PVector mousePos = new PVector(mouseX, mouseY);
  for (int i = 0; i < bombs.size(); i++)
  {//loop through every bomb
    Bomb curBomb=bombs.get(i);
    float bombDist=mousePos.dist(curBomb.pos); //distance from cursor to currently checked bomb
    if (bombDist<curDist && bombDist<bombRadius)
    {
      curDist=bombDist;
      curClosest=curBomb;
    }
  } 
  
  if (curClosest!=null)
  {
    //do action on requested closest bomb
    //println(curDist);
    //curClosest.myColor=color(255);
    curClosest.pickup();
    heldBomb=curClosest;
  }
  
}

void mouseReleased()
{
    if (heldBomb!=null)
    {
       heldBomb.dropoff(); 
       heldBomb=null;
    }
}

//other functions
