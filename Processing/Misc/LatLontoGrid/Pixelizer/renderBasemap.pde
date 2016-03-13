PImage basemap;
String mapColor = "bw";
boolean showBasemap = true;

// Loads Basemap file
void loadBasemap() {
  try {
    basemap = loadImage("data/" + mapColor + "/" + fileName + "_" + int(gridSize*1000) + ".png");
    basemap.resize(width, height);
  } catch(RuntimeException e) {
    println("No basemap available at this scale: " + gridSize + "km per pixel.");
  }
}

// Draws a Google Satellite Image
void renderBasemap() {
  try {
    if (showBasemap) {
      image(basemap, 0, 0, width, height);
    }
  } catch(RuntimeException e) {
    println("No basemap available at this scale: " + gridSize + "km per pixel.");
  }
}
