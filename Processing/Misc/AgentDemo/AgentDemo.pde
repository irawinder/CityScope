// This is the staging script for the Pathfinding for agent-based modeling
// Ira Winder, MIT Media Lab, jiw@mit.edu, Fall 2015

int canvasWidth = 1000;
int canvasHeight = 500;
    
// Key Commands:
//
//   Data Navigation
//     'D' = Next Data Mode
//         dataMode = 1 for random network
//         dataMode = 0 for empty network and Pathfinder Test OD
//
//   Rendering:
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
String loadText = "AgentDemo | Version " + version;

boolean showFrameRate = false;
boolean printFrames = false;

// used to initialize objects when application is first run or reInitialized
boolean initialized = false;

// Number of frames for draw function to run before
// running setup functions. Setting to greater than 0 
// allows you to draw a loading screen
int drawDelay = 10;

void setup() {
  size(canvasWidth + 200, canvasHeight, P3D);
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
    initContent(tableCanvas);
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
    
       button = new Button(canvasWidth+10, 10, "Refresh Visualization");
      button2 = new Button(canvasWidth+10, 40, "Show/Hide Info");
      button3 = new Button(canvasWidth+10, 70, "Show/Hide Sinks");
      button4 = new Button(canvasWidth+10, 100, "Show/Hide Edges");
      button5 = new Button(canvasWidth+10, 130, "Print Framerate to Console");
      button6 = new Button(canvasWidth+10, 160, "Show/Hide Info");
      button7 = new Button(canvasWidth+10, 190, "Show/Hide Sinks");
      button8 = new Button(canvasWidth+10, 220, "Show/Hide Edges");
      button9 = new Button(canvasWidth+10, 250, "Refresh Visualization");
      button10 = new Button(canvasWidth+10, 280, "Show/Hide Info");
      button11 = new Button(canvasWidth+10, 310, "Show/Hide Sinks");
      button12 = new Button(canvasWidth+10, 340, "Show/Hide Edges");
      button13 = new Button(canvasWidth+10, 370, "Refresh Visualization");
      button14 = new Button(canvasWidth+10, 400, "Show/Hide Info");
      button15 = new Button(canvasWidth+10, 430, "Show/Hide Sinks");
      button16 = new Button(canvasWidth+10, 460, "Show/Hide Edges");
      button17 = new Button(canvasWidth+10, 490, "Refresh Visualization");
      button18 = new Button(canvasWidth+10, 520, "Show/Hide Info");
      button19 = new Button(canvasWidth+10, 550, "Show/Hide Sinks");
      
      button.draw();
      button2.draw();
      button3.draw();
      button4.draw();
      button5.draw();
      button6.draw();
      button7.draw();
      button8.draw();
      button9.draw();
      button10.draw();
      button11.draw();
      button12.draw();
      button13.draw();
      button14.draw();
      button15.draw();
      button16.draw();
      button17.draw();
      button18.draw();
      button19.draw();
      
      
    
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
  // most likely, you'll want a black background
  background(0);
  
  // Renders the tableCanvas as either a projection map or on-screen 
  image(tableCanvas, 0, 0, tableCanvas.width, tableCanvas.height);
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

