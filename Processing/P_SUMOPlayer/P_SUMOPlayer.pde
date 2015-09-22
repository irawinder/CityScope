

// Anson's Values
// float lat =  42.329544;
// float lon = -71.083984;

//Koharu's Values
float lat = 42.332387;
float lon = -71.08790015;
int zoom = 16;

// Dudley Square Corner Coordinates
// a  -71.0971527  42.3292084
// b  -71.0921783  42.3392525
// c  -71.0786514  42.3355637
// d  -71.0836182  42.3255234

float modelWidth  = 4752.54/4; // width of model in meters
float modelHeight = 4752.54/4; // height of model in meters
float modelRotation = -0.458378018; // rotation of model in radians clockwise from north



public void setup() {
  //Screen size
  size(1000,1000,P2D);

  setupSUMO();
  
  setupCrop();
  setupOps();
  setup_ImageProj();
}

public void draw() {

  drawSUMO();
  
  Crop();
  imageOps();
}

