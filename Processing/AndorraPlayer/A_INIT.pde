// Table SetUp with Margin:

//  |------------------------------------|      ^ North
//  | |--------------------------------| |
//  | |                                | |
//  | |                                | |
//  | |           Topo Model           | |<- Margin
//  | |                                | |
//  | |                                | |
//  | |--------------------------------| |
//  |------------------------------------|

//  Projector Setup
//  |------------------------------------|      ^ North
//  |                  |                 |
//  |      Proj 1      |     Proj 2      |
//  |                  |                 |
//  |------------------------------------|
//  |                  |                 |
//  |      Proj 3      |     Proj 4      |
//  |                  |                 |
//  |------------------------------------|

// Projector dimensions in Pixels
    
    int numProjectors = 4;
    
//    int projectorWidth = 1920;
//    int projectorHeight = 1080;

    int projectorWidth = 1000;
    int projectorHeight = 1000;
    
// Model and Table Dimensions in Centimeters

    // Dimensions of Topographic Model
    float topoWidth = 310;
    float topoHeight = 110;
    
    // Dimension of Margin around Table
    float marginWidth = 15;
    
    // Net Table Dimensions
    float tableWidth = topoWidth + 2*marginWidth;
    float tableHeight = topoHeight + 2*marginWidth;
    
    // Scale of model (i.e. meters represented per actual meter)
    float scale = 1000;
    
// Graphics Objects

    // canvas width = 2x Projector Width ensure all pixels being used
    int canvasWidth = 2*projectorWidth;
    
    // canvas height reduced to minimum ratio to save memory
    int canvasHeight = int((tableHeight/tableWidth)*2*projectorWidth);
    
    // Table Object Dimensions in Pixels
    int topoWidthPix = int((topoWidth/tableWidth)*canvasWidth);
    int topoHeightPix = int((topoHeight/tableHeight)*canvasHeight);
    int marginWidthPix = int((marginWidth/tableWidth)*canvasWidth);
    
    // Graphics object in memory that matches the surface of the table to which we write undistorted graphics
    PGraphics tableCanvas;
    
    // Satellite image of Andorra
    PImage topo;


/**
 * This is a simple example of how to use the Keystone library.
 *
 * To use this example in the real world, you need a projector
 * and a surface you want to project your Processing sketch onto.
 *
 * Simply drag the corners of the CornerPinSurface so that they
 * match the physical surface's corners. The result will be an
 * undistorted projection, regardless of projector position or 
 * orientation.
 *
 * You can also create more than one Surface object, and project
 * onto multiple flat surfaces using a single projector.
 *
 * This extra flexbility can comes at the sacrifice of more or 
 * less pixel resolution, depending on your projector and how
 * many surfaces you want to map. 
 */

    import deadpixel.keystone.*;
    
    Keystone ks;
    CornerPinSurface[] surface = new CornerPinSurface[numProjectors];
    
    PGraphics offscreen;



// Objects for converting Latitude-Longitude to Canvas Coordinates
   
    // corner locations for topographic model (latitude and longitude)
    PVector UpperLeft = new PVector(42.505086, 1.509961);
    PVector UpperRight = new PVector(42.517066, 1.544024);
    PVector LowerRight = new PVector(42.508161, 1.549798);
    PVector LowerLeft = new PVector(42.496164, 1.515728);
    
    //Amount of degrees rectangular canvas is rotated from horizontal latitude axis
    float rotation = 25.5000; //degrees
    float lat1 = 42.517066; // Uppermost Latitude on canvas
    float lat2 = 42.496164; // Lowermost Latitude on canvas
    float lon1 = 1.509961; // Leftmost Longitude on canvas
    float lon2 = 1.549798; // Rightmost Longitude on canvas
     
    MercatorMap mercatorMap; // rectangular projection environment to convert latitude and longitude into pixel locations on the canvas
    
    boolean sketchFullScreen() {
      return !debug;
    }

//import processing.video.*;
//Movie theMovie;
//
//void movieEvent(Movie m) {
//  m.read();
//}

  boolean showFrameRate = false;
  
void initPlayer() {
  if (!use4k) {
    canvasWidth    /= 2;
    canvasHeight   /= 2;
    topoWidthPix   /= 2;
    topoHeightPix  /= 2;
    marginWidthPix /= 2;
  }
  
  // object for holding projection-map canvas callibration information
  ks = new Keystone(this);
  
  // Creates 4 cornerpin surfaces for projection mapping (1 for each projector)
  for (int i=0; i<surface.length; i++) {
    surface[i] = ks.createCornerPinSurface(canvasWidth/2, canvasHeight/2, 20);
  }
  
  // We need an offscreen buffer to draw the surface we
  // want projected
  // note that we're matching the resolution of the
  // CornerPinSurface.
  // (The offscreen buffer can be P2D or P3D)
  
  // Largest Canvas that holds unchopped parent graphic.
  tableCanvas = createGraphics(canvasWidth, canvasHeight, P3D);
  
  // Smaller PGraphic to hold quadrants 1-4 of parent tableCanvas.
  offscreen = createGraphics(canvasWidth/2, canvasHeight/2, P3D);
  
  // loads baseimage for topographic model
  topo = loadImage("crop.png");
  
  // Creates projection environment to convert latitude and longitude into pixel locations on the canvas
  //mercatorMap = new MercatorMap(lg_width, lg_height, lat1, lat2, lon1, lon2, rotation);
  mercatorMap = new MercatorMap(topoWidthPix, topoHeightPix, lat1, lat2, lon1, lon2, rotation);
  
  // loads the saved layout
  ks.load();

//  Deprecated movie animation
//      theMovie = new Movie(this, "cityscope_sponsorweek.mp4");
//      theMovie.loop();
}
