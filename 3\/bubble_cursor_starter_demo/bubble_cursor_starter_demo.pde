//to exit click, and press ESC
//sample code to get you started on BubbleCursor

int cursorRadius = 10;

int targetRadius = 20;
int targetCount = 25;
int targetX, targetY; 

PVector[] targets = new PVector[targetCount];

//set to false for normal cursor
boolean bubbleCursor = false;

void setup()
{
  fullScreen();
  noCursor();
   
   
  int i = 0;
  while (i < targetCount)
  {
    
    targetX = (int)(random(width - targetRadius * 2) + targetRadius);
    targetY = (int)(random(height - targetRadius * 2) + targetRadius);
  
    PVector pv = new PVector(targetX, targetY);
    
    targets[i] = pv;
    i++;
  }
}

void draw()
{
  push();  //save current drawing settings
 
  clear();
  stroke(255);

  if (bubbleCursor)
  {
    ellipse(targetX, targetY, targetRadius*2, targetRadius*2);
    double xSquared = Math.pow(mouseX - targetX, 2);
    double ySquared = Math.pow(mouseY - targetY,2);
    cursorRadius = (int) Math.round(Math.sqrt(xSquared + ySquared));
    
    fill(255);
    ellipse(mouseX,mouseY, cursorRadius * 2, cursorRadius * 2);
  }
  
  stroke(40);
  fill(120);
  
  //draw targets
  for (int i = 0; i < targetCount; i++)
    ellipse(targets[i].x, targets[i].y, targetRadius*2, targetRadius*2);
  
  //draw red dot for mouse cursor
  stroke(255);
  fill(255,0,0);
  ellipse(mouseX,mouseY,10,10);
  
  pop();  //restore previous drawing settings
}
