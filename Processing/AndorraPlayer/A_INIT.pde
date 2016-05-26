//
// ---------------------Initialize Graphics Objects for Projection-Mapping ---
//f
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
  
  println("Initializing Canvas and Projection Mapping Objects ... ");
  
  if (!use4k && !initialized) {
    float reduce = 0.5;
    
    canvasWidth    *= reduce;
    canvasHeight   *= reduce;
    topoWidthPix   *= reduce;
    topoHeightPix  *= reduce;
    marginWidthPix *= reduce;
    
    for (int i=0; i<container_Locations.length; i++) {
      container_Locations[i].mult(reduce);
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
  
  if (!debug) {
    // Opens Projection-mapping when debug is off
    drawMode = 1;
  }
  
  // Adjusts Colors and Transparency depending on whether visualization is on screen or projected
  setScheme(drawMode);
  
  println("Canvas and Projection Mapping complete.");
}

void initContent() {
  
  switch(dataMode) {
    case 0: // Pathfinder Demo
      showGrid = true;
      finderMode = 0;
      showEdges = false;
      showSource = false;
      showPaths = false;
      break;
    case 1: // Random Demo
      showGrid = true;
      finderMode = 0;
      showEdges = false;
      showSource = false;
      showPaths = false;
      break;
    case 2: // Wifi and Towers Demo
      showGrid = false;
      finderMode = 2;
      showEdges = false;
      showSource = false;
      showPaths = false;
      break;
    case 3: // Andorra Demo
      showGrid = false;
      finderMode = 2;
      showEdges = false;
      showSource = false;
      showPaths = false;
      break;
    case 4: //Hotel and Amenities Demo 
      showGrid = false; 
      finderMode = 2;
      showEdges = false;
      showSource = false;
      showPaths = false;
      showSwarm = true;
      break;
  }
  
  // Loads MercatorMap projecetion for canvas, csv files referenced in 'DATA' tab, etc
  initData();
  
  initObstacles();
  initPathfinder(tableCanvas, 10);
  initAgents(tableCanvas);
  
  //hurrySwarms(1000);
  println("Initialization Complete.");
}


// ---------------------Initialize Agent-based Objects---

Horde swarmHorde;

PVector[] origin, destination, nodes, origin_coord, destination_coord, origin_CDR, destination_CDR;
float[] weight;

int textSize = 8;

boolean enablePathfinding = true;

HeatMap traces;

PGraphics sources_Viz, edges_Viz;

void initAgents(PGraphics p) {
  
  println("Initializing Agent Objects ... ");
  
  swarmHorde = new Horde(2000);
  
  sources_Viz = createGraphics(p.width, p.height);
  edges_Viz = createGraphics(p.width, p.height);
  maxFlow = 0;
  resetSummary();
  CDRNetwork();
  
  switch(dataMode) {
    case 0:
      testNetwork_Random(0);
      break;
    case 1:
      testNetwork_Random(16);
      break;
    case 2:
      testNetwork_CDRWifi(true, true);
      break;
    case 3:
      CDRNetwork();
      break;
    case 4: 
      CDRNetwork();
      break;
  }
  
  swarmPaths(p, enablePathfinding);
  sources_Viz(p);
  edges_Viz(p);
  traces = new HeatMap(canvasWidth/5, canvasHeight/5, canvasWidth, canvasHeight);
  
  println("Agents initialized.");
}

void swarmPaths(PGraphics p, boolean enable) {
  // Applyies pathfinding network to swarms
  swarmHorde.solvePaths(pFinder, enable);
  pFinderPaths_Viz(p, enable);
}

void sources_Viz(PGraphics p) {
  sources_Viz = createGraphics(p.width, p.height);
  sources_Viz.beginDraw();
  // Draws Sources and Sinks to canvas
  swarmHorde.displaySource(sources_Viz);
  sources_Viz.endDraw(); 
}

void edges_Viz(PGraphics p) {
  edges_Viz = createGraphics(p.width, p.height);
  edges_Viz.beginDraw();
  // Draws Sources and Sinks to canvas
  swarmHorde.displayEdges(edges_Viz);
  edges_Viz.endDraw(); 
}

void hurrySwarms(int frames) {
  //speed = 20;
  showSwarm = false;
  showEdges = false;
  showSource = false;
  showPaths = false;
  showTraces = false;
  for (int i=0; i<frames; i++) {
    swarmHorde.update();
  }
  showSwarm = true;
  //speed = 1.5;
}

// dataMode for random network
void testNetwork_Random(int _numNodes) {
  
  int numNodes, numEdges, numSwarm;
  
  numNodes = _numNodes;
  numEdges = numNodes*(numNodes-1);
  numSwarm = numEdges;
  
  nodes = new PVector[numNodes];
  origin = new PVector[numSwarm];
  destination = new PVector[numSwarm];
  weight = new float[numSwarm];
  swarmHorde.clearHorde();
  
  for (int i=0; i<numNodes; i++) {
    nodes[i] = new PVector(random(10, canvasWidth-10), random(10, canvasHeight-10));
  }
  
  for (int i=0; i<numNodes; i++) {
    for (int j=0; j<numNodes-1; j++) {
      
      origin[i*(numNodes-1)+j] = new PVector(nodes[i].x, nodes[i].y);
      
      destination[i*(numNodes-1)+j] = new PVector(nodes[(i+j+1)%(numNodes)].x, nodes[(i+j+1)%(numNodes)].y);
      
      weight[i*(numNodes-1)+j] = random(0.1, 2.0);
      
      //println("swarm:" + (i*(numNodes-1)+j) + "; (" + i + ", " + (i+j+1)%(numNodes) + ")");
    }
  }
  
    // rate, life, origin, destination
  colorMode(HSB);
  for (int i=0; i<numSwarm; i++) {
    
    // delay, origin, destination, speed, color
    swarmHorde.addSwarm(weight[i], origin[i], destination[i], 1, color(255.0*i/numSwarm, 255, 255));

    
    // Makes sure that agents 'staying put' eventually die
    swarmHorde.getSwarm(i).temperStandingAgents();
  }
  colorMode(RGB);
  
  swarmHorde.popScaler(1.0);
}

// dataMode for basic network of Andorra Tower Locations
void testNetwork_CDRWifi(boolean CDR, boolean Wifi) {
  
  int numNodes, numEdges, numSwarm;
  
  numNodes = 0;
  if (CDR) {
    numNodes += localTowers.getRowCount();
  }
  if (Wifi) {
    numNodes += frenchWifi.getRowCount();
  }
  
  numEdges = numNodes*(numNodes-1);
  numSwarm = numEdges;
  
  nodes = new PVector[numNodes];
  origin = new PVector[numNodes];
  destination = new PVector[numSwarm];
  weight = new float[numSwarm];
  swarmHorde.clearHorde();
  
  
  for (int i=0; i<numNodes; i++) {
    for (int j=0; j<numNodes-1; j++) {
      destination[i*(numNodes-1)+j] = new PVector(nodes[(i+j+1)%(numNodes)].x, nodes[(i+j+1)%(numNodes)].y);
      
      weight[i*(numNodes-1)+j] = random(2.0);
      
      //println("swarm:" + (i*(numNodes-1)+j) + "; (" + i + ", " + (i+j+1)%(numNodes) + ")");
    }
  }
  
    // rate, life, origin, destination
  colorMode(HSB);
  for (int i=0; i<numSwarm; i++) {
    
    boolean external = topoBoundary.testForCollision(origin[i]) || topoBoundary.testForCollision(destination[i]);
    
    // delay, origin, destination, speed, color
    swarmHorde.addSwarm(weight[i], origin[i], destination[i], 1, color(255.0*i/numSwarm, 255, 255));
    
    // Makes sure that agents 'staying put' eventually die
    // also that they don't blead into the margin or topo
    swarmHorde.getSwarm(i).temperStandingAgents(external);
  }
  colorMode(RGB);

  swarmHorde.popScaler(1.0);
}

//make array of spanish speaking
//make array of other

void CDRNetwork() {
  
  int numSwarm;
  color col;
  
  numSwarm = network.getRowCount();
  
  
  
  origin = new PVector[numSwarm];
  origin_coord = new PVector[numSwarm];
  origin_CDR = new PVector[numSwarm];
  destination = new PVector[numSwarm];
  destination_coord = new PVector[numSwarm];
  destination_CDR = new PVector[numSwarm];
  weight = new float[numSwarm];
  swarmHorde.clearHorde();

  
  int w = 1;
  float minDistanceOrigin = 0;
  float minDistanceDestination = 0;
  int minIndexOrigin = 0;
  int minIndexDestination = 0;
  boolean external = false;
  PVector v_tower1 = new PVector(1112, 217, 0);
  PVector v_tower2 = new PVector(793, 232, 0);
  PVector v_tower3 = new PVector(470, 92,0);
  PVector v_tower4 = new PVector(963, 342,0);
  PVector v_tower5 = new PVector(377, 123, 0);
  PVector v_tower6 = new PVector(601, 517, 0);
  PVector v_tower7 = new PVector(545, 319, 0);
  PVector v_tower8 = new PVector(806, 41, 0);
  PVector v_tower9 = new PVector(259, 112, 0);
  PVector v_tower10 = new PVector(515, 68, 0);
  PVector v_tower11 = new PVector(520, 10, 0);
  ArrayList<PVector> tower_1 = new ArrayList<PVector>();
  ArrayList<PVector> tower_2 = new ArrayList<PVector>();
  ArrayList<PVector> tower_3 = new ArrayList<PVector>();
  ArrayList<PVector> tower_4 = new ArrayList<PVector>();
  ArrayList<PVector> tower_5 = new ArrayList<PVector>();
  ArrayList<PVector> tower_6 = new ArrayList<PVector>();
  ArrayList<PVector> tower_7 = new ArrayList<PVector>();
  ArrayList<PVector> tower_8 = new ArrayList<PVector>();
  ArrayList<PVector> tower_9 = new ArrayList<PVector>();
  ArrayList<PVector> tower_10 = new ArrayList<PVector>();
  ArrayList<PVector> tower_11 = new ArrayList<PVector>();

  
  for (int i=0; i<numSwarm; i++) {
           
   if (network.getInt(i, "CON_O") == 0 && network.getInt(i, "CON_D") == 0) {  
            destination[i] = mercatorMap.getScreenLocation(new PVector(network.getFloat(i, "LAT_D"), network.getFloat(i, "LON_D")));
            origin[i] = mercatorMap.getScreenLocation(new PVector(network.getFloat(i, "LAT_O"), network.getFloat(i, "LON_O"))); 

                    for(int j =0; j<marc_rest.getRowCount(); j++){
                        
                        origin_coord[j] = mercatorMap.getScreenLocation(new PVector(marc_rest.getFloat(j, "LAT"), marc_rest.getFloat(j, "LNG")));
                        destination_coord[j] = mercatorMap.getScreenLocation(new PVector(marc_rest.getFloat(j, "LAT"), marc_rest.getFloat(j, "LNG")));
                        
                        origin_coord[j] = new PVector(origin_coord[j].x + marginWidthPix, origin_coord[j].y + marginWidthPix);
                        destination_coord[j] = new PVector(destination_coord[j].x + marginWidthPix, destination_coord[j].y + marginWidthPix);

                         PVector dist_origin_1 = PVector.sub(v_tower1, origin[i]);
                         PVector dist_dest_1 = PVector.sub(v_tower1, destination[i]);
                         PVector dist_origin_2 = PVector.sub(v_tower2, origin[i]);
                         PVector dist_dest_2 = PVector.sub(v_tower2, destination[i]);
                         PVector dist_origin_3 = PVector.sub(v_tower3, origin[i]);
                         PVector dist_dest_3 = PVector.sub(v_tower3, destination[i]);
                         PVector dist_origin_4 = PVector.sub(v_tower4, origin[i]);
                         PVector dist_dest_4 = PVector.sub(v_tower4, destination[i]);
                         PVector dist_origin_5 = PVector.sub(v_tower5, origin[i]);
                         PVector dist_dest_5 = PVector.sub(v_tower5, destination[i]);
                         PVector dist_origin_6 = PVector.sub(v_tower6, origin[i]);
                         PVector dist_dest_6 = PVector.sub(v_tower6, destination[i]);
                         PVector dist_origin_7 = PVector.sub(v_tower7, origin[i]);
                         PVector dist_dest_7 = PVector.sub(v_tower7, destination[i]);
                         PVector dist_origin_8 = PVector.sub(v_tower8, origin[i]);
                         PVector dist_dest_8 = PVector.sub(v_tower8, destination[i]);
                         
                         PVector dist_origin_9 = PVector.sub(v_tower9, origin[i]);
                         PVector dist_dest_9 = PVector.sub(v_tower9, destination[i]);
                         
                         
                         PVector dist_origin_10 = PVector.sub(v_tower10, origin[i]);
                         PVector dist_dest_10 = PVector.sub(v_tower10, destination[i]);
                         PVector dist_origin_11 = PVector.sub(v_tower11, origin[i]);
                         PVector dist_dest_11 = PVector.sub(v_tower11, destination[i]);
                         
                         
                         float m = dist_origin_1.mag();
                         float o = dist_dest_1.mag();
                         float p = dist_origin_2.mag();
                         float q = dist_dest_2.mag();
                         float dist_3_origin = dist_origin_3.mag();
                         float dist_3_dest = dist_dest_3.mag();
                         float dist_4_origin = dist_origin_4.mag();
                         float dist_4_dest = dist_dest_4.mag();
                         float dist_5_origin = dist_origin_5.mag();
                         float dist_5_dest = dist_dest_5.mag();
                         float dist_6_origin = dist_origin_6.mag();
                         float dist_6_dest = dist_dest_6.mag();
                         float dist_7_origin = dist_origin_7.mag();
                         float dist_7_dest = dist_dest_7.mag();
                         float dist_8_origin = dist_origin_8.mag();
                         float dist_8_dest = dist_dest_8.mag();                         
                         float dist_9_origin = dist_origin_9.mag();
                         float dist_9_dest = dist_dest_9.mag();
                         float dist_10_origin = dist_origin_10.mag();
                         float dist_10_dest = dist_dest_10.mag();
                         float dist_11_origin = dist_origin_11.mag();
                         float dist_11_dest = dist_dest_11.mag();
                         
                         
                        if(m <= 5){
                          if(tower_1.size() >= 1){
                          int h = int(random(0, tower_1.size()));
                          origin[i] = tower_1.get(h);
                          }
                        }
                        
                        if(o <= 5){
                          if(tower_1.size() >= 1){
                          int h = int(random(0, tower_1.size()));
                          destination[i] = tower_1.get(h);
                          }
                        }
                        
                        if(p <= 5){
                          if(tower_2.size() >= 1){
                          int h = int(random(0, tower_2.size()));
                          origin[i] = tower_2.get(h);
                          }
                        }
                        
                        if(q <= 5){
                          if(tower_2.size() >= 1){
                          int h = int(random(0, tower_2.size()));
                          destination[i] = tower_2.get(h);
                          }
                        }
                        
                        if(dist_3_origin <= 5){
                          if(tower_3.size() >= 1){
                          int h = int(random(0, tower_3.size()));
                          origin[i] = tower_3.get(h);
                          }
                        }
                        
                        if(dist_3_dest <= 5){
                          if(tower_3.size() >= 1){
                          int h = int(random(0, tower_3.size()));
                          destination[i] = tower_3.get(h);
                          }
                        }
                        
                        if(dist_4_origin <= 5){
                          if(tower_4.size() >= 1){
                          int h = int(random(0, tower_4.size()));
                          origin[i] = tower_4.get(h);
                          }
                        }
                        
                        if(dist_4_dest <= 5){
                          if(tower_4.size() >= 1){
                          int h = int(random(0, tower_4.size()));
                          destination[i] = tower_4.get(h);
                          }
                        }
                        
                       if(dist_5_origin <= 5){
                          if(tower_5.size() >= 1){
                          int h = int(random(0, tower_5.size()));
                          origin[i] = tower_5.get(h);
                          }
                        }
                        
                        if(dist_5_dest <= 5){
                          if(tower_5.size() >= 1){
                          int h = int(random(0, tower_5.size()));
                          destination[i] = tower_5.get(h);
                          }
                        }
                        
                        if(dist_6_origin <= 5){
                          if(tower_6.size() >= 1){
                          int h = int(random(0, tower_6.size()));
                          origin[i] = tower_6.get(h);
                          }
                        }
                        
                        if(dist_6_dest <= 5){
                          if(tower_6.size() >= 1){
                          int h = int(random(0, tower_6.size()));
                          destination[i] = tower_6.get(h);
                          }
                        }
                        
                        if(dist_7_origin <= 5){
                          if(tower_7.size() >= 1){
                          int h = int(random(0, tower_7.size()));
                          origin[i] = tower_7.get(h);
                          }
                        }
                        
                        if(dist_7_dest <= 5){
                          if(tower_7.size() >= 1){
                          int h = int(random(0, tower_7.size()));
                          destination[i] = tower_7.get(h);
                          }
                        }
                        
                        if(dist_8_origin <= 5){
                          if(tower_8.size() >= 1){
                          int h = int(random(0, tower_8.size()));
                          origin[i] = tower_8.get(h);
                          }
                        }
                        
                        if(dist_8_dest <= 5){
                          if(tower_8.size() >= 1){
                          int h = int(random(0, tower_8.size()));
                          destination[i] = tower_8.get(h);
                          }
                        }
                        
                        if(dist_9_origin <= 5){
                          if(tower_9.size() >= 1){
                          int h = int(random(0, tower_9.size()));
                          origin[i] = tower_9.get(h);
                          }
                        }
                        
                        if(dist_9_dest <= 5){
                          if(tower_9.size() >= 1){
                          int h = int(random(0, tower_9.size()));
                          destination[i] = tower_9.get(h);
                          }
                        }
                        
                       if(dist_10_origin <= 5){
                          if(tower_10.size() >= 1){
                          int h = int(random(0, tower_10.size()));
                          origin[i] = tower_10.get(h);
                          }
                        }
                        
                        if(dist_10_dest <= 5){
                          if(tower_10.size() >= 1){
                          int h = int(random(0, tower_10.size()));
                          destination[i] = tower_10.get(h);
                          }
                        }
                        
                       if(dist_11_origin <= 5){
                          if(tower_11.size() >= 1){
                          int h = int(random(0, tower_11.size()));
                          origin[i] = tower_11.get(h);
                          }
                        }
                        
                        if(dist_11_dest <= 5){
                          if(tower_11.size() >= 1){
                          int h = int(random(0, tower_11.size()));
                          destination[i] = tower_11.get(h);
                          }
                        }
                        
        //rest arrays calculations                 
                            PVector v4 = PVector.sub(v_tower1, origin_coord[j]);
                                float n = v4.mag();
                                
                                if(abs(n) <= 200 && origin_coord[j].y > 120){
                                tower_1.add(origin_coord[j]);
                                println("tower 1", tower_1.size());
                                }
                                
                             PVector v10 = PVector.sub(v_tower2, origin_coord[j]);
                                float l = v10.mag();
                                
                                if(abs(l) <= 100 && origin_coord[j].y > 120){
                                tower_2.add(origin_coord[j]);
                                }    
                        
                             PVector v16 = PVector.sub(v_tower3, origin_coord[j]);
                                float k = v16.mag();
                                
                                if(abs(k) <= 300 && origin_coord[j].y > 120){
                                tower_3.add(origin_coord[j]);
                                }    
                                
                          PVector v22 = PVector.sub(v_tower4, origin_coord[j]);
                                float u = v22.mag();
                                
                                if(abs(u) <= 20 && origin_coord[j].y > 120){
                                tower_4.add(origin_coord[j]);
                                }
                                
                           PVector v28 = PVector.sub(v_tower5, origin_coord[j]);
                                float t = v28.mag();
                                
                                if(abs(t) <= 300 && origin_coord[j].y > 120){
                                tower_5.add(origin_coord[j]);
                                }    
                         
                         PVector v34 = PVector.sub(v_tower6, origin_coord[j]);
                                float r = v34.mag();
                                
                                if(abs(r) <= 200 && origin_coord[j].x < 650){
                                tower_6.add(origin_coord[j]);
                                }      
                                
                         PVector v40 = PVector.sub(v_tower7, origin_coord[j]);
                                float b = v40.mag();
                                
                                if(abs(b) <= 200 && abs(origin_coord[j].x - 545)>=20){
                                tower_7.add(origin_coord[j]);
                                }              
                                
                         PVector v46 = PVector.sub(v_tower8, origin_coord[j]);
                                float f = v46.mag();
                                
                                if(abs(f) <= 200 && origin_coord[j].y < 240){
                                tower_8.add(origin_coord[j]);
                                }   
                      
                         PVector v52 = PVector.sub(v_tower9, origin_coord[j]);
                                float s = v52.mag();
                                
                                if(abs(s) <= 300 && origin_coord[j].y > 150){
                                tower_9.add(origin_coord[j]);
                                }      
                 
                         PVector v58 = PVector.sub(v_tower10, origin_coord[j]);
                                float v = v58.mag();
                                
                                if(abs(v) <= 500 && origin_coord[j].y >120 && origin_coord[j].x < 750){
                                tower_10.add(origin_coord[j]);
                                }             
               
                         PVector v64 = PVector.sub(v_tower11, origin_coord[j]);
                                float g = v64.mag();
                                
                                if(abs(g) <= 500 && origin_coord[j].y > 120 && origin_coord[j].x < 750){
                                tower_11.add(origin_coord[j]);
                                println("tower 11", tower_11.size());
                                }                                     
                     }

            
   }
  }
  
  
//            for(int j=0; j<marc_rest.getRowCount(); j++){
//            origin_coord[j] = mercatorMap.getScreenLocation(new PVector(marc_rest.getFloat(j, "LAT"), marc_rest.getFloat(j, "LNG")));
//            destination_coord[j] = mercatorMap.getScreenLocation(new PVector(marc_rest.getFloat(j, "LAT"), marc_rest.getFloat(j, "LNG")));
//            
//            origin_coord[j] = new PVector(origin_coord[j].x + marginWidthPix, origin_coord[j].y + marginWidthPix);
//            destination_coord[j] = new PVector(destination_coord[j].x + marginWidthPix, destination_coord[j].y + marginWidthPix);
//            
//             minDistanceOrigin = pow((origin_coord[j].x - origin[1].x), 2)  +  pow((origin_coord[j].y - origin[1].y), 2);
//             minDistanceDestination = pow((destination_coord[j].x - destination[1].x), 2)  +  pow((destination_coord[j].y - destination[1].y), 2);
//             minIndexOrigin = 1;
//             minIndexDestination = 1;
//             
//             for(int i=2; i<numSwarm; i++){
//              if (network.getInt(i, "CON_O") == 0 && network.getInt(i, "CON_D") == 0) {  
//              float dist_o = pow((origin_coord[j].x - origin[i].x), 2)  +  pow((origin_coord[j].y - origin[i].y), 2);
//              float dist_d = pow((destination_coord[j].x - destination[i].x), 2)  +  pow((destination_coord[j].y - destination[i].y), 2);
//                              
//                             if (dist_o <= minDistanceOrigin)
//                             {
//                                 minDistanceOrigin = dist_o;
//                                 minIndexOrigin = i;
//                                 println("possible origin...", i, j);
//                            }
//                            
//                            if (dist_d <= minDistanceDestination)
//                             {
//                                 minDistanceDestination = dist_d;
//                                 minIndexDestination = i;
//                                 println("possible destination...", i, j);
//                            }
//                           
//                  } 
//                 }
//                 origin[minIndexOrigin] = origin_coord[j];
//                 destination[minIndexDestination] = destination_coord[j];
//               }
  
  for (int i=0; i<numSwarm; i++) {
      if(network.getInt(i, "CON_O") != 0 || network.getInt(i, "CON_D") != 0){
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
    swarmHorde.addSwarm(weight[i], origin[i], destination[i], 1, col);
    
    // Makes sure that agents 'staying put' eventually die
    // also that they don't blead into the margin or topo
    swarmHorde.getSwarm(i).temperStandingAgents(external);
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

void resetSummary() {
  summary = new Table();
  summary.addColumn("HOUR");
  summary.addColumn("TOTAL");
  summary.addColumn("SPANISH");
  summary.addColumn("FRENCH");
  summary.addColumn("OTHER");
}

// Sets to rates at specific hour ...
void setSwarmFlow(int hr) {
  
  checkValidHour(hourIndex);
  
  swarmHorde.setFrequency(100000);
  
  for (int i=0; i<OD.getRowCount(); i++) {
    if (OD.getInt(i, "HOUR") == hr) {
      swarmHorde.setFrequency( OD.getInt(i, "EDGE_ID"), 1.0/OD.getInt(i, "AMOUNT") );
      //println(1.0/OD.getInt(i, "AMOUNT"));
      date = OD.getString(i, "DATE");
    }
  }
  
  if (hr < summary.getRowCount()) {
    swarmHorde.popScaler(summary.getFloat(hr, "TOTAL")/maxFlow);
  } else {
    swarmHorde.popScaler(1.0);
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

void checkValidHour(int _hourIndex) {
  // Ensures that hourIndex doesn't null point
  if (_hourIndex > summary.getRowCount()) {
     hourIndex = summary.getRowCount()-1;
  }
}



//------------------Initialize Obstacles----

boolean showObstacles = false;
boolean editObstacles = false;
boolean testObstacles = true;

ObstacleCourse boundaries, grid, topoBoundary;
PVector[] obPts;

void initObstacles() {
  
  println("Initializing Obstacle Objects ...");
  
  // Single Obstacle that describes table
  topoBoundary = new ObstacleCourse();
  setObstacleTopo(marginWidthPix-10, marginWidthPix-10, topoWidthPix+20, topoHeightPix+20);
  
  // Gridded Obstacles for testing
  grid = new ObstacleCourse();
  testObstacles(testObstacles);
  
  // Obstacles for agents generates within Andorra le Vella
  boundaries = new ObstacleCourse();
  boundaries.loadCourse("data/course.tsv");
  
  println("Obstacles initialized.");
}

void testObstacles(boolean place) {
  if (place) {
    setObstacleGrid(32, 16);
  } else {
    setObstacleGrid(0, 0);
  }
}

void setObstacleTopo(int x, int y, int w, int h) {
  
  topoBoundary.clearCourse();
  
  obPts = new PVector[4];
  
  for (int i=0; i<obPts.length; i++) {
    obPts[i] = new PVector(0,0);
  }
  
  obPts[0].x = x;     obPts[0].y = y;
  obPts[1].x = x+w;   obPts[1].y = y;
  obPts[2].x = x+w;   obPts[2].y = y+h;
  obPts[3].x = x;     obPts[3].y = y+h;
  
  topoBoundary.addObstacle(new Obstacle(obPts));
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

Pathfinder pFinder;
int finderMode = 2;
// 0 = Random Noise Test
// 1 = Grid Test
// 2 = Custom

// Pathfinder test and debugging Objects
Pathfinder finderRandom, finderGrid, finderCustom;
PVector A, B;
ArrayList<PVector> testPath, testVisited;

// PGraphic for holding pFinder Viz info so we don't have to re-write it every frame
PGraphics pFinderPaths, pFinderGrid;

void initPathfinder(PGraphics p, int res) {
  
  println("Initializing Pathfinder Objects ... ");
  
  // Initializes a Custom Pathfinding network Based off of user-drawn Obstacle Course
  initCustomFinder(p, res);
  
  // Initializes a Pathfinding network Based off of standard Grid-based Obstacle Course
  initGridFinder(p, res);
  
  // Initializes a Pathfinding network Based off of Random Noise
  initRandomFinder(p, res);
  
  // Initializes an origin-destination coordinate for testing
  initOD(p);
  
  // sets 'pFinder' to one of above network presets
  setFinder(p, finderMode);
  initPath(pFinder, A, B);
  
  // Ensures that a valid path is always initialized upon start, to an extent...
  forcePath(p);
  
  // Initializes a PGraphic of the paths found
  pFinderGrid_Viz(p);
  
  println("Pathfinders initialized.");
}

void initCustomFinder(PGraphics p, int res) {
  finderCustom = new Pathfinder(p.width, p.height, res, 0.0); // 4th float object is a number 0-1 that represents how much of the network you would like to randomly cull, 0 being none
  finderCustom.applyObstacleCourse(boundaries);
}

void initGridFinder(PGraphics p, int res) {
  finderGrid = new Pathfinder(p.width, p.height, res, 0.0); // 4th float object is a number 0-1 that represents how much of the network you would like to randomly cull, 0 being none
  finderGrid.applyObstacleCourse(grid);  
}

void initRandomFinder(PGraphics p, int res) {
  finderRandom = new Pathfinder(p.width, p.height, res, 0.55);
}

// Refresh Paths and visualization; Use for key commands and dynamic changes
void refreshFinder(PGraphics p) {
  setFinder(p, finderMode);
  initPath(pFinder, A, B);
  swarmPaths(p, enablePathfinding);
  pFinderGrid_Viz(p);
}

// Completely rebuilds a selected Pathfinder Network
void resetFinder(PGraphics p, int res, int _finderMode) {
  switch(_finderMode) {
    case 0:
      initRandomFinder(p, res);
      break;
    case 1:
      initGridFinder(p, res);
      break;
    case 2:
      initCustomFinder(p, res);
      break;
  }
  setFinder(p, _finderMode);
}

void setFinder(PGraphics p, int _finderMode) {
  switch(_finderMode) {
    case 0:
      pFinder = finderRandom;
      break;
    case 1:
      pFinder = finderGrid;
      break;
    case 2:
      pFinder = finderCustom;
      break;
  }
}

void pFinderPaths_Viz(PGraphics p, boolean enable) {
  
  // Write Path Results to PGraphics
  pFinderPaths = createGraphics(p.width, p.height);
  pFinderPaths.beginDraw();
  swarmHorde.solvePaths(pFinder, enable);
  swarmHorde.displayPaths(pFinderPaths);
  pFinderPaths.endDraw();
  
}

void pFinderGrid_Viz(PGraphics p) {
  
  // Write Network Results to PGraphics
  pFinderGrid = createGraphics(p.width, p.height);
  pFinderGrid.beginDraw();
  if (dataMode == 0) {
    drawTestFinder(pFinderGrid, pFinder, testPath, testVisited);
  } else {
    pFinder.display(pFinderGrid);
  }
  pFinderGrid.endDraw();
}

// Ensures that a valid path is always initialized upon start, to an extent...
void forcePath(PGraphics p) {
  int counter = 0;
  while (testPath.size() < 2) {
    println("Generating new origin-destination pair ...");
    initOD(p);
    initPath(pFinder, A, B);
    
    counter++;
    if (counter > 1000) {
      break;
    }
  }
}

void initPath(Pathfinder f, PVector A, PVector B) {
  testPath = f.findPath(A, B, enablePathfinding);
  testVisited = f.getVisited();
}

void initOD(PGraphics p) {
  A = new PVector(random(1.0)*p.width, random(1.0)*p.height);
  B = new PVector(random(1.0)*p.width, random(1.0)*p.height);
}
