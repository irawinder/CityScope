// This is the staging script for the Pathfinding for agent-based modeling
// Ira Winder, MIT Media Lab, jiw@mit.edu, Fall 2015

int canvasWidth = 1000;
int canvasHeight = 540;
String refresh; 
String editor;
boolean show_menu = false;
boolean bw = true;

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
//     'T' - toggle demoMap underlay
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
  size(canvasWidth, canvasHeight, P3D);
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
//    
//    
    mainDraw();
    
    //strings for shared button placements
      if(dataMode == 1){
      refresh = "Refresh Visualization";
        }
      if(dataMode == 0) {
      refresh = "New Origin Destination Pair";
      }
      
      if(editObstacles == true){
      editor = "Exit Editor";
      }
      if(editObstacles == false){
      editor = "Enter Editor";
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
  

//directions
if(show_directions == true && dataMode != 2){
fill(abs(textColor-25), 200);
  noStroke();
  rect(10, 30, 0.4*width, 10*10+10-20, 12, 12, 12, 12);
  fill(background);
  text("Directions:", 20, 50);
  text("Click to add vertices. Use arrows to fine tune.", 20, 70);
}

//lightboxes for button
if(show_menu == true && editObstacles == false && dataMode != 2){
  if(showPaths){
  fill(textColor, 180);
  rect(canvasWidth - 180, 430, 82, 25, 5);
  }
  
  if(showSwarm && dataMode == 1){
  fill(textColor, 200);
  rect(canvasWidth - 180, 370, 82, 25, 5);}
  
  if(showTraces){
    fill(textColor, 180);
  rect(canvasWidth - 90, 400, 82, 25, 5);
  }
  
  if(showEdges){
   fill(textColor, 180);
  rect(canvasWidth - 180, 400, 82, 25, 5);
}
  
  if(showSource){
    fill(textColor, 170);
  rect(canvasWidth - 90, 370, 82, 25, 5);
}
  if(showPathInfo){
    fill(textColor, 180);
  rect(canvasWidth - 180, 40, 170, 25, 5);
}
  if(showInfo && dataMode == 1){
    fill(textColor, 180);
  rect(canvasWidth - 90, 430, 82, 25, 5);}
  
  if(button4_down){
  fill(textColor, 180);
  rect(canvasWidth - 180, 130, 170, 25, 5);
}

  if(showFrameRate && dataMode == 1){
     fill(textColor, 180);
  rect(canvasWidth - 180, 340, 170, 25, 5);
  }

  if(enablePathfinding){
  fill(textColor, 200);
  rect(canvasWidth - 180, 160, 170, 25, 5);}
  
}


if(initialized){
//master button to toggle menu display
      menu = new MenuButton(canvasWidth - 100, 10, "Show Menu");
      menu2 = new MenuButton(canvasWidth - 180, 10, "Hide Menu");
     
//global buttons    
      button = new Button(canvasWidth - 180, 70, refresh);
      button2 = new Button(canvasWidth - 180, 100, "Next Network"); //random, grid, custom (MIT), gridded obstacles 
      button3 = new Button(canvasWidth-180, 40, "Overview");
      button4 = new Button(canvasWidth-180, 130, "Invert Colors");
      menu5 = new MenuButton(canvasWidth-180, 220, "-");
      menu6 = new MenuButton(canvasWidth-30, 220, "+");
      button7 = new Button(canvasWidth-180, 160, "Path Finding");
      button8 = new Button(canvasWidth-180, 190, "Next Data Mode");
      
      if(show_menu == false){
      menu.draw();
    }
      
      if(show_menu == true && editObstacles == false && (finderMode == 0 || finderMode == 1 || finderMode == 2 | finderMode == 3)){
         fill(0, 70);
        rect(canvasWidth - 200, 0, 200, canvasHeight);
      menu2.draw();
      button.draw();
      button2.draw();
      button3.draw();
      button4.draw();
      fill(textColor);
      text("Transparency", canvasWidth -137, 237);
      menu5.draw();
      menu6.draw();
      button7.draw();
      button8.draw();
      }
      
      if(show_menu == true && editObstacles == true){
      fill(background, 50);
        rect(canvasWidth - 200, 0, 200, canvasHeight);
        menu2.draw();
      }
      
      
//buttons for not in obstacle editor
      if(editObstacles == false && dataMode == 1){
      menu9 = new MenuButton(canvasWidth-180, 280, "-");
      menu10 = new MenuButton(canvasWidth-30, 280, "+");
      button10 = new Button(canvasWidth-180, 310, "New Random Network");
      button11 = new Button(canvasWidth-180, 340, "Framerate");
      button12 = new HalfButton(canvasWidth-180, 370, "Agents");
      button30 = new HalfButton(canvasWidth-90, 370, "Sources");
      button13 = new HalfButton(canvasWidth-90, 400, "Traces");
      button14 = new HalfButton(canvasWidth-180, 400, "Edges");
      button15 = new HalfButton(canvasWidth-180, 430, "Paths");
      button31 = new HalfButton(canvasWidth-90, 430, "Swarm Info");
      
      if(show_menu == true){
      menu9.draw();
      fill(textColor);
      text("Speed", canvasWidth - 120, 295);
      menu10.draw();
      button10.draw();
      button11.draw();
      button12.draw();
      button13.draw();
      button14.draw();
      button15.draw();
      button30.draw();
      button31.draw();
      }
      }
      
//enter/exit obstacle editor button placement 
int y = 0; 
if(editObstacles == false){
  y = 490;
}

if(editObstacles == true){
  y = 490;
}

//enter/exit obstacle editor
      if(dataMode == 1){
        button16 = new Button(canvasWidth-180, y, editor);
        if(show_menu == true){
        button16.draw();
        }
      }

//buttons for obstacle editor       
      if(editObstacles == true && dataMode == 1){
      button17 = new Button(canvasWidth+10, 250, "Sources");
      button18 = new Button(canvasWidth+60, 250, "Agents");
      button19 = new Button(canvasWidth+10, 280, "Traces");
      button20 = new Button(canvasWidth+70, 280, "Edges");
      menu21 = new MenuButton(canvasWidth+10, 220, "+");
      fill(255);
      //text("Speed", canvasWidth + 40, 235);
      menu22 = new MenuButton(canvasWidth+90, 220, "-");
      button23 = new Button(canvasWidth+10, 310, "Print Framerate to Console");
      button32 = new Button(canvasWidth-180, 40, "Directions");
      button24 = new Button(canvasWidth-180, 250, "Save Layout");
      button25 = new Button(canvasWidth-180, 70, "Load Saved Layout");
      button26 = new Button(canvasWidth-180, 100, "Add Obstacle");
      button33 = new Button(canvasWidth-180, 130, "Next Obstacle");
      button27 = new Button(canvasWidth-180, 160, "Remove Obstacle");
      button28 = new Button(canvasWidth-180, 190, "Jump Vertex");
      button29 = new Button(canvasWidth-180, 220, "Remove Vertex");
      button34 = new ThirdButton(canvasWidth-180, 310, "Apply");
      button35 = new ThirdButton(canvasWidth-120, 310, "OK");
      button36 = new ThirdButton(canvasWidth-60, 310, "Cancel");
      
      
      if(show_menu == true){
      button24.draw();
      button25.draw();
      button26.draw();
      button27.draw();
      button28.draw();
      button29.draw();
      button32.draw();
      button33.draw();
      button34.draw();
      button35.draw();
      button36.draw();
      }
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

