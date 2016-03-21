/**
 * An application with a basic interactive map. You can zoom and pan the map.
 */

PImage get;
PGraphics g, crop;
PImage template;

float counter;

float C = 2*PI*6372798.2; // Circumference of Earth

// Dudley Square Location
        
//        // Ira's Values
//        float lat = 42.332382;
//        float lon = -71.08837;
//        int zoom = 16;
//        
//        // Dudley Square Corner Coordinates
//        // a  -71.0971527  42.3292084
//        // b  -71.0921783  42.3392525
//        // c  -71.0786514  42.3355637
//        // d  -71.0836182  42.3255234
//        
//        float modelWidth  = 1.05*4752.54/4; // width of model in meters
//        float modelHeight = 1.05*4752.54/4; // height of model in meters
//        float modelRotation = -0.458378018+0.09; // rotation of model in radians clockwise from north
        
// Andorra Location
        
//        // Juanita's Values
//        float lat = 42.495531;
//        float lon = 1.515080;
//        int zoom = 16;
//        float modelWidth  = 3100; // width of model in meters
//        float modelHeight = 1100; // height of model in meters
//        float modelRotation = -25.218*(180/PI); // rotation of model in radians clockwise from north
//
//        // Ira's Numbers
//        float lat = 42.506596;
//        float lon = 1.5299543;
//        int zoom = 17;
//        float modelWidth  = 3100; // width of model in meters
//        float modelHeight = 1100; // height of model in meters
//        float modelRotation = 25.5/180*PI; // rotation of model in radians clockwise from north
        
// Hamburg Location
        
//        // Ira's Numbers
//        float lat = 53.537388;
//        float lon = 10.035539;
//        int zoom = 17;
//        float modelWidth  = 7.99125*192; // width of model in meters
//        float modelHeight = 7.99125*192; // height of model in meters
//        float modelRotation = -26.0/180*PI; // rotation of model in radians clockwise from north

// Tongzhou Location
        
//        Latitude and Longitude at Center of Model
//          // Microsoft Lat-Lon
//          float lat = 39.895565;
//          float lon = 116.69402;
//          // Google Lat-Lon
//          float lat = 39.89675;
//          float lon = 116.700035;
//        int zoom = 16;
//        float modelWidth  =                     6.68612*96*4; // width of model in meters
//        float modelHeight = (1 + 284.0*2/768.0)*6.68812*96;   // height of model in meters
//        float modelRotation = -(43.69+1.7068)/180*PI; // rotation of model in radians clockwise from north
//        boolean useTemplate = true;
//        String templateFile = "TongzhouPlanTemplate.png";

// Denver Location

//    // Latitude and Longitude at Center of Model
//    float lat = 39.95;
//    float lon = -104.9903;
//    int zoom = 9;
//    float modelWidth  = 2000*18*4; // width of model in meters
//    float modelHeight = 2000*22*4;   // height of model in meters
//    float modelRotation = 0.0; // rotation of model in radians clockwise from north
//    boolean useTemplate = true;
//    String templateFile = "denver.png";

// San Jose Location

//    // Latitude and Longitude at Center of Model
//    float lat = 37.395237;
//    float lon = -121.979507;
//    int zoom = 11;
//    float modelWidth  = 1000*18*4; // width of model in meters
//    float modelHeight = 1000*22*4;   // height of model in meters
//    float modelRotation = 0.0; // rotation of model in radians clockwise from north
//    boolean useTemplate = false;
//    String templateFile = "denver.png";
    
    // Latitude and Longitude at Center of Model
    float lat = 39.95;
    float lon = -104.9903;
    int zoom = 11;
    float modelWidth  = 2000*18*4; // width of model in meters
    float modelHeight = 2000*22*4;   // height of model in meters
    float modelRotation = 0.0; // rotation of model in radians clockwise from north
    boolean useTemplate = true;
    String templateFile = "denver.png";

float scale; // distance represented by one pixel

int modelW_Pix;
int modelH_Pix;

public void setupCrop() {
  g = createGraphics(width, height);
  
  setScale();
  
  if (useTemplate) {
    template = loadImage(templateFile);
  }
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
  
  if (useTemplate) {
    image(template, 0, 0, crop.width, crop.height);
  }
}
