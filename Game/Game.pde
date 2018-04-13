 //<>//
ArrayList<Laser> lasers;
float beamSpawn;
boolean beamActive, hasRun;
boolean displaytime = false;
int luck, sec, counter, x, y, spawn;
float randX, direction;
float randY;
Score score;
Ship a1;
Lives lives;
Timer movetimer;
Timer powertimer; //Timer for the testing
Timer powertimer2; //Cooldown
Timer laserTimer;
Timer displaytimer;
Powerups powerup;
Hero hero;
Mouse mouse;
Wall tw;
Wall bw;
Star[] stars;
boolean play = false;

void setup() {


  lasers = new ArrayList<Laser>();
  hero = new Hero(50);
  mouse = new Mouse(50);
  score = new Score();
  powerup = new Powerups(870, 250);
  powertimer = new Timer(1000);
  powertimer2 = new Timer(1000);
  movetimer = new Timer(1000);
  laserTimer = new Timer(1000);
  displaytimer = new Timer(10000);
  stars = new Star[150];
  a1 = new Ship(900, 250, 70, 70);
  tw = new Wall(width/2, 0, width, 200);
  bw = new Wall(width/2, 500, width, 200);  
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star(int(random(width)), int(random(height)));
  }
  x = 0;
  y = 0;
  spawn = 1;
  size(1000, 500);
  background(255);
  beamActive = false;  
  luck = 1;
  hasRun = true;
  //int s = second();
  frameRate(30);
}
void draw() {

  noCursor();
  background(0);
  if (!play) {
    startScreen();
    mouse.display();
  } else if (play) {
    gameplay();
  }
}

void startScreen() {
  background(0);
  textAlign(CENTER);
  textSize(20);
  fill(17, 234, 65);
  text("Welcome to THINE SHIP GAME", width/2, height/2-80);
  text("By: Daniel Canto, Nate Payne, Nicholas Gonzalez, Silvio Santini, Sam Burnham", width/2, height/2-40);
  text("Special thanks to KANISHKA RAGULA and MR. KAPPTIE for making this game possible", width/2, height/2);
  text("Click", width/2 - 70, height/2+40);
  fill(#FF1717);
  text("HERE", width/2, height/2+40);
  fill(17, 234, 65);
  text("to start...", width/2 + 90, height/2+40);
  textSize(12);

  if (mousePressed) {
    play = true;
  }
}

void gameplay() {
  hero.display();
  lives = new Lives(hero.health);

  //Stars
  for (int i = 0; i < stars.length; i++) {
    stars[i].move();
    stars[i].display();
  }

  //Lasers
  if (laserTimer.isFinished()) {
    lasers.add(new Laser(a1.x, a1.y));
    lasers.add(new Laser(a1.x, a1.y+43));
    laserTimer.start();
  }

  for (int i = lasers.size()-1; i>=0; i--) {
    Laser laser = (Laser) lasers.get(i);
    laser.fire();
    laser.display();
    if (laser.reachedLeft()) {
      lasers.remove(laser);
    }
  }

  for (int j = lasers.size()-1; j>=0; j--) {
    Laser l = (Laser) lasers.get(j);
    if (dist(l.x, l.y, hero.x, hero.y) < hero.size/2) {
      hero.health-=1;
      lasers.remove(l);
      println(hero.health);
    }
  }

  //println(lasers.size());

  if (hero.health == 0) {
    death();
  }
  counter++;
  tw.display();
  if (counter>10) {
    sec++;
    counter = 0;
  }
  tw.s = sec;
  bw.display();
  bw.s = sec;
  score.display();
  if (powertimer2.isFinished() && !hasRun) {
    powertimer.start();
    hasRun = true;
    displaytime();
  } 
  if (powertimer.isFinished() && powertimer2.isFinished()) {  
    powertimer2.start();
    hasRun = false;
    displaytimer.start();
  }
  if (displaytime) {
    if (!displaytimer.isFinished() && spawn == 1) {
      powerup.display();
      if (mouseX > 800 && mouseX < 950 && mouseY > 24 && mouseY < 265) {
        hero.health++;
        displaytime = false;
        spawn--;
      }
    }
  }
  lives.display();
  a1.display();
  a1.movement();
  //println("top " + a1.topPosition());
  if (a1.topPosition() < tw.getBottomBoundary() ) {
    //println("horray top " + tw.getBottomBoundary() + " a1 " + a1.topPosition());
    a1.setrandom();
    a1.y +=5;
  } else if ( a1.bottomPosition() > bw.getTopBoundary() ) {
    //println("horray bottom " + bw.getTopBoundary() + " a1 " + a1.bottomPosition());
    a1.setrandom();
    a1.y -=5;
  }
  if (hero.topPosition() < tw.getBottomBoundary() ) {
    hero.health-=1;
  } else if (hero.bottomPosition() > bw.getTopBoundary() ) {
    hero.health-=1;
  }
  if (mouseX == a1.x && mouseY == a1.y ) {
    hero.health-=1;
  }
}
void displaytime() {
  displaytimer.start();
  displaytime = true;
  if (displaytimer.isFinished()) {
    displaytime = false;
  }
}
void death() {
  background(0);
  textAlign(CENTER);
  fill(222);
  textSize(25);
  text("Game Over! YOU LOSE CAUSE YOU SUCK!!! SUCKS TO SUCK SUCKER!!!!", width/2, height/2);
  noLoop();
}