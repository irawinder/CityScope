// Demo Mode 1 = Street Scale
// Demo Mode 2 = Neighborhood Scale

    int demoMode = 1;



// Unfolding Map Location
float lat;
float lon;
int zoom;

float modelWidth; // width of model in meters
float modelHeight; // height of model in meters
float modelRotation; // rotation of model in radians clockwise from north

boolean showOverlay = true;
int overlayIndex = 0;

// SUMOPlayer Tab Global Variables
int timer, animationTimer; 
int frame;
float playbackSpeed = 1; 
int fr = 25; //fps
boolean labelBuses, rt = false;
int rtStep = 0;
String[] tokens;
PImage[] imgOrangeLine;
int tokenIndex = 0;

public void setup() {
  //Screen size
  size(2000,2000,P2D);
  
  // Sets Static Global Variables to a Demo of Choice
  switch (demoMode) {
    
    case 1:
      setupStreetDemo();
      
      setupM_SUMO();
      break;
      
    case 2:
      setupNeighborhoodDemo();
      
      // Allocates Memory for SUMO Vehicle Agents
      setupU_SUMO();
  
      break;
      
  }
    
  
  // Allocates Memory for Cropped Rendering
  setupCrop();
  
  // Allocates memory for 'slicing' a redering for multiple screens
  setupOps();
  
  // Attempts to turn projection map canvases on
  toggle2DProjection();

}

public void draw() {
  
  // Draws Demo of Choice
  switch (demoMode) {
    
    case 1:
      // Draws Agents into primary graphic
      drawM_SUMO();
      break;
      
    case 2:
      // Draws Agents into primary graphic
      drawU_SUMO();
  
      break;
      
  }
  
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

