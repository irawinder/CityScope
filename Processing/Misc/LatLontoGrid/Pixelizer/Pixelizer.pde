// Set this to false if you know that you don't need to regenerate 
// data every time Software is run

boolean pixelizeData = true;

void setup() {
  size(canvasWidth, canvasHeight);
  
  // Window may be resized after initialized
  frame.setResizable(true);
  
  if (pixelizeData) {
    pixelizeData();
  }
  
  loadPixelData();
}

void draw() {
  // Draws false color heatmap to canvas
  renderData();
  
  save("data/" + fileName + ".png");
}

