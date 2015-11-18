// This is the staging script to allow splitting 4k projection mapping across 4 projectors
// For Andorra Data Stories
// Ira Winder, MIT Media Lab, jiw@mit.edu, Fall 2015

// Set to false when rendering on projectors; true when developing on your PC, etc
// Setting to false opens a 4k canvas
boolean debug = true;

boolean loadData = false;

// !!!
// Developers of this Code (Nina and Connie!) probably need only concern themselves with the 'data' and 'draw' tabs
//


// Key Commands:
//
//   View Mode:
//     'm' - toggle On-Screen mode or Projection-mapping mode
//
//   Projection Mapping:
//     'c' - toggle callibration mode for projection mapping
//     's' - save callibration
//     'l' - load callibration
//
//     'g' - toggle debug

// Need Libaries:
// Keystone for Processing

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
    
    int projectorWidth = 1920;
    int projectorHeight = 1080;
    
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
    
    //Amount of degrees rectangular canvas is rotated from horizontal latitude axis.
    float rotation = 25.5000; //degrees
    
    float lat1 = 42.517066; // Uppermost Latitude on canvas
    float lat2 = 42.496164; // Lowermost Latitude on canvas
    float lon1 = 1.509961; // Uppermost Longitude on canvas
    float lon2 = 1.549798; // Lowermost Longitude on canvas
    
    // Dimensions for larger or equal-size canvas, perpendicular to north, that bounds and intersects 4 corners of original 
    float lg_width = topoHeightPix*sin(abs(rotation)*2*PI/360) + topoWidthPix*cos(abs(rotation)*2*PI/360);
    float lg_height = topoWidthPix*sin(abs(rotation)*2*PI/360) + topoHeightPix*cos(abs(rotation)*2*PI/360);
    
    float w_shift = (lg_width-topoWidthPix)/2;
    float h_shift = (lg_height-topoHeightPix)/2;
     
    MercatorMap mercatorMap; // rectangular projection environment to convert latitude and longitude into pixel locations on the canvas

// Draw Modes:
// 0 = Render For Screen
// 1 = Render for Projection-Mapping

    int drawMode = 1;
    
    boolean sketchFullScreen() {
      return !debug;
    }

//import processing.video.*;
//Movie theMovie;
//
//void movieEvent(Movie m) {
//  m.read();
//}



void setup() {
  
  // Keystone will only work with P3D or OPENGL renderers, 
  // since it relies on texture mapping to deform
  if (debug) {
    size(projectorWidth, projectorHeight, P3D);
  } else {
    size(2*projectorWidth, 2*projectorHeight, P3D);
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
  mercatorMap = new MercatorMap(lg_width, lg_height, lat1, lat2, lon1, lon2);
  
  // loads the saved layout
  ks.load();
  
  if (loadData) {
    // Loads csv files referenced in data tab
    initData();
  }

//  Deprecated movie animation
//      theMovie = new Movie(this, "cityscope_sponsorweek.mp4");
//      theMovie.loop();
}

void draw() {
  
  // Renders frame onto 'tableCanvas' PGraphic
  drawTableCanvas();

  // most likely, you'll want a black background to minimize
  // bleeding around your projection area
  background(0);
  
  // Renders the tableCanvas as either a projection map or on-screen 
  switch (drawMode) {
    
    case 0: // On-Screen Rendering
    
      image(tableCanvas, 0, 0, tableCanvas.width/2, tableCanvas.height/2);
      break;
      
    case 1: // Projection-Mapping Rendering
    
      // render the scene, transformed using the corner pin surface
      for (int i=0; i<surface.length; i++) {
        chopScreen(i);
        surface[i].render(offscreen);
      }
      break;
  }
  
  if (showFrameRate) {
    println(frameRate);
  }

}

void chopScreen(int projector) {
  
  offscreen.beginDraw();
  
  switch (projector) {
    
    case 0:
      offscreen.image(tableCanvas, 0, 0);
      break;
    case 1:
      offscreen.image(tableCanvas, -canvasWidth/2, 0);
      break;
    case 2:
      offscreen.image(tableCanvas, 0, -canvasHeight/2);
      break;
    case 3:
      offscreen.image(tableCanvas, -canvasWidth/2, -canvasHeight/2);
      break;
      
  }
  
  offscreen.endDraw();
  
}

boolean showFrameRate = false;

void keyPressed() {
  switch(key) {
  case 'c':
    // enter/leave calibration mode, where surfaces can be warped 
    // and moved
    ks.toggleCalibration();
    break;

  case 'l':
    // loads the saved layout
    ks.load();
    break;

  case 's':
    // saves the layout
    ks.save();
    break;
  
  case 'm':
    // changes draw mode
    if (drawMode < 1) {
      drawMode++;
    } else {
      drawMode = 0;
    }
    break;
    
  case 'g':
    // changes debug mode
    debug = toggle(debug);
    break;
    
  case 'd':
    // changes debug mode
    showData = toggle(showData);
    break;
  
  case 'f':
    // changes debug mode
    showFrameRate = toggle(showFrameRate);
    break;
  }
}

boolean toggle(boolean bool) {
  if (bool) {
    return false;
  } else {
    return true;
  }
}


