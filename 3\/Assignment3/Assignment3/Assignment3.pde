import static javax.swing.JOptionPane.*; //Popup import
import processing.sound.*; //Sound effects

String inputIn;

int userNum = 0; //The number input by the user to designate who they are
int blockNum = 1; //1 = Practice. 2, 3, & 4 = Trials
int trialNum = 0; //The current number that the user is on (0 to 20) in this block
int condition = 0; //0 = Normal Cursor, 1 = Area Cursor

float startTime = 0; //Time since started the trial
float trialTime = 0, blockTime = 0, totalTime = 0; //Time taken in milliseconds
float dist = 0; //distance between circles
float timerStart = 0; //varible used for the timer function
int trialErr = 0, blockErr = 0, totalErr = 0; //Number of errors
boolean blockStarted = false; //True if player has clicked start. Set to false when the block has finished

int targetRadius = 30; //The radius of our targets
int targetCount = 21; //The number of targets
int targetX, targetY; //To store the values for where targets should be placed
int cursorRadius = 10;

PVector[] targets = new PVector[targetCount]; //The vector locations of all targets

//PShape[] circles = new PShape[21]; //Array of all targets
int curTar = 0; //The value of the current target
int prev = 0; //The previous target

PShape start; //Start button

TriOsc triOsc; //for sounds
Env env;

color yellow = color(255, 255, 0);
color gray = color(128, 128, 128);
color white = color(255, 255, 255);
color black = color(0.39, 5.31, 7.45);

void setup(){
    size(1920, 1080);
    inputIn = null;
    
    inputIn = showInputDialog("Please enter User Number.");
    if (inputIn == null){
      exit();
    }
    
    userNum = Integer.parseInt(inputIn);
    
    triOsc = new TriOsc(this);
    env  = new Env(this); 
    randomizeTargets();
    curTar = (int)random(targetCount);
}

void draw(){
   clear();
   background(gray);
   
    if(condition == 1){
      PVector temp = findClosestT();
      ellipse(temp.x, temp.y, targetRadius*2, targetRadius*2);
      double xSquared = Math.pow(mouseX - temp.x, 2);
      double ySquared = Math.pow(mouseY - temp.y,2);
      cursorRadius = (int) Math.round(Math.sqrt(xSquared + ySquared));
      
      if(temp == targets[curTar]){
        fill(yellow);
      }else{
        fill(white); 
      }
      ellipse(mouseX,mouseY, cursorRadius * 2, cursorRadius * 2);
    }
     
    for(int i = 0; i < targetCount; i++){ //Draw all targets
      fill(white);
      if(i == curTar){
        fill(yellow); 
      }
      ellipse(targets[i].x, targets[i].y, targetRadius*2, targetRadius*2);
    }
    fill(white);
    text("Mouse Condition: " + condition, 20, 20);
    text("Please select highlighted buttons as quickly and accurately as possible. This is round "+ blockNum + " of 4.", 20, 40);
    if(!blockStarted){
      text("Press the target to continue", 20, 60);
    }
    if(trialNum == 20){
     if(condition==0 && blockNum == 2){
       condition = 1;
     }
     else if(condition==1 && blockNum == 2){
       condition = 0;
     }
     trialNum = 0;
     blockNum++;
     randomizeTargets();
     blockStarted = false;
   }
}

void newTarget(){ //Picks a new target that does not equal the old one
  prev = curTar;
  do{
    curTar = (int)random(targetCount);
    if (!blockStarted){
      curTar = 0; 
    }
  }while(prev == curTar);
  
}

void randomizeTargets(){ //Randomizes all target placements
  for(int i = 0; i < targetCount; i++){
    boolean tooClose = true;
    PVector pv = new PVector(0, 0);
    while(tooClose){ //While too close to another target (less than 15 pixels between the two) regenerate the location
      targetX = (int)(random(width - targetRadius * 2) + targetRadius);
      targetY = (int)(random(height - targetRadius * 2) + targetRadius);
      pv = new PVector(targetX, targetY);
      tooClose = false;
      for(int j = 0; j < i; j++){
        if(distanceForShapes(targets[j], pv) < ((targetRadius*2)+15)){
          tooClose = true;
          break;
        }
      }
    }
    targets[i] = pv;
  } 
}

void mouseReleased(){
  if(!blockStarted){
    PVector temp = findClosestT();
    if(overTarget(targets[curTar]) || temp == targets[curTar]){//If we have not started yet...
      blockStarted = true;
      triOsc.play();
      env.play(triOsc, 0.001, 0.004, 0.4, 0.2);
      //randomizeTargets();
      newTarget();
      timerStart = startTimer();
     }
  }else{
    boolean checkHit = false;
    if(condition == 0){ //If regular cursor
      if(overTarget(targets[curTar])){
        checkHit = true;
      }
    }else{ //If bubble cursor
      PVector temp = findClosestT();
      if(temp == targets[curTar]){
        checkHit = true;
      }
    }
     if(checkHit){ //If over the current target when the mouse is released
        triOsc.play();
        env.play(triOsc, 0.001, 0.004, 0.4, 0.2);
        if(blockNum == 2 || blockNum == 4){
          dist = distanceForShapes(targets[curTar], targets[prev]);
          timerStart = endTimer(timerStart);
          dataOutput(userNum,trialNum+1,condition,timerStart,trialErr,dist);
          timerStart = startTimer();
        }
        newTarget();
        trialNum++;
        trialErr = 0;
     }
     else{
      trialErr++;
     }
  }
    
}

boolean overTarget(PVector t){ //Check if the mouse is over the current target
  //if (mouseX >= t.x-targetRadius && mouseX <= t.x+targetRadius && mouseY >= t.y-targetRadius && mouseY <= t.y+targetRadius) {
    
  if(distanceFromMouse(t) <= targetRadius){
    return true;
  }else {
    return false;
  }
}

void keyReleased(){
  if (key == ' ') {
      if(condition == 0 && blockNum == 1 && !blockStarted){
        condition = 1;
      }
      else if(condition == 1 && blockNum == 1 && !blockStarted){
        condition = 0;
      }
   }
}

PVector findClosestT(){ //Find the closest target to the current cursor position
  PVector pv = new PVector(0, 0);
  int c = 10000;
  PVector mouse = new PVector(mouseX, mouseY);
  for(int i = 0; i < targetCount; i++){
    int temp = (int)distanceForShapes(targets[i], mouse);
    if(temp < c){
      c = temp;
      pv = targets[i];
    }
  }
  return pv;
}


float distanceForShapes(PVector prev, PVector current){
  float output = prev.dist(current);
  return output;
  
}

float distanceFromMouse(PVector in){
  return dist(in.x,in.y,mouseX,mouseY);
}

void dataOutput(int id, int trial,int condition, double time, int errors, float distance){
  System.out.println(id + "\t" + trial + "\t" + condition + "\t" + time + "\t" + errors + "\t" + distance);
}

int startTimer(){
  return millis();
}

float endTimer(float timeStart){
  float output = (millis()-timeStart);
  return output;
}
