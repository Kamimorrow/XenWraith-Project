
//Fuction variables
int phase = 1;
int invis = 0;

//Startup
void setup() {
  //Window
  size(1000, 600);
  fill(0);
  rect(0, 0, 1000, 600);
  noFill();
  textSize(15);
  stroke(0);
  strokeWeight(1);

  //Framerate
  frameRate(100);

  //Player Vectors
  p1.pos = new PVector(50, 500);
  p1.move = new PVector(3, 0);

  //Slime Vectors
  s1.pos = new PVector(random(200, 800), 500);
  s1.move = new PVector(2, 0);

  //Attacks Vectors
  test.pos = new PVector(p1.pos.x, 0);
}

//Draw
void draw() {
  p1.move();
  s1.move();
  p1.atk();
  s1.damage();
  invis -= 1;  

  //Death Check
  if (p1.health <= 0) {
    p1.dead();
    fill(100, 0, 100);
    rect(0, 0, 1000, 600);
    noFill();
    fill(0);
    textSize(60);
    text("You Died!", 375, 300);
    textSize(30);
    text("Score: "+p1.score, 450, 400);
    textSize(10);
    noFill();
  }

  //Invincibility Frames
  if (invis <= 0) {
    invis = 0;
  }

  //Damage Check
  println(p1.pos.y, s1.pos.y);
  if (p1.pos.x+50 >= s1.pos.x && s1.pos.x >= p1.pos.x && invis == 0 && p1.pos.y-100 <= s1.pos.y && p1.pos.y >= s1.pos.y|| p1.pos.x+50 >= s1.pos.x+50 && s1.pos.x+50 >= p1.pos.x && invis == 0  && p1.pos.y-100 <= s1.pos.y-50 && p1.pos.y >= s1.pos.y-50) {
    p1.health -= 1;
    invis = 100;
  }
}