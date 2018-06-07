
//Enemy Variables
PShape slime;
int random;
//Enemy Creation
Slime s1 = new Slime(slime);

//Enemy Class
class Enemy {
  PVector pos;
  PVector move;
  PShape image;

  void dead() {
    pos = new PVector(random(200, 800), 500);
    p1.score += 1;
  }

  void damage() {
    if (keyPressed == true && key == ' ' && p1.pos.x+55 >= pos.x && p1.pos.x+55 <= pos.x+50 ||keyPressed == true && key == ' ' && p1.pos.x+65 >= pos.x && p1.pos.x+65 <= pos.x+50) {
      dead();
    }
  }
}

class Slime extends Enemy {
  Slime(PShape x) {
    PShape image = x;
  }

  //Enemy Visual
  void printVisual() {
    visual();
    shape(image, pos.x, pos.y);
  }

  void visual() {
    image = createShape();
    image.beginShape();
    image.fill(255);
    image.vertex(0, 0);
    image.vertex(50, 0);
    image.vertex(50, -50);
    image.vertex(0, -50);
    image.vertex(0, 0);
    image.endShape();
  }

  //Move Function
  void move() {
    if (phase == 1) {
      printVisual();
      random = int(random(1, 76));
      pos.x += move.x;


      //Random Movement
      if (random == 1) {
        move.x = 2;
      } else if (random == 75) {
        move.x = -2;
      }

      //Right Border    
      if (pos.x >= 950) {
        move.x = -2;
      }

      //Left Border
      if (pos.x <= 50) {
        move.x = 2;
      }

      //Border Enforcement
      if (pos.x >= 950) {
        pos.x = 950;
      }
      if (pos.x <= 50) {
        pos.x = 50;
      }
    }
  }
}