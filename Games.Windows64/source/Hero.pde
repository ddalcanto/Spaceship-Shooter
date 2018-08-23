class Hero {
  //Member variables
  int size;
  PImage test;
  int x, y, r;
  int health;

  //Constructor
  Hero(int size) {
    this.size = size;
    test = loadImage("test.png");
    r = 3;
    health = r;
  }

  void display() {
    x = mouseX;
    y = mouseY;
    image(test, mouseX, mouseY, 50, 50);
  }

  int topPosition() {
    return y;
  }

  int bottomPosition() {
    return y+20;
  }
}
