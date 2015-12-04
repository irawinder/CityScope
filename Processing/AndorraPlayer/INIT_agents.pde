boolean showSource = false;
boolean showEdges = false;
boolean showSwarm = true;
boolean showInfo = false;
boolean showTraces = false;

  int testMode = 0;
  // testMode = 0 for random network
  // testMode = 1 for basic network of Andorra Tower Locations

Swarm[] swarms;


PVector[] origin;
PVector[] destination;
PVector[] nodes;
float[] weight;

PVector[] obPts;

int textSize;
int numAgents, maxAgents;
int[] swarmSize;
float adjust; // dynamic scalar used to nomralize agent generation rate

HeatMap traces;

void initAgents() {
  
  maxAgents = 1000;
  adjust = 1;
  
  //testNetwork();
  touristNetwork();
  
  traces = new HeatMap(canvasWidth/5, canvasHeight/5, canvasWidth, canvasHeight);
}

void testNetwork() {
  
  int numNodes, numEdges, numSwarm;
  
  if (testMode == 0) { // testMode = 0 for random network
  
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
    
  } else if (testMode == 1) { // testMode = 1 for basic network of Andorra Tower Locations
    
    numNodes = frenchWifi.getRowCount() + localTowers.getRowCount();
    numEdges = numNodes*(numNodes-1);
    numSwarm = numEdges;
    
    nodes = new PVector[numNodes];
    origin = new PVector[numSwarm];
    destination = new PVector[numSwarm];
    weight = new float[numSwarm];
    swarmSize = new int[numSwarm];
    
    for (int i=0; i<numNodes; i++) {
      
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
  } else {
    
    numNodes = 0;
    numEdges = numNodes*(numNodes-1);
    numSwarm = numEdges;
    
    nodes = new PVector[numNodes];
    origin = new PVector[numSwarm];
    destination = new PVector[numSwarm];
    weight = new float[numSwarm];
    swarmSize = new int[numSwarm];
  }
  
  for (int i=0; i<numNodes; i++) {
    for (int j=0; j<numNodes-1; j++) {
      
      origin[i*(numNodes-1)+j] = new PVector(nodes[i].x, nodes[i].y);
      
      destination[i*(numNodes-1)+j] = new PVector(nodes[(i+j+1)%(numNodes)].x, nodes[(i+j+1)%(numNodes)].y);
      
      weight[i*(numNodes-1)+j] = int(random(1, 40));
      //weight[i*(numNodes-1)+j] = 40;
      
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
  
}

void touristNetwork() {
  
  int numSwarm;
  color col;
  
  //numSwarm = tourists_0.getRowCount();
  numSwarm = 79;
  
  origin = new PVector[numSwarm];
  destination = new PVector[numSwarm];
  weight = new float[numSwarm];
  swarmSize = new int[numSwarm];
  swarms = new Swarm[numSwarm];
  
  for (int i=0; i<numSwarm; i++) {
    origin[i] = mercatorMap.getScreenLocation(new PVector(tourists_0.getFloat(i, "origin_lat"), tourists_0.getFloat(i, "origin_lon")));
    destination[i] = mercatorMap.getScreenLocation(new PVector(tourists_0.getFloat(i, "destination_lat"), tourists_0.getFloat(i, "destination_lon")));
    weight[i] = tourists_0.getFloat(i, "amount");
    
    if (tourists_0.getString(i, "country").equals("sp")) {
      col = #0000FF;
    } else if (tourists_0.getString(i, "country").equals("fr")) {
      col = #EDFF00;
    } else {
      col = #666666;
    }
    
    // delay, origin, destination, speed, color
    swarms[i] = new Swarm(weight[i], origin[i], destination[i], 1, col);
  }
  
  // rate, life, origin, destination
  
  colorMode(HSB);
  for (int i=0; i<numSwarm; i++) {
    
  }
  colorMode(RGB);
}
