class Ship {
  PImage img;
  int x, y, w, h;
  boolean up = true;
  //int r;

  Ship(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    img = loadImage("PurpleSpaceship.png");
  }

  void display() {
    image(img, x, y, w, h);
  }

  void movement() {
    if (up) {
      y-=5;
      //if (y <= r) {
      //  up = true;
      //}
    } else {
      y+=5;
    }
  }

  void setrandom() {
    up = !up;
  }

  int topPosition() {
    return y;
  }

  int bottomPosition() {
    return y + h;
  }
}
