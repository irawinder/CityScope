// This is the staging script to allow splitting 4k projection mapping across 4 projectors
// For Andorra Data Stories
// Ira Winder, MIT Media Lab, jiw@mit.edu, Fall 2015

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

// Key Commands:
//
//     'g' - Toggle debug
//
//   View Mode:
//     'm' - Toggle On-Screen mode or Projection-mapping mode
//     'T' - Toggle Topographic Map
//
//   Projection Mapping:
//     'c' - Toggle callibration mode for projection mapping
//     's' - Save callibration
//     'l' - Load callibration
//
//   Agent-based Modeling:
//      case 'o': Show Obstacle Outlines
//      case 'k': Show Sources and Sinks for Agents
//      case 'r': Reset Agent Sinks and Sources
//      case 'f': Print Framerate to console
//      case 'S': Toggle display of agents
//      case 'e': Toggle display of network edges
//      case 'i': Toggle Information Menu
//      case 'p': Toggle Obstacles On/Off
//      case 't': Toggle HeatMap Visualization
//      case 'F': Toggle Frame-based or Time-based acceleration
//      case '+': Increase Agent Speed
//      case '-': Decrease Agent Speed


// set to true when running app to prevent fullScreen Mode
// also enables some visualizations for debugging
boolean debug = true;

// Only set this to true if projectors display output is 4k
// Also set to false if developing on your machine in 1080p
boolean use4k = false;

boolean loadData = false;

// Draw Modes:
// 0 = Render For Screen
// 1 = Render for Projection-Mapping
int drawMode = 0;

void setup() {
  //size(2*projectorWidth, 2*projectorHeight, P3D);
  
  // Keystone will only work with P3D or OPENGL renderers, 
  // since it relies on texture mapping to deform
  if (use4k) {
    size(2*projectorWidth, 2*projectorHeight, P3D);
  } else {
    size(projectorWidth, projectorHeight, P3D);
  }
  
  initPlayer();
  initAgents(0, 0);
  
}

void draw() {
  
  // Renders frame onto 'tableCanvas' PGraphic
  drawTableCanvas();
  
  drawAgents();
  
  // draws Table Canvas onto projection map or on screen
  drawTable();

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


