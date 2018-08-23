ArrayList<Laser> lasers;
boolean beamActive, hasRun;
boolean second = false;
boolean displaytime = false;
boolean dead = false;
boolean retry = false;
boolean secondLevel = false;
boolean levelTwo = false;
boolean finishedGame = false;
boolean usedLife = false;
int luck, sec, counter, x, y, spawn;
float randX, direction;
float randY;
int scoreNext, score, scoreLevel;
Ship alien1;
Ship alien2;
Lives lives;
Timer startDelay;
Timer movetimer;
Timer powertimer; //Timer for the testing
Timer powertimer2; //Cooldown
Timer laserTimer;
Timer laserTimer2;
Timer shootTimer;
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
  powerup = new Powerups(870, 250);
  startDelay = new Timer(1000);
  powertimer = new Timer(13000);
  powertimer2 = new Timer(13000);
  movetimer = new Timer(1000);
  laserTimer = new Timer(1000);
  displaytimer = new Timer(10000);
  shootTimer = new Timer(500);
  stars = new Star[150];
  alien1 = new Ship(900, 250, 70, 70);
  alien2 = new Ship(900, 100, 70, 70);
  tw = new Wall(width/2, 0, width, 200);
  bw = new Wall(width/2, 500, width, 200);  
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star(int(random(width)), int(random(height)));
  }
  x = 0;
  y = 0;
  spawn = 0;
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
  if (!play && !dead) {
    startScreen();
    mouse.display();
  }
  if (play) {
    gameplay();
    scorePanel();
  }
  if (dead) {
    startDelay.start();
    retry = true;
    play = false; 
    background(0);
    textAlign(CENTER);
    fill(222);
    textSize(25);
    fill(17, 234, 65);
    mouse.display();
    text("Game Over!", width/2, height/2-40);
    fill(17, 234, 65);
    text("Don't worry, you weren't expected to win", width/2, height/2+80);
    text("Don't get too sad. If you keep trying, im sure you'll be able to do it one day!", width/2, height/2+120);
    text("Ah, who am I kidding, no you wont", width/2, height/2+160);
    text("Well, you can click anywhere on the screen if you want to try again", width/2, height/2+200);
    secondLevel = false;
    score = 0;
    if (mousePressed) {
      play = false;
      dead = false;
    }
  }
  if (finishedGame) {
    finishedGame();
  }
}

void startScreen() {
  background(0);
  textAlign(CENTER);
  textSize(20);
  fill(17, 234, 65);
  text("Click", width/2 - 70, height/2+40);
  fill(#FF1717);
  text("HERE", width/2, height/2+40);
  fill(17, 234, 65);
  text("to start...", width/2 + 90, height/2+40);
  score = 0;
  tw.h = 200;
  bw.h = 200;
  tw.s = 0;
  bw.s =0;
  sec = 0;
  if (!retry && !secondLevel) {
    text("Special thanks to KANISHKA RAGULA and MR. KAPPTIE for making this game possible", width/2, height/2);
    text("Try to survive as long as you can!", width/2, height/2-40);
    text("Welcome to the Ship Game!", width/2, height/2-80);
  }
  if (retry) {
    second = true;
    text("Better luck this time! (You'll need it)", width/2, height/2);
    text("I recommend you just give up. I wouldn't blame you", width/2, height/2-40);
    text("Welcome to the Ship Game again!", width/2, height/2-80);
  } 
  if (!retry && secondLevel) {
    text("Tip: You can now press the Spacebar key to gain an extra life.\nHowever, you will lose 1000 points, so use it wisely!", width/2, height/2-20);
    text("This is where you die. I would wish you luck, but it still wouldn't be enough", width/2, height/2-60);
    text("Whatever, you're not going to make it any further", width/2, height/2-100);
    text("Wow, I'm surpised! I really didn't think you'd be able to make it past the first level!", width/2, height/2-140);
  }
  textSize(12);
  if (mousePressed && startDelay.isFinished()) {
    play = true;
    hero.health = 3;
  }
}

void gameplay() {
  retry = false;
  if (secondLevel && score > 10000) {
    finishedGame = true;
  }
  if (!secondLevel && score > 10000) {
    secondLevel = true;
    play = false;
    println("success");
  }
  if (secondLevel) {
    alien2.display();
  }
  hero.display();
  lives = new Lives(hero.health);

  //Stars
  for (int i = 0; i < stars.length; i++) {
    stars[i].move();
    stars[i].display();
  }

  //Lasers
  if (laserTimer.isFinished()) {
    lasers.add(new Laser(alien1.x, alien1.y));
    lasers.add(new Laser(alien1.x, alien1.y+43));
    laserTimer.start();
  }
  if (shootTimer.isFinished()) {
    if (laserTimer.isFinished()) {
      lasers.add(new Laser(alien2.x, alien2.y));
      lasers.add(new Laser(alien2.x, alien2.y+43));
      laserTimer.start();
    }
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
    if (dist(l.x, l.y, hero.x, hero.y+17) < hero.size-20) {
      hero.health-=1;
      lasers.remove(l);
    }
    if (hero.health==0||score>10000) {
      lasers.remove(l);
    }
  }

  //println(lasers.size());

  if (hero.health == 0) {
    dead = true;
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
  if (powertimer2.isFinished() && !hasRun) {
    powertimer.start();
    hasRun = true;
    displaytime();
    println("second");
    spawn++;
  } 
  if (powertimer.isFinished() && powertimer2.isFinished()) {  
    powertimer2.start();
    hasRun = false;
    println("first");
  }
  if (displaytime) {
    if (!displaytimer.isFinished() && spawn == 1) {
      powerup.display();
      if (mouseX > 800 && mouseX < 950 && mouseY > 24 && mouseY < 265) {
        hero.health++;
        displaytime = false;
        spawn--;
        powertimer.start();
        powertimer2.start();
        println("touch");
        displaytimer.start();
      }
    }
  }
  lives.display();
  alien1.display();
  alien1.movement();
  alien2.movement();
  //println("top " + alien1.topPosition());
  if (alien1.topPosition() < tw.getBottomBoundary() ) {
    //println("horray top " + tw.getBottomBoundary() + " alien1 " + alien1.topPosition());
    alien1.setrandom();
    alien1.y +=5;
  } else if ( alien1.bottomPosition() > bw.getTopBoundary() ) {
    //println("horray bottom " + bw.getTopBoundary() + " alien1 " + alien1.bottomPosition());
    alien1.setrandom();
    alien1.y -=5;
  }
  if (alien2.topPosition() < tw.getBottomBoundary() ) {
    //println("horray top " + tw.getBottomBoundary() + " alien1 " + alien1.topPosition());
    alien2.setrandom();
    alien2.y +=5;
  } else if ( alien2.bottomPosition() > bw.getTopBoundary() ) {
    //println("horray bottom " + bw.getTopBoundary() + " alien1 " + alien1.bottomPosition());
    alien2.setrandom();
    alien2.y -=5;
  }
  if (hero.topPosition() < tw.getBottomBoundary() ) {
    hero.health-=1;
  } else if (hero.bottomPosition() > bw.getTopBoundary() ) {
    hero.health-=1;
  }
  if (mouseX == alien1.x && mouseY == alien1.y ) {
    hero.health-=1;
  }
}

void scorePanel() {
  fill(0);
  rect(650, 450, 600, 50);
  if (!secondLevel) {
    score = score + (millis() / 800);
    scoreNext = 10000 - score;
    if (score > 5000 && score < 10000) {
      fill(255, 0, 0);
      textSize(22);   
      text("Next level in: " + scoreNext, 795, 460);
    }
    fill(0, 0, 255);
    textSize(25);
    text("level: 1", 620, 460);
    fill(17, 234, 65);
    text("Score: " + score, 480, 460);
  }
  if (secondLevel) {
    score = score + (millis() / 3000);
    scoreNext = 10000 - score;
    if (score > 5000 && score < 10000) {
      fill(255, 0, 0);
      textSize(22);
      text("Next level in: " + scoreNext, 795, 460);
    }
    fill(0, 0, 255);
    textSize(25);
    text("level: 2", 620, 460);
    fill(17, 234, 65);
    text("Score: " + score, 480, 460);
  }
}
void displaytime() {
  displaytimer.start();
  displaytime = true;
  if (displaytimer.isFinished()) {
    displaytime = false;
  }
}

void keyReleased() {
  if (secondLevel) {
    if (!usedLife) {
      if (key == ' ') {
        score -= 1000;
        println("pressed");
        usedLife = true;
        tw.h -= 50;
        bw.h -= 50;
      }
    }
  }
}

void finishedGame() {
  background(0);
  textAlign(CENTER);
  textSize(20);
  fill(17, 234, 65);
  text("Thank you for your persistance to beat this game!", width/2, height/2);
  text("I hope you enjoyed. For more projects visit Godofdeathftw on github!", width/2, height/2-40);
  text("I can't believe it, you actually won!", width/2, height/2-80);
}
