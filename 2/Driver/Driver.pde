/* Ayoola & Brandon - HCI Assignment 2 */ //<>//
import static javax.swing.JOptionPane.*;
import java.util.*;

int scheme = 0; //The scheme in use. 0 for scheme 1 (Cycling), 1 for scheme 2 (Shortcuts)
PShape[] ui = new PShape[3]; //UI Squares
int shapeSel = 0; //The currently selected shape. 0 = Freeform line, 1 = Straight Line, 2 = Rectangle, 3 = Oval
int colorSel = 0; //The currently selected color. 0 = Black, 1 = Red, 2 = Green, 3 = Blue
int weightSel = 0; //The currently selected weight. 0 = Thin, 1 = Medium, 2 = Thick

color white = color(255, 255, 255);
color black = color(0.39, 5.31, 7.45);
color red = color(255, 0, 0);
color green = color(0, 255, 0);
color blue = color(0, 0, 255);

color[] colors = new color[4]; //An array of the 4 color options

int weightSizes[] = new int [3];

boolean undo = false; //Whether the user has pressed backspace to undo

PShape shapes; //The current shape the user is drawing
LinkedList<PShape> allShapes = new LinkedList<PShape>();

boolean ctrl = false; //Whether or not ctrl is being held
boolean shift = false; //Whether or not shift is being held
boolean alt = false; //Whether or not alt is being held
boolean s = false; //Whether or not s is being held (For scheme 2)
boolean c = false; //Whether or not c is being held (For scheme 2)
boolean w = false; //Whether or not w is being held (For scheme 2)
boolean drawing = false; //Whether or not the user is currently drawing a shape

int prevX = 0;
int prevY = 0;

void setup(){
  size(1920, 1080);
  colors[0] = black;
  colors[1] = red;
  colors[2] = green;
  colors[3] = blue;
  
  weightSizes[0] = 1; //
  weightSizes[1] = 4;
  weightSizes[2] = 10;
  
  ui[0] = createShape(RECT, 1590, 0 , 100, 50); //Shape
  ui[0].setFill(colors[2]);
  ui[1] = createShape(RECT, 1700 , 0 , 100, 50); //Color
  ui[1].setFill(colors[colorSel]);
  ui[2] = createShape(RECT, 1810, 0 , 100, 50); //Weight
  ui[2].setFill(black);
  
  //showConfirmDialog(null, "Welcome To Gestures and Short Cuts", "Assignment 2", DEFAULT_OPTION);
}

void draw(){
  clear();
  background(white);
  stroke(255);
  
  if(undo && allShapes.size() > 0){ //Undo if there is something to undo
    undo = false;
    allShapes.removeLast();
  }else{
    undo = false;
  }
  
  if(allShapes.size() > 0){
    for(int i = 0; i < allShapes.size(); i++){
      shape(allShapes.get(i));
    }
  }
  drawUI();
  
  if(mousePressed == true){
    if(!drawing){
       prevX = mouseX;
       prevY = mouseY;
    }
    drawing = true;
      //not sure how to make free flowing line
    switch(shapeSel){
      case 0: //Freeform Line
        stroke(colors[colorSel]);
        strokeWeight(weightSizes[weightSel]);
        shapes = createShape(LINE, prevX, prevY, mouseX, mouseY);
        shape(shapes);
        break;
      case 1: //Straight Line
        stroke(colors[colorSel]);
        strokeWeight(weightSizes[weightSel]);
        shapes = createShape(LINE, prevX+100, prevY, mouseX, mouseY);
        shape(shapes);
        break;
      case 2: //Rectangle
        strokeWeight(weightSizes[weightSel]);
        shapes = createShape(RECT, prevX, prevY, (prevX-mouseX)*-1, (prevY-mouseY)*-1);
        shapes.setFill(colors[colorSel]);
        shape(shapes);
        break;
      case 3: //Oval
        fill(white);
        strokeWeight(weightSizes[weightSel]);
        shapes = createShape(ELLIPSE, prevX, prevY, (prevX-mouseX)*-1, (prevY-mouseY)*-1);
        shapes.setFill(colors[colorSel]);
        shape(shapes);
    }
  }else{ //If the mouse is not pressed
    if (drawing){ //If the user was just drawing a shape, then add the shape to the stack
      drawing = false;
      fill(white); //Ensures boxes are white in the middle
      switch(shapeSel){
        case 0: //Freeform Line
          stroke(colors[colorSel]);
          strokeWeight(weightSizes[weightSel]);
          allShapes.addLast(createShape(LINE, prevX, prevY, mouseX, mouseY));
          break;
        case 1: //Straight Line
          stroke(colors[colorSel]);
          strokeWeight(weightSizes[weightSel]);
          allShapes.addLast(createShape(LINE, prevX+100, prevY, mouseX, mouseY));
          break;
        case 2: //Rectangle
          stroke(colors[colorSel]);
          strokeWeight(weightSizes[weightSel]);
          allShapes.addLast(createShape(RECT, prevX, prevY, (prevX-mouseX)*-1, (prevY-mouseY)*-1));
          allShapes.peek().setFill(255);
          break;
        case 3: //Oval
          stroke(colors[colorSel]);
          strokeWeight(weightSizes[weightSel]);
          allShapes.addLast(createShape(ELLIPSE, prevX, prevY, (prevX-mouseX)*-1, (prevY-mouseY)*-1));
          allShapes.peek().setFill(255);
      }
    }
  }
}

void drawUI(){
  shape(ui[0], 0, 5); //Shape
  ui[0].setFill(white);
  shape(ui[1], 0, 5); //Color
  ui[1].setFill(colors[colorSel]);
  shape(ui[2], 0, 5); //Weight
  ui[2].setFill(white);
  fill(black);
  switch(shapeSel){ //Show user what shape is selected
    case 0:
      text("Freeform Line", 1600, 36);
      break;
    case 1:
      text("Straight Line", 1604, 36);
      break;
    case 2:
      text("Rectangle", 1612, 36);
      break;
    case 3:
      text("Oval", 1623, 36);
  }
  switch(weightSel){ //Show user what weight is selected
    case 0:
      text("Thin", 1845, 36);
      break;
    case 1:
      text("Medium", 1840, 36);
      break;
    case 2:
      text("T H I C C", 1838, 36);
  }
  if(scheme == 0){ //Scheme 1 (Cycling)
    text("Cycle through selections with the designated keys.", 1603, 88);
    text("S", 1635, 70);
    text("C", 1745, 70);
    text("W", 1855, 70);
    text("Scheme 1", 1530, 17);
  }else{ //Scheme 2 (Shortcuts)
    checkKeys();
    text("S / CTRL+S / Shift+S / Alt+S", 1660, 88);
    text("C / CTRL+C / Shift+C / Alt+C", 1660, 103);
    text("W / CTRL+W / Shift+W", 1674, 118);
    text("S", 1635, 70);
    text("C", 1745, 70);
    text("W", 1855, 70);
    text("Scheme 2", 1530, 17);
  }
}

void checkKeys(){ //Checks the scheme 2 keys to see if they are being held
  if (ctrl && s){
      shapeSel = 1; //1: Straight Line
    }
    if (ctrl && c){
      colorSel = 1; //1: Red
    }
    if (ctrl && w){
      weightSel = 1; //1: Medium
    }
    /*----------------------------------------------------------------------*/
    if (shift && s){
       shapeSel = 2; //2: Rectangle
    }
    if (shift && c){
       print("Butts");
       colorSel = 2; //2: Green
    }
    if (shift && w){
       weightSel = 2; //2: T H I C C
    }
    /*----------------------------------------------------------------------*/
    if (alt && s){
      shapeSel = 3; //3: Oval
    }
    if (alt && c){
      shapeSel = 3; //3: Blue
    }
}

void keyPressed() {
  if (char(keyCode) == 's' || char(keyCode) == 'S'){
    if(scheme == 0){ //Wrapping code for shape selection
       if(shapeSel == 3){
         shapeSel = 0; //0: Freeform Line
       }else if(shapeSel == 0){
         shapeSel = 1; //1: Straight Line
       }else if(shapeSel == 1){
         shapeSel = 2; //2: Rectangle
       }else{
         shapeSel = 3; //3: Oval 
       }
    }else{ //Shortcut code for color selection
      shapeSel = 0; //0: Black
    }
  }
  
  if (char(keyCode) == 'c' || char(keyCode) == 'C'){
    if(scheme == 0){ //Wrapping code for color selection
       if(colorSel == 3){
         colorSel = 0; //0: Black
       }else if(colorSel == 0){
         colorSel = 1; //1: Red
       }else if(colorSel == 1){
         colorSel = 2; //2: Green
       }else{
         colorSel = 3; //3: Blue
       }
    }else{ //Shortcut code for color selection
      colorSel = 0; //0: Black
    }
  }
  
  if (char(keyCode) == 'w' || char(keyCode) == 'W'){
     if(scheme == 0){ //Wrapping code for weight selection
       if(weightSel == 2){
         weightSel = 0; //0: Thin
       }else if(weightSel == 0){
         weightSel = 1; //1: Medium
       }else{
         weightSel = 2; //2: T H I C C
       }
    }else{ //Shortcut code for color selection
      weightSel = 0; //0: Black
    }
  }
  
  if(scheme == 1){
    if (keyCode == CONTROL){
      ctrl = true;
    }
    if (keyCode == SHIFT){
      shift = true;
    }
    if (keyCode == ALT){
      alt = true;
    }
    
    if(char(keyCode) == 's' || char(keyCode) == 'S'){
      s = true;
    }
    if(char(keyCode) == 'c' || char(keyCode) == 'C'){
      c = true;
    }
    if(char(keyCode) == 'w' || char(keyCode) == 'W'){
      w = true;
    }
  }
  
  if (keyCode == BACKSPACE){
    undo = true;
  }
  
  if (keyCode == ENTER){
    if(scheme == 0){
      scheme = 1;
    }else{
      scheme = 0; 
    }
  }
}

void keyReleased(){
  if (keyCode == CONTROL){
    ctrl = false;
  }
  if (keyCode == SHIFT){
    shift = false;
  }
  if (keyCode == ALT){
    alt = false;
  }
  if(char(keyCode) == 's' || char(keyCode) == 'S'){
    s = false;
  }
  if(char(keyCode) == 'c' || char(keyCode) == 'C'){
    c = false;
  }
  if(char(keyCode) == 'w' || char(keyCode) == 'W'){
    w = false;
  }
}
