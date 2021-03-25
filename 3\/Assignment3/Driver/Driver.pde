/* Ayoola & David - HCI Assignment 3 */
import static javax.swing.JOptionPane.*;
String userId;
PrintWriter results;

int buttonX[];
int buttonY[];
int buttonNumber = 25;
int buttonLit;
//boolean practiceMode;
//boolean evaluationMode;
int buttonOver = -1;
boolean response;
int trialCount = 0;
int stage = 1;
int start;
float distanceData;
int prevX;
int prevY;
int error = 0;


Object[] possibleValues = { 0, 1};
Object selectedCursor;
// 0 normal cursor
// 1 area cursor

void setup(){
  buttonX = new int[buttonNumber];
  buttonY = new int[buttonNumber];
  
  start = startTimer();
  fullScreen();
  background(100);
  noStroke();
  //fill(102);
  
  userId = showInputDialog("Please enter UserId");
  if (userId == null){ exit(); }  
  else if ("".equals(userId)){ showMessageDialog(null, "Empty ID Input", "Alert", ERROR_MESSAGE);} 
  else { showMessageDialog(null, "UserId \"" + userId + "\" successfully added", "Info", INFORMATION_MESSAGE);
  }
  println("User Id: ", userId);
  selectedCursor = showInputDialog(null,"Choose one", "Input", INFORMATION_MESSAGE, 
                                          null,possibleValues, possibleValues[0]);
  println("Which cursor?: ", selectedCursor);
    showMessageDialog(null, "Please select highligheted buttons as quick as possible. This is round 1 of 4\n\n\t\t\t Click Ok to begin practice",
    "Test", DEFAULT_OPTION);
      addButtonCoordinates();
      drawButtons();
      results = createWriter("Student ID" + userId + ".txt");
}
  
void draw(){
   if(trialCount == 21){
     stage++;
     background(100);
     //if stage == 4, say thank you
     //if stage < 4, stage++ and show dialog
     showBetweenDialog();
     trialCount = 0;
   }
   
   background(100);
   drawButtons();
   update();
}

void addButtonCoordinates(){
  /*
  The addButtonCoordinates method adds x and y values to the respective arrays. It also
  adds an integer to buttonLit. This is important as it is the button that is lit up. Before adding a coordinate 
  to an array, it checks to see if there is another coordinate within 15 pixels, if there is, it randomizes again.
  */
    int randX = int(random(13, (displayWidth - 13)));
    int randY = int(random(13, (displayHeight - 13)));
    buttonLit = int(random(0, buttonNumber));
    
   
    for(int i = 0; i < buttonNumber; i ++){
      
      while(checkArrayForClose(buttonX, randX) != false){
        randX = int(random(13, (displayWidth - 13)));
      }
      buttonX[i] = randX;
      
      while(checkArrayForClose(buttonY, randY) != false){
        randY = int(random(13, (displayHeight - 13)));
      }
      buttonY[i] = randY;
      //println(buttonX[i] + ":" + buttonY[i] + " - ");
   }
}

void drawButtons(){
  /*
  The drawButton function draws the circles from the coordinate arrays buttonX and buttonY.
  It checks to see if buttonLit is equal to i, and if it is, the fill colour is the lit up
  colour, if it isn't, the colour is a dark grey colour.
  */
 for(int i = 0; i < buttonNumber; i++){
   if(buttonLit == i){
     fill(204, 102, 0);
   }
   else{
     fill(50);
   }
   circle(buttonX[i], buttonY[i], 25);
   //fill(0);
 }
}
boolean checkArrayForClose(int[] arrayIn, int numIn){
  /*
  checkArrayForClose checks an array to see if the numIn integer is within 15 of the value in the array.
  If there is a value that is within 15, the function returns true, and if there isn't the function returns false.
  */
  boolean output = false;
  
  for(int i = 0; i < arrayIn.length; i++){
    if(abs(arrayIn[i] - numIn) < 15){
      output = true;
    }
  }
  
  return output;
}

boolean overButton(int buttonNum){
  /*
  checks to see if mouse is over the button thats number is passed in. If the mouse is over the button,
  returns true, else returns false.
  *******ISSUE: technically it checks a square, need to ignore the corners.*******
  */
  int x = buttonX[buttonNum];
  int y = buttonY[buttonNum];
  
  if (mouseX >= x - 12 && mouseX <= x+12 && 
      mouseY >= y - 12 && mouseY <= y+12) {
    return true;
  } else {
    return false;
  }
}

int closestButton(){
  /*
  Finds the closest button to the cursor. It will replace the overButton function for the bubble click mode.
  */
  float dist;
  float shortestDist = 10000;
  int closestButton = -1;
  
  for(int i = 0; i < buttonX.length; i++){
   dist = sqrt(((abs(mouseX - buttonX[i]))^2) +((abs(mouseY - buttonY[i])^2))); 
   if(dist < shortestDist){
      shortestDist = dist;
      closestButton = i;
   }
  }
  return closestButton;
}

int startTimer(){
  /*
  Starts timer to be used in data.
  */
  return millis();
}

double endTimer(int timeStart){
  /*
  Ends timer to be used in data.
  */
  double output = (millis()-timeStart);
  return output/1000; 
}

void update() {
 /*
 checks to see if the mouse is over any buttons, if mode = 1, then it uses bubble cursor and uses the closestButton
 function rather than the overButton function to determine which button it is over if any.
 */
 if((int ) selectedCursor == 0){ // mode= 0 regular cursor
   buttonOver = -1;
   for(int i = 0; i < buttonNumber; i++){
     if(overButton(i)){
       buttonOver = i; 
       //break here?
     }
   }
 }
 else{ //mode = 1: bubble cursor
   buttonOver = closestButton();
 }
}

void mousePressed(){
 /*
 The behaviour of the mouse pressed. If on regular cursor, checks to see if a buttonOver is greater than -1 when
 mouse is clicked. If it is, and the button that is lit is the button that the mouse is over, it registers a correct hit, otherwise
 an error.
 
 For bubble cursor, when a click happens, it registers a click on the closest button.
 */
 int buttonLitTemp;
 if((int ) selectedCursor == 0){ //selectedCursor == 0 normal mode //<>//
   if(overButton(buttonLit)){
     trialCount++;
     //println("right");
     //buttonLit can become any of the other buttons
     buttonLitTemp = int(random(0, buttonNumber));
     if(buttonLitTemp == buttonLit){
       while(buttonLitTemp == buttonLit){
          prevX = buttonX[buttonLit];
          prevY = buttonY[buttonLit];
          buttonLitTemp = int(random(0, buttonNumber));
          //distanceData = sqrt((abs(prevX - buttonX[buttonLit]))^2 + (abs(prevY - buttonY[buttonLit]))^2 );
          //addLineToFile(userId, trialCount, (int)selectedCursor, endTimer(start), error, distanceData);
          
       }
     }
     error = 0;
     buttonLit = buttonLitTemp;
   }
   else{
    error++;; 
   }
 }
 else{ //selectedCursor == 1: bubble mode //<>//
   if(overButton(buttonLit)){
     trialCount++; //<>//
     //println("right");
     //buttonLit can become any of the other buttons
     buttonLitTemp = int(random(0, buttonNumber));
     if(buttonLitTemp == buttonLit){
       while(buttonLitTemp == buttonLit){
          prevX = buttonX[buttonLit];
          prevY = buttonY[buttonLit];
          buttonLitTemp = int(random(0, buttonNumber));
          //distanceData = sqrt((abs(prevX - buttonX[buttonLit]))^2 + (abs(prevY - buttonY[buttonLit]))^2 );
          //addLineToFile(userId, trialCount, (int)selectedCursor, endTimer(start), error, distanceData);
          
       }
     }
     error = 0;
     buttonLit = buttonLitTemp;
   }
   else{
    error++;
   }
 }
 distanceData = sqrt((abs(prevX - buttonX[buttonLit]))^2 + (abs(prevY - buttonY[buttonLit]))^2 );
 addLineToFile(userId, trialCount, (int)selectedCursor, endTimer(start), error, distanceData);
}

void addLineToFile(String id, int trial, int selectedCursor, double time, int errors, float distanceData)
{
  if(stage == 2 || stage == 4){
    println(id + " " + trial + " " + selectedCursor + " " + time + " " + errors + " " + distanceData);
    String data = id + " \t" + trial + " \t" + selectedCursor + " \t" + time + " \t" + errors + " \t" + distanceData;
    results.println(data);
    results.flush();
  }
  start = startTimer();
  
}

void showBetweenDialog(){
    if(stage == 2 || stage == 4){
      showMessageDialog(null, "Please select highligheted buttons as quick as possible. This is round " + stage + " of 4\n\n\t\t\t Click Ok to begin evaluation",
        "Evaluation", DEFAULT_OPTION);
        if((int)selectedCursor == 0){
            selectedCursor = possibleValues[1];
        } 
        else{
           selectedCursor = possibleValues[0];
        }
    }
    else if(stage == 1 || stage == 3){
       showMessageDialog(null, "Please select highligheted buttons as quick as possible. This is round " + stage + " of 4\n\n\t\t\t Click Ok to begin practice",
        "Practice", DEFAULT_OPTION);
    }
    else{       
      showMessageDialog(null, "Thank You!",
        "Done", DEFAULT_OPTION);
    }
}
