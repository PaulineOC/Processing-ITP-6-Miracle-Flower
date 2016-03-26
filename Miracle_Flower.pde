
Flower flower;
int [] flower_width = {
  32, 43, 57, 88, 95, 94, 122, 122
};
int[] flower_height = {
  60, 80, 100, 120, 140, 160, 180, 200
};

Rain rain;

Deer deer;
int deer_direction = 0;
PFont deerCollide;
PImage dead_Flower;
Sun sun;

Thunder thunder;
PImage lightening_bolt;
//Clicking cloud: 
boolean overCloud = false;
boolean locked = false;
int rain_click = 0;


void setup() {
  size(700, 450);
  flower = new Flower("1.png", "2.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png");
  rain = new Rain("Cloud3.png");
  thunder = new Thunder("Thunder3.png");
  lightening_bolt = loadImage("Lightening.png");

  //FOR DEER: (String filename1, String filename2, int _x, int _y, int _velocity)
  deer = new Deer("DeerLeft.png", "DeerRight.png", -5, 1);
  deerCollide = loadFont ("ArialMT-16.vlw");
  dead_Flower = loadImage("skull.png");


  sun = new Sun("Sun.png");
}

void draw () {
  //Background and Soil
  fill(139, 69, 19);
  rect(0, 425, width, 70);
  fill(179, 232, 255);
  rect(0, 0, width, 425);


  thunder.thunder_Draw(75, 100);

  sun.sun_Draw(620, -45);

  //SWITCH DEER ORIENTATION
  deer.deer_Move(deer_direction);

  rain.rain_Draw(350 - (111/2), 100);
  fill(00, 00, 255, 50);
  //CLICKABLE AREA for RAIN CLOUD
  if (mouseX >= 295 && mouseX <=495 &&
    mouseY >= 100 && mouseY <= 311) {
    overCloud = true;
  }
  else {
    overCloud = false;
  }
  
  if (rain_click <= 10){
    flower.flower_Draw(350, (height-(flower_height[0]+18)), 1);
  }
  
  if (rain_click <= 20 && rain_click > 10){
    flower.flower_Draw(350, (height-(flower_height[1]+18)), 2);
  }
  
  if (rain_click <= 30 && rain_click > 20){
    flower.flower_Draw(350, (height-(flower_height[2]+18)), 3);
  }
  
  if (rain_click <= 40 && rain_click > 30){
    flower.flower_Draw(350, (height-(flower_height[3]+18)), 4);
  }
  
  if (rain_click <= 50 && rain_click > 40){
    flower.flower_Draw(350, (height-(flower_height[4]+18)), 5);
  }
  
  if (rain_click <= 60 && rain_click > 50){
    flower.flower_Draw(350, (height-(flower_height[5]+18)), 6);
  }
  
  if (rain_click <= 70 && rain_click > 6){
    flower.flower_Draw(350, (height-(flower_height[6]+18)), 7);
  }
  
  if (rain_click >= 80){
    flower.flower_Draw(350, (height-(flower_height[7]+18)), 8);
    textFont(deerCollide, 16);
    text ("Miracle flower has grown!", 370, 300);
  }
  
  


  textFont(deerCollide, 16);
  fill(0);
  deer.check_collision();
} // END OF DRAW 

//Flower Class
class Flower {
  PImage flower1;
  PImage flower2;
  PImage flower3;
  PImage flower4;
  PImage flower5;
  PImage flower6;
  PImage flower7;
  PImage flower8;


  int x;
  int y;
  //Constructor
  Flower(String filename1, String filename2, String filename3, String filename4, String filename5, String filename6, String filename7, String filename8) {
    flower1 = loadImage (filename1);
    flower2 = loadImage (filename2);
    flower3 = loadImage (filename3);
    flower4 = loadImage (filename4);
    flower5 = loadImage (filename5);
    flower6 = loadImage (filename6);
    flower7 = loadImage (filename7);
    flower8 = loadImage (filename8);
  } 
  void flower_Draw(float x, float y, int flower_type) {
    switch (flower_type) {
    case 0:
      image(flower1, x, y);
      break;
    case 1:
      image(flower2, x, y);
      break;
    case 2:
      image(flower3, x, y);
      break;
    case 3:
      image(flower5, x, y);
      break;
    case 4:
      image(flower6, x, y);
      break;
    case 5:
      image(flower7, x, y);
      break;
    case 6:
      image(flower8, x, y);
    }
  }
  //End of Flower Class
}


//Sun class
class Sun {
  PImage sun_ball;
  int x;
  int y;

  //Sun constructor
  Sun(String filename1) {
    sun_ball = loadImage(filename1);
  }

  void sun_Draw(int x, int y) {
    image(sun_ball, x, y);
  }
  
  void SunRays (){
  }
  
  
}
//End of Sun class


//Rain class
class Rain {
  PImage cloud;
  int cloud_x;
  int cloud_y;

  //Cloud constructor
  Rain(String filename) {
    cloud = loadImage(filename);
  }

  void rain_Draw(float x, float y) {
    image(cloud, x, y);
  }
}
//End of Rain class

//Thunder class
class Thunder {
  PImage lightening;
  int cloud_x;
  int cloud_y;

  //Cloud constructor
  Thunder(String filename) {
    lightening = loadImage(filename);
  }

  void thunder_Draw(int x, int y) {
    image(lightening, x, y);
  }
}//End of THUNDER class

//Deer class
class Deer {

  PImage predator1;
  PImage predator2;
  int x;
  int y;
  float velocity;

  //Deer constructor
  Deer(String filename1, String filename2, int _x, float _velocity) {
    predator1 = loadImage(filename1);
    predator2 = loadImage(filename2);

    x = _x;
    velocity = _velocity;
  }

  void deer_Draw(int x, int deer_direction) {
    y = 340;
    switch (deer_direction) {
    case 0:
      image(predator1, x, y);
      break;
    case 1:
      image(predator2, x, y);
      break;
    }
  }
  //Move deer
  int get_x () {
    return x;
  }

  //Get direction: 
  int get_direction() {
    return deer_direction;
  }

  float get_velocity() {
    return velocity;
  }
  void deer_Move(int deer_direction) {
    x += velocity;
    this.deer_Draw(x, deer_direction);
  }


  void deer_Reset() {
    int side = (int) random(1, 3);
    if (side ==1 ) {
      x = -100;
      velocity = 2;
      deer_direction = 0;
    }
    else {
      x = width+50;
      velocity = -2;
      deer_direction = 1;
    }
  }

  boolean check_collision() {
    boolean signal = false;
    if (deer_direction == 0) {
      if (((x + 100) > 350) && (x) < 475) { 
        image(dead_Flower, 310, 255);
        signal = true;
        rain_click = 0;
        this.deer_Reset();
      }
    }

    else if (deer_direction == 1) {
      if ((x) < 350) {
        image(dead_Flower, 310, 255);
        signal = true;
        rain_click= 0;
        this.deer_Reset();
      }
    }

    return signal;
  }
}// End of Deer class


void keyPressed () {
  deer.deer_Reset();
  image(lightening_bolt, 150, 205);
  textFont(deerCollide, 16);
  fill(255, 255, 102);
  text ("ZAP", 100, 250);
  text ("ZAP", 225, 250);
}

void mousePressed() {
  if (overCloud) {
    textFont(deerCollide, 16);
    fill(0, 0, 255);
    text ("Whee water!", 299, 100);
    draw_rain();
    rain_click += 5;
  }
  else {
    locked = false;
  }
}

void draw_rain() {
  float x = 0;
  x = (random(294, 800));
  System.out.println(x);
  float y = 0;
  int velocity_y = 3;
  for (int i = 0; i < 40; i++) {
    x = (random(294, 400));
    y = random(220, height);
    y+= velocity_y;
    fill(00, 00, 255);
    ellipse(x, y, 4, 7);
  }
}

