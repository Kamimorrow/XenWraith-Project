//Xen Project
  //Game Fonts
PFont big;
  
  //Phase
int phase = 0;

  //Character models
PShape playerStand;
PShape feet;
PShape legs;
PShape chest;
PShape head;
PShape arms;
PShape slime;

  //Attack Models
PShape hit;

  //Character movement variables
int cspeed = 4;
int sspeed = 3;
int airtime = 0;
int momentum = 0;

float gravity = 5;

//Class Objects
player p1 = new player();
slime s1 = new slime();

//Player Class
class player{
  int score = 0;
  int posx = 0;
  int posy = 300;
  int health = 10;
  int invis = 0;
  int red = int(random(0,256));
  int green = int(random(0,256));
  int blue = int(random(0,256));
  void printPlayer(){
    //Calling the character model
    shape(feet, posx,posy);
    shape(legs, posx,posy);
    shape(chest, posx,posy);
    shape(head, posx,posy);
    shape(arms, posx,posy);
    //Print Health
    textFont(big, 15);
    fill(255,0,0);
    rect(20,20, 400/10*health,25);
    text("Health: "+p1.health,20,20);
    text("Score: "+score, 725,20);
  }
  void movePlayer(){
    if (phase == 1){
      printPlayer();
      
      //Flying Damage
      if (posy < 300 ){
        airtime += 1;
        println(airtime);
        if (airtime >= 130){
          airtime = 0;
          health -= 1;
        }
      }
      if (posy >= 300){
          airtime = 0;
      }
      
      //Death
      if (health <= 0){
        p1.posx = 0;
        p1.posy = 300;
        s1.posx = 500;
        s1.posy = 400;
        p1.score = 0;
        fill(#5900B4);
        rect(0,0, 800,600);
        strokeWeight(0);
        fill(87,59,12);
        rect(0,400,800,200);
        fill(#24E02F);
        rect(0,400,800,25);
        fill(#BC0C06);
        textFont(big,70);
        text("Welcome to Xen!", 150,125);
        textFont(big);
        phase = 0;
      }
      
      //Right move
      if (keyPressed == true && key == 'd' && posx < 770 && posy == 300){
        posx += cspeed;
        momentum = 4;
        //println(posx);
        fill(#24E02F);
        rect(0,400,800,25);
        fill(#5900B4);
        rect(0,0,800,400);
        printPlayer();
      }
      
      //Left move
      if (keyPressed == true && key == 'a' && posx > 0 && posy == 300){
        posx -= cspeed;
        momentum = -4;
        //println(posx);
        fill(#24E02F);
        rect(0,400,800,25);
        fill(#5900B4);
        rect(0,0,800,400);
        printPlayer();
      }
      
      //Jump up
      if (keyPressed == true && key == 'w' && posx > 0 && posx < 770){
        posy -= gravity;
        posx += momentum;
        //println(posy);
        fill(#24E02F);
        rect(0,400,800,25);
        fill(#5900B4);
        rect(0,0,800,400);
        printPlayer();
        if (posy <= 300){
          //println(gravityU);
          gravity -= 0.1;
        }
        if (posy >= 300){
          gravity = 5;
        }
        if (gravity <= -5){
          gravity = -5;
        }
        if (posy >= 300){
          posy = 300;
          momentum = 0;
        }
      }
      
      //Slam Down
      if (keyPressed == true && key == 's' && posy <= 300){
        gravity = 5;
        posy += gravity;
        momentum = 0;
        //println(posy);
        fill(#24E02F);
        rect(0,400,800,25);
        fill(#5900B4);
        rect(0,0,800,400);
        printPlayer();
        if (posy < 300){
          //println(gravity);
          gravity += 0.1;
        }
        if (posy == 300){
          gravity = 5;
        }
        if (gravity >= 5){
          gravity = 5;
        }
        if (posy >= 300){
          posy = 300;
        }
      }
      if (keyPressed == true && key == 'q'){
        shape(hit,posx+27+18, posy+50);
        if (s1.posx > posx+27 && s1.posx < posx+57){
          s1.health = 0;
          score += 1;
        }
      }
    }
  }
}

//Slime Enemy
class slime{
  int health = 3;
  int posx = 50;
  int posy = 400;
  int randmove;
  void printSlime(){
    shape(slime,posx,posy);
  }
  void moveSlime(){
    if (phase == 1){
      randmove = int(random(1,76));
      posx += sspeed;
      printSlime();
      //println(randmove);
      if (randmove == 1){
        sspeed = -3;
      }
      if (randmove == 75){
        sspeed = 3;
      }
      if (posx >= 770){
        posx = 770;
        sspeed = -3;
      }
      if (posx <= 0){
        posx = 0;
        sspeed = 3;
      }
    }
    if (p1.posx >= posx && p1.posx <= posx+32 || p1.posx+27 >= posx && p1.posx+27 <= posx+32){
      if (p1.invis == 0 && p1.posy >= 282){
        p1.health -= 0.1;
      }
      p1.invis += 1;
      
      //Invincibility Frames
      if (p1.invis >= 10){
        p1.invis = 0;
      }
    }
  if (health <= 0){
    posx = int(random(0,771));
    posy = 400;
    health = 3;
    slime s1 = new slime();
    moveSlime();
  }
  }
}

void setup(){
  //Window
  size(800,600);
  background(#5900B4);
  
  //Other setup
  big = createFont("Arial", 30);
  
  //Attack Animation
  hit = createShape();
  hit.beginShape();
  hit.fill(255,0,0);
  hit.vertex(0,0);
  hit.vertex(15,20);
  hit.vertex(30,0);
  hit.vertex(0,0);
  hit.endShape();
  
  
  //Slime Character 
  slime = createShape();
  slime.beginShape();
  slime.fill(#2DB727);
  slime.vertex(0,0);
  slime.vertex(0,-10);
  slime.vertex(2,-10);
  slime.vertex(2,-15);
  slime.vertex(4,-15);
  slime.vertex(4,-17);
  slime.vertex(8,-17);
  slime.vertex(8,-18);
  slime.vertex(24,-18);
  slime.vertex(24,-17);
  slime.vertex(28,-17);
  slime.vertex(28,-15);
  slime.vertex(30,-15);
  slime.vertex(30,-10);
  slime.vertex(32,-10);
  slime.vertex(32,0);
  slime.vertex(0,0);
  slime.endShape();
  
  //player character
    //Feet
  feet = createShape();
  feet.beginShape();
  feet.fill(#4B232F);
  feet.vertex(2,100);
  feet.vertex(27,100);
  feet.vertex(27,90);
  feet.vertex(2,90);
  feet.vertex(2,100);
  feet.endShape();
    //Legs
  legs = createShape();
  legs.beginShape();
  legs.fill(#140C93);
  legs.vertex(2,50);
  legs.vertex(17,50);
  legs.vertex(17,90);
  legs.vertex(2,90);
  legs.vertex(2,50);
  legs.endShape(); 
    //Chest
  chest = createShape();
  chest.beginShape();
  chest.fill(p1.red,p1.green,p1.blue);
  chest.vertex(0,50);
  chest.vertex(0,10);
  chest.vertex(20,10);
  chest.vertex(20,50);
  chest.vertex(0,50);
  chest.vertex(0,10);
  chest.endShape();
    //Head
  head = createShape();
  head.beginShape();
  head.fill(#FFBFBF);
  head.vertex(1,10);
  head.vertex(1,-10);
  head.vertex(19,-10);
  head.vertex(19,10);
  head.endShape();
    //Arms
  arms = createShape();
  arms.beginShape();
  arms.fill(#FF1530);
  arms.vertex(16,10);
  arms.vertex(16,45);
  arms.vertex(2,45);
  arms.vertex(2,10);
  arms.endShape();
  
  
  //Back Art-Title
  strokeWeight(0);
  fill(87,59,12);
  rect(0,400,800,200);
  fill(#24E02F);
  rect(0,400,800,25);
  fill(#BC0C06);
  
  //Title-Title
  textFont(big,70);
  text("Welcome to Xen!", 150,125);
  textFont(big);
  
  //Buttons-Title
  noFill();
  strokeWeight(3);
    //Play Button
  rect(345,173, 100,35);
  text("Play", 365, 200);
    //Instructions Button
  rect(320,253, 160,35);
  text("Instructions",325,280);
    //Quit Button
  rect(345,323, 100,35);
  text("Quit", 365, 350);
  strokeWeight(0);
}

void draw(){
  //Title Screen Stuff
  if (phase == 0){
    //Button Animation
      //Play Button Animation
    if(mouseX >= 345 && mouseX <= 445 && mouseY >= 173 && mouseY <= 208){
      //Play Button
      fill(#45EA64);
      strokeWeight(3);
      rect(345,173, 100,35);
      fill(#DDF052);
      text("Play", 365, 200);
    }
    else{
      //Play Button
      fill(#5900B4);
      rect(345,173, 100,35);
      fill(#BC0C06);
      text("Play", 365, 200);
    }
    
      //Instruction Button Animation
    if(mouseX >= 320 && mouseX <= 480 && mouseY >= 253 && mouseY <= 288){
      //Play Button
      fill(#45EA64);
      strokeWeight(3);
      rect(320,253, 160,35);
      fill(#DDF052);
      text("Instructions",325,280);
    }
    else{
      //Play Button
      fill(#5900B4);
      rect(320,253, 160,35);
      fill(#BC0C06);
      text("Instructions",325,280);
    }
    
      //Quit Button Animation
    if(mouseX >= 345 && mouseX <= 445 && mouseY >= 323 && mouseY <= 358){
      //Play Button
      fill(#45EA64);
      strokeWeight(3);
      rect(345,323, 100,35);
      fill(#DDF052);
      text("Quit", 365, 350);
    }
    else{
      //Play Button
      fill(#5900B4);
      rect(345,323, 100,35);
      fill(#BC0C06);
      text("Quit", 365, 350);
    }
  }
  if (phase == 1){
    fill(#24E02F);
    rect(0,400,800,25);
    fill(#5900B4);
    rect(0,0,800,400);
    p1.movePlayer();
    s1.moveSlime();
  }
}

void mousePressed(){
  //Title Button Features
  if (phase == 0){
      //Play Feature
    if(mouseX >= 345 && mouseX <= 445 && mouseY >= 173 && mouseY <= 208){
      p1.health = 10;
      phase = 1;
      if (phase == 1){
        strokeWeight(0);
        fill(#5900B4);
        rect(0,0,800,400);
        p1.printPlayer();
  }
    }
      //Instruction Feature
    if(mouseX >= 320 && mouseX <= 480 && mouseY >= 253 && mouseY <= 288){
      phase = 2;
    }
      //Quit Feature
    if(mouseX >= 345 && mouseX <= 445 && mouseY >= 323 && mouseY <= 358){
      exit();
    }
  }
}