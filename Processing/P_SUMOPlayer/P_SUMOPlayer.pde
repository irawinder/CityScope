
// Unfolding Map Location
float lat;
float lon;
int zoom;

float modelWidth; // width of model in meters
float modelHeight; // height of model in meters
float modelRotation; // rotation of model in radians clockwise from north

boolean showOverlay = true;
int overlayIndex = 0;

public void setup() {
  //Screen size
  size(2000,2000,P2D);
  
  // Sets Static Global Variables to a Demo of Choice
  
    //setupNeighborhoodDemo();
    setupStreetDemo();
  
  // Allocates Memory for SUMO Vehicle Agents
  setupSUMO();
  
  // Allocates Memory for Cropped Rendering
  setupCrop();
  
  // Allocates memory for 'slicing' a redering for multiple screens
  setupOps();
  
  // Attempts to turn projection map canvases on
  toggle2DProjection();

}

public void draw() {
  
  // Draws Agents into primary graphic
  drawSUMO();
  
  // Crops Graphic to Physical Model Area
  Crop();
  
  // Overlays any static PNGs onto Cropped Image
  if (showOverlay) {
    crop.beginDraw();
    crop.image(imgOrangeLine[overlayIndex],0,0,crop.width,crop.height);
    crop.endDraw();
  }
  
  //Splits Cropped Image onto Multiple Screens
  imageOps();
}

