class Powerups {
  int luck, px, py;
  PImage life;
  Powerups(int px, int py) {
    this.px = px;
    this.py = py;
    life = loadImage("LifePowerup.png");
  }
  void display() {
    //timer = new Timer(5000);
    luck = 1;

    if (powertimer2.isFinished()) {
      beamSpawn = random(0, 5);
      if (beamSpawn <= luck) {
        println("success");
        beamActive = true;
        powertimer.start();
      }
      if (beamActive == true) {
        //noStroke();


        fill(#1317AD);
        ellipse(px, py, 30, 30);
        image(life, px-9, py-10, 20, 20);
        //stroke(1);
        luck =- 1;
      }

      //background(255);
      //luck =+ 1;
    }
  }
}