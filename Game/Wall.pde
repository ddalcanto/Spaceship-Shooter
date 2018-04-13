class Wall {
  int x, y, w, h;
  int s;

  Wall(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    s = 0;
  }

  void display() {
    fill(100);
    rectMode(CENTER);
    rect(x, y, w, h+s * 2);
  }

  int getTopBoundary() {
    return (y - ((h + s * 2) / 2));
  }
  int getBottomBoundary() {
    return (y + ((h + s * 2) / 2));
  }
}