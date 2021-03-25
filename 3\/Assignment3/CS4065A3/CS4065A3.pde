//to exit click, and press ESC
//sample code to get you started on BubbleCursor
import static javax.swing.JOptionPane.*;
int cursorRadius = 10;

int targetRadius = 25;
int targetCount = 25;
int targetX, targetY; 
int closestX,closestY;
int lastX=0, lastY=0;
String id = "";

PVector[] targets = new PVector[targetCount];

int count = 0;
int trial = 0;
int miss = 0;

int startMil = 0;
int endMil = 0;


//set to false for normal cursor
boolean bubbleCursor = false;
boolean far = true;
boolean testing = false;
boolean choice = false;

void setup()
{
  fullScreen();
  //noCursor();
  clear();
  id = showInputDialog("Please enter ID");
  int i = 0;
  while (i < targetCount)
  {
    
    targetX = (int)(random(width - targetRadius * 2) + targetRadius);
    targetY = (int)(random(height - targetRadius * 2) + targetRadius);
    for(int j=0; j<i; j++){
      if(Math.sqrt(Math.pow(targetX - targets[j].x, 2) + Math.pow(targetY - targets[j].y, 2)) < targetRadius*2 + 15){
        far = false;
      }
    }
    if(far){
      PVector pv = new PVector(targetX, targetY);
      targets[i] = pv;
      i++;
    }
    else{
      far = true;
    }
  }
}

void draw()
{
  //push();  //save current drawing settings
 
  clear();
  stroke(255);
  
  if(!choice){
    fill(255);
    textSize(32);
    text("Select the starting condition", width/2 - 200, height/2 - 50);
    rect(width/2 - 55, height/2 - 25, 50, 50);
    rect(width/2 + 5, height/2 - 25, 50,50);
    textSize(32);
    fill(0);
    text("0", width/2 - 40,height/2 + 15);
    text("1", width/2 + 20,height/2 + 15);
  }
  else{
    noCursor();
    if(count == 21 && trial < 4){
      if(trial == 1){
        showMessageDialog(null, "Please select highlighted buttons as quickly and accurately as possible. This is round 2 of 4.\nPress ok to begin evaluation");
      }
      else if(trial == 2){
        showMessageDialog(null, "Please select highlighted buttons as quickly and accurately as possible. This is round 3 of 4.\nPress ok to begin practice");
        bubbleCursor = !bubbleCursor;
      }
      else if(trial == 3){
        showMessageDialog(null, "Please select highlighted buttons as quickly and accurately as possible. This is round 4 of 4.\nPress ok to begin evaluation");
      }
      trial ++;
      count = 0; 
    }
    else if(count == 21 && trial >= 4){
      showMessageDialog(null, "Thank you for participating");
      exit();
    }
    
    if (bubbleCursor){
      double xSquared;
      double ySquared;
      double smallest = Double.MAX_VALUE;
      for(int i=0; i<targets.length; i++){
        xSquared = Math.pow(mouseX - targets[i].x, 2);
        ySquared = Math.pow(mouseY - targets[i].y, 2);
        if(Math.sqrt(xSquared + ySquared) < smallest){
          closestX = (int)targets[i].x;
          closestY = (int)targets[i].y;
          cursorRadius = (int) Math.round(Math.sqrt(xSquared + ySquared));
          smallest = cursorRadius;
        }
      }
    }
    
    stroke(40);
    fill(120);
    
    //draw targets
    for (int i = 0; i < targetCount; i++)
      ellipse(targets[i].x, targets[i].y, targetRadius*2, targetRadius*2);
    
    if(count<21 && !testing){  
      int t = (int) random(25);
      targetX = (int)targets[t].x;
      targetY = (int)targets[t].y;
      testing = true;
      startMil = millis();
    }
    fill(255,0,255);
    ellipse(targetX, targetY, targetRadius*2, targetRadius*2);
    //draw red dot for mouse cursor
    stroke(255);
    fill(255,0,0);
    ellipse(mouseX,mouseY,10,10);
    
    //pop();  //restore previous drawing settings
  }
}

void mouseClicked(){
  if(!choice && mouseX< width/2 - 5 && mouseX > width/2 - 55 && mouseY > height/2 - 25 && mouseY < height/2 + 25){
    bubbleCursor = true;
    showMessageDialog(null, "Please select highlighted buttons as quickly and accurately as possible. This is round 1 of 4.\nPress ok to begin practice");
    choice = true;
    trial ++;
  }
  else if(!choice && mouseX> width/2 + 5 && mouseX < width/2 + 55 && mouseY > height/2 - 25 && mouseY < height/2 + 25){
    bubbleCursor = false;
    showMessageDialog(null, "Please select highlighted buttons as quickly and accurately as possible. This is round 1 of 4.\nPress ok to begin practice");
    choice = true;
    trial ++;
  }
  else{
    if(bubbleCursor && closestX == targetX && closestY == targetY){
      endMil = millis();
      if(count>0 && trial%2 == 0)
        hit();
      lastX = targetX;
      lastY = targetY;
      count++;
      miss = 0;
      testing = false;
    }
    else if(!bubbleCursor && mouseX-cursorRadius <= targetX+targetRadius && mouseX+cursorRadius >= targetX-targetRadius && mouseY-cursorRadius <= targetY+targetRadius && mouseY+cursorRadius >= targetY-targetRadius){
      endMil = millis();
      if(count>0 && trial%2 == 0)
        hit();
      lastX = targetX;
      lastY = targetY;
      count++;
      miss = 0;
      testing = false;
    }
    else if(trial%2 == 0){
       miss++; 
    }
  }
}

void hit(){
  String condition = "normal";
  if(bubbleCursor)
    condition = "bubble";
  
  println(id + "\t" + count + "\t" + condition + "\t" + (endMil - startMil) + "\t" + miss + "\t" + (int)Math.round(Math.sqrt(Math.pow(targetX - lastX, 2) + Math.pow(targetY - lastY, 2))));
}
