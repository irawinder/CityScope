/* Projection Map Utility By Ira Winder [jiw@mit.edu], CityScope Project, Changing Places Group, MIT Media Lab
*/
float version = 1.0;

// For any given setup, please update these dimensions, in pixels
//
// Example TSV Format:
//
//  width   height
//  1280    800

String canvasPath = "canvas.tsv";
Table canvas;
// Initial dimensions of canvas when application is run, in pixels
int canvasWidth, canvasHeight;

// Set to true to automatically open in present mode
boolean sketchFullScreen() {
  return false;
}

// Visualization is usually customized to a particular demo configuration.
// Configurations are named accordingly, given 'index.txt' as of v1.18:
//
// 0 = Kendall Square Playground
// 1 = Riyadh
// 2 = Flinders
// 3 = Kendall Square Real-time Data Visualization
// 4 = Toronto

// Sets default visualization Mode
int vizMode = 0;
boolean vizChange = false;

boolean drawStats = false;

// Runs once before any draw function is called
void setup() {
  initializeCanvas();
  size(canvasWidth, canvasHeight, P3D);         // Canvas Size
  frame.setResizable(true);             
  toggle2DProjection();
}

// Infinite draw loop
void draw() {
  background(0);

}

void initializeCanvas() {
  canvas = loadTable(canvasPath, "header");
  canvasWidth  = canvas.getInt(0, "width");   // Projector Width in Pixels
  canvasHeight = canvas.getInt(0, "height");  // Projector Height in Pixels
  println("Canvas Info: " + canvasWidth + ", " + canvasHeight);
}
