PGraphics miniMap;
PImage miniBaseMap;
float mapRatio = 0.2;

void loadMiniBaseMap() {
  miniBaseMap = loadImage("data/" + mapColor + "/" + fileName + "_2000.png");
  miniBaseMap.resize(4*displayU, 4*displayV);
}

void renderMiniMap(PGraphics miniMap) {
  
  println(miniMap.width, miniMap.height);
  
  miniMap.beginDraw();
  miniMap.clear();
  miniMap.background(background);
  if (showBasemap) {
    miniMap.image(miniBaseMap, 0, 0, miniMap.width, miniMap.height);
  }
  miniMap.colorMode(HSB);
  miniMap.fill(textColor);
  
  float normalized;
  color from, to;
  
  miniMap.stroke(textColor);
  miniMap.strokeWeight(1);
  
  float pixel_per_U = (float)miniMap.width/gridU;
  float pixel_per_V = (float)miniMap.height/gridV;
  
  for (int u=0; u<gridU; u++) {
    for (int v=0; v<gridV; v++) {
      
      if (showPopulationData){
        if (pop[u][v] > 10.0*sq(gridSize)) {
          // HEATMAP
          normalized = findPopFill(miniMap, pop[u][v]);
          miniMap.noStroke();
          miniMap.rect(u*pixel_per_U,v*pixel_per_V, pixel_per_U, pixel_per_V);
        }
      }
      if (showDeliveryData) {
        if (heatmap[u][v] > 0) {
          // HEATMAP
          normalized = findHeatmapFill(miniMap, heatmap[u][v]);
          miniMap.noStroke();
          miniMap.rect(u*pixel_per_U,v*pixel_per_V, pixel_per_U, pixel_per_V);
        }
      }
      
    }
  }
  
  miniMap.endDraw();
  miniMap.beginDraw();
  
  if (showStores) {
    for (int u=0; u<gridU; u++) {
      for (int v=0; v<gridV; v++) {
        if (stores[u][v] != 0) {
          // HEATMAP
          normalized = findStoreFill(miniMap, stores[u][v]);
          if (normalized == 0) {miniMap.noFill();}
          //miniMap.fill(#FF0000);
          miniMap.stroke(textColor);
          miniMap.strokeWeight(4);
          miniMap.ellipse(u*pixel_per_U,v*pixel_per_V,12,12);
        }
      }
    }
  }
      
  miniMap.endDraw();
  
}
