boolean showSource = false;
boolean showObstacles = true;
boolean showFrameRate = false;
boolean showEdges = false;
boolean showSwarm = true;
boolean showInfo = false;
boolean placeObstacles = true;
boolean showTraces = false;

Swarm[] testSwarm;
Obstacle[] testWall;

PVector[] origin;
PVector[] destination;
PVector[] nodes;
float[] weight;

PVector[] obPts;

int textSize;
int numAgents, maxAgents;
int[] swarmSize;
float adjust;

HeatMap traces;

void initAgents(int u, int v) {
  
  maxAgents = 1000;
  
  adjust = 1;
  
  int numNodes = 8;
  int numEdges = numNodes*(numNodes-1);
  int numSwarm = numEdges;
  
  nodes = new PVector[numNodes];
  origin = new PVector[numSwarm];
  destination = new PVector[numSwarm];
  weight = new float[numSwarm];
  swarmSize = new int[numSwarm];
  
  for (int i=0; i<numNodes; i++) {
    nodes[i] = new PVector(random(canvasWidth), random(canvasHeight));
  }
  
  for (int i=0; i<numNodes; i++) {
    for (int j=0; j<numNodes-1; j++) {
      
      origin[i*(numNodes-1)+j] = new PVector(nodes[i].x, nodes[i].y);
      
      destination[i*(numNodes-1)+j] = new PVector(nodes[(i+j+1)%(numNodes)].x, nodes[(i+j+1)%(numNodes)].y);
      
      weight[i*(numNodes-1)+j] = int(random(1, 40));
      
      //println("swarm:" + (i*(numNodes-1)+j) + "; (" + i + ", " + (i+j+1)%(numNodes) + ")");
    }
  }
  
  // rate, life, origin, destination
  testSwarm = new Swarm[numSwarm];
  colorMode(HSB);
  for (int i=0; i<numSwarm; i++) {
    // delay, origin, destination, speed, color
    testSwarm[i] = new Swarm(weight[i], origin[i], destination[i], 1, color(255.0*i/numSwarm, 255, 255));
  }
  colorMode(RGB);
  
  placeObstacles(placeObstacles);
  
  traces = new HeatMap(canvasWidth/5, canvasHeight/5, canvasWidth, canvasHeight);
}

void placeObstacles(boolean place) {
  if (place) {
    setObstacles(16, 16);
  } else {
    setObstacles(0, 0);
  }
}

void setObstacles(int u, int v) {
  
  float w = 0.75*float(canvasWidth)/(u+1);
  float h = 0.75*float(canvasHeight)/(v+1);
  
  obPts = new PVector[4];
  for (int i=0; i<obPts.length; i++) {
    obPts[i] = new PVector(0,0);
  }
  
  testWall = new Obstacle[u*v];
  for (int i=0; i<u; i++) {
    for (int j=0; j<v; j++) {
      
      float x = float(canvasWidth)*i/(u+1)+w/2.0;
      float y = float(canvasHeight)*j/(v+1)+h/2.0;
      obPts[0].x = x;     obPts[0].y = y;
      obPts[1].x = x+w;   obPts[1].y = y;
      obPts[2].x = x+w;   obPts[2].y = y+h;
      obPts[3].x = x;     obPts[3].y = y+h;
      
      testWall[i*u + j] = new Obstacle(obPts);
    }
  }
}
