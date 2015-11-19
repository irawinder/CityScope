int canvasWidth = 1000;
int canvasHeight = 1000;

PGraphics tableCanvas;

void setup() {
  size(canvasWidth, canvasHeight);
  
  tableCanvas = createGraphics(canvasWidth, canvasHeight);
    
  init(0, 0);
}

void draw() {
  
  drawAgents();

  image(tableCanvas, 0, 0);
  
  if (showFrameRate) {
    println("frameRate = " + frameRate);
  }
  
}
