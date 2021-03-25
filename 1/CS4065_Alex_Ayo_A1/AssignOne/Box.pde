 class Box { //<>// //<>//
  PShape rects;
  
  float x, y, w, h;
  float cx, cy;
  float cxz = -300;
  float cyz = 150;
  
  int size, index, blockNum, totalTrialNumber, restMode;
  
  int chosenRect = -1;
  int curChosenX, curChosenY, offsetX, offsetY;
  
  color fillColor, textColor, redColor;
  
    public Box(float newX, float newY, float newW, float newH) { 
    x = newY;
    y = newX;
    w = newW;
    h = newH;
    cx = newX + w/2;
    cy = newY + h/2; 
    size = 1;
    fillColor = color(0,0,255);
    textColor = color(0, 0, 0);
    redColor = color(255, 0, 0);
  }
  
  void mainRect(boolean startedBlock){
    pushMatrix();
    translate(cx, cy);
    scale(size);
    fill(redColor);
    rect(x,y,w,h);
    fill(textColor);
    if(startedBlock){
      text("Start", x+63, y+30);
    } else {
      text("Start Block", x+45, y+30);
    };
    popMatrix();
  }
  //to check if mouse is outside the triangle
  boolean outsideRectangle() {
  if (mouseX < x || mouseX > x+w || mouseY < y || mouseY > y+h){
    return true;
  }
  else {
    return false;
  }
}
  
  void rectDraw(int blockNumber, boolean startedBlock){
    index = 2;
    blockNum = 2;
    mainRect(startedBlock);
       if(index == 2){
        fill(fillColor);
        for(int i=0; i<2; i++){
          pushMatrix();
          translate(0, cy);
          scale(size);
          //rect(x+(600*i)-50,y,w,h);
          
          if((i == 0 && chosenRect == 0) || (chosenRect == 1 && i == 1)) {
            fill(color(255,255,0));
            rects = createShape(RECT,x+(600*i)-50,y,w,h);
                        
            curChosenX = int(x+(600*i)-50);
            curChosenY = int(y);
            offsetX = 0;
            offsetY = int(cy);
            
            shape(rects);
            fill(fillColor);
          } else {
            rects = createShape(RECT,x+(600*i)-50,y,w,h);
            shape(rects);
          }
          
          translate(cx, 0);
          
          if((i == 0 && chosenRect == 2) || (chosenRect == 3 && i == 1) && blockNumber != 0) {
            fill(color(255,255,0));
            rects = createShape(RECT,x,y+(400*i)-200,w,h);
                        
            curChosenX = int(x);
            curChosenY = int(y+(400*i)-200);
            offsetX = int(cx);
            offsetY = 0;
            
            shape(rects);
            fill(fillColor);
          } else if(blockNumber != 0) {
            rects = createShape(RECT,x,y+(400*i)-200,w,h);
            shape(rects);
          }
          
          translate(0, cyz);
          
          if((i == 0 && chosenRect == 4) || (chosenRect == 5 && i == 1) && blockNumber != 0 && blockNumber != 1) {
            fill(color(255,255,0));
            rects = createShape(RECT,x+(500*i)-250,y,w,h);
                        
            curChosenX = int(x+(500*i)-250);
            curChosenY = int(y);
            offsetX = 0;
            offsetY = int(cyz);
            
            shape(rects);
            fill(fillColor);
          } else if(blockNumber != 0 && blockNumber != 1) {
            rects = createShape(RECT,x+(500*i)-250,y,w,h);
            shape(rects);
          }
          
          translate(0, cxz);
          
          if((i == 0 && chosenRect == 6) || (chosenRect == 7 && i == 1) && blockNumber != 0 && blockNumber != 1) {
            fill(color(255,255,0));
            rects = createShape(RECT,x+(500*i)-250,y,w,h);
                        
            curChosenX = int(x+(500*i)-250);
            curChosenY = int(y);
            offsetX = 0;
            offsetY = int(cxz);
            
            shape(rects);
            fill(fillColor);
          } else if(blockNumber != 0 && blockNumber != 1) {
            rects = createShape(RECT,x+(500*i)-250,y,w,h);
            shape(rects);
          }
          
          popMatrix();
        }
      }
  }
  
  void setRandomChosen(int rand) {
    chosenRect = rand;
  }
  
  boolean checkIfOverChosen(int mX, int mY){
    loadPixels();
    if (red(get().pixels[mX + mY * width]) == 255.0 && green(get().pixels[mX + mY * width]) == 255.0 && blue(get().pixels[mX + mY * width]) == 0.0){
      return true;
    } else {
      return false;
    } //<>//
  }
  
  boolean checkIfStartClick(int mX, int mY){
    loadPixels();
    if (red(get().pixels[mX + mY * width]) == 255.0 && green(get().pixels[mX + mY * width]) == 0.0 && blue(get().pixels[mX + mY * width]) == 0.0){
      return true;
    } else {
      return false;
    }
  }
}
