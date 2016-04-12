// This is the staging script to allow splitting 4k projection mapping across 4 projectors
// It's also the staging area for the AI of some agent-based modeling
// For Andorra Data Stories
// Ira Winder, MIT Media Lab, jiw@mit.edu, Fall 2015

/*
Nina To Do
1. Implement voronois about ammenities data
2. Ammenities data graph
3. Ammenities data radius thing 
*/

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

// set to true when running app to prevent fullScreen Mode
// also enables some visualizations for debugging
boolean debug = false;
//boolean debug = true;

int projectorWidth = 1920;
int projectorHeight = 1200;
//int projectorWidth = 1500;
//int projectorHeight = 1000;
    
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
//     '{' - decrease alpha for translucent graphics
//     '}' - increase alpha for translucent graphics
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
//      'P': show/hide pathfinder Paths
//      'G': show/hide pathfinder Grids
//      'h': show/hide additional info about pathfinder network
//      'X': regenerate a random origin and destination
//      'n': regenerate a random network for testing
//      '>': Next Pathfinder Network (Random, Gridded, and Custom)
//      '<': Enable/Disable Pathfinding

float version = 1.1;
String loadText = "Andorra Player | Version " + version;

boolean showFrameRate = false;
boolean printFrames = false;

// used to initialize objects when application is first run or reInitialized
boolean initialized = false;

// Number of frames for draw function to run before
// running setup functions. Setting to greater than 0 
// allows you to draw a loading screen
int drawDelay = 10;

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
  
//  //Call this method if data folder ever needs to be selected by a user
//  selectFolder("Please select the a folder and click 'Open'", "folderSelected");
}


void mainDraw() {
  // Draw Functions Located here should exclusively be drawn onto 'tableCanvas',
  // a PGraphics set up to hold all information that will eventually be 
  // projection-mapped onto a big giant table:
  drawTableCanvas(tableCanvas);
  
  if (!keyLoaded) {
    // Draws loading screen on top of last drawn content if keypressed while drawing
    loading(tableCanvas, loadText);
  }
  
  // Renders the finished tableCanvas onto main canvas as a projection map or screen
  renderTableCanvas();
  
  // Draws a line graph of all data for given OD matrix onto the main canvas
  if (load_non_essential_data && dataMode == 3 && drawMode == 0 || dataMode == 4) {
    drawLineGraph();
  }
}

void draw() {
  
  // If certain key commands are pressed, it causes a <0 delay which counts down in this section
  if (drawDelay > 0) {
    
    if (initialized) {
      mainDraw();
    } else {
      // Draws loading screen
      loading(tableCanvas, loadText);
      renderTableCanvas();
    }
    
    drawDelay--;
  }
  
  // These are usually run in setup() but we put them here so that 
  // the 'loading' screen successfully runs for the user
  else if (!initialized) {
    initContent();
    initialized = true;
  }
  
  // Methods run every frame (i.e. 'draw()' functions) go here
  else {
    
    // These are initialization functions that may be called while the app is running
    if (!keyLoaded) {
      keyInit();
      keyLoaded = true;  
    }
    
    mainDraw();
    
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

// Method that opens a folder
String folderPath;
void folderSelected(File selection) {
  if (selection == null) { // Notifies console and closes program
    println("User did not select a folder");
    exit();
  } else { // intitates the rest of the software
    println("User selected " + selection.getAbsolutePath());
    folderPath = selection.getAbsolutePath() + "/";
    // some other startup function
  }
}

