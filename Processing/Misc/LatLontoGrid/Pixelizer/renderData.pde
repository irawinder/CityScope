// 2D matrix that holds grid values
float matrix[][];
// variables to hol minimum and maximum grid values in matrix
float matrixMIN, matrixMAX;

//JSON array holding totes
JSONArray array;
// JSONObject temp;

// Runs once when initializes
void loadPixelData() {
  
  array = loadJSONArray("data/" + fileName + "_totes.json");
  
  println(fileName);
  matrix = new float[gridU][gridV];
  for (int u=0; u<gridU; u++) {
    for (int v=0; v<gridV; v++) {
      matrix[u][v] = 0;
    }
  }
  
  // MIN and MAX set to arbitrarily large and small values
  matrixMIN = 100000;
  matrixMAX = 0;
  
  for (int i=0; i<array.size(); i++) {
    try {
      temp = array.getJSONObject(i);
    } catch(RuntimeException e) {
    }
    matrix[temp.getInt("u")][temp.getInt("v")] = temp.getInt("totes");
  }
  
  for (int u=0; u<gridU; u++) {
    for (int v=0; v<gridV; v++) {
      
      // each cell in the MAtrix randomly assigned a vlue between 0 and 178
      // This is a placeholder that should eventually hold real data (i.e. number of totes)
      //matrix[u][v] = random(0, 178);
      
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

// Draws false color heatmap to canvas
void renderData() {
  
  // Dynamically adjusts grid size to fit within canvas dimensions
  float gridWidth = float(width)/gridU;
  float gridHeight= float(height)/gridV;
  
  // No lines draw around grid cells
  noStroke();
  
//  // Stroke color set to balck, "0"
//  stroke(0);
//
//  // Stroke is 2 pixel wide (i.e. polylines)
//  strokeWeight(1);
  
  // makes it so that colors are defined by Hue, Saturation, and Brightness values (0-255 by default)
  colorMode(HSB);
  
  for (int u=0; u<gridU; u++) {
    for (int v=0; v<gridV; v++) {
      
      // Matrix value is normalized to a value between 0 and 1;
      float normalized = (matrix[u][v] - matrixMIN)/(matrixMAX-matrixMIN);
      
      // Hue Color of the grid is function of matrix value;
      // 0.25 coefficient narrows the range of colors used
      // 100 + var offsets the range of colors used
      //fill(100 + 0.25*255*normalized, 255, 255, 50);
      
      fill(100 + 0.5*255*normalized, 255, 255, 100);
      
      if (normalized == 0) {
        noFill();
      }
      
//      if (normalized > 0) {
//        fill(255/2, 255, 255, 50);
//      } else {
//        fill(0, 255, 255, 50);
//      }
      
      // Draws a grid cell
      rect(u*gridWidth, v*gridHeight, gridWidth, gridHeight);
      
    }
  }
}

// Draws Outlines of Lego Data Modules (a 4x4 lego stud piece)
void renderLines() {
  stroke(255, 50);
  strokeWeight(1.5);
  for (int i=1; i<gridU/4; i++) {
    line(width*i/(gridU/4.0), 0, width*i/(gridU/4.0), height);
  }
  for (int i=1; i<gridV/4; i++) {
    line(0, height*i/(gridV/4.0), width, height*i/(gridV/4.0));
  }
}
