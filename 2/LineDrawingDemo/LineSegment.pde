public class LineSegment{
  private ArrayList<Line> lines;
  
  public LineSegment()
  {
     lines = new ArrayList<Line>();
  }
  
  public ArrayList<Line> getLines()
  {
     return lines; 
  }
  
  public void draw()
  {
       println("drawing segment");

     for (Line l : lines)
     {
       l.draw(); 
     }
  }
}
