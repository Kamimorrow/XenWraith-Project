
//Character Variables
PShape player;
//Character Creation
Char p1 = new Char(test);

//Character class
class Char {
  int health = 10;
  int healthMax = 10;
  int score = 0;
  PShape image;
  PVector pos; 
  PVector move;
  Attacks atk;
  Char(Attacks x) {
    Attacks atk = x;
  }

  void player() {
    image = createShape();
    image.beginShape();
    image.fill(255);
    image.vertex(0, 0);
    image.vertex(50, 0);
    image.vertex(50, -100);
    image.vertex(0, -100);
    image.vertex(0, 0);
    image.endShape();
  }

  //Character Visual
  void printVisual() {
    player();
    fill(0);
    rect(0, 0, 1000, 600);
    noFill();
    shape(image, pos.x, pos.y);
    fill(255, 0, 0);
    text("Health: "+health+"     Score: "+score, 10, 25);
    rect(10, 30, 300/healthMax*health, 50);
    noFill();
    strokeWeight(4);
    stroke(128, 128, 128);
    rect(10, 30, 300, 50);
    stroke(0);
    strokeWeight(1);
  }

  //Object Visual
  void printAtk() {
    fill(0, 255, 0);
    rect(pos.x+55, 0, 10, 500);
    noFill();
  }

  //Death Function
  void dead() {
    phase = 0;
  }

  //Attack Function
  void atk() {
    if (phase == 1) {
      if (keyPressed == true && key == ' ') {
        atk.printVisual();
      }
    }
  }

  //Move Fuction
  void move() {
    if (phase == 1) {
      printVisual();
      pos.x += move.x;
      pos.y -= move.y;

      //Right Border
      if (pos.x >= 900) {
        move.x = 0;
      }

      //Left Border
      if (pos.x <= 50) {
        move.x = 0;
      }

      //Border Enforcement
      if (pos.x >= 950) {
        pos.x = 950;
      }
      if (pos.x <= 50) {
        pos.x = 50;
      }

      //On-ground Jump check
      if (pos.y < 500) {
        move.y -= 0.1;
      }

      //Gravity limit
      if (move.y <= -5) {
        move.y = -5;
      }

      //Ground Border
      if (pos.y >= 500) {
        move.y = 0;
        pos.y = 500;
      }
      if (keyPressed == true && key == 'd' && pos.x <= 900) {
        move.x = 3;
        printVisual();
      } else if (keyPressed == true && key == 'a' && pos.x >= 50) {
        move.x = -3;
        printVisual();
      } else if (keyPressed == true && key == 'w' && pos.y == 500) {
        move.y = 5;
        printVisual();
      } else if (keyPressed == true && key == 's' && pos.y != 500) {
        move.y = -5;
        printVisual();
      }
    }
  }
}