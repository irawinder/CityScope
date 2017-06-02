PGraphics tableCanvas;
int textColor = 255;
int background = 0;
ObstacleCourse boundaries = new ObstacleCourse();
ObstacleCourse container = new ObstacleCourse();

boolean redraw = true;

void setup() {
  tableCanvas = createGraphics(1000, 500);
  size(tableCanvas.width, tableCanvas.height);
  
  initPathfinder(tableCanvas, 20);
}

void draw() {
  
  if (redraw) {
    tableCanvas.beginDraw();
    tableCanvas.background(background);
    tableCanvas.endDraw();
    
    drawPathfinder(tableCanvas);
    
    image(tableCanvas, 0, 0);
    
    redraw = false;
  }
  
}

class ObstacleCourse {
  
  ObstacleCourse() {
    
  }
  
  boolean testForCollision(PVector v) {
    return false;
  }
}
