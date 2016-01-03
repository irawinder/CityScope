// This is the staging script to allow splitting 4k projection mapping across 4 projectors
// It's also the staging area for the AI of some agent-based modeling
// For Andorra Data Stories
// Ira Winder, MIT Media Lab, jiw@mit.edu, Fall 2015

// To Do:
// Callibrate Agent Lifespans
// Make a Horde Class for Swarms
// Get Rid of Flickering Sources and Sinks

// In general, migrate global "void drawFoo()" methods into class-specific "display()" methods
// Consolidate Agents, Obstacles, and Pathfinder classes to libraries and/or standalone applets and/or libraries?

// Need Libaries:
// Keystone for Processing

// Table SetUp with Margin:
//
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
//   Data Navigation
//     'D' = Next Data Mode
//         dataMode = 3 for Andorra CDR Network (circa Dec 2015)
//         dataMode = 2 for basic network of Andorra Tower Locations
//         dataMode = 1 for random network
//         dataMode = 0 for empty network and Pathfinder Test OD
//     'I' - Next OD Data Set
//     ']' - Go forward an hour in OD dataset
//     '[' - Go backward an hour in OD dataset 
//     'd' - Show/hide test geodata
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
//      case 'i': Show Swarm Index
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
//      case 'b': Toggle Background color black/white
//
//    Obstacle Editor:
//      'E': toggle editing
//      'A': Add Obstacle
//      'R': Remove Obstacle
//      'SPACEBAR': Select next Obstacle to edit
//      'CLICK' add vertex to selected obstacle
//      'DELETE' remove vertex from selected obstacle
//       Arrow Keys - fine movement of seleted vertex in obstacle
//      's' save CSV file of boundary locations (if editor is on)
//      'l' load CSV file of boundary locations (if editor is on)
//
//    Pathfinding Tools:
//      'P': show/hide pathfinder network
//      'h': show/hide additional info about pathfinder network
//      'X': regenerate a random origin and destination
//      'n': regenerate a random network for testing


// set to true when running app to prevent fullScreen Mode
// also enables some visualizations for debugging
boolean debug = true;
boolean showFrameRate = false;
boolean printFrames = false;

// Only set this to true if projectors display output is 4k
// Also set to false if developing on your machine in 1080p
boolean use4k = false;

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
  
  initCanvas();
  initContent();
  
  tableCanvas.beginDraw();
  tableCanvas.background(background);
  tableCanvas.endDraw();
  
}

void draw() {

  // Draw Functions Located hear should exclusively be draw onto 'tableCanvas',
  // a PGraphics set up to hold all information that will eventually be 
  // projection-mapped onto a big giant table
  
      // Renders frame onto 'tableCanvas' PGraphic (Margins, basemap, and sample Geo-Data)
      drawTableCanvas(tableCanvas);
  
  // -----------------------------------------------------------------------------
  // -----------------------------------------------------------------------------
  
  
  
  
  
  // Renders the finished tableCanvas onto main canvas as a projection map or screen
  renderTableCanvas();
  
  // Draws a line graph of all data for given OD matrix
  if (load_non_essential_data) {
    drawLineGraph();
  }
  
  // Print Framerate of animation to console
  if (showFrameRate) {
    println(frameRate);
  }
  
  // If true, saves every frame of the main canvas to a PNG
  if (printFrames) {
    //tableCanvas.save("videoFrames/" + millis() + ".png");
    save("videoFrames/" + millis() + ".png");
  }
  
}

void renderTableCanvas() {
  // most likely, you'll want a black background to minimize
  // bleeding around your projection area
  background(0);
  
  // Renders the tableCanvas as either a projection map or on-screen 
  switch (drawMode) {
    case 0: // On-Screen Rendering
      //image(tableCanvas, 0, (height-tableCanvas.height)/2, tableCanvas.width, tableCanvas.height);
      image(tableCanvas, 0, 0, tableCanvas.width, tableCanvas.height);
      break;
    case 1: // Projection-Mapping Rendering
      // render the scene, transformed using the corner pin surface
      for (int i=0; i<surface.length; i++) {
        chopScreen(i);
        surface[i].render(offscreen);
      }
      break;
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


