// Set this to false if you know that you don't need to regenerate 
// data every time Software is run

// 0 = Denver
// 1 = San Jose
int modeIndex = 0;

boolean pixelizeData = true;

void setup() {
  size(canvasWidth, canvasHeight);
  
  // Window may be resized after initialized
  frame.setResizable(true);
  
  load();
}

void draw() {

  renderBasemap();
  
  // Draws false color heatmap to canvas
  renderData();
  
  renderLines();
  //save("data/" + fileName + ".png");
}

void keyPressed() {
  switch(key) {
    case 'm': 
      modeIndex = next(modeIndex, 1);
      load();
      break;
  }
}

int next(int index, int max) {
  if (index == max) {
    index = 0;
  } else {
    index ++;
  }
  println(index);
  return index;
}

void load() {
  
  switch(modeIndex) {
    case 0:
      denverMode();
      break;
    case 1:
      sanjoseMode();
      break;
  }
  
  if (pixelizeData) {
    pixelizeData();
  }
  
  loadPixelData();
  loadBasemap();
  
}
    
    
  
