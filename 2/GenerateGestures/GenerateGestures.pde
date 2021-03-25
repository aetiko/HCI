//
// A simple tool for creating training data compatible with the $1 Unistroke Recognizer.
//
// Usage:
//    1. Draw a gesture anywhere within the application window by clicking and dragging the mouse
//    2. When mouse button is released, application window will close and training data will appear in console window
//    3. Copy and paste the training data into the One.learn() method in your drawing application. For example:
//        one.learn("myGesture", new int[] {<paste data here>});
//

ArrayList<PVector> points;


void setup(){
  size(500, 500);
  points = new ArrayList<PVector>();
}

void draw(){
  background(255);
  fill(0);
  text("Draw a gesture anywhere in the window.", 10, 20);
  stroke(0);
  for (PVector p : points) {
    point(p.x,p.y);
  }
}


void mouseDragged(){
  points.add(new PVector(mouseX, mouseY));
}

void mouseReleased(){
  for (PVector p : points) {
    print(int(p.x) + "," + int(p.y) + ",");
  }
  println();
  exit();
}
