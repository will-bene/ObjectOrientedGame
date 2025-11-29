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
  resetGame();
  
  
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
  
  for (Sorter sorters : sorters)
  {//do every sorter function
    sorters.drawSelf();
  }  
  
  for (Bomb bombs : bombs)
  {//do every bomb function
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
    Bomb curBomb=bombs.get(i);//get current bomb check
    float bombDist=mousePos.dist(curBomb.pos); //distance from cursor to currently checked bomb
    if (bombDist<curDist && bombDist<bombRadius)
    {//if bomb is within pickup radius and less than the one before, make it take over as the currently closest bomb
      curDist=bombDist;
      curClosest=curBomb;
    }
  } 
  
  if (curClosest!=null)
  {
    //do action on requested closest bomb
    curClosest.pickup(); //pickup bomb
    heldBomb=curClosest; //set currently held bomb as that bomb
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

void keyPressed()
{
   resetGame(); 
}

//custom functions
void resetGame()
{//called when resetting game
    for (int i = bombs.size()-1; i >-1; i--)
    {//remove all bombs
       bombs.remove(i);
    }
    for (int i = sorters.size()-1; i>-1; i--)
    {//remove all sorters
       sorters.remove(i);
    }
    for (int i = particles.size()-1; i>-1; i--)
    {//remove all particles
       particles.remove(i);
    }
    score=0; //reset score
    sorters.add(new Sorter(30, 50, 0));
    sorters.add(new Sorter(width-180, 50, 1));
    
}
