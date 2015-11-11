// This is the staging script to allow splitting 4k projection mapping across two sets of two projectors

// Need Libaries:
// Keystone
// Just to be safe: opencv

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
    
    PGraphics tableCanvas;
    
    PImage topo;
    
    import processing.video.*;
    Movie theMovie;


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

/**
 * Objects for converting Latitude-Longitude to Canvas Coordinates
 */

//        // Ira's Numbers
//        float lat = 42.506294;
//        float lon = 1.5296538;
//        int zoom = 17;
//        float modelWidth  = 3100; // width of model in meters
//        float modelHeight = 1100; // height of model in meters
//        float modelRotation = 24.218/180*PI; // rotation of model in radians clockwise from north
        
// Rotated and Cropped Corner locations
PVector UpperLeft = new PVector(42.505086, 1.509961);
PVector UpperRight = new PVector(42.517066, 1.544024);
PVector LowerRight = new PVector(42.508161, 1.549798);
PVector LowerLeft = new PVector(42.496164, 1.515728);

//Amount of degrees rectangular canvas is rotated from horizontal latitude axis. These values specific to Kendall Square.
float rotation = 25.5000; //degrees
float lat1 = 42.517066; // Uppermost Latitude on canvas
float lat2 = 42.496164; // Lowermost Latitude on canvas
float lon1 = 1.509961; // Uppermost Longitude on canvas
float lon2 = 1.549798; // Lowermost Longitude on canvas

// Creates larger canvas, rotated, that bounds and intersects 4 corners of original 
float lg_width = topoHeightPix*sin(abs(rotation)*2*PI/360) + topoWidthPix*cos(abs(rotation)*2*PI/360);
float lg_height = topoWidthPix*sin(abs(rotation)*2*PI/360) + topoHeightPix*cos(abs(rotation)*2*PI/360);

float w_shift = (lg_width-topoWidthPix)/2;
float h_shift = (lg_height-topoHeightPix)/2;
 
MercatorMap mercatorMap; // rectangular projection environment to convert latitude and longitude into pixel locations on the canvas

// Draw Modes:
// 0 = Render For Screen
// 1 = Render for Projection-Mapping

int drawMode = 1;

void setup() {
  
  // Keystone will only work with P3D or OPENGL renderers, 
  // since it relies on texture mapping to deform
  size(projectorWidth, projectorHeight, P3D);

  ks = new Keystone(this);
  
  for (int i=0; i<surface.length; i++) {
    surface[i] = ks.createCornerPinSurface(canvasWidth/2, canvasHeight/2, 20);
  }
  
  // We need an offscreen buffer to draw the surface we
  // want projected
  // note that we're matching the resolution of the
  // CornerPinSurface.
  // (The offscreen buffer can be P2D or P3D)
  
  // Smaller PGraphic to hold cropped quadrants of parent canvas.
  offscreen = createGraphics(canvasWidth/2, canvasHeight/2, P3D);
  
  // Largest Canvas that holds unchopped parent graphic.
  tableCanvas = createGraphics(canvasWidth, canvasHeight, P3D);
  
  // loads baseimage for topographic model
  topo = loadImage("crop.png");
  
  // Creates projection environment to convert latitude and longitude into pixel locations on the canvas
  mercatorMap = new MercatorMap(lg_width, lg_height, lat1, lat2, lon1, lon2);
  
  // loads the saved layout
  ks.load();
  
  initData();
  
  theMovie = new Movie(this, "cityscope_sponsorweek.mp4");
  theMovie.loop();
}

void draw() {
  
  drawTableCanvas();
  
  // Convert the mouse coordinate into surface coordinates
  // this will allow you to use mouse events inside the 
  // surface from your screen. 
  PVector surfaceMouse = surface[0].getTransformedMouse();



  // most likely, you'll want a black background to minimize
  // bleeding around your projection area
  background(0);
  
  switch (drawMode) {
    
    case 0: // On-Screen Rendering
      image(tableCanvas, 0, 0, tableCanvas.width/2, tableCanvas.height/2);
      break;
      
    case 1: // Projection-Mapping Rendering
      // render the scene, transformed using the corner pin surface
      for (int i=0; i<surface.length; i++) {
        chopScreen(i);
        
        // Draw the scene, offscreen
        offscreen.beginDraw();
        //offscreen.background(255);
        offscreen.fill(0, 255, 0);
        offscreen.ellipse(surfaceMouse.x, surfaceMouse.y, 75, 75);
        offscreen.endDraw();
      
        surface[i].render(offscreen);
      }
      break;
      
  }

}

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
  }
}

PVector coord;

void drawTableCanvas() {
  tableCanvas.beginDraw();
  tableCanvas.background(#555555);
  
  tableCanvas.translate(marginWidthPix, marginWidthPix);
  
  tableCanvas.image(topo, 0, 0, topoWidthPix, topoHeightPix);
  
  
  // Draw Dots //
  
  setMercator(topoWidthPix, topoHeightPix);
  
  tableCanvas.translate(-w_shift, -h_shift);
  //println(w_shift + ", " + h_shift + ", " + topoWidthPix + ", " + topoHeightPix + ", " + marginWidthPix);
  
  
  
  tableCanvas.fill(#0000FF);
  
  for (int i=0; i<sampleOutput.getRowCount(); i+=2) {
    
    if (sampleOutput.getInt(i, "origin container") == 0) {
      
      // turns latitude and longitude of a point into canvas location within PGraphic topo
      coord = mercatorMap.getScreenLocation(new PVector(sampleOutput.getFloat(i, "origin lat"), sampleOutput.getFloat(i, "origin lon")));
      
      
      tableCanvas.ellipse(coord.x, coord.y, 30, 30);
    }
    
  }
  
  tableCanvas.fill(#FF0000);
  
  for (int i=0; i<tripAdvisor.getRowCount(); i+=2) {

    // turns latitude and longitude of a point into canvas location within PGraphic topo
    coord = mercatorMap.getScreenLocation(new PVector(tripAdvisor.getFloat(i, "Lat"), tripAdvisor.getFloat(i, "Long")));
    

    tableCanvas.ellipse(coord.x, coord.y, 30, 30);
    
  }
  
  tableCanvas.fill(#00FF00);
  
  for (int i=0; i<frenchWifi.getRowCount(); i+=2) {

    // turns latitude and longitude of a point into canvas location within PGraphic topo
    coord = mercatorMap.getScreenLocation(new PVector(frenchWifi.getFloat(i, "Source_lat"), frenchWifi.getFloat(i, "Source_long")));
    

    tableCanvas.ellipse(coord.x, coord.y, 30, 30);

    
  }
  
  /*
  tableCanvas.strokeWeight(20);
  
  tableCanvas.stroke(#FFFFFF);
  tableCanvas.line(mercatorMap.getScreenX(UpperLeft.y), mercatorMap.getScreenY(UpperLeft.x), mercatorMap.getScreenX(UpperRight.y), mercatorMap.getScreenY(UpperRight.x));
  tableCanvas.stroke(#FF0000);
  tableCanvas.line(mercatorMap.getScreenX(UpperRight.y), mercatorMap.getScreenY(UpperRight.x), mercatorMap.getScreenX(LowerRight.y), mercatorMap.getScreenY(LowerRight.x));
  tableCanvas.stroke(#00FF00);
  tableCanvas.line(mercatorMap.getScreenX(LowerRight.y), mercatorMap.getScreenY(LowerRight.x), mercatorMap.getScreenX(LowerLeft.y), mercatorMap.getScreenY(LowerLeft.x));
  tableCanvas.stroke(#0000FF);
  tableCanvas.line(mercatorMap.getScreenX(UpperLeft.y), mercatorMap.getScreenY(UpperLeft.x), mercatorMap.getScreenX(LowerLeft.y), mercatorMap.getScreenY(LowerLeft.x));

  */
  
  tableCanvas.translate(w_shift, h_shift);
  unsetMercator(topoWidthPix, topoHeightPix);
  tableCanvas.translate(-marginWidthPix, -marginWidthPix);
  
  //tableCanvas.image(theMovie, (marginWidth/tableWidth)*canvasWidth, (marginWidth/tableHeight)*canvasHeight, (topoWidth/tableWidth)*canvasWidth, (topoHeight/tableHeight)*canvasHeight);
  
  //framewidth = 1920; frameheight = 1080
  //tableCanvas.image(theMovie, 0, -60, 3800, 2138);
  
  tableCanvas.stroke(255, 255, 255);
  tableCanvas.fill(0, 0, 0);
  
  tableCanvas.rect(0, 0, canvasWidth/3, (marginWidth/tableWidth)*canvasWidth);
  tableCanvas.rect(canvasWidth/3, 0, canvasWidth/3, (marginWidth/tableWidth)*canvasWidth);
  tableCanvas.rect(2*canvasWidth/3, 0, canvasWidth/3, (marginWidth/tableWidth)*canvasWidth);
  
  tableCanvas.rect(0, (marginWidth/tableWidth)*canvasWidth, (marginWidth/tableWidth)*canvasWidth, canvasHeight-2*(marginWidth/tableWidth)*canvasWidth);
  tableCanvas.rect(canvasWidth-(marginWidth/tableWidth)*canvasWidth, (marginWidth/tableWidth)*canvasWidth, (marginWidth/tableWidth)*canvasWidth, canvasHeight-2*(marginWidth/tableWidth)*canvasWidth);
  
  tableCanvas.rect(0, canvasHeight-(marginWidth/tableWidth)*canvasWidth, canvasWidth/3, (marginWidth/tableWidth)*canvasWidth);
  tableCanvas.rect(canvasWidth/3, canvasHeight-(marginWidth/tableWidth)*canvasWidth, canvasWidth/3, (marginWidth/tableWidth)*canvasWidth);
  tableCanvas.rect(2*canvasWidth/3, canvasHeight-(marginWidth/tableWidth)*canvasWidth, canvasWidth/3, (marginWidth/tableWidth)*canvasWidth);
  
  // End Margaret's Containers
  
  tableCanvas.endDraw();
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

public void setMercator(int w, int h) { //Run this function before drawing latitude and longitude-based data
  //Mercator Coordinates
  tableCanvas.translate(w/2, h/2);
  tableCanvas.rotate(rotation*TWO_PI/360);
  tableCanvas.translate(-w/2, -h/2);
}

public void unsetMercator(int w, int h) { //Run this function before drawing text, legends, etc
  //Canvas Coordinates
  tableCanvas.translate(w/2, h/2);
  tableCanvas.rotate(-rotation*TWO_PI/360);
  tableCanvas.translate(-w/2, -h/2);
}


boolean sketchFullScreen() {
  return true;
}


void movieEvent(Movie m) {
  m.read();
}
