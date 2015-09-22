/**
 * An application with a basic interactive map. You can zoom and pan the map.
 */

PImage get;
PGraphics g, crop;

float counter;

float C = 2*PI*6372798.2; // Circumference of Earth

// Anson's Values
// float lat =  42.329544;
// float lon = -71.083984;

// Koharu's Values
// float lat = 42.332387;
// float lon = -71.08790015;

// Ira's Values
float lat = 42.332314;
float lon = -71.08835;
int zoom = 16;

// Dudley Square Corner Coordinates
// a  -71.0971527  42.3292084
// b  -71.0921783  42.3392525
// c  -71.0786514  42.3355637
// d  -71.0836182  42.3255234

float modelWidth  = 1.05*4752.54/4; // width of model in meters
float modelHeight = 1.05*4752.54/4; // height of model in meters
float modelRotation = -0.458378018+0.08; // rotation of model in radians clockwise from north

float scale; // distance represented by one pixel

int modelW_Pix;
int modelH_Pix;

public void setupCrop() {
  g = createGraphics(width, height);
  
  setScale();
}

public void setScale() {
  zoom = map.getZoomLevel();
  
  // Scale Equation:
  // http://wiki.openstreetmap.org/wiki/Zoom_levels
  scale = C*cos( (lat/360.0)*(2*PI) )/ pow(2, zoom+8);
  println("scale: " + scale);
  
  modelW_Pix = int(modelWidth/scale);
  modelH_Pix = int(modelHeight/scale);
  
  crop = createGraphics(modelW_Pix, modelH_Pix);
}

public void Crop() {
  
  //background(0);
  
  g.beginDraw();
  g.background(0);
  g.translate(width/2, height/2);
  g.rotate(modelRotation);
  g.translate(-width/2, -height/2);
  g.image(get(), 0, 0);
  g.endDraw();
  
  crop.beginDraw();
  crop.background(0);
  crop.translate(-(g.width-crop.width)/2, -(g.height-crop.height)/2);
  crop.image(g,0,0);
  crop.translate((g.width-crop.width)/2, (g.height-crop.height)/2);
  crop.endDraw();
  
  image(crop,0,0);
}
