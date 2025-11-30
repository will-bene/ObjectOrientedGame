//global vars
float bombTimer=0;
float bombTimerLength=90;

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
    //spawn bomb after timer is up
    bombs.add(new Bomb());
    bombTimer=0;
    bombTimerLength--; //make bombs come faster as time goes on
    bombTimerLength = constrain(bombTimerLength, 40, 80); //constrain so it doesn't go too low
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

  for (Particle particles : particles)
  {//do every particle function
    particles.drawSelf();
    particles.step();
  }

  if (gameOver)
  {//game over screen
    drawGameOver();
  }

  drawScore(); //draw score
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

  //clear objects
  bombs.clear();
  sorters.clear();
  particles.clear();

  score=0; //reset score
  sorters.add(new Sorter(30, 50, 0)); //create left sorter
  sorters.add(new Sorter(width-180, 50, 1)); //create right sorter

  bombTimer=0;
  bombTimerLength=80;

  gameOver=false; //reset game over
}

void drawScore()
{//draw score value
  textAlign(CENTER, TOP);
  textSize(24);
  fill(0);
  text("Score: "+str(score), width/2, 0);
}

void drawGameOver()
{//draw game over screen
  //background(255);
  textAlign(CENTER, TOP);
  textSize(24);
  fill(0);
  text("Better luck next time!\n\nPress any button to reset", width/2, 64);
}
