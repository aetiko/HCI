import static javax.swing.JOptionPane.*; //<>// //<>//
import static javax.swing.JComponent.*;
import ddf.minim.*;
PrintWriter results;

//Block num
// if index = 0 block 1->3 rects -> 2targets
// if index = 1 block 2->5 rects -> 4targets
// if index = 2 block 3->9 rects -> 9targets

int x = 175;
int y = 175;
int z = 175;
int w = 150;
int h = 50;

int curChosen = -1;

String userId;
PShape p;

Box b;

int blockNumber = 0;

int numOfErrors, startTime, endTime, duration;

int errorCount[] = {0, 0, 0};
int trialTime[] = new int[3];

boolean trialStarted = false;
boolean startedBlock = false;

int trialNum = 0;
int restMode;

Minim m;
AudioSample soundClicked;

void setup(){
  size(1080, 840);
  b= new Box(x,y,w,h);
  userId = showInputDialog("Please enter UserId");
 
  if (userId == null){   
    exit();
  }  
  else if ("".equals(userId)){
    showMessageDialog(null, "Empty ID Input", 
    "Alert", ERROR_MESSAGE);
  } 
  else {
    showMessageDialog(null, "UserId \"" + userId + "\" successfully added", 
    "Info", INFORMATION_MESSAGE);
  }
  println("User Id: ", userId);
  results = createWriter("Student ID" + userId + ".txt");
  m = new Minim(this);
  soundClicked = m.loadSample("mouseClick.mp3");
}

void draw(){
  //if(blockNumber == 1) {
  //  print("HERE\n");
  //}
  
  background(255);
  if (curChosen == -1 && trialStarted) {
    chooseTarget();
  }
  
  b.rectDraw(blockNumber, startedBlock);
}

void mouseClicked(){
  if(trialStarted) {
    
    //startTime = millis();
    numOfErrors = 0;
    boolean response = b.checkIfOverChosen(mouseX, mouseY); //<>//
    
    if (response){
      if(response == true){
        soundClicked.trigger();
        endTime = millis();
      }
      trialNum++;
      
      trialStarted = false;
      curChosen = -1;
      b.setRandomChosen(curChosen);
     
      checkExperimentStatus();
    } else {
      numOfErrors++;
      errorCount[blockNumber]++;
    }
    
    duration = endTime-startTime;
    String data = "" + userId + "\t" + (blockNumber+1) + "\t" + trialNum + "\t" + duration + "\t" + numOfErrors;
    println(data);
    results.println(data);
    results.flush();
    print("Response: " + response + "\n");
  } else {
    
    if (startedBlock) {
      trialStarted = b.checkIfStartClick(mouseX, mouseY);
      startTime = millis(); 
    } else {
      trialStarted = b.checkIfStartClick(mouseX, mouseY);
      startedBlock = trialStarted;
      startTime = millis(); 
    }
    
  }  
}

 void checkExperimentStatus(){
  if(trialNum == 20){
    //noLoop();
    blockNumber++;
    trialNum = 0;
    
    if(blockNumber < 3){
      startedBlock = false;
      /*restMode = showConfirmDialog(null, "Take rest and click ok to go to next block", "Start next block", DEFAULT_OPTION);
      if(restMode == 0){
        loop();
      }*/
    }
    if(blockNumber >= 3){
      restMode = showConfirmDialog(null, "Thank you for participating", "Have a great day", DEFAULT_OPTION);
      results.flush();
      results.close();
      exit();
    }
  }
}

void chooseTarget(){
    if(blockNumber == 0){
      curChosen = int(random(0,2));
    } else if (blockNumber == 1) {
      curChosen = int(random(0,4));
    } else {
      curChosen = int(random(0,8));
    }
    
    b.setRandomChosen(curChosen);
}
