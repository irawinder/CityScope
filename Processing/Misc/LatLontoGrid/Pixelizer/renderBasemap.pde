PImage wholeMap, basemap;
String mapColor = "bw";

void initializeBaseMap() {
  wholeMap = loadImage("data/" + mapColor + "/" + fileName + "_2000.png");
}

// Loads Basemap file
void loadBasemap() {
  float w = (float)wholeMap.width/gridU;
  float h = (float)wholeMap.height/gridV;
  basemap = wholeMap.get(int(gridPanU*w), int(gridPanV*h), int(displayU*w), int(displayV*h));
  loadMiniBaseMap();
}

// Draws a Google Satellite Image
void renderBasemap(PGraphics graphic) {
  if (showBasemap) {
    graphic.image(basemap, 0, 0, table.width, table.height);
  }
}
