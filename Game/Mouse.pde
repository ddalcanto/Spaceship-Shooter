class Mouse {
  //Member variables
  int size;
  PImage mouse;
  int x, y, r;
  int health;

  //Constructor
  Mouse(int size) {
    this.size = size;
    mouse = loadImage("Mouse.png");
    r = 3;
    health = r;
  }

  void display() {
    x = mouseX;
    y = mouseY;
    image(mouse, mouseX, mouseY, 50, 50);
  }

  int topPosition() {
    return y;
  }

  int bottomPosition() {
    return y+20;
  }
}