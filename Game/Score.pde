class Score {

  void display() {
    //println(millis()/10);
    int s = millis()/10;
    stroke(0);
    fill(0);
    rect(650, 450, 600, 50);
    fill(17, 234, 65);
    text("Score: "  + s, 650, 460);
    if (s > 800) {
      //background(0);
    }
  }
}