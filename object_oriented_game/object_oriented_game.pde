//global vars
float bombTimer=0;
float bombTimerLength=180;

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
    
}  

//other functions
