PGraphics screen, projector, table;
PGraphics h, s, l, i, c, p;
float gridWidth, gridHeight;

int tabley_0 = 50;
int tablex_0 = 50;
int tabley_1, tablex_1;

// 2D matrix that holds grid values
float heatmap[][], stores[][], pop[][], hu[][];
// variables to hol minimum and maximum grid values in matrix
float heatmapMIN, heatmapMAX;
float storesMIN, storesMAX;
float popMIN, popMAX;
float huMIN, huMAX;

//JSON array holding totes
JSONArray array;

//Table holding Population Counts and Housing Units (created from GridResampler)
Table popCSV, huCSV;

void initScreenOffsets() {
  screenWidth = width;
  screenHeight = height;
  screen = createGraphics(screenWidth, screenHeight);
  i = createGraphics(screenWidth, screenHeight);
         
  tabley_1 = screenHeight - 2*tabley_0;
  tablex_1 = int(((float)displayU/displayV)*tabley_1);
}

void initDataGraphics() {
  projector = createGraphics(projectorWidth, projectorHeight);
  
  screen = createGraphics(screenWidth, screenHeight);
  i = createGraphics(screen.width, screen.height); // Information
  miniMap = createGraphics(gridU, gridV);

  // Table Layers
  table = createGraphics(tableWidth, tableHeight); // Main Table Canvas
  h = createGraphics(table.width, table.height);   // Heatmap Cells
  p = createGraphics(table.width, table.height);   // Population Cells
  s = createGraphics(table.width, table.height);   // Store Dots
  l = createGraphics(table.width, table.height);   // lines
  c = createGraphics(table.width, table.height);   // Cursor
}

boolean reDraw = true;
void reRender() {
  
  // Renders false color heatmap to canvas
  renderData(h, s, p);
  
  // Renders Outlines of Lego Data Modules (a 4x4 lego stud piece)
  renderLines(l);
  
  // Renders Text
  renderInfo(i, 2*tablex_0 + tablex_1, tabley_0, 0.2*tablex_1, 0.2*tabley_1);
  
  mapPan();
  
  reDraw = true;
}

// Runs once when initializes
void loadPixelData() {
  
  array = loadJSONArray("data/" + fileName + "_" + valueMode + ".json");
  try {
    popCSV = loadTable("data/CSV_POPHU/" + fileName + "_" + popMode + "_" + gridV + "_" + gridU + "_" + int(gridSize*1000) + ".csv");
  }  catch(RuntimeException e) {
    popCSV = new Table();
  }
  
  heatmap = new float[gridU][gridV];
  stores = new float[gridU][gridV];
  pop = new float[gridU][gridV];
  for (int u=0; u<gridU; u++) {
    for (int v=0; v<gridV; v++) {
      heatmap[u][v] = 0;
      stores[u][v] = 0;
      pop[u][v] = 0;
    }
  }
  
  // MIN and MAX set to arbitrarily large and small values
  heatmapMIN = Float.POSITIVE_INFINITY;
  heatmapMAX = Float.NEGATIVE_INFINITY;
  
  // MIN and MAX set to arbitrarily large and small values
  storesMIN = Float.POSITIVE_INFINITY;
  storesMAX = Float.NEGATIVE_INFINITY;
  
  // MIN and MAX set to arbitrarily large and small values
  popMIN = Float.POSITIVE_INFINITY;
  popMAX = Float.NEGATIVE_INFINITY;
  
  JSONObject temp = new JSONObject();
  for (int i=0; i<array.size(); i++) {
    try {
      temp = array.getJSONObject(i);
    } catch(RuntimeException e) {
    }
    heatmap[temp.getInt("u")][temp.getInt("v")] = temp.getInt(valueMode);
    stores[temp.getInt("u")][temp.getInt("v")] = temp.getInt("store");
  }
  
  for (int i=0; i<popCSV.getRowCount(); i++) {
    for (int j=0; j<popCSV.getColumnCount(); j++) {
      pop[j][i] = popCSV.getFloat(popCSV.getRowCount()-1-i, j);
    }
  }
    
  
  for (int u=0; u<gridU; u++) {
    for (int v=0; v<gridV; v++) {
      
      // each cell in the heatmap randomly assigned a vlue between 0 and 178
      // This is a placeholder that should eventually hold real data (i.e. number of totes)
      //heatmap[u][v] = random(0, 178);
      
      if (heatmap[u][v] != 0) { // 0 is usually void, so including it will skew our color gradient
        heatmapMIN = min(heatmapMIN, heatmap[u][v]);
        heatmapMAX = max(heatmapMAX, heatmap[u][v]);
      }
        
      storesMIN = min(storesMIN, stores[u][v]);
      storesMAX = max(storesMAX, stores[u][v]);
      
      if (pop[u][v] != 0) { // 0 is usually void, so including it will skew our color gradient
        popMIN = min(popMIN, pop[u][v]);
        popMAX = max(popMAX, pop[u][v]);
      }
    }
  }
  
  // Prints largest and smallest values to console
  println("Maximum Value: " + heatmapMAX);
  println("Minimum Value: " + heatmapMIN);
  
}

// Draws false color heatmap to canvas
void renderData(PGraphics h, PGraphics s, PGraphics p) {
  
  // Dynamically adjusts grid size to fit within canvas dimensions
  gridWidth = float(table.width)/displayU;
  gridHeight= float(table.height)/displayV;
  
  // clear canvases
  h.beginDraw();
  h.clear();
  
  s.beginDraw();
  s.clear();
  
  p.beginDraw();
  p.clear();
  
  // makes it so that colors are defined by Hue, Saturation, and Brightness values (0-255 by default)
  h.colorMode(HSB);
  s.colorMode(HSB);
  p.colorMode(HSB);
  
  for (int u=0; u<displayU; u++) {
    for (int v=0; v<displayV; v++) {
      // Only loads data within bounds of dataset
      if (u+gridPanU>=0 && u+gridPanU<gridU && v+gridPanV>=0 && v+gridPanV<gridV) {
        float normalized;
        color from, to; 
        
        // HEATMAP
        normalized = findHeatmapFill(h, u+gridPanU, v+gridPanV);
        // Doesn't draw a rectangle for values of 0
        h.noStroke(); // No lines draw around grid cells
        if (normalized >= 0) {
          h.rect(u*gridWidth, v*gridHeight, gridWidth, gridHeight);
        }
        
        // POPULATION
        if (pop[u+gridPanU][v+gridPanV] > 10.0*sq(gridSize)) {
          normalized = findPopFill(p, u+gridPanU, v+gridPanV);
          // Doesn't draw a rectangle for values of 0
          p.noStroke(); // No lines draw around grid cells
          p.rect(u*gridWidth, v*gridHeight, gridWidth, gridHeight);
        }
        
        //STORES
        normalized = findStoreFill(s, u+gridPanU, v+gridPanV);
        //Outlines stores
        s.strokeWeight(2);
        s.stroke(textColor);
        // Doesn't draw a rectangle for values of 0
        if (normalized != 0) {
          s.ellipse((u+.5)*gridWidth, (v+.5)*gridHeight, 0.75*gridWidth, 0.75*gridHeight);
        }
      }
    }
  }
  h.endDraw();
  s.endDraw();
  p.endDraw();
}

float findHeatmapFill(PGraphics graphic, int u, int v) {
    float normalized;
    color from, to;        
    
    //BEGIN Drawing HEATMAP
    from = color(0,255,0);
    to = color(255,0,0);
    
    // Draw Heatmap
    try {
      // heatmap value is normalized to a value between 0 and 1;
      normalized = (heatmap[u][v] - heatmapMIN)/(heatmapMAX-heatmapMIN);
    } catch(Exception ex) {
      normalized = (0 - heatmapMIN)/(heatmapMAX-heatmapMIN);
    }
    
    // Hue Color of the grid is function of heatmap value;
    // 0.25 coefficient narrows the range of colors used
    // 100 + var offsets the range of colors used
    
    if (valueMode.equals("totes") || valueMode.equals("deliveries")) {
      // Narrower Color Range
      graphic.fill(0.75*255*(1-normalized), 255, 255, 150);
      graphic.stroke(0.75*255*(1-normalized), 255, 255, 150);
    } else if (valueMode.equals("source")) {
      // Less Narrower Color Range
      graphic.fill(0.75*255*normalized, 255, 255, 150);
      graphic.stroke(0.75*255*normalized, 255, 255, 150);
    } else if (valueMode.equals("doorstep")) {
      // Less Narrower Color Range, reversed
      graphic.fill(lerpColor(from,to,normalized), 150);
      graphic.stroke(lerpColor(from,to,normalized), 150);
    } else {
      // Full Color Range
      graphic.fill(255*normalized, 255, 255, 150);
      graphic.stroke(255*normalized, 255, 255, 150);
    }
    
    return normalized;
}

float findPopFill(PGraphics graphic, int u, int v) {
    float normalized;
    color from, to;  
    
    //BEGIN Drawing POPULATION
    from = color(#000AF7, 100); // Blue
    to = color(#FF0000);   // Red
    
    // Draw Population
    try {
      // heatmap value is normalized to a value between 0 and 1;
      normalized = ( sqrt(sqrt(pop[u][v])) - sqrt(sqrt(popMIN)))/sqrt(sqrt(popMAX-popMIN));
    } catch(Exception ex) {
      normalized = (0 - popMIN)/(popMAX-popMIN);
    }
    
    // Full Color Range
    //p.fill(255*(1-normalized), 255, 255, 150);
      
    graphic.fill(lerpColor(from,to,normalized));
    graphic.stroke(lerpColor(from,to,normalized));
    
    return normalized;
}

float findStoreFill(PGraphics graphic, int u, int v) {
    float normalized;  
    
    // BEGIN Drawing Draws Store Locations
    try {
      // heatmap value is normalized to a value between 0 and 1;
      normalized = (stores[u][v] - storesMIN)/(storesMAX-storesMIN);
    } catch(Exception ex) {
      normalized = (0 - storesMIN)/(storesMAX-storesMIN);
    }
  
    // Full Color Range
    graphic.fill(255*normalized, 255, 255, 255);
    graphic.stroke(255*normalized, 255, 255, 255);
        
    return normalized;
}

// Draws Outlines of Lego Data Modules (a 4x4 lego stud piece)
void renderLines(PGraphics l) {
  l.beginDraw();
  l.clear();
  l.stroke(255, 50);
  l.strokeWeight(1.5);
  for (int i=1; i<displayU/4; i++) {
    l.line(table.width*i/(displayU/4.0), 0, table.width*i/(displayU/4.0), table.height);
  }
  for (int i=1; i<displayV/4; i++) {
    l.line(0, table.height*i/(displayV/4.0), table.width, table.height*i/(displayV/4.0));
  }
  l.endDraw();
}

void renderInfo(PGraphics i, int x_0, int y_0, float w, float h) {
  i.beginDraw();
  i.clear();
  i.fill(textColor);
  
  i.textAlign(RIGHT);
  i.text("Pixelizer v1.0 by Ira Winder, jiw@mit.edu", screen.width - 10, screen.height - 15);
  

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
  
  i.translate(x_0, 2*y_0 + h + 10);
  
  i.fill(0,255,0);
  String value = "";
  if (showDeliveryData) {
    value = "";
    if ((int)getCellValue(mouseToU(), mouseToV()) == -1) {
      value = "NO_DATA";
    } else {
      value += (int)getCellValue(mouseToU(), mouseToV());
    }
    i.text("Cell Value: " + prefix + value + suffix, 10, 120);
  }
  if (showPopulationData) {
    value = "";
    if ((int)getCellPop(mouseToU(), mouseToV()) == -1) {
      value = "NO_DATA";
    } else {
      value += (int)getCellPop(mouseToU(), mouseToV());
    }
    i.text("Cell Population: " + value + " " + popMode, 10, 135);
  }
  
  i.fill(textColor);
  i.text(fileName.toUpperCase() + " Grid Statistics:", 10, 0);
  i.text("Min Cell Value: " + prefix + (int)heatmapMIN + suffix, 10, 30);
  i.text("Max Cell Value: " + prefix + (int)heatmapMAX + suffix, 10, 45);
  i.text("1 grid square = " + gridSize + "km", 10, 60);
  
  if (showFrameRate) {
    i.text("FrameRate: " + frameRate, 10, 80);
  }
  
  i.endDraw();
  
  
  // Draw MiniMap
  i.beginDraw();
  i.translate(x_0, y_0);  
  i.image(miniMap, 0, 0, w, h);
  i.noFill();
  i.stroke(textColor);
  i.rect(w*gridPanU/gridU, h*gridPanV/gridV, w*(0.5*gridSize), h*(0.5*gridSize));
  

  i.endDraw();
}

// pass 1 to include pan
int mouseToU() {
  return int(displayU*(float)(mouseX - tablex_0)/tablex_1) + gridPanU;   
}

// pass 1 to include pan
int mouseToV() {
  return int(displayV*(float)(mouseY - tabley_0)/tabley_1) + gridPanV;
}

float getCellValue(int u, int v) {
  try {
    return heatmap[u][v];
  }  catch(RuntimeException e) {
    return -1;
  }
}

float getCellPop(int u, int v) {
  try {  
    return pop[u][v];
  }  catch(RuntimeException e) {
    return -1;
  }
}

void renderCursor(PGraphics c) {
  c.beginDraw();
  c.clear();
  c.noFill();
  c.strokeWeight(2);
  
  int x, y;
  
  // Render Mouse
  c.stroke(0, 255, 255);
  x = mouseToU() - gridPanU;
  y = mouseToV() - gridPanV;
  c.rect(x*gridWidth, y*gridWidth, gridWidth, gridWidth);
  
//  // Render Selection
//  c.stroke(0, 255, 0);
//  x = selectionU - gridPanU;
//  y = selectionV - gridPanV;
//  c.rect(x*gridWidth, y*gridWidth, gridWidth, gridWidth);
  
  c.endDraw();
}
