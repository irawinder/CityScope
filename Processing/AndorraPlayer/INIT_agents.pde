boolean showSource = false;
boolean showEdges = false;
boolean showSwarm = true;
boolean showInfo = false;
boolean showTraces = false;


Swarm[] swarms;


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
  
  int numNodes = frenchWifi.getRowCount() + localTowers.getRowCount();
  //int numNodes = frenchWifi.getRowCount();
  //int numNodes = 16;
  int numEdges = numNodes*(numNodes-1);
  int numSwarm = numEdges;
  
  nodes = new PVector[numNodes];
  origin = new PVector[numSwarm];
  destination = new PVector[numSwarm];
  weight = new float[numSwarm];
  swarmSize = new int[numSwarm];
  
  for (int i=0; i<numNodes; i++) {
    //nodes[i] = new PVector(random(10, canvasWidth-10), random(10, canvasHeight-10));
    
    if (i < frenchWifi.getRowCount()) {
      nodes[i] = mercatorMap.getScreenLocation(new PVector(frenchWifi.getFloat(i, "Source_lat"), frenchWifi.getFloat(i, "Source_long")));
    } else {
      //nodes[i] = mercatorMap.getScreenLocation(new PVector(tripAdvisor.getFloat(int(random(tripAdvisor.getRowCount())), "Lat"), tripAdvisor.getFloat(int(random(tripAdvisor.getRowCount())), "Long")));
      //int rando = int(random(tripAdvisor.getRowCount()));
      //nodes[i] = mercatorMap.getScreenLocation(new PVector(tripAdvisor.getFloat(rando, "Lat"), tripAdvisor.getFloat(rando, "Long")));
      nodes[i] = mercatorMap.getScreenLocation(new PVector(localTowers.getFloat(i-frenchWifi.getRowCount(), "Lat"), localTowers.getFloat(i-frenchWifi.getRowCount(), "Lon")));
    }
    nodes[i].x += marginWidthPix;
    nodes[i].y += marginWidthPix;
  }
  
  for (int i=0; i<numNodes; i++) {
    for (int j=0; j<numNodes-1; j++) {
      
      origin[i*(numNodes-1)+j] = new PVector(nodes[i].x, nodes[i].y);
      
      destination[i*(numNodes-1)+j] = new PVector(nodes[(i+j+1)%(numNodes)].x, nodes[(i+j+1)%(numNodes)].y);
      
      //weight[i*(numNodes-1)+j] = int(random(1, 40));
      weight[i*(numNodes-1)+j] = 40;
      
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
  
  traces = new HeatMap(canvasWidth/5, canvasHeight/5, canvasWidth, canvasHeight);
}


