// This is the staging script to allow splitting 4k projection mapping across two sets of two projectors

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
    
    PGraphics tableCanvas;
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
  topo = loadImage("test6200x2200.png");
  
  // loads the saved layout
  ks.load();
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
  }
}

void drawTableCanvas() {
  tableCanvas.beginDraw();
  tableCanvas.background(255);
  tableCanvas.image(topo, (marginWidth/tableWidth)*canvasWidth, (marginWidth/tableHeight)*canvasHeight, (topoWidth/tableWidth)*canvasWidth, (topoHeight/tableHeight)*canvasHeight);
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

boolean sketchFullScreen() {
  return true;
}
