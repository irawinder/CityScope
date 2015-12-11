boolean showSource = true;
boolean showEdges = false;
boolean showSwarm = true;
boolean showInfo = false;
boolean showTraces = false;
boolean printFrames = false;

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
int numAgents, maxAgents, maxFlow, agentCap;
int[] swarmSize;
float adjust; // dynamic scalar used to nomralize agent generation rate

int hourIndex = 25;
int maxHour = 23;
Table summary;
String date;

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
  
  //testNetwork();
  //touristNetwork();
  CDRNetwork();
  
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
      col = spanish;
    } else if (tourists_0.getString(i, "country").equals("fr")) {
      col = french;
    } else {
      col = other;
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
      date = OD.getString(i, "DATE");
    }
  }
  
  maxAgents = int(agentCap * summary.getFloat(hr, "TOTAL")/maxFlow);
  
  
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
  
