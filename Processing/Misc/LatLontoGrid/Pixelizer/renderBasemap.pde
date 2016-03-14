PImage basemap;
String mapColor = "bw";
int mapPanX, mapPanY;

// Loads Basemap file
void loadBasemap() {
  try {
    basemap = loadImage("data/" + mapColor + "/" + fileName + "_" + int(gridSize*1000) + ".png");
    basemap.resize(width, height);
  } catch(RuntimeException e) {
    println("No basemap available at this scale: " + gridSize + "km per pixel.");
  }
  mapPan();
  println(mapPanX, mapPanY); 
}

void mapPan() {
  mapPanX = - int(width *( gridPanU - (gridU-displayU)/2 ) / displayU);
  mapPanY = - int(height*( gridPanV - (gridV-displayV)/2 ) / displayV);
}

// Draws a Google Satellite Image
void renderBasemap() {
  try {
    if (showBasemap) {
      image(basemap, mapPanX, mapPanY, width, height);
    }
  } catch(RuntimeException e) {
    println("No basemap available at this scale: " + gridSize + "km per pixel.");
  }
}
