// Graphics object in memory that holds visualization
PGraphics tableCanvas;


PImage demoMap;

int dataMode = 1;
// dataMode = 1 for random network
// dataMode = 0 for empty network and Pathfinder Test OD

void initCanvas() {
  
  println("Initializing Canvas Objects ... ");
  
  // Largest Canvas that holds unchopped parent graphic.
  tableCanvas = createGraphics(canvasWidth, canvasHeight, P3D);
  
  // Adjusts Colors and Transparency depending on whether visualization is on screen or projected
  setScheme();
  
  println("Canvas and Projection Mapping complete.");

}

void initContent(PGraphics p) {
  
  switch(dataMode) {
    case 0: // Pathfinder Demo
      showGrid = true;
      finderMode = 0;
      showEdges = false;
      showSource = false;
      showPaths = false;
      showTraces = false;
      showInfo = false;
      break;
    case 1: // Random Demo
      showGrid = true;
      finderMode = 0;
      showEdges = false;
      showSource = true;
      showPaths = false;
      break;
//    case 2: // Random Demo
//      showGrid = true;
//      finderMode = 0;
//      showEdges = true;
//      showSource = true;
//      showPaths = true;
//      break;
  }
  
  initObstacles(p);
  initPathfinder(p, p.width/100);
  initAgents(p);
  //initButtons(p);
  
  demoMap = loadImage("data/demoMap.png");
  
  //hurrySwarms(1000);
  println("Initialization Complete.");
}





// ---------------------Initialize Agent-based Objects---

Horde swarmHorde;

PVector[] origin, origin2, origin3, origin4, origin5, origin6, origin7, origin8, origin9, origin10, origin11, origin12, origin13, origin14, origin15, destination, nodes;
float[] weight;

  

int textSize = 8;

boolean enablePathfinding = true;

HeatMap traces;

PGraphics sources_Viz, edges_Viz;

void initAgents(PGraphics p) {
  
  println("Initializing Agent Objects ... ");
  
  swarmHorde = new Horde(8000);
  sources_Viz = createGraphics(p.width, p.height);
  edges_Viz = createGraphics(p.width, p.height);
  
  switch(dataMode) {
    case 0:
      testNetwork_Random(p, 0);
      break;
    case 1:
      testNetwork_Random(p, 16);
      break;
    case 2: 
      testNetwork_Random(p, 16);
      break;
//    case 3: 
//      testNetwork_Random(p, 16);
//      showVoronoi = false;
//      break;
  }
  
  swarmPaths(p, enablePathfinding);
  sources_Viz(p);
  edges_Viz(p);
  traces = new HeatMap(p.width/5, p.height/5, p.width, p.height);
  
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
void testNetwork_Random(PGraphics p, int _numNodes) {
  
  int numNodes, numEdges, numSwarm;
  
  numNodes = _numNodes;
  numEdges = numNodes*(numNodes-1);
  numSwarm = numEdges;
  
  float[] towers_x = new float[numNodes];
  float[] towers_y = new float[numNodes];

  
  nodes = new PVector[numNodes];
  origin = new PVector[numSwarm];
  origin2 = new PVector[numSwarm];
  origin3 = new PVector[numSwarm];
  origin4 = new PVector[numSwarm];
  origin5 = new PVector[numSwarm];
  origin6 = new PVector[numSwarm];
  origin7 = new PVector[numSwarm];
  origin8 = new PVector[numSwarm];
  origin9 = new PVector[numSwarm];
  origin10 = new PVector[numSwarm];
  origin11 = new PVector[numSwarm];
  origin12 = new PVector[numSwarm];
  origin13 = new PVector[numSwarm];
  origin14 = new PVector[numSwarm];
  origin15 = new PVector[numSwarm];
  destination = new PVector[numSwarm];
  weight = new float[numSwarm];
  swarmHorde.clearHorde();

        color[] tower_colors = new color[16];
        tower_colors[0] = color(255, 0, 0); //red
        tower_colors[1] = color(0, 255, 0); //green
        tower_colors[2] = color(0, 0, 255); //cyan blue
        tower_colors[3] = color(255, 255, 0); //yellow 
        tower_colors[4] = color(255, 0, 255); //bright purple
        tower_colors[5] = color(0, 255, 255); //light bright blue
        tower_colors[6] = color(127, 0, 255); //medium purple
        tower_colors[7] = color(225, 128, 0); //orange
        tower_colors[8] = color(102, 255, 178); //seafoam
        tower_colors[9] = color(0, 128, 255); //medium blue
        tower_colors[10] = color(255, 0, 127); //medium pink
        tower_colors[11] = color(229, 204, 255); //lavendar
        tower_colors[12] = color(255, 153, 153); //peach
        tower_colors[13] = color(255, 213, 0); //yellow-orange
        tower_colors[14] = color(0, 204, 102); //medium green
        tower_colors[15] = color(128, 255, 0); //yellow green
  
 if(dataMode ==1){ 
 //towers for Voronoi 
 for (int i=0; i<numNodes; i++) {
    nodes[i] = new PVector(random(10, p.width-10), random(10, p.height-10));
    towers_x[i] = nodes[i].x;
    towers_y[i] = nodes[i].y;
  }
  //draw voronoi
       float minDistance = 0;
       float minIndex = 0;
       
       for(int px = 0; px < width; px++)
    {
      
         for(int py = 0; py < height; py++)
         {
           
             // Check distances to colors
             minDistance = ((px  - towers_x[0]) * (px - towers_x[0])) +  ((py  - towers_y[0]) * (py  - towers_y[0]));
             minIndex = 0;
 
             for (int nc = 1; nc < 16; nc++)
             {
                 float dist = ((px  - towers_x[nc]) * (px - towers_x[nc])) +  ((py  - towers_y[nc]) * (py  - towers_y[nc]));
                  
                 if (dist <= minDistance)
                 {
                     minDistance = dist;
                     minIndex = nc;
                }
            }
            stroke(tower_colors[int(minIndex)]);
            point(px, py);
           
        }
        
    }
 }

  
  for (int i=0; i<numNodes; i++) {
    nodes[i] = new PVector(random(10, p.width-10), random(10, p.height-10));
  }
  
  for (int i=0; i<numNodes; i++) {
    for (int j=0; j<numNodes-1; j++) {
//      origin[i*(numNodes-1)+j] = new PVector(nodes[i].x, nodes[i].y);

//HUGE UGLY VORONOI MATH THAT DOES THING 
if(showVoronoi == true)
{
 for(int l = 0; l<5; l++){
      float x = random(width);
      float y = random(height);
      if( (((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))) && 
      ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <= ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
      &&
      ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <= ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
      &&
      ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <=  ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
      &&
      ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <= ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
      &&
      ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <=  ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
      &&
     ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
      &&
      ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <= ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
      &&
      ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <=((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
      &&
      ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <=  ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
      &&
      ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <= ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
      &&
      ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <= ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
      &&
      ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <= ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
      &&
      ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <=  ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
      &&
      ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <=((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])))
      {
      origin[i*(numNodes-1)+j] = new PVector(x, y);
      }
      
      else{
         origin[i*(numNodes-1)+j] = new PVector(towers_x[0] + 1000000, towers_y[0] + 1000000);
      }
}

  
  for(int l = 0; l<5; l++){
      float x = random(width);
      float y = random(height);
      if( (((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) && 
      ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <=  ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
      &&
      ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <= ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
      &&
      ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <=  ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
      &&
      ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <=  ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
      &&
      ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <=  ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
      &&
     ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
      &&
      ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <=  ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
      &&
      ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <= ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
      &&
      ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <=  ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
      &&
      ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <=  ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
      &&
      ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <= ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
      &&
      ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <= ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
      &&
      ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <=  ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
      &&
      ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <= ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])))
      {
      origin2[i*(numNodes-1)+j] = new PVector(x, y);
      }
      
      else{
         origin2[i*(numNodes-1)+j] = new PVector(towers_x[2] + 1000000, towers_y[2] + 1000000);
      }
}


 for(int l = 0; l<5; l++){
      float x = random(width);
      float y = random(height);
      if( (((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) && 
      ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
      &&
      ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <= ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
      &&
      ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <= ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
      &&
      ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <= ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
      &&
      ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <= ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
      &&
      ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
      &&
      ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <= ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
      &&
      ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <=((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
      &&
     ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <= ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
      &&
      ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <= ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
      &&
      ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <=((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
      &&
      ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <=((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
      &&
      ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <= ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
      &&
      ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <=((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])))
      {
      origin3[i*(numNodes-1)+j] = new PVector(x, y);
      }
      
      else{
        origin3[i*(numNodes-1)+j] = new PVector(towers_x[3] + 1000000, towers_y[3] + 1000000);
      }
       
  }
  
   for(int l = 0; l<5; l++){
      float x = random(width);
      float y = random(height);
      if( (((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) && 
      ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
      &&
      ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <= ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
      &&
      ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <= ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
      &&
      ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <= ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
      &&
      ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <= ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
      &&
      (((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
      &&
      ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <= ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
      &&
      ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <=((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
      &&
     ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <= ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
      &&
      ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <=((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
      &&
      ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <=((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
      &&
      ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <=((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
      &&
      ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <= ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
      &&
      ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <= ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15]))))
      {
      origin4[i*(numNodes-1)+j] = new PVector(x, y);
      }
      
      else{
        origin4[i*(numNodes-1)+j] = new PVector(towers_x[4] + 1000000, towers_y[4] + 1000000);
      }
       
  }
  
   for(int l = 0; l<5; l++){
      float x = random(width);
      float y = random(height);
      if( (((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) && 
      ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
      &&
      ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <= ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
      &&
      ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <= ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
      &&
      ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <= ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
      &&
      ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <= ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
      &&
      ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
      &&
      ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <= ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
      &&
      ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <=((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
      &&
     ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <= ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
      &&
      ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <= ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
      &&
      ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <=((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
      &&
      ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <=((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
      &&
      ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <= ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
      &&
      ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <= ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])))
      {
      origin5[i*(numNodes-1)+j] = new PVector(x, y);
      }
      
      else{
        origin5[i*(numNodes-1)+j] = new PVector(towers_x[5] + 1000000, towers_y[5] + 1000000);
      }
       
  }

 for(int l = 0; l<5; l++){
      float x = random(width);
      float y = random(height);
      if( (((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) && 
      ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
      &&
      ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
      &&
      ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
      &&
      ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
      &&
     ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
      &&
      ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
      &&
      ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
      &&
      ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <=((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
      &&
     ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
      &&
      ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
      &&
      ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
      &&
      ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
      &&
      ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
      &&
      ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])))
      {
      origin6[i*(numNodes-1)+j] = new PVector(x, y);
      }
      
      else{
        origin6[i*(numNodes-1)+j] = new PVector(towers_x[6] + 100000, towers_y[6] + 100000);
      }
       
  }

      for(int l = 0; l<5; l++){
      float x = random(width);
      float y = random(height);
      if( (((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) && 
      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
      &&
      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
      &&
      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
      &&
      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
      &&
      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
      &&
      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
      &&
      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
      &&
      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <=((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
      &&
      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
      &&
      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
      &&
      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
      &&
      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
      &&
      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
      &&
      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])))
      {
      origin7[i*(numNodes-1)+j] = new PVector(x, y);
      }
      
      else{
        origin7[i*(numNodes-1)+j] = new PVector(towers_x[7] + 1000000, towers_y[7]+ 1000000);
      }
       
  }
  
     for(int l = 0; l<5; l++){
      float x = random(width);
      float y = random(height);
      if( (((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) && 
      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
      &&
      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <=((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
      &&
      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <= ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
      &&
      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <= ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
      &&
      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <= ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
      &&
      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
      &&
      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <= ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
      &&
      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <= ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
      &&
      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <= ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
      &&
      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <=((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
      &&
      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <= ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
      &&
      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <= ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
      &&
      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <= ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
      &&
      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <= ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])))
      {
      origin8[i*(numNodes-1)+j] = new PVector(x, y);
      }
      
      else{
        origin8[i*(numNodes-1)+j] = new PVector(towers_x[8] + 1000000, towers_y[8] + 1000000);
      }
       
  }
  
  for(int l = 0; l<5; l++){
      float x = random(width);
      float y = random(height);
      if( (((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) && 
      ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
      &&
      ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <=((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
      &&
      ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <= ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
      &&
     ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <= ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
      &&
     ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <= ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
      &&
      ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
      &&
      ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <= ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
      &&
      ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <=((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
      &&
      ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <= ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
      &&
      ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <=((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
      &&
      ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <= ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
      &&
      ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <= ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
      &&
      ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <= ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
      &&
      ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <= ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])))
      {
      origin9[i*(numNodes-1)+j] = new PVector(x, y);
      }
      
      else{
        origin9[i*(numNodes-1)+j] = new PVector(towers_x[9] + 1000000, towers_y[9] + 1000000);
      }
       
  }
  
  for(int l = 0; l<5; l++){
      float x = random(width);
      float y = random(height);
      if( (((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) && 
      ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
      &&
      ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <=((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
      &&
      ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <= ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
      &&
     ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <= ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
      &&
     ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <= ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
      &&
      ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
      &&
      ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <= ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
      &&
      ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <=((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
      &&
      ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <= ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
      &&
      ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <=((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
      &&
      ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <=((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
      &&
      ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <=((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
      &&
      ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <=((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
      &&
      ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <=((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])))
      {
      origin10[i*(numNodes-1)+j] = new PVector(x, y);
      }
      
      else{
        origin10[i*(numNodes-1)+j] = new PVector(towers_x[10] + 1000000, towers_y[10]+ 1000000);
      }
       
  }
  
  for(int l = 0; l<5; l++){
      float x = random(width);
      float y = random(height);
      if( (((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) && 
     ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
      &&
      ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <=((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
      &&
      ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <= ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
      &&
     ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <= ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
      &&
     ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <= ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
      &&
      ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
      &&
      ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <= ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
      &&
     ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <=((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
      &&
      ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <= ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
      &&
      ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <=((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
      &&
      ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <=((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
      &&
      ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <=((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
      &&
      ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <=((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
      &&
      ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <=((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])))
      {
      origin11[i*(numNodes-1)+j] = new PVector(x, y);
      }
      
      else{
        origin11[i*(numNodes-1)+j] = new PVector(towers_x[11] + 1000000, towers_y[11] + 1000000);
      }
       
  }
  
    for(int l = 0; l<5; l++){
      float x = random(width);
      float y = random(height);
      if( (((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) && 
     ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
      &&
      ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <=((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
      &&
      ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <= ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
      &&
     ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <= ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
      &&
     ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <=((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
      &&
     ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
      &&
      ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <= ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
      &&
     ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <=((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
      &&
      ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <= ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
      &&
      ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <=((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
      &&
      ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <=((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
      &&
      ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <=((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
      &&
      ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <=((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
      &&
      ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <= ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])))
      {
      origin12[i*(numNodes-1)+j] = new PVector(x, y);
      }
      
      else{
        origin12[i*(numNodes-1)+j] = new PVector(towers_x[12] + 1000000, towers_y[12] + 1000000);
      }
       
  }
  
    for(int l = 0; l<5; l++){
      float x = random(width);
      float y = random(height);
      if( (((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) 
      && 
     ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
      &&
     ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <=((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
      &&
      ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <= ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
      &&
     ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <=((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
      &&
     ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <=((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
      &&
     ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
      &&
      ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <= ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
      &&
     ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <=((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
      &&
      ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <=((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
      &&
     ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <=((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
      &&
      ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <=((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
      &&
      ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <=((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
      &&
      ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <=((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
      &&
      ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <= ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])))
      {
      origin13[i*(numNodes-1)+j] = new PVector(x, y);
      }
      
      else{
        origin13[i*(numNodes-1)+j] = new PVector(towers_x[13] + 1000000, towers_y[13] + 1000000);
      }
       
  }
  
    for(int l = 0; l<5; l++){
      float x = random(width);
      float y = random(height);
      if( (((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) 
      && 
     ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
      &&
     ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <=((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
      &&
      ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <= ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
      &&
     ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <=((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
      &&
     ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <=((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
      &&
     ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
      &&
      ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <= ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
      &&
     ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <=((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
      &&
      ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <=((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
      &&
     ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <=((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
      &&
      ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <=((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
      &&
      ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <=((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
      &&
      ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <=((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
      &&
      ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <= ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])))
      {
      origin14[i*(numNodes-1)+j] = new PVector(x, y);
      }
      
      else{
        origin14[i*(numNodes-1)+j] = new PVector(towers_x[14] + 1000000, towers_y[14] + 1000000);
      }
       
  }
  
      for(int l = 0; l<5; l++){
      float x = random(width);
      float y = random(height);
      if( (((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) 
      && 
     ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
      &&
     ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <=((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
      &&
      ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <=((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
      &&
     ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <=((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
      &&
     ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <=((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
      &&
     ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
      &&
      ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <=((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
      &&
     ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <=((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
      &&
      ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <=((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
      &&
     ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <=((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
      &&
      ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <=((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
      &&
     ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <=((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
      &&
      ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <=((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
      &&
      ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <=((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])))
      {
      origin15[i*(numNodes-1)+j] = new PVector(x, y);
      }
      
      else{
        origin15[i*(numNodes-1)+j] = new PVector(towers_x[15]+ 1000000, towers_y[15]+ 1000000);
      }
       
  }
      
    }

      
      destination[i*(numNodes-1)+j] = new PVector(nodes[(i+j+1)%(numNodes)].x, nodes[(i+j+1)%(numNodes)].y);
      
      weight[i*(numNodes-1)+j] = random(0.1, 2.0);
      
      
      //println("swarm:" + (i*(numNodes-1)+j) + "; (" + i + ", " + (i+j+1)%(numNodes) + ")");
    }
  }
  
    // rate, life, origin, destination
  colorMode(HSB);
  for (int i=0; i<numSwarm; i++) {
    
    // delay, origin, destination, speed, color
  swarmHorde.addSwarm(weight[i], origin[i], destination[i], 1, color(tower_colors[0])); //color(255.0*i/numSwarm, 255, 255
  swarmHorde.addSwarm(weight[i], origin2[i], destination[i], 1, color(tower_colors[1]));
  swarmHorde.addSwarm(weight[i], origin3[i], destination[i], 1, color(tower_colors[2]));
  swarmHorde.addSwarm(weight[i], origin4[i], destination[i], 1, color(tower_colors[3]));
  swarmHorde.addSwarm(weight[i], origin5[i], destination[i], 1, color(tower_colors[4]));
  swarmHorde.addSwarm(weight[i], origin6[i], destination[i], 1, color(tower_colors[5]));
  swarmHorde.addSwarm(weight[i], origin7[i], destination[i], 1, color(tower_colors[6]));
  swarmHorde.addSwarm(weight[i], origin8[i], destination[i], 1, color(tower_colors[7]));
  swarmHorde.addSwarm(weight[i], origin9[i], destination[i], 1, color(tower_colors[8]));
  swarmHorde.addSwarm(weight[i], origin10[i], destination[i], 1, color(tower_colors[9]));
  swarmHorde.addSwarm(weight[i], origin11[i], destination[i], 1, color(tower_colors[10]));
  swarmHorde.addSwarm(weight[i], origin12[i], destination[i], 1, color(tower_colors[11]));
  swarmHorde.addSwarm(weight[i], origin13[i], destination[i], 1, color(tower_colors[12]));
  swarmHorde.addSwarm(weight[i], origin14[i], destination[i], 1, color(tower_colors[13]));
  swarmHorde.addSwarm(weight[i], origin15[i], destination[i], 1, color(tower_colors[14]));

    // Makes sure that agents 'staying put' eventually die
    swarmHorde.getSwarm(i).temperStandingAgents();
  }
  
  
  colorMode(RGB);
  
  swarmHorde.popScaler(1.0);
}

//------------------Initialize Obstacles----

boolean showObstacles = false;
boolean editObstacles = false;
boolean testObstacles = true;

ObstacleCourse boundaries, grid;
PVector[] obPts;

void initObstacles(PGraphics p) {
  
  println("Initializing Obstacle Objects ...");
  
  // Gridded Obstacles for testing
  grid = new ObstacleCourse();
  testObstacles(p, testObstacles);
  
  // Obstacles for agents generates within Andorra le Vella
  boundaries = new ObstacleCourse();
  boundaries.loadCourse("data/course.tsv");
  
  println("Obstacles initialized.");
}

void testObstacles(PGraphics p, boolean place) {
  if (place) {
    setObstacleGrid(p, p.width/50, p.height/50);
  } else {
    setObstacleGrid(p, 0, 0);
  }
}

void setObstacleGrid(PGraphics p, int u, int v) {
  
  grid.clearCourse();
  
  float w = 0.75*float(p.width)/(u+1);
  float h = 0.75*float(p.height)/(v+1);
  
  obPts = new PVector[4];
  for (int i=0; i<obPts.length; i++) {
    obPts[i] = new PVector(0,0);
  }
  
  for (int i=0; i<u; i++) {
    for (int j=0; j<v; j++) {
      
      float x = float(p.width)*i/(u+1)+w/2.0;
      float y = float(p.height)*j/(v+1)+h/2.0;
      obPts[0].x = x;     obPts[0].y = y;
      obPts[1].x = x+w;   obPts[1].y = y;
      obPts[2].x = x+w;   obPts[2].y = y+h;
      obPts[3].x = x;     obPts[3].y = y+h;
      
      grid.addObstacle(new Obstacle(obPts));
    }
  }
}

//-------Initialize Buttons
/*void initButtons(PGraphics p){
  button = new Button(70, 70, "refresh");
}
*/

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
  finderRandom = new Pathfinder(p.width, p.height, res, 0.5);
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
    case 3: 
      initGridFinder(p, res);
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
    case 3: 
      pFinder = finderGrid;
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
