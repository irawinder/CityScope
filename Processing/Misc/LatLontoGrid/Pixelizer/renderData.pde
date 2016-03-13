PGraphics h, s, l, i;

// 2D matrix that holds grid values
float heatmap[][], stores[][];
// variables to hol minimum and maximum grid values in matrix
float heatmapMIN, heatmapMAX;
float storesMIN, storesMAX;

//JSON array holding totes
JSONArray array;

void initDataGraphics() {
  h = createGraphics(width, height);
  s = createGraphics(width, height);
  l = createGraphics(width, height);
  i = createGraphics(width, height);
}

void reRender() {
  
  // Renders false color heatmap to canvas
  renderData(h, s);
  
  // Renders Outlines of Lego Data Modules (a 4x4 lego stud piece)
  renderLines(l);
  
  // Renders Text
  renderInfo(i);
  
  mapPan();
  
  println("ReRendered");
}

// Runs once when initializes
void loadPixelData() {
  
  array = loadJSONArray("data/" + fileName + "_" + valueMode + ".json");
  
  heatmap = new float[gridU][gridV];
  stores = new float[gridU][gridV];
  for (int u=0; u<gridU; u++) {
    for (int v=0; v<gridV; v++) {
      heatmap[u][v] = 0;
      stores[u][v] = 0;
    }
  }
  
  // MIN and MAX set to arbitrarily large and small values
  heatmapMIN = 100000;
  heatmapMAX = 0;
  
  // MIN and MAX set to arbitrarily large and small values
  storesMIN = 100000;
  storesMAX = 0;
  
  JSONObject temp = new JSONObject();
  for (int i=0; i<array.size(); i++) {
    try {
      temp = array.getJSONObject(i);
    } catch(RuntimeException e) {
    }
    heatmap[temp.getInt("u")][temp.getInt("v")] = temp.getInt(valueMode);
    stores[temp.getInt("u")][temp.getInt("v")] = temp.getInt("store");
  }
  
  for (int u=0; u<gridU; u++) {
    for (int v=0; v<gridV; v++) {
      
      // each cell in the heatmap randomly assigned a vlue between 0 and 178
      // This is a placeholder that should eventually hold real data (i.e. number of totes)
      //heatmap[u][v] = random(0, 178);
      
      if (heatmap[u][v] != 0) { // 0 is usually void, so including it will skew our color gradient
        // Checks if smallest value thusfar
        if (heatmap[u][v] < heatmapMIN) {
          heatmapMIN = heatmap[u][v]; }
        // Checks if largest value thusfar
        if (heatmap[u][v] > heatmapMAX) {
          heatmapMAX = heatmap[u][v]; }
      }
        
      // Checks if smallest value thusfar
      if (stores[u][v] < storesMIN) {
        storesMIN = stores[u][v]; }
      // Checks if largest value thusfar
      if (stores[u][v] > storesMAX) {
        storesMAX = stores[u][v]; }
    }
  }
  
  // Prints largest and smallest values to console
  println("Maximum Value: " + heatmapMAX);
  println("Minimum Value: " + heatmapMIN);
  
}

// Draws false color heatmap to canvas
void renderData(PGraphics h, PGraphics s) {
  
  // Dynamically adjusts grid size to fit within canvas dimensions
  float gridWidth = float(width)/displayU;
  float gridHeight= float(height)/displayV;
  
  // clear canvases
  h.beginDraw();
  h.clear();
  
  s.beginDraw();
  s.clear();
  
  // makes it so that colors are defined by Hue, Saturation, and Brightness values (0-255 by default)
  h.colorMode(HSB);
  s.colorMode(HSB);
  
  for (int u=0; u<displayU; u++) {
    for (int v=0; v<displayV; v++) {
      
      float normalized;
      
      // Draw Heatmap
      try {
        // heatmap value is normalized to a value between 0 and 1;
        normalized = (heatmap[u + gridPanU][v + gridPanV] - heatmapMIN)/(heatmapMAX-heatmapMIN);
      } catch(Exception ex) {
        normalized = (0 - heatmapMIN)/(heatmapMAX-heatmapMIN);
      }
      
      // Hue Color of the grid is function of heatmap value;
      // 0.25 coefficient narrows the range of colors used
      // 100 + var offsets the range of colors used
      
      if (valueMode.equals("totes") || valueMode.equals("deliveries") ) {
        // Narrower Color Range
        h.fill(0.75*255*(1-normalized), 255, 255, 150);
      } else if (valueMode.equals("source") || valueMode.equals("doorstep") ) {
        // Less Narrower Color Range
        h.fill(0.75*255*normalized, 255, 255, 150);
      } else {
        // Full Color Range
        h.fill(255*normalized, 255, 255, 150);
      }
      // No lines draw around grid cells
      h.noStroke();
      
      // Doesn't draw a rectangle for values of 0
      if (normalized >= 0) {
        h.rect(u*gridWidth, v*gridHeight, gridWidth, gridHeight);
      }
      
      // Draws Store Locations
      try {
        // heatmap value is normalized to a value between 0 and 1;
        normalized = (stores[u + gridPanU][v + gridPanV] - storesMIN)/(storesMAX-storesMIN);
      } catch(Exception ex) {
        normalized = (0 - storesMIN)/(storesMAX-storesMIN);
      }
    
      // Full Color Range
      s.fill(255*normalized, 255, 255, 255);
      
      //Outlines stores
      s.strokeWeight(1);
      s.stroke(textColor);
      
      // Doesn't draw a rectangle for values of 0
      if (normalized != 0) {
        s.rect(u*gridWidth, v*gridHeight, gridWidth, gridHeight);
      }
    }
  }
  h.endDraw();
  s.endDraw();
}

// Draws Outlines of Lego Data Modules (a 4x4 lego stud piece)
void renderLines(PGraphics l) {
  l.beginDraw();
  l.clear();
  l.stroke(255, 50);
  l.strokeWeight(1.5);
  for (int i=1; i<displayU/4; i++) {
    l.line(width*i/(displayU/4.0), 0, width*i/(displayU/4.0), height);
  }
  for (int i=1; i<displayV/4; i++) {
    l.line(0, height*i/(displayV/4.0), width, height*i/(displayV/4.0));
  }
  l.endDraw();
}

void renderInfo(PGraphics i) {
  i.beginDraw();
  i.clear();
  i.fill(textColor);
  
  i.textAlign(RIGHT);
  i.text("Pixelizer v1.0 by Ira Winder, jiw@mit.edu", width - 10, height - 15);
  
  if (showMainMenu) {
    i.textAlign(LEFT);
    String suffix = "";
    String prefix = "";
    if (valueMode.equals("totes") || valueMode.equals("deliveries") ) {
      suffix = " " + valueMode;
    } else if ( valueMode.equals("source") ) {
      prefix = "StoreID ";
    }  else if ( valueMode.equals("doorstep") ) {
      suffix = " seconds";
    }
    i.text("Grid Stats", 10, height - 75);
    i.text("Min: " + prefix + (int)heatmapMIN + suffix, 10, height - 60);
    i.text("Max: " + prefix + (int)heatmapMAX + suffix, 10, height - 45);
    i.text(fileName + ": 1 grid square = " + gridSize + "km", 10, height - 15);
  }
  i.endDraw();
}
