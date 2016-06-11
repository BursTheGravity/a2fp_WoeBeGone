//Team WoeBeGone -- Leo Au-Yeung, Jannie Li, Henry Zhang
//APCS2 pd9
//Final Project -- Pest Decimation
//Due Date: 2016-06-13

//ints for _screen
final static int HOME = 0;
final static int HELP = 1;
final static int PLAY = 2;
final static int END = 3;

boolean _gameOver;
boolean _startGame;
boolean _holdingObstacle;
int _screen;
int _money;
int _level;
int _score;
Storage _storage;
Obstacle _currObstacle;
ArrayList<Obstacle> _obstacles;
//queue ConstructionQueue;

void setup() {
  
  size(650,600);
  homeScreen();
  
  //VARIABLES
  _startGame=false;
  _gameOver = false;
  _holdingObstacle = false;
  _screen = HOME;
  _money = 10000;
  _level = 0;
  _score = 0;
  _storage = new Storage(25);
  _obstacles = new ArrayList<Obstacle>();
  
  /*BUG SPAWN RANGE: --- ***we're just doing the bug screen without side panes first***
  X-cor: randomly choose an x-cor from 75 to 525...
  if <100 or >525, then choose y-cor from 50 to 550
  else choose y-cor from either 50 to 75 or 525 to 550
  also-
  make the spawn range a different color?
  */
  //make bugs to add to queue
}

void draw() {
  
  if ( _screen == HOME ) {
    homeScreen();
  }
  
  else if ( _screen == HELP ) {
    helpScreen();
  }
  
  else if ( _screen == PLAY ) {
    
    gameScreen();
    
    //Obstacle following mouse cursor
    if ( _holdingObstacle ) {
      rect(mouseX - 50, mouseY - 25, 100, 50);
    }
  }
  
  else if ( _screen == END ) {
    _gameOver = true;
  }
  
}

//Setting up game's home screen
void homeScreen() {
  background(0);
  stroke(255); //to avoid border intersection
  fill(255); //makes it grey
  rect(75, 50, 50, 500);
  rect(525,50, 50, 500);
  rect(75,50, 500, 50);
  rect(75,500, 500, 50);
  
  textSize(40);
  
  fill(255);
  text("PEST DECIMATION ", 150, 200);
  
  fill(255);
  rect(250, 250, 125, 50);
  fill(0);
  text ("PLAY", 266, 289);
  
  fill(255);
  rect(250, 350, 125, 50);
  fill(0);
  text ("HELP", 266, 389);
  
  //Credits ?? Later
}

//Setting up game's help screen
void helpScreen() {
  clear();
  textSize(30);
  fill(255);
  text("UNDER CONSTRUCTION", 150, 300);
}

//Setting up game's screen
void gameScreen() {
  clear();
  background(0);
  stroke(255);
  fill(255);
  
  //Spawn platforms
  rect(75, 50, 50, 500);
  rect(525,50, 50, 500);
  rect(75,50, 500, 50);
  rect(75,500, 500, 50);
  
  //Information
  textSize(30);
  text("LVL: "+_level, 275, 35);
  text("$"+_money, 125, 35);
  text("Score: "+_score, 425, 35);
  
  //Storage
  ellipseMode(CENTER);
  ellipse(313, 300, _storage.size*2, _storage.size*2);
  
  //Obstacles
  if ( !_obstacles.isEmpty() ) {
    for ( int i = 0; i < _obstacles.size(); i++ ) {
      Obstacle x = _obstacles.get(i);
      rect(x.xcor, x.ycor, x._width, x._height);
    }
  }
  
  //Temp Shop
  stroke(150);
  fill(200);
  rect(0,0, 100, 100);
  
  fill(255);
}

void mousePressed() {
  
  //Home Screen
   if( _screen == HOME ) {
     
     if ( (mouseX > 250) && (mouseX < 375) && (mouseY > 250) && (mouseY < 300) ) {
        _startGame=true;
        _screen = PLAY;
     }
     
     else if ( (mouseX > 250) && (mouseX < 375) && (mouseY > 350) && (mouseY < 400) ) {
       _screen = HELP;
     }
     
   }
   
   else if ( _screen == HELP ) {
     //Display help screen
     //Create a button somewhere to go BACK
   }
   
   else if ( _screen == PLAY ) {
     
     //All functions using a mouse click within the game will go here:
     //1. Killing Pests
     //2. Buying Obstacles
     //Current obstacle shop = top left corner
     if ( !_holdingObstacle && mouseX > 0 && mouseX < 100 && mouseY > 0 && mouseY < 100 ) {
       if ( _money > 100 ) {
         _money -= 100;
         _holdingObstacle = true;
       }
       else {
         //not enuff $$ text
       }
     }
     //3. Setting down obstacles
     else if ( _holdingObstacle ) {
       fill(255);
       Obstacle o = new Obstacle(mouseX - 50, mouseY - 25, 100, 50);
       _obstacles.add(o);
       _holdingObstacle = false;
     }
     //4. Clicking powerup/weapon
     
   }
     
}