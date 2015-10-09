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
  screenWidth = 1824;
  
  tokens = new String[1];
  tokens[0] = "000011";
  //tokens[1] = "000012";
  
  overlay = new PImage[10];
  overlay[0] = loadImage("neighborhood_overlays/00_Landmarks.png");
  overlay[1] = loadImage("neighborhood_overlays/01_A.png");
  overlay[2] = loadImage("neighborhood_overlays/01_B.png");
  overlay[3] = loadImage("neighborhood_overlays/01_C.png");
  overlay[4] = loadImage("neighborhood_overlays/01_D.png");
  overlay[5] = loadImage("neighborhood_overlays/02_OrangeLine.png");
  overlay[6] = loadImage("neighborhood_overlays/Dudley_OFF.png");
  overlay[7] = loadImage("neighborhood_overlays/01_BA.png");
  overlay[8] = loadImage("neighborhood_overlays/01_BC.png");
  overlay[9] = loadImage("neighborhood_overlays/01_BD.png");
  
  drawWidth = 2000;
  drawHeight = 2000;
  
  IDArray = new int[4];
  IDArray[0] = -1;
  IDArray[1] = -1;
  IDArray[2] = 0;
  IDArray[3] = -1;
//  for (int i=0; i<IDArray.length; i++) {
//    IDArray[i] = -1;
//  }
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
  
  tokens = new String[3];
  tokens[0] = "model0_results";
  tokens[1] = "model1_results";
  tokens[2] = "model2_results";
  
  overlay = new PImage[4];
  overlay[0] = loadImage("orangeLine-01.png");
  overlay[1] = loadImage("newStops-01.png");
  overlay[2] = loadImage("newStopOutlines-01.png");
  overlay[3] = loadImage("newRoutes-01.png");
  
  underlay = new PImage[5];
  underlay[0] = loadImage("street_basemaps/0.jpg");
  underlay[1] = loadImage("street_basemaps/1.jpg");
  underlay[2] = loadImage("street_basemaps/2.jpg");
  underlay[3] = loadImage("street_basemaps/3.jpg");
  underlay[4] = loadImage("street_basemaps/OFF.png");
  
//  drawWidth = 4000;
//  drawHeight = int(4000*modelHeight/modelWidth);

//  drawWidth = int(modelWidth);
//  drawHeight = int(modelHeight);

  drawWidth = 144*streetScalar;
  drawHeight = 48*streetScalar;
  
  showOverlay = false;
  
  IDArray = new int[3];
  for (int i=0; i<IDArray.length; i++) {
    IDArray[i] = -1;
  }

}
