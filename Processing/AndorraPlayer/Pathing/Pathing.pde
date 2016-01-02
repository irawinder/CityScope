PGraphics tableCanvas;
int textColor = 50;
ObstacleCourse boundaries = new ObstacleCourse();
ObstacleCourse container = new ObstacleCourse();

void setup() {
  tableCanvas = createGraphics(1000, 500);
  size(tableCanvas.width, tableCanvas.height);
  
  initPathfinder(tableCanvas, 20);
}

void draw() {
  
  tableCanvas.beginDraw();
  tableCanvas.background(0);
  
  drawPathfinder(tableCanvas);
  
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

void keyPressed() {
  switch(key) {
    case 'X':
      pathTest(tableCanvas, finderTest);
      break;
  }
}
