ArrayList<LineSegment> lineSegs = new ArrayList<LineSegment>();

LineSegment currentSeg = null;

void setup() {
  size(640, 360);
}

void draw() {
  clear();
  background(102);
  stroke(255);
    
  for (LineSegment ls : lineSegs)
    ls.draw();
}

void mousePressed(){
   currentSeg = new LineSegment();
   lineSegs.add(currentSeg);
   println("pressed");
}

void mouseDragged(){
  currentSeg.getLines().add(new Line(pmouseX, pmouseY, mouseX, mouseY));
  println("dragged");
}

void mouseReleased(){
   currentSeg = null;
   println("released");

}
