boolean showSource = false;
boolean showObstacles = false;
boolean showFrameRate = false;
boolean showEdges = false;
boolean showSwarm = true;
boolean showInfo = false;
boolean placeObstacles = true;

Swarm[] testSwarm;
Obstacle[] testWall;

PVector[] origin;
PVector[] destination;
PVector[] nodes;
float[] weight;

PVector[] obPts;

int textSize;
int numAgents;

void setup() {
  size(1000, 1000);
  background(0);
  reset(0, 0);
}

void reset(int u, int v) {
  
  int numNodes = 5;
  int numEdges = numNodes*(numNodes-1);
  int numSwarm = numEdges;
  
  nodes = new PVector[numNodes];
  origin = new PVector[numSwarm];
  destination = new PVector[numSwarm];
  weight = new float[numSwarm];
  
  for (int i=0; i<numNodes; i++) {
    nodes[i] = new PVector(random(width), random(height));
  }
  
  for (int i=0; i<numNodes; i++) {
    for (int j=0; j<numNodes-1; j++) {
      
      origin[i*(numNodes-1)+j] = new PVector(nodes[i].x, nodes[i].y);
      
      destination[i*(numNodes-1)+j] = new PVector(nodes[(i+j+1)%(numNodes)].x, nodes[(i+j+1)%(numNodes)].y);
      
      weight[i*(numNodes-1)+j] = int(random(40));
      
      println("swarm:" + (i*(numNodes-1)+j) + "; (" + i + ", " + (i+j+1)%(numNodes) + ")");
    }
  }
  
  // rate, life, origin, destination
  testSwarm = new Swarm[numSwarm];
  colorMode(HSB);
  for (int i=0; i<numSwarm; i++) {
    // delay, origin, destination, speed, color
    testSwarm[i] = new Swarm(weight[i], origin[i], destination[i], 2, color(255.0*i/numSwarm, 255, 255));
  }
  colorMode(RGB);
  
  placeObstacles(placeObstacles);
}

void placeObstacles(boolean place) {
  if (place) {
    setObstacles(16, 16);
  } else {
    setObstacles(0, 0);
  }
}

void setObstacles(int u, int v) {
  
  int l = 40;
  
  obPts = new PVector[4];
  for (int i=0; i<obPts.length; i++) {
    obPts[i] = new PVector(0,0);
  }
  
  testWall = new Obstacle[u*v];
  for (int i=0; i<u; i++) {
    for (int j=0; j<v; j++) {
      
      float x = float(width)*i/(u+1)+l/2.0;
      float y = float(height)*j/(v+1)+l/2.0;
      obPts[0].x = x;     obPts[0].y = y;
      obPts[1].x = x+l;   obPts[1].y = y;
      obPts[2].x = x+l;   obPts[2].y = y+l;
      obPts[3].x = x;     obPts[3].y = y+l;
      
      testWall[i*u + j] = new Obstacle(obPts);
    }
  }
}

void draw() {
  
  // Instead of solid background draws a translucent overlay every frame.
  // Provides the effect of giving animated elements "tails"
  noStroke();
  fill(#ffffff, 100);
  //fill(0, 100);
  rect(0,0,width,height);
  
  if (showObstacles) {
    for (Obstacle o : testWall) {
      o.display(#0000FF, 100);
    }
  }
  
  numAgents = 0;
  
  for (Swarm s : testSwarm) {
    s.update();
    numAgents += s.swarm.size();
    
    if (showSource) {
      s.displaySource();
    }
    
    if (showEdges) {
      s.displayEdges();
    }
    
    if (showSwarm) {
      s.display();
    }
  }
  
  textSize = 12;
  
  if (showInfo) {
    pushMatrix();
    translate(2*textSize, 2*textSize);
    for (int i=0; i<testSwarm.length; i++) {
      fill(testSwarm[i].fill);
      textSize(textSize);
      text("Swarm[" + i + "] Weight: " + 1000.0/testSwarm[i].agentDelay + "/sec", 0,0);
      translate(0, 1.5*textSize);
    }
    translate(0, 1.5*textSize);
    text("Total Swarms: " + testSwarm.length,0,0);
    translate(0, 1.5*textSize);
    text("Total Agents: " + numAgents,0,0);
    popMatrix();
  }
  
  
  if (showFrameRate) {
    println("frameRate = " + frameRate);
  }
  
}

void keyPressed() {
  
  switch (key) {
    case 'o':
      showObstacles = toggle(showObstacles);
      break;
    case 'k':
      showSource = toggle(showSource);
      break;
    case 'r':
      reset(16, 16);
      break;
    case 'f':
      showFrameRate = toggle(showFrameRate);
      break;
    case 's':
      showSwarm = toggle(showSwarm);
      break;
    case 'e':
      showEdges = toggle(showEdges);
      break;
    case 'i':
      showInfo = toggle(showInfo);
      break;
    case 'p':
      placeObstacles = toggle(placeObstacles);
      placeObstacles(placeObstacles);
      break;
  }
  
}

boolean toggle(boolean bool) {
  if (bool) {
    return false;
  } else {
    return true;
  }
}
