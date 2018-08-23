class Star {
  int x, y, r, speed;

  Star(int x, int y) {
    this.x = x;
    this.y = y;
    r = int(random(1, 4));
    speed = int(1);
  }

  void display() {
    noStroke();
    fill(255, 255, 0);
    ellipse(x, y, r, r);
  }

  void move() {
    x -= speed;
    if (x < 0) {
      x = width;
    }
  }

  boolean reachedBottom() {
    if (x > width + r*4) { 
      return true;
    } else {
      return false;
    }
  }
}
