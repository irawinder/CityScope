
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
  
  setupNeighborhoodDemo();
  
  setupSUMO();
  
  setupCrop();
  setupOps();
  setup_ImageProj();
  
  // Attempts to turn projection map canvases on
  toggle2DProjection();

}

public void draw() {

  drawSUMO();
  
  Crop();
  
  if (showOverlay) {
    crop.beginDraw();
    crop.image(imgOrangeLine[overlayIndex],0,0,crop.width,crop.height);
    crop.endDraw();
  }
  
  imageOps();
}

