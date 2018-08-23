class Lives {
  PImage testup;
  int l;
  //Constructor
  Lives(int l) {
    this.l=l;
    testup = loadImage("testup.png");
  }

  void display() {
    if (l == 4) {
      image(testup, 25, 435, 50, 50);
      image(testup, 100, 435, 50, 50);
      image(testup, 175, 435, 50, 50);
      image(testup, 250, 435, 50, 50);
    }else if (l == 3) {
        image(testup, 25, 435, 50, 50);
        image(testup, 100, 435, 50, 50);
        image(testup, 175, 435, 50, 50);
      } else if (l == 2) {
        image(testup, 25, 435, 50, 50);
        image(testup, 100, 435, 50, 50);
      } else if (l == 1) {
        image(testup, 50, 435, 50, 50);
      }
    }
  }
