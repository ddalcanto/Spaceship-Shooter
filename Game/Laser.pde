class Laser {
  //int fx, fy;
  int x, y;
  float speed; 

  float r; 

  Laser(int x, int y) {
    r = 4; 
    this.x = x; 
    this.y = y; 
    speed = random(5, 30);
  }

  void fire() {
    x -= speed;
  }

  boolean reachedLeft() {
    if (x < 0 - 50) { 
      return true;
    } else {
      return false;
    }
  }

  void display() {
    fill(255, 0, 0);
    noStroke();
    for (int i = 2; i < r; i++ ) {
      rect(x+15, y+12, 8, r);
      //rect(x+15, y+57, 8, r);
    }
  }
}