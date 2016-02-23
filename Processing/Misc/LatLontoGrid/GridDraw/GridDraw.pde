// How big your applet window is, in pixels
int canvasWidth = 500;
int canvasHeight = 500;

// how many grid squares you are visualizing
int gridU = 100;
int gridV = 100;

// 2D matrix that holds grid values
float matrix[][];
// variables to hol minimum and maximum grid values in matrix
float matrixMIN, matrixMAX;

// Runs once when initializes
void setup() {
  size(canvasWidth, canvasHeight);
  
  // Window may be resized after initialized
  frame.setResizable(true);
  
  matrix = new float[gridU][gridV];
  // MIN and MAX set to arbitrarily large and small values
  matrixMIN = 100000;
  matrixMAX = 0;
  
  for (int u=0; u<gridU; u++) {
    for (int v=0; v<gridV; v++) {
      
      // each cell in the MAtrix randomly assigned a vlue between 0 and 178
      // This is a placeholder that should eventually hold real data (i.e. number of totes)
      matrix[u][v] = random(0, 178);
      
      // Checks if smallest value thusfar
      if (matrix[u][v] < matrixMIN) {
        matrixMIN = matrix[u][v];
      }
      
      // Checks if largest value thusfar
      if (matrix[u][v] > matrixMAX) {
        matrixMAX = matrix[u][v];
      }
      
    }
  }
  
  // Prints largest and smallest values to console
  println("Maximum Value: " + matrixMAX);
  println("Minimum Value: " + matrixMIN);
  
}

// runs every frame
void draw() {
  
  // Dynamically adjusts grid size to fit within canvas dimensions
  float gridWidth = float(width)/gridU;
  float gridHeight= float(height)/gridV;
  
  // Stroke color set to balck, "0"
  stroke(0);
  
  // Stroke is 2 pixel wide (i.e. polylines)
  strokeWeight(1);
  
  // makes it so that colors are defined by Hue, Saturation, and Brightness values (0-255 by default)
  colorMode(HSB);
  
  for (int u=0; u<gridU; u++) {
    for (int v=0; v<gridV; v++) {
      
      // Matrix value is normalized to a value between 0 and 1;
      float normalized = (matrix[u][v] - matrixMIN)/(matrixMAX-matrixMIN);
      
      // Hue Color of the grid is function of matrix value;
      // 0.25 coefficient narrows the range of colors used
      // 100 + var offsets the range of colors used
      fill( 100 + 0.25*255*normalized, 255, 255);
      
      // Draws a grid cell
      rect(u*gridWidth, v*gridHeight, gridWidth, gridHeight);
      
    }
  }

}
