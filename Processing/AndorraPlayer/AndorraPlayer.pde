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
//      case 'b': Toggle Background color black/white
//
//    ObStacle Editor:
//      'E': toggle editing
//      'A': Add Obstacle
//      'R': Remove Obstacle
//      'SPACEBAR': Select next Obstacle to edit
//      'CLICK' add vertex to selected obstacle
//      'DELETE' remove vertex from selected obstacle
//       Arrow Keys - fine movement of seleted vertex in obstacle
//      's' save CSV file of boundary locations (if editor is on)
//      'l' load CSV file of boundary locations (if editor is on)


// set to true when running app to prevent fullScreen Mode
// also enables some visualizations for debugging
boolean debug = true;

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
  
  if (loadData) {
    // Loads csv files referenced in data tab
    initData();
  }
  
  initPlayer();
  initAgents();
  initObstacles();
  
  tableCanvas.beginDraw();
  tableCanvas.background(background);
  tableCanvas.endDraw();
  
}

void draw() {
  
  // Renders frame onto 'tableCanvas' PGraphic
  drawTableCanvas();
  
  // Renders Agent 'dots' and corresponding obstacles and heatmaps
  drawAgents(); 

  // draws Table Canvas onto projection map or on screen
  drawTable();

  if (showFrameRate) {
    println(frameRate);
  }
  
  if (printFrames) {
    tableCanvas.save("videoFrames/" + millis() + ".png");
  }
  
  // Temporary Graph //
  
  fill(#FFFFFF);
  translate(float(1)/(maxHour+6)*width, 1.45*canvasHeight);
  text("Hr", 0, textSize);
  
  int graphHeight = 2*marginWidthPix;
  
  textAlign(CENTER);
  for (int i=0; i<=maxHour; i+=3) {
    float hor = float(i+2)/(maxHour+6)*width;
    text(i%24, hor, textSize);
  }
  
  
  noStroke();
  fill(french, 200);
  beginShape();
  vertex(float(0+2)/(maxHour+6)*width, 0 - 2*textSize);
  for (int i=0; i<=maxHour; i++) {
    float hor = float(i+2)/(maxHour+6)*width;
    vertex(hor, -graphHeight*summary.getFloat(i, "TOTAL")/maxFlow - 2*textSize);
  }
  vertex(float(maxHour+2)/(maxHour+6)*width, 0 - 2*textSize);
  endShape();
  
  noStroke();
  fill(spanish, 200);
  beginShape();
  vertex(float(0+2)/(maxHour+6)*width, 0 - 2*textSize);
  for (int i=0; i<=maxHour; i++) {
    float hor = float(i+2)/(maxHour+6)*width;
    vertex(hor, -graphHeight*(summary.getFloat(i, "TOTAL")-summary.getFloat(i, "FRENCH"))/maxFlow - 2*textSize);
  }
  vertex(float(maxHour+2)/(maxHour+6)*width, 0 - 2*textSize);
  endShape();
  
  noStroke();
  fill(other, 200);
  beginShape();
  vertex(float(0+2)/(maxHour+6)*width, 0 - 2*textSize);
  for (int i=0; i<=maxHour; i++) {
    float hor = float(i+2)/(maxHour+6)*width;
    vertex(hor, -graphHeight*(summary.getFloat(i, "TOTAL")-summary.getFloat(i, "FRENCH")-summary.getFloat(i, "SPANISH"))/maxFlow - 2*textSize);
  }
  vertex(float(maxHour+2)/(maxHour+6)*width, 0 - 2*textSize);
  endShape();
  
  textAlign(LEFT);
  textSize(18*(projectorWidth/1920.0));
  
  float hor = float(hourIndex+2)/(maxHour+6)*width;
  stroke(#00FF00, 150);
  fill(#00FF00);
  strokeWeight(2);
  line(hor, -graphHeight - 4*textSize, hor, -1.75*textSize);
  text(hourIndex%24 + ":00 - " + (hourIndex%24+1) + ":00", 
                   hor + 0.5*textSize, -graphHeight - 3*textSize);
  text(date, 
                   hor + 0.5*textSize, -graphHeight - 3*textSize + 2.5*textSize);
  
//  fill(french);
//  text(int(100*summary.getFloat(hourIndex, "FRENCH") / summary.getFloat(hourIndex, "TOTAL")) + "%", 
//                   hor + 0.5*textSize, -graphHeight - 3*textSize);
//  fill(spanish);
//  text(int(100*summary.getFloat(hourIndex, "SPANISH") / summary.getFloat(hourIndex, "TOTAL")) + "%", 
//                   hor + 0.5*textSize, -graphHeight - 3*textSize + 2*textSize);
//  fill(other);
//  text(int(100*summary.getFloat(hourIndex, "OTHER") / summary.getFloat(hourIndex, "TOTAL")) + "%", 
//                   hor + 0.5*textSize, -graphHeight - 3*textSize + 4*textSize);
  
  
  noStroke();
  
  translate(float(0+2)/(maxHour+6)*width, -1.5*graphHeight);
  
  fill(#FFFFFF);
  textSize(24*(projectorWidth/1920.0));
  textAlign(LEFT);
  text("Tourists |", 0, 0);
  
  fill(spanish);
  text("Spanish", 3.5*marginWidthPix, 0);
  
  fill(french);
  text("French", 2.0*marginWidthPix, 0);
  
  fill(other);
  text("Other", 5.0*marginWidthPix, 0);
  
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


