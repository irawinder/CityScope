PGraphics screen, projector, table;
PGraphics h, s, l, i, c, p;
float gridWidth, gridHeight;
PGraphics legendH, legendP;

int tabley_0 = 25;
int tablex_0 = 25;
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
  
  int legendWidth = 40;
  int legendHeight = 100;
  legendH = createGraphics(legendWidth, legendHeight);
  legendP = createGraphics(legendWidth, legendHeight);
}

boolean reDraw = true;
void reRender() {
  
  // Renders false color heatmap to canvas
  renderData(h, s, p);
  
  // Renders Outlines of Lego Data Modules (a 4x4 lego stud piece)
  renderLines(l);
  
  // Renders Legends
  renderLegends();
  
  // Renders Text
  renderInfo(i, 2*tablex_0 + tablex_1, tabley_0, mapRatio*tablex_1, mapRatio*tabley_1);
  
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
  
//  // Prints largest and smallest values to console
//  println("Maximum Value: " + heatmapMAX);
//  println("Minimum Value: " + heatmapMIN);
  
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
        if (valueMode.equals("source")) {
          normalized = findStoreFill(h, heatmap[u+gridPanU][v+gridPanV]);
          if (normalized == 0) {h.noFill();}
        } else {
          normalized = findHeatmapFill(h, heatmap[u+gridPanU][v+gridPanV]);
        }
        // Doesn't draw a rectangle for values of 0
        h.noStroke(); // No lines draw around grid cells
        if (normalized >= 0) {
          h.rect(u*gridWidth, v*gridHeight, gridWidth, gridHeight);
        }
        
        // POPULATION
        if (pop[u+gridPanU][v+gridPanV] > 10.0*sq(gridSize)) {
          normalized = findPopFill(p, pop[u+gridPanU][v+gridPanV]);
          // Doesn't draw a rectangle for values of 0
          p.noStroke(); // No lines draw around grid cells
          p.rect(u*gridWidth, v*gridHeight, gridWidth, gridHeight);
        }
        
        //STORES
        normalized = findStoreFill(s, stores[u+gridPanU][v+gridPanV]);
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

float findHeatmapFill(PGraphics graphic, float heatmap) {
    float normalized;
    color from, to;        
    
    //BEGIN Drawing HEATMAP
    from = color(0,255,0);
    to = color(255,0,0);
    
    // Draw Heatmap
    try {
      // heatmap value is normalized to a value between 0 and 1;
      normalized = (heatmap - heatmapMIN)/(heatmapMAX-heatmapMIN);
    } catch(Exception ex) {
      normalized = (0 - heatmapMIN)/(heatmapMAX-heatmapMIN);
    }
    
    // Hue Color of the grid is function of heatmap value;
    // 0.25 coefficient narrows the range of colors used
    // 100 + var offsets the range of colors used
    
    graphic.colorMode(HSB);
    
    int alpha = 255;
    
    if (valueMode.equals("totes") || valueMode.equals("deliveries")) {
      // Narrower Color Range
      graphic.fill(0.75*255*(1-normalized), 255, 255, alpha);
      graphic.stroke(0.75*255*(1-normalized), 255, 255, alpha);
    } else if (valueMode.equals("source")) {
      // Less Narrower Color Range
      graphic.fill(0.75*255*normalized, 255, 255, alpha);
      graphic.stroke(0.75*255*normalized, 255, 255, alpha);
    } else if (valueMode.equals("doorstep")) {
      // Less Narrower Color Range, reversed
      graphic.fill(lerpColor(from,to,normalized), alpha);
      graphic.stroke(lerpColor(from,to,normalized), alpha);
    } else {
      // Full Color Range
      graphic.fill(255*normalized, 255, 255, alpha);
      graphic.stroke(255*normalized, 255, 255, alpha);
    }
    
    return normalized;
}

float findPopFill(PGraphics graphic, float pop) {
    float normalized;
    color from, to;  
    
    //BEGIN Drawing POPULATION
    from = color(#000AF7, 100); // Blue
    to = color(#FF0000);   // Red
    
    // Draw Population
    try {
    // heatmap value is normalized to a value between 0 and 1;
//      normalized = ( sqrt(sqrt(pop)) - sqrt(sqrt(popMIN)))/sqrt(sqrt(popMAX-popMIN));
        normalized = ( sqrt(pop) - sqrt(popMIN))/sqrt(popMAX-popMIN);
//      normalized = ( pop - popMIN)/(popMAX-popMIN);
    } catch(Exception ex) {
      normalized = (0 - popMIN)/(popMAX-popMIN);
    }
    
    graphic.colorMode(HSB);
    graphic.fill(lerpColor(from,to,normalized));
    graphic.stroke(lerpColor(from,to,normalized));
    
    return normalized;
}

float findStoreFill(PGraphics graphic, float stores) {
    float normalized;  
    int alpha = 255;
    
    // BEGIN Drawing Draws Store Locations
    try {
      // heatmap value is normalized to a value between 0 and 1;
      normalized = (stores - storesMIN)/(storesMAX-storesMIN);
    } catch(Exception ex) {
      normalized = (0 - storesMIN)/(storesMAX-storesMIN);
    }
  
    // Full Color Range
    graphic.colorMode(HSB);
    graphic.fill(255*normalized, 255, 255, alpha);
    graphic.stroke(255*normalized, 255, 255, alpha);
        
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
  
  // Draw Rectangle around main canvas
  i.noFill();
  i.stroke(textColor);
  i.strokeWeight(1);
  i.rect(tablex_0, tabley_0, tablex_1, tabley_1);
  
  
  i.translate(tablex_0 + tablex_1, tabley_0 + tabley_1);
  
    // Draw Scale
    int scale_0 = 10;
    int scale_1 = int(w + tablex_0);
    float scalePix = tabley_1/displayV;
    i.line(scale_0, 0, scale_1, 0);
    i.line(scale_0, -4*scalePix, scale_1, -4*scalePix);
    i.line(scale_1 - scale_0, 0, scale_1 - scale_0, -scalePix);
    i.line(scale_1 - scale_0, -3*scalePix, scale_1 - scale_0, -4*scalePix);
    i.text(4*gridSize + " km", scale_1 - 2*scale_0, -1.5*scalePix);
    
    if (showPopulationData) {
      float legendPix = -tabley_0-4*scalePix-legendP.height;
      // Draw Legends
      i.image(legendP, tablex_0, legendPix);
      i.text("Population Legend", tablex_0, legendPix - 20);
      i.text(int(popMIN+1) + " " + popMode, 1.5*tablex_0 + legendP.width, legendPix + legendP.height);
      i.text(int(popMAX) + " " + popMode, 1.5*tablex_0 + legendP.width, legendPix+10);
    }
    
    if (showDeliveryData) {
      float legendPix = -3*tabley_0-4*scalePix-2*legendH.height-20;
      if (valueMode.equals("source")) {
        float normalized;
        int column = -1;
        i.text("Delivery Legend", tablex_0, legendPix - 20);
        for (int j=0; j<storeID.size(); j++) {
          if (j % 8 == 0) {
            column++;
          }
          normalized = findHeatmapFill(i, (float)storeID.get(j));
          i.text("StoreID: " + storeID.get(j), tablex_0*(column*5+1), legendPix+10+(j-column*8)*15);
        }
      } else { 
        // Draw Legends
        i.image(legendH, tablex_0, legendPix);
        i.text("Delivery Legend", tablex_0, legendPix - 20);
        i.text(int(heatmapMIN+1) + " " + valueMode, 1.5*tablex_0 + legendP.width, legendPix + legendP.height);
        i.text(int(heatmapMAX) + " " + valueMode, 1.5*tablex_0 + legendP.width, legendPix+10);
      }
    }
  
  i.translate(-(tablex_0 + tablex_1), -(tabley_0 + tabley_1));
  
  i.fill(textColor);
  i.textAlign(RIGHT);
  i.text("Pixelizer v1.0", screen.width - 10, screen.height - tabley_0 - 15);
  i.text("Ira Winder, jiw@mit.edu", screen.width - 10, screen.height - tabley_0);
  

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
  
  if (showDeliveryData || showPopulationData) {
    i.text("Cell Information:", 0, 90);
    i.text("Delivery Value:", 0, 120);
    i.text("Population Value:", 0, 150);
  }
  i.colorMode(RGB);
  i.fill(0,255,255);
  String value = "";
  if (showDeliveryData) {
    value = "";
    if ((int)getCellValue(mouseToU(), mouseToV()) == -1) {
      value = "NO_DATA";
    } else {
      value += (int)getCellValue(mouseToU(), mouseToV());
      i.text(prefix + value + suffix, 0, 135);
    }
  }
  if (showPopulationData) {
    value = "";
    if ((int)getCellPop(mouseToU(), mouseToV()) == -1) {
      value = "NO_DATA";
    } else {
      value += (int)getCellPop(mouseToU(), mouseToV());
      i.text(value + " " + popMode, 0, 165);
    }
  }
  
  i.fill(textColor);
  i.text(fileName.toUpperCase(), 0, 0);
  i.text("Last Mile Logistics", 0, 15);
//  i.text(fileName.toUpperCase() + " Grid Statistics:", 0, 0);
//  i.text("Min Cell Value: " + prefix + (int)heatmapMIN + suffix, 0, 30);
//  i.text("Max Cell Value: " + prefix + (int)heatmapMAX + suffix, 0, 45);
//  i.text("1 grid square = " + gridSize + "km", 0, 60);
  
  if (showFrameRate) {
    i.text("FrameRate: " + frameRate, 0, 45);
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

void renderLegends() {
  
  float normalized;
  int intervals = 10;
  int h = legendP.height/intervals;
  
  
  legendP.beginDraw();
  legendP.clear();
  for (int i=0; i<intervals; i++) {
     normalized = findPopFill(legendP, (intervals-i-1)*popMAX/intervals);
     legendP.rect(0, i*h, legendP.width, h);
  }
  legendP.endDraw();
  
  legendH.beginDraw();
  legendH.clear();
  for (int i=0; i<intervals; i++) {
     normalized = findHeatmapFill(legendH, (intervals-i-1)*heatmapMAX/intervals);
     legendH.rect(0, i*h, legendH.width, h);
  }
  legendH.endDraw();
}
