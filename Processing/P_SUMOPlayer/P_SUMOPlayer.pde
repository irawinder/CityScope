

// Anson's Values
// float lat =  42.329544;
// float lon = -71.083984;

// Koharu's Values
// float lat = 42.332387;
// float lon = -71.08790015;

// Ira's Values
float lat = 42.332382;
float lon = -71.08837;
int zoom = 17;

// Dudley Square Corner Coordinates
// a  -71.0971527  42.3292084
// b  -71.0921783  42.3392525
// c  -71.0786514  42.3355637
// d  -71.0836182  42.3255234

float modelWidth  = 1.05*4752.54/4; // width of model in meters
float modelHeight = 1.05*4752.54/4; // height of model in meters
float modelRotation = -0.458378018+0.09; // rotation of model in radians clockwise from north



public void setup() {
  //Screen size
  size(2000,2000,P2D);

  setupSUMO();
  
  setupCrop();
  setupOps();
  setup_ImageProj();

}

public void draw() {

  drawSUMO();
  
  Crop();
  
  // crop.beginDraw();
  // crop.image(imgOrangeLine,0,0,crop.width,crop.height);
  // crop.endDraw();
  
  imageOps();
}

