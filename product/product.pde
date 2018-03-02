import processing.video.*;
import gab.opencv.*;
import processing.sound.*;

SoundFile sfile[];

Capture video;
OpenCV opencv;

PImage thresh;

float SPEED = 30;
float R = 10;
float ax = 0.3;
float ay = 1;
color black = color(0, 0, 0);
Ball[] balls;
float minR = 3;
int rippleN = 4;
float ranV = 60.0;
PFont f;
int ballCount = 0;
int score = 0;

int sTime;
int nTime;
int pTime;
boolean game = false;
int[] highScore;


void setup(){
  fullScreen();
  frameRate(30);
  
  video = new Capture(this, width, height);
  opencv = new OpenCV(this, width, height);
  
  video.start();
  
  //printArray(PFont.list());
  f = createFont("Droid Serif Italic", 120);
  textFont(f);
  
  balls = new Ball[30];
  highScore = new int[3];
  highScore[0] = 0;
  highScore[1] = 0;
  highScore[2] = 0;

  sfile = new SoundFile[3];
  sfile[0] = new SoundFile(this, "pianoC.mp3");
  sfile[1] = new SoundFile(this, "pianoE.mp3");
  sfile[2] = new SoundFile(this, "pianoG.mp3");

  for(int i = 0; i < balls.length; i++){
    balls[i] = new Ball(random(width), random(height)+height, 0, SPEED, R, (int)random(3));
  }
}

void draw(){
  opencv.loadImage(video);
  opencv.threshold(50);
  thresh = opencv.getSnapshot();
  
  image(thresh, 0, 0);
  
  /*
  textAlign(RIGHT);
  fill(126, 206, 244);
  text(ballCount, width - 40, 120);
  */
  
  for(int i = 0; i < balls.length; i++){
    balls[i].isAlive();
    balls[i].collision();
    balls[i].velocity();
    balls[i].move();
    balls[i].draw();
  }
  
  // button click
  if (keyPressed){
    if (key == ' '){
      ballCount = 0;
      game = true;
      sTime = millis();
    } 
  }
  if(game){
    nTime = millis();
    pTime = nTime - sTime;
    if(pTime < 1000){
      textAlign(CENTER);
      fill(126, 206, 244);
      text("ready?",width/2, 200);
    } else if(1000 <= pTime && pTime < 2000){
      // initialization
      ballCount = 0;
      score = 0;
      textAlign(CENTER);
      fill(126, 206, 244);
      text("Go!", width/2, 200);
    } else if(2000 <= pTime && pTime < 3000){
      textAlign(RIGHT);
      fill(126, 206, 244);
      text(ballCount, width - 40, 120);
      textAlign(LEFT);
      fill(126, 206, 244);
      text("15", 20, 100);
    } else if(3000 <= pTime && pTime < 4000){
      textAlign(RIGHT);
      fill(126, 206, 244);
      text(ballCount, width - 40, 120);
      textAlign(LEFT);
      fill(126, 206, 244);
      text("14", 20, 100);
    } else if(4000 <= pTime && pTime < 5000){
      textAlign(RIGHT);
      fill(126, 206, 244);
      text(ballCount, width - 40, 120);
      fill(126, 206, 244);
      textAlign(LEFT);
      text("13", 20, 100);
    } else if(5000 <= pTime && pTime < 6000){
      textAlign(RIGHT);
      fill(126, 206, 244);
      text(ballCount, width - 40, 120);
      textAlign(LEFT);
      fill(126, 206, 244);
      text("12", 20, 100);
    } else if(6000 <= pTime && pTime < 7000){
      textAlign(RIGHT);
      fill(126, 206, 244);
      text(ballCount, width - 40, 120);
      textAlign(LEFT);
      fill(126, 206, 244);
      text("11", 20, 100);
    } else if(7000 <= pTime && pTime < 8000){
      textAlign(RIGHT);
      fill(126, 206, 244);
      text(ballCount, width - 40, 120);
      textAlign(LEFT);
      fill(126, 206, 244);
      text("10", 20, 100);
    } else if(8000 <= pTime && pTime < 9000){
      textAlign(RIGHT);
      fill(126, 206, 244);
      text(ballCount, width - 40, 120);
      textAlign(LEFT);
      fill(126, 206, 244);
      text(" 9", 20, 100);
    } else if(9000 <= pTime && pTime < 10000){
      textAlign(RIGHT);
      fill(126, 206, 244);
      text(ballCount, width - 40, 120);
      textAlign(LEFT);
      fill(126, 206, 244);
      text(" 8", 20, 100);
    } else if(10000 <= pTime && pTime < 11000){
      textAlign(RIGHT);
      fill(126, 206, 244);
      text(ballCount, width - 40, 120);
      textAlign(LEFT);
      fill(126, 206, 244);
      text(" 7", 20, 100);
    } else if(11000 <= pTime && pTime < 12000){
      textAlign(RIGHT);
      fill(126, 206, 244);
      text(ballCount, width - 40, 120);
      textAlign(LEFT);
      fill(126, 206, 244);
      text(" 6", 20, 100);
    } else if(12000 <= pTime && pTime < 13000){
      textAlign(RIGHT);
      fill(126, 206, 244);
      text(ballCount, width - 40, 120);
      textAlign(LEFT);
      fill(126, 206, 244);
      text(" 5", 20, 100);
    } else if(13000 <= pTime && pTime < 14000){
      textAlign(RIGHT);
      fill(126, 206, 244);
      text(ballCount, width - 40, 120);
      textAlign(LEFT);
      fill(126, 206, 244);
      text(" 4", 20, 100);
    } else if(14000 <= pTime && pTime < 15000){
      textAlign(RIGHT);
      fill(126, 206, 244);
      text(ballCount, width - 40, 120);
      textAlign(LEFT);
      fill(126, 206, 244);
      text(" 3", 20, 100);
    } else if(15000 <= pTime && pTime < 16000){
      textAlign(RIGHT);
      fill(126, 206, 244);
      text(ballCount, width - 40, 120);
      textAlign(LEFT);
      fill(126, 206, 244);
      text(" 2", 20, 100);
    } else if(16000 <= pTime && pTime < 17000){
      textAlign(RIGHT);
      fill(126, 206, 244);
      text(ballCount, width - 40, 120);
      textAlign(LEFT);
      fill(126, 206, 244);
      text(" 1", 20, 100);
      
      score = ballCount;
      
    } else {
      
      updateHighScore(score);
      
      textAlign(CENTER);
      fill(126, 206, 244);
      text("Your score is " + score + "!", width/2, 200);
      
      f = createFont("Droid Serif Italic", 60);
      textFont(f);
      text("ranking", width/2, 400);
      text("1st: " + highScore[0], width/2, 500);
      text("2nd: " + highScore[1], width/2, 600);
      text("3rd: " + highScore[2], width/2, 700);
      text("Please press the Enter key...", width/2, 800);
      
      f = createFont("Droid Serif Italic", 120);
      textFont(f);
      
      if(keyPressed){
        if(key == ENTER){
          background(0);
          game = false;
        }
      }
    }
  }
}



class Ball{
  float x, y;
  float vx, vy;
  float r;
  int   sID;
  
  Ball(float _x, float _y, float _vx, float _vy, float _r, int _sID){
    x = _x;
    y = _y;
    vx = _vx;
    vy = _vy;
    r = _r;
    sID = _sID;
  }
  
  void isAlive(){
    if(r <= minR){ // Initialization
        y = 0;
        x = random(width);
        r = R;
        ballCount++;
    }
  }
  
  void collision(){
    color c;
    int i;
    Boolean isCollideX = false, isCollideY=false;
    float nvx, nvy, ranT;
    
    // collision check
    c = get(int(max(0,x-r)), int(y)); // LEFT
    if(c == black) isCollideX = true;
    c = get(int(min(width - 1,x+r)), int(y)); // RIGHT
    if(c == black) isCollideX = true;
    c = get(int(x), int(max(0,y-r))); // TOP
    if(c == black) isCollideY = true;
    c = get(int(x), int(min(height - 1,y+r))); // BOTTOM
    if(c == black) isCollideY = true;
    
    if(isCollideX || isCollideY){
      sfile[sID].play();
  
      if(isCollideX) vx *= -1;
      if(isCollideY) vy *= -1;
      
      // Change direction
      ranT = (ranV/180 * 3.14)*(random(1)-0.5);
      nvx = vx * cos(ranT) - vy * sin(ranT);
      nvy = vx * sin(ranT) + vy * cos(ranT);
         
      vx = nvx;
      vy = nvy;
      
      if(r > minR) r--;
      
      // draw ripple
      for(i = 0; i < rippleN; i++){
          noFill();
          strokeWeight(i+1);
          stroke(126, 206, 244, (256/rippleN)*(rippleN-i));
          ellipse(x, y, r*2*(i+1), r*(i+1));
      }
    }
  }
  
  void velocity(){
    // changing vx
   if(vx > 0){
      vx = vx - ax;
      if(vx < 0){
        vx = 0;
      }
    }
    if(vx < 0){
      vx = vx + ax;
      if(vx > 0){
        vx = 0;
      }
    }
    
    // changing vy
    if(vy < SPEED){
      vy = vy + ay;
      if(vy > SPEED){
        vy = SPEED;
      }
    }
  }
  
  void move(){
    // moving x axis
    x = x + vx;
    // reflection
    if(x - r <= 0){
      x = r;
      vx *= -1;
    }
    if(x + r >= width){
      x = width - r;
      vx *= -1;
    }
    // moving y axis
    y = y + vy;
    // setting up the border of y axis
    if(y > height*2){
      // new position
      y = 0;
      x = random(width);
      r = R;
    }
  }
  
  void draw(){
    fill(126, 206, 244);
    ellipse(x, y, r*2, r*2);
  }
}


void updateHighScore(int score){
  if(score != highScore[0] && score != highScore[1] && score != highScore[2]){
    if(highScore[2] > score){
      
    } else if(highScore[1] > score && score > highScore[2]){
      highScore[2] = score;
    } else if(highScore[0] > score && score > highScore[1]){
      highScore[2] = highScore[1];
      highScore[1] = score;
    } else if(score > highScore[0]){
      highScore[2] = highScore[1];
      highScore[1] = highScore[0];
      highScore[0] = score;
    }
  }
}

// necessary
void captureEvent(Capture c){
  c.read();
}