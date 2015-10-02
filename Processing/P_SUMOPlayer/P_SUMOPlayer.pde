// Demo Mode 1 = Street Scale
// Demo Mode 2 = Neighborhood Scale

    int demoMode = 2;



// Unfolding Map Location
float lat;
float lon;
int zoom;

float modelWidth; // width of model in meters
float modelHeight; // height of model in meters
float modelRotation; // rotation of model in radians clockwise from north

int drawWidth;
int drawHeight;

boolean showOverlay = true;
int overlayIndex = 0;

//// SUMOPlayer Tab Global Variables
int timer, animationTimer; 
int frame;
float playbackSpeed = 1; 
int fr = 25; //fps
boolean labelBuses, rt = false;
int rtStep = 0;
String[] tokens;
int tokenIndex = 0;
PImage[] overlay;
PImage[] underlay;
int streetScalar;



public void setup() {
  
  initUDP();
  
  // Sets Static Global Variables to a Demo of Choice
  switch (demoMode) {
    case 1:
      setupStreetDemo();
      setupM_SUMO();
      break;
      
    case 2:
      setupNeighborhoodDemo();
      setupU_SUMO();
      break;
  }
    
  //Screen size
  size(drawWidth,drawHeight,P2D);
  
  // Allocates Memory for Cropped Rendering
  switch (demoMode) {
    case 1:
      setupM_Crop();
      break;
      
    case 2:
      setupU_Crop();
      break;
  }
  
  
  // Allocates memory for 'slicing' a redering for multiple screens
  setupOps();
  
  // Attempts to turn projection map canvases on
  toggle2DProjection();
  
  background(0);
}

public void draw() {
  
  // Draws Demo of Choice
  switch (demoMode) {
    
    case 1:
      //Draw Underlay
      drawUnderlay();
    
      // Draws Agents into primary graphic
      drawM_SUMO();
      
      // Crops Graphic to Physical Model Area
      M_Crop();
      break;
      
    case 2:
      // Draws Agents into primary graphic
      drawU_SUMO();
      
      // Crops Graphic to Physical Model Area
      U_Crop();
      
      // Overlays any static PNGs onto Cropped Image
      if (showOverlay) {
        crop.beginDraw();
  //    crop.image(overlay[overlayIndex],0,0,crop.width,crop.height);
  
        crop.image(overlay[0],0,0,crop.width,crop.height);
        crop.image(overlay[5],0,0,crop.width,crop.height);
        
        // Corridor A
        if (IDArray[0] > -1) {
          crop.image(overlay[1],0,0,crop.width,crop.height);
        }
        if (IDArray[0] > 0) {
          crop.image(overlay[1],0,0,crop.width,crop.height);
        }
        if (IDArray[0] > 1) {
          crop.image(overlay[1],0,0,crop.width,crop.height);
        }
        
        // Corridor B
        if (IDArray[1] > -1) {
          crop.image(overlay[2],0,0,crop.width,crop.height);
        }
        if (IDArray[1] > 0) {
          crop.image(overlay[2],0,0,crop.width,crop.height);
        }
        if (IDArray[1] > 1) {
          crop.image(overlay[2],0,0,crop.width,crop.height);
        }
        
        // Corridor C
        if (IDArray[2] > -1) {
          crop.image(overlay[3],0,0,crop.width,crop.height);
        }
        if (IDArray[2] > 0) {
          crop.image(overlay[3],0,0,crop.width,crop.height);
        }
        if (IDArray[2] > 1) {
          crop.image(overlay[3],0,0,crop.width,crop.height);
        }
        
        // Corridor D
        if (IDArray[3] > -1) {
          crop.image(overlay[4],0,0,crop.width,crop.height);
        }
        if (IDArray[3] > 0) {
          crop.image(overlay[4],0,0,crop.width,crop.height);
        }
        if (IDArray[3] > 1) {
          crop.image(overlay[4],0,0,crop.width,crop.height);
        }
      
        crop.endDraw();
      }
      break;
  }
  

  
  //Splits Cropped Image onto Multiple Screens
  imageOps();
  
  //println("Xmax = " + Xmax + " ; Ymax = " + Ymax + " ; Xmin = " + Xmin + " ; Ymin = " + Ymin);
  
}

