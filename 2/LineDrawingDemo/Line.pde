public class Line{
 public float x1, y1, x2, y2;
 
 public Line(float x1, float y1, float x2, float y2){
    this.x1 = x1;
    this.x2 = x2;
    this.y1 = y1;
    this.y2 = y2;
 }
 
 public void draw()
 {
   println("drawing line");
  line(x1, y1, x2, y2); 
 }
}
