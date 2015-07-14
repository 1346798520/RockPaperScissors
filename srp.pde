Box userBox, computerBox;
Box sciBox, rockBox, paperBox;
Result resultBox;


int lastPressed = -1000;

int SCISSORS = 0;
int ROCK     = 1;
int PAPER    = 2;

String[] numToText = { "Scissors", "Rock", "Paper" };
int[] winning = { ROCK, PAPER, SCISSORS };
int[] userRecord = { 0, 0, 0 };
PImage[] numToImage = { null, null, null };

void setup() {
  size(500,800);
  PImage sci, roc, pap;
  numToImage[0] = sci= loadImage("s.png");
  numToImage[1] = roc= loadImage("r.png");
  numToImage[2] = pap= loadImage("p.png");
  computerBox = new Box(100, 50, 300, 150);
  userBox = new Box(100, 400, 300, 150);
  sciBox = new Box(50, 600, 100, 150, sci);
  rockBox = new Box(200, 600, 100, 150, roc);
  paperBox = new Box(350, 600, 100, 150, pap);
  resultBox = new Result();
}

void draw() {
  print();

  background(255);
  handleSignals();
  stroke(0);
  noFill();
  computerBox.draw();
  noFill();
  userBox.draw();
  noFill();
  sciBox.draw();
  noFill();
  rockBox.draw();
  noFill();
  paperBox.draw();
  resultBox.draw();
}

//void mouseClicked() {

//}
void handleSignals() {
  if (keyPressed) {
    switch (key) {
      case '1':
      case 's':
        userInput(SCISSORS);
        break;
      case '2':
      case 'r':
        userInput(ROCK);
        break;
      case '3':
      case 'p':
        userInput(PAPER);
        break;
    }
  }
}

void userInput(int inp) {
  // Debounce
  if (lastPressed + 100 >= millis()) {
    lastPressed = millis();
    return;
  }
  lastPressed = millis();

  print(userRecord[0], " ", userRecord[1], " ", userRecord[2], "\n");
  int max = 0, selection = 0;
  for (int i = 0; i < userRecord.length; i++) {
    if (userRecord[i] >= max) {
      selection = i;
      max = userRecord[i];
    }
  }
  userRecord[inp] += 1;
  print(selection, "\n");
  int comp = winning[selection];
  computerBox.changeImg(comp);
  userBox.changeImg(inp);
  if (comp == inp) {
    resultBox.changeText("You tied!");
  } else if (comp + 1 == inp) {
    resultBox.changeText("You won!");
  } else if (comp + 2 == inp) {
    resultBox.changeText("You lost!");
  } else if (inp  + 1 == comp) {
    resultBox.changeText("You lost!");
  } else {
    resultBox.changeText("You won!");
  }
  
}

class Box {
  float x, y, w, h;
  String str;
  PImage img;
  Box(float xp, float yp, float wp, float hp) {
    x = xp;
    y = yp;
    w = wp;
    h = hp;
    img = null;
  }
  Box(float xp, float yp, float wp, float hp, PImage imgp) {
    x = xp;
    y = yp;
    w = wp;
    h = hp;
    img = imgp;
    str = null;
  }
  void draw() {
    rect(x, y, w, h);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(20);
    float smallerDimension = w < h ? w : h;
    float newX = w < h ? 0 : (w - h) / 2.;
    float newY = w > h ? 0 : (h - w) / 2.;
    if (img != null) image(img, x + newX, y + newY,  smallerDimension, smallerDimension);
  }
  void changeImg(int sel) {
    img = numToImage[sel];
  }
}

class Result {
  float x, y, w, h;
  String str;
  Result() {
    x = 0;
    y = 250;
    w = 500;
    h = 100;
    str = "";
  }
  void draw() {
    noStroke();
    fill(#EDEDED);
    rect(0, 250, 500, 100); // Win / lose
    fill(0);
    textSize(26);
    text(str, x, y, w, h);
  }
  void changeText(String newStr) {
    str = newStr;
  }
}
