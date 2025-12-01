//global vars
float bombTimer=0;
float bombTimerLength=110;
float bombWid=86;

boolean gameOver=true;
boolean firstPlay=true;

int score=0;

//list of all colors used
color[] allColors = {color(255, 0, 0), color(0, 0, 255)};

//array lists of each class
ArrayList<Bomb> bombs = new ArrayList<Bomb>();
ArrayList<Sorter> sorters = new ArrayList<Sorter>();
ArrayList<Particle> particles = new ArrayList<Particle>();

//PImage initialization
PImage bombWalkA[]; //walking
PImage bombGrabA; //being grabbed

PImage bombWalkB[]; //walking
PImage bombGrabB; //being grabbed

PImage bombExplode[]; //exploding
PImage bombSleep; //sleeping

PImage title;
PImage gameOverSpr;
PImage bg;
PImage sorterA;
PImage sorterB;


//currently held bomb
Bomb heldBomb;

void setup()
{
  size(800, 800);
  ellipseMode(CENTER);
  
  
  //load sprites
  bombWalkA = new PImage[4];
  bombWalkA[0] = loadImage("bomb1.png");
  bombWalkA[1] = loadImage("bomb2.png");  
  bombWalkA[2] = loadImage("bomb3.png");  
  bombWalkA[3] = loadImage("bomb4.png");  
  
  bombWalkB = new PImage[4];
  bombWalkB[0] = loadImage("bombB1.png");
  bombWalkB[1] = loadImage("bombB2.png");  
  bombWalkB[2] = loadImage("bombB3.png");  
  bombWalkB[3] = loadImage("bombB4.png");  
  
  bombExplode = new PImage[4];
    for (int i = 0; i < bombExplode.length; i++) {
      bombExplode[i] = loadImage("bombExplode" + (i + 1) + ".png");
    }
    
  bombSleep = loadImage("bombSleep.png");
  bombGrabA = loadImage("bombGrabbed.png");
  bombGrabB = loadImage("bombGrabbedB.png");
  
  title = loadImage("title.png");
  gameOverSpr = loadImage("gameOver.png");
  bg = loadImage("bg.png");
  sorterA = loadImage("sorterA.png");
  sorterB = loadImage("sorterB.png");
  
  //resetGame();
}



void draw()
{
  image(bg, 0, 0);
  bombTimer++;
  if (bombTimer>=bombTimerLength)
  {
    //spawn bomb after timer is up
    spawnBomb();
    bombTimer=0;
    bombTimerLength--; //make bombs come faster as time goes on
    bombTimerLength = constrain(bombTimerLength, 40, 999); //constrain so it doesn't go too low
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

  for (int i = particles.size()-1; i >0 ; i--)
  {//do every particle function
    particles.get(i).drawSelf();
    particles.get(i).step();
    if (particles.get(i).pos.y>=height)
    {//clean up offscreen particles
        particles.remove(i);
    }
    
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
  float curDist=bombWid;
  float bombRadius=bombWid;//radius around mouse that bomb origin has to be in
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

void spawnBomb()
{
  if (!gameOver)
  {
    int bombAmnt=int(round(random(1, 3))); //choose a bomb amount from 1-3

    for (var i = 0; i < bombAmnt; i++)
    {//spawn that number of bombs
      bombs.add(new Bomb());
    }
  }
}

void resetGame()
{//called when resetting game

  //clear objects
  bombs.clear();
  sorters.clear();
  particles.clear();

  score=0; //reset score
  sorters.add(new Sorter(30, 50, 0)); //create left sorter
  sorters.add(new Sorter(width-330, 50, 1)); //create right sorter

  bombTimer=0;
  bombTimerLength=110; //reset bomb timer length

  firstPlay=false; //can't be first play anymore
  gameOver=false; //reset game over
}

void drawScore()
{//draw score value
  textAlign(CENTER, TOP);
  textSize(32);
  fill(255, 255, 230);
  text(str(score), width/2, 0);
}

void drawGameOver()
{//draw game over screen
  if (firstPlay)
  {image(title, 0, 0);}
  else
  {image(gameOverSpr, 0, 0);}
}

void loadSprites(PImage spriteToLoad[], int spriteLength, String prefix)
{
    spriteToLoad = new PImage[spriteLength];
    for (int i = 0; i < spriteToLoad.length; i++) {
      spriteToLoad[i] = loadImage(prefix + (i + 1) + ".png");
    }
}
