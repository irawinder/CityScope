PImage basemap;
String mapColor = "bw";
//String mapColor = "color";

// Loads Basemap file
void loadBasemap() {
  try {
    basemap = loadImage("data/" + mapColor + "/" + fileName + "_" + int(gridSize*1000) + ".png");
  } catch(RuntimeException e) {
    println("No basemap available at this scale: " + gridSize + "km per pixel.");
  }
}

// Draws a Google Satellite Image
void renderBasemap() {
  try {
    image(basemap, 0, 0, width, height);
  } catch(RuntimeException e) {
    println("No basemap available at this scale: " + gridSize + "km per pixel.");
  }
}
