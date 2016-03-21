PGraphics miniMap;
PImage miniBaseMap;

void loadMiniBaseMap() {
  miniBaseMap = loadImage("data/" + mapColor + "/" + fileName + "_2000.png");
  miniBaseMap.resize(4*displayU, 4*displayU);
}

void renderMiniMap(PGraphics miniMap) {
  
  miniMap.beginDraw();
  miniMap.clear();
  miniMap.background(background);
  if (showBasemap) {
    miniMap.image(miniBaseMap, 0, 0, gridU, gridV);
  }
  miniMap.colorMode(HSB);
  miniMap.fill(textColor);
  
  float normalized;
  color from, to;
  
  miniMap.stroke(textColor);
  miniMap.strokeWeight(1);
  
  for (int u=0; u<gridU; u++) {
    for (int v=0; v<gridV; v++) {
      
      if (showPopulationData){
        if (pop[u][v] > 10.0*sq(gridSize)) {
          // HEATMAP
          normalized = findPopFill(miniMap, u, v);
          miniMap.point(u,v);
        }
      }
      if (showDeliveryData) {
        if (heatmap[u][v] > 0) {
          // HEATMAP
          normalized = findHeatmapFill(miniMap, u, v);
          miniMap.point(u,v);
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
          //normalized = findStoreFill(miniMap, u, v);
          miniMap.fill(#FF0000);
          miniMap.stroke(textColor);
          miniMap.strokeWeight(2.0/gridSize);
          miniMap.ellipse(u,v,6/gridSize,6/gridSize);
        }
      }
    }
  }
      
  miniMap.endDraw();
  
}
