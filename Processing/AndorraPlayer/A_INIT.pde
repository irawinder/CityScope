//
// ---------------------Initialize Graphics Objects for Projection-Mapping ---
//
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

// Projector dimensions in Pixels
    
    int numProjectors = 4;
    
//    int projectorWidth = 1920;
//    int projectorHeight = 1080;

    int projectorWidth = 1500;
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
    
    //---Projection-Mapping Objects
    import deadpixel.keystone.*;
    Keystone ks;
    CornerPinSurface[] surface = new CornerPinSurface[numProjectors];
    PGraphics offscreen;
    
boolean sketchFullScreen() {
  return !debug;
}
  
void initCanvas() {
  if (!use4k) {
    canvasWidth    /= 2;
    canvasHeight   /= 2;
    topoWidthPix   /= 2;
    topoHeightPix  /= 2;
    marginWidthPix /= 2;
    
    for (int i=0; i<container_Locations.length; i++) {
      container_Locations[i].mult(.5);
    }
  }
  
  // object for holding projection-map canvas callibration information
  ks = new Keystone(this);
  
  // Creates 4 cornerpin surfaces for projection mapping (1 for each projector)
  for (int i=0; i<surface.length; i++) {
    surface[i] = ks.createCornerPinSurface(canvasWidth/2, canvasHeight/2, 20);
  }
  
  // Largest Canvas that holds unchopped parent graphic.
  tableCanvas = createGraphics(canvasWidth, canvasHeight, P3D);
  
  // We need an offscreen buffer to draw the surface we
  // want projected
  // note that we're matching the resolution of the
  // CornerPinSurface.
  // (The offscreen buffer can be P2D or P3D)
  
  // Smaller PGraphic to hold quadrants 1-4 of parent tableCanvas.
  offscreen = createGraphics(canvasWidth/2, canvasHeight/2, P3D);
  
  // loads the saved projection-mapping layout
  ks.load();

}

void initContent() {
  // Loads MercatorMap projecetion for canvas, csv files referenced in 'DATA' tab, etc
  initData();
  
  initObstacles();
  initPathfinder(tableCanvas, 10);
  initAgents();
}





// ---------------------Initialize Agent-based Objects---

boolean showSource = true;
boolean showEdges = false;
boolean showSwarm = true;
boolean showInfo = false;
boolean showTraces = false;
boolean printFrames = false;

  int dataMode = 2;
  // dataMode = 0 for random network
  // dataMode = 1 for basic network of Andorra Tower Locations
  // dataMode = 2 for Andorra CDR Network (circa Dec 2015)

Swarm[] swarms;

PVector[] origin;
PVector[] destination;
PVector[] nodes;
float[] weight;

PVector[] obPts;

int textSize = 8;
int numAgents, maxAgents, maxFlow, agentCap;
int[] swarmSize;
float adjust; // dynamic scalar used to nomralize agent generation rate

int hourIndex = 16;
int maxHour = 23;
Table summary;
String date = "no data";

HeatMap traces;

void initAgents() {
  
  agentCap = 2000;
  adjust = 1;
  maxFlow = 0;
  
  summary = new Table();
  summary.addColumn("HOUR");
  summary.addColumn("TOTAL");
  summary.addColumn("SPANISH");
  summary.addColumn("FRENCH");
  summary.addColumn("OTHER");
  
  CDRNetwork();
  
  switch(dataMode) {
    case 0:
      testNetwork_Random();
      break;
    case 1:
      testNetwork_CDRWifi();
      break;
    case 2:
      CDRNetwork();
      break;
  }
      
  //touristNetwork();
  
  traces = new HeatMap(canvasWidth/5, canvasHeight/5, canvasWidth, canvasHeight);
  
}

void CDRNetwork() {
  
  int numSwarm;
  color col;
  
  numSwarm = network.getRowCount();
  
  origin = new PVector[numSwarm];
  destination = new PVector[numSwarm];
  weight = new float[numSwarm];
  swarmSize = new int[numSwarm];
  swarms = new Swarm[numSwarm];
  
  for (int i=0; i<numSwarm; i++) {
    
    boolean external = false;
    
    // If edge is within table area
    if (network.getInt(i, "CON_O") == 0 && network.getInt(i, "CON_D") == 0) {
      origin[i] = mercatorMap.getScreenLocation(new PVector(network.getFloat(i, "LAT_O"), network.getFloat(i, "LON_O")));
      destination[i] = mercatorMap.getScreenLocation(new PVector(network.getFloat(i, "LAT_D"), network.getFloat(i, "LON_D")));
    } 
    
    // If edge crosses table area
    else {
      origin[i] = container_Locations[network.getInt(i, "CON_O")];
      destination[i] = container_Locations[network.getInt(i, "CON_D")];
      external = true;
    }
    

      
    weight[i] = 20;
    
    if (network.getString(i, "NATION").equals("sp")) {
      col = spanish;
    } else if (network.getString(i, "NATION").equals("fr")) {
      col = french;
    } else {
      col = other;
    }
    
    // delay, origin, destination, speed, color
    swarms[i] = new Swarm(weight[i], origin[i], destination[i], 1, col);
    swarms[i].solvePath(finder);
    
    if (external) {
      swarms[i].cropAgents = false;
      swarms[i].maxSpeed = 0.2;
    }
    
  }
  
  //Sets maximum range for hourly data
  maxHour = 0;
  for (int i=0; i<OD.getRowCount(); i++) {
    if (OD.getInt(i, "HOUR") > maxHour) {
      maxHour = OD.getInt(i, "HOUR");
    }
  }
  
  for (int i=0; i<maxHour+1; i++) {
    summary.addRow();
    summary.setInt(i, "HOUR", i);
    summary.setInt(i, "TOTAL", 0);
    summary.setInt(i, "SPANISH", 0);
    summary.setInt(i, "FRENCH", 0);
    summary.setInt(i, "OTHER", 0);
  }
  
  for (int i=0; i<OD.getRowCount(); i++) {
    String country = network.getString(OD.getInt(i, "EDGE_ID"), "NATION");
    if ( country.equals("sp") ) {
      summary.setInt(OD.getInt(i, "HOUR"), "SPANISH", summary.getInt(OD.getInt(i, "HOUR"), "SPANISH") + OD.getInt(i, "AMOUNT"));
    } else if ( country.equals("fr") ) {
      summary.setInt(OD.getInt(i, "HOUR"), "FRENCH", summary.getInt(OD.getInt(i, "HOUR"), "FRENCH") + OD.getInt(i, "AMOUNT"));
    } else if ( country.equals("other") ) {
      summary.setInt(OD.getInt(i, "HOUR"), "OTHER", summary.getInt(OD.getInt(i, "HOUR"), "OTHER") + OD.getInt(i, "AMOUNT"));
    }
    summary.setInt(OD.getInt(i, "HOUR"), "TOTAL", summary.getInt(OD.getInt(i, "HOUR"), "TOTAL") + OD.getInt(i, "AMOUNT"));
  }
  
  for (int i=0; i<summary.getRowCount(); i++) {
    if ( summary.getInt(i, "TOTAL") > maxFlow ) {
      maxFlow = summary.getInt(i, "TOTAL");
    }
  }
  
  // Sets to rates at specific hour ...
  setSwarmFlow(hourIndex);
}

// Sets to rates at specific hour ...
void setSwarmFlow(int hr) {
  
  for (int i=0; i<swarms.length; i++) {
    swarms[i].agentDelay = 100000;
  }
  
  for (int i=0; i<OD.getRowCount(); i++) {
    if (OD.getInt(i, "HOUR") == hr) {
      swarms[OD.getInt(i, "EDGE_ID")].agentDelay = 1.0/OD.getInt(i, "AMOUNT");
      //println(1.0/OD.getInt(i, "AMOUNT"));
      date = OD.getString(i, "DATE");
    }
  }
  
  if (hr < summary.getRowCount()) {
    maxAgents = int(agentCap * summary.getFloat(hr, "TOTAL")/maxFlow);
  } else {
    maxAgents = agentCap;
  }
}

int nextHour(int hr) {
  if (hr < maxHour) {
    hr++;
  } else {
    hr = 0;
  }
  println("Hour: " + hr + ":00 - " + (hr+1) + ":00");
  return hr;
}

//introducing new prevHour function for back button 
int prevHour(int hr){ 
  if (hr < maxHour && hr != 0) { 
    hr--; 
  } else{ 
    hr = maxHour;
    if (hr == maxHour){
    hr--;
    }
  } 
  return hr;
}

// dataMode for basic network of Andorra Tower Locations
void testNetwork_CDRWifi() {
  
  int numNodes, numEdges, numSwarm;
  numNodes = frenchWifi.getRowCount() + localTowers.getRowCount();
  numEdges = numNodes*(numNodes-1);
  numSwarm = numEdges;
  
  nodes = new PVector[numNodes];
  origin = new PVector[numSwarm];
  destination = new PVector[numSwarm];
  weight = new float[numSwarm];
  swarmSize = new int[numSwarm];
  
  for (int i=0; i<numNodes; i++) {
    
    if (i < frenchWifi.getRowCount()) { // load wifi routers
      nodes[i] = mercatorMap.getScreenLocation(new PVector(frenchWifi.getFloat(i, "Source_lat"), frenchWifi.getFloat(i, "Source_long")));
    } else { // Load cell towers
      nodes[i] = mercatorMap.getScreenLocation(new PVector(localTowers.getFloat(i-frenchWifi.getRowCount(), "Lat"), localTowers.getFloat(i-frenchWifi.getRowCount(), "Lon")));
    }
    nodes[i].x += marginWidthPix;
    nodes[i].y += marginWidthPix;
  }
  
  for (int i=0; i<numNodes; i++) {
    for (int j=0; j<numNodes-1; j++) {
      
      origin[i*(numNodes-1)+j] = new PVector(nodes[i].x, nodes[i].y);
      
      destination[i*(numNodes-1)+j] = new PVector(nodes[(i+j+1)%(numNodes)].x, nodes[(i+j+1)%(numNodes)].y);
      
      weight[i*(numNodes-1)+j] = random(2.0);
      
      //println("swarm:" + (i*(numNodes-1)+j) + "; (" + i + ", " + (i+j+1)%(numNodes) + ")");
    }
  }
  
    // rate, life, origin, destination
  swarms = new Swarm[numSwarm];
  colorMode(HSB);
  for (int i=0; i<numSwarm; i++) {
    // delay, origin, destination, speed, color
    swarms[i] = new Swarm(weight[i], origin[i], destination[i], 1, color(255.0*i/numSwarm, 255, 255));
  }
  colorMode(RGB);
  
  maxAgents = agentCap;
}

// dataMode for random network
void testNetwork_Random() {
  
  int numNodes, numEdges, numSwarm;
  
  numNodes = 8;
  numEdges = numNodes*(numNodes-1);
  numSwarm = numEdges;
  
  nodes = new PVector[numNodes];
  origin = new PVector[numSwarm];
  destination = new PVector[numSwarm];
  weight = new float[numSwarm];
  swarmSize = new int[numSwarm];
  
  for (int i=0; i<numNodes; i++) {
    nodes[i] = new PVector(random(10, canvasWidth-10), random(10, canvasHeight-10));
  }
  
  for (int i=0; i<numNodes; i++) {
    for (int j=0; j<numNodes-1; j++) {
      
      origin[i*(numNodes-1)+j] = new PVector(nodes[i].x, nodes[i].y);
      
      destination[i*(numNodes-1)+j] = new PVector(nodes[(i+j+1)%(numNodes)].x, nodes[(i+j+1)%(numNodes)].y);
      
      weight[i*(numNodes-1)+j] = random(2.0);
      
      //println("swarm:" + (i*(numNodes-1)+j) + "; (" + i + ", " + (i+j+1)%(numNodes) + ")");
    }
  }
  
    // rate, life, origin, destination
  swarms = new Swarm[numSwarm];
  colorMode(HSB);
  for (int i=0; i<numSwarm; i++) {
    // delay, origin, destination, speed, color
    swarms[i] = new Swarm(weight[i], origin[i], destination[i], 1, color(255.0*i/numSwarm, 255, 255));
  }
  colorMode(RGB);
  
  maxAgents = agentCap;
}




//------------------Initialize Obstacles----

boolean showObstacles = false;
boolean editObstacles = false;
boolean testObstacles = true;

ObstacleCourse boundaries;
ObstacleCourse grid;

void initObstacles() {
  // Gridded Obstacles for testing
  grid = new ObstacleCourse();
  testObstacles(testObstacles);
  
  // Obstacles for agents generates within Andorra le Vella
  boundaries = new ObstacleCourse();
  boundaries.loadCourse("data/course.tsv");
}

void testObstacles(boolean place) {
  if (place) {
    setObstacleGrid(32, 16);
  } else {
    setObstacleGrid(0, 0);
  }
}

void setObstacleGrid(int u, int v) {
  
  grid.clearCourse();
  
  float w = 0.75*float(canvasWidth)/(u+1);
  float h = 0.75*float(canvasHeight)/(v+1);
  
  obPts = new PVector[4];
  for (int i=0; i<obPts.length; i++) {
    obPts[i] = new PVector(0,0);
  }
  
  for (int i=0; i<u; i++) {
    for (int j=0; j<v; j++) {
      
      float x = float(canvasWidth)*i/(u+1)+w/2.0;
      float y = float(canvasHeight)*j/(v+1)+h/2.0;
      obPts[0].x = x;     obPts[0].y = y;
      obPts[1].x = x+w;   obPts[1].y = y;
      obPts[2].x = x+w;   obPts[2].y = y+h;
      obPts[3].x = x;     obPts[3].y = y+h;
      
      grid.addObstacle(new Obstacle(obPts));
    }
  }
}




//------------- Initialize Pathfinding Objects

Pathfinder finder;

// Pathfinder test and debugging Objects
Pathfinder finderTest, finderGrid;
PVector A, B;
ArrayList<PVector> testPath, testVisited;

void initPathfinder(PGraphics p, int res) {
  
  // Initializes a Pathfinding network
  finder = new Pathfinder(p.width, p.height, res, 0.0); // 4th float object is a number 0-1 that represents how much of the network you would like to randomly cull, 0 being none
  finder.applyObstacleCourse(boundaries);
  
  initOD(p);
  initNetwork(p, 10, 0.55);
  initPath(finderTest, A, B);
  
  // Ensures that a valid path is always initialized upon start, to an extent...
  int counter = 0;
  while (testPath.size() < 2) {
    println("Generating new origin-destination pair ...");
    initOD(p);
    initPath(finderTest, A, B);
    
    counter++;
    if (counter > 1000) {
      break;
    }
  }
}

void initNetwork(PGraphics p, int res, float cullRatio) {
  finderTest = new Pathfinder(p.width, p.height, res, cullRatio);
}

void initPath(Pathfinder finder, PVector A, PVector B) {
  testPath = finder.findPath(A, B);
  testVisited = finder.getVisited();
}

void initOD(PGraphics p) {
  A = new PVector(random(1.0)*p.width, random(1.0)*p.height);
  B = new PVector(random(1.0)*p.width, random(1.0)*p.height);
}
