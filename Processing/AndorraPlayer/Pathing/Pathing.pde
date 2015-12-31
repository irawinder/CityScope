PGraphics tableCanvas;
int textColor = 255;
ObstacleCourse boundaries = new ObstacleCourse();

void setup() {
  tableCanvas = createGraphics(1000, 500);
  size(tableCanvas.width, tableCanvas.height);
  
  initPathfinder();
  
}

void draw() {
  
  tableCanvas.beginDraw();
  tableCanvas.background(0);
  drawPathfinder();
  tableCanvas.endDraw();
  
  image(tableCanvas, 0, 0);
  
}

class ObstacleCourse {
  
  ObstacleCourse() {
    
  }
  
  boolean testForCollision(PVector v) {
    return false;
  }
}
