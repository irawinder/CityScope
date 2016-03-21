PImage basemap;
String mapColor = "bw";
int mapPanX, mapPanY;

// Loads Basemap file
void loadBasemap() {
  try {
    loadMiniBaseMap();
    basemap = loadImage("data/" + mapColor + "/" + fileName + "_" + int(gridSize*1000) + ".png");
    basemap.resize(table.width, table.height);
  } catch(RuntimeException e) {
    println("No basemap available at this scale: " + gridSize + "km per pixel.");
  }
  mapPan();
}

void mapPan() {
  mapPanX = - int(table.width *( gridPanU - (gridU-displayU)/2 ) / displayU);
  mapPanY = - int(table.height*( gridPanV - (gridV-displayV)/2 ) / displayV);
}

// Draws a Google Satellite Image
void renderBasemap(PGraphics graphic) {
  try {
    if (showBasemap) {
      graphic.image(basemap, mapPanX, mapPanY, table.width, table.height);
    }
  } catch(RuntimeException e) {
    println("No basemap available at this scale: " + gridSize + "km per pixel.");
  }
}
