public void setupNeighborhoodDemo() {
  
  // Anson's Values
  // float lat =  42.329544;
  // float lon = -71.083984;
  
  // Koharu's Values
  // float lat = 42.332387;
  // float lon = -71.08790015;
  
  // Ira's Values
  lat = 42.332382;
  lon = -71.08837;
  zoom = 17;
  
  // Dudley Square Corner Coordinates
  // a  -71.0971527  42.3292084
  // b  -71.0921783  42.3392525
  // c  -71.0786514  42.3355637
  // d  -71.0836182  42.3255234
  
  modelWidth  = 1.05*4752.54/4; // width of model in meters
  modelHeight = 1.05*4752.54/4; // height of model in meters
  modelRotation = -0.458378018+0.09; // rotation of model in radians clockwise from north
  
  projector_width = 1920;
  projector_height = 1200;
  screenWidth = 1280;
  
  tokens = new String[2];
  tokens[0] = "000011";
  tokens[1] = "000012";
  
  overlay = new PImage[4];
  overlay[0] = loadImage("orangeLine-01.png");
  overlay[1] = loadImage("newStops-01.png");
  overlay[2] = loadImage("newStopOutlines-01.png");
  overlay[3] = loadImage("newRoutes-01.png");
  
  drawWidth = 2000;
  drawHeight = 2000;
}

public void setupStreetDemo() {
  streetScalar = 16;
  
  // Ira's Values
  lat = 0.5*0.5*6*48;
  lon = 0.5*0.5*2*48;
  zoom = 19;
  
  modelWidth  = 0.5*6*48; // width of model in meters
  modelHeight = 0.5*2*48; // height of model in meters
  modelRotation = 0; // rotation of model in radians clockwise from north
  
  projector_width = 1920;
  projector_height = 1200;
  screenWidth = 1920;
  
  tokens = new String[1];
  tokens[0] = "model0_results";
  
  overlay = new PImage[4];
  overlay[0] = loadImage("orangeLine-01.png");
  overlay[1] = loadImage("newStops-01.png");
  overlay[2] = loadImage("newStopOutlines-01.png");
  overlay[3] = loadImage("newRoutes-01.png");
  
  underlay = new PImage[1];
  underlay[0] = loadImage("testStreet.png");
  
//  drawWidth = 4000;
//  drawHeight = int(4000*modelHeight/modelWidth);

//  drawWidth = int(modelWidth);
//  drawHeight = int(modelHeight);

  drawWidth = 144*streetScalar;
  drawHeight = 48*streetScalar;
  
  showOverlay = false;

}
