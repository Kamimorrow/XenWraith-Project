
//Object Variables
PShape light;
//Object Creation
Attacks test = new Attacks(light);

//Object Class
class Object {
  PVector pos;
  PShape image;
}

class Attacks extends Object {
  Attacks(PShape x) {
    PShape image = x;
  }

  void light() {
    light.beginShape();
    light.fill(0, 255, 0);
    light.vertex(0, 0);
    light.vertex(10, 0);
    light.vertex(10, 500);
    light.vertex(0, 500);
    light.vertex(0, 0);
    light.noFill();
    light.endShape();
  }

  void printVisual() {
    light();
    shape(image, pos.x, pos.y);
  }
}