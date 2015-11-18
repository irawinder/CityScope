boolean showSource = false;
boolean showObstacles = false;
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

int canvasWidth = 1000;
int canvasHeight = 1000;

PGraphics tableCanvas;

void setup() {
  size(canvasWidth, canvasHeight);
  tableCanvas = createGraphics(canvasWidth, canvasHeight);
    tableCanvas.beginDraw();
    tableCanvas.background(#FFFFFF);
    tableCanvas.endDraw();
  reset(0, 0);
}

void reset(int u, int v) {
  
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
  
  int l = 40;
  
  obPts = new PVector[4];
  for (int i=0; i<obPts.length; i++) {
    obPts[i] = new PVector(0,0);
  }
  
  testWall = new Obstacle[u*v];
  for (int i=0; i<u; i++) {
    for (int j=0; j<v; j++) {
      
      float x = float(canvasWidth)*i/(u+1)+l/2.0;
      float y = float(canvasHeight)*j/(v+1)+l/2.0;
      obPts[0].x = x;     obPts[0].y = y;
      obPts[1].x = x+l;   obPts[1].y = y;
      obPts[2].x = x+l;   obPts[2].y = y+l;
      obPts[3].x = x;     obPts[3].y = y+l;
      
      testWall[i*u + j] = new Obstacle(obPts);
    }
  }
}

void draw() {
  tableCanvas.beginDraw();
  
  
  // Instead of solid background draws a translucent overlay every frame.
  // Provides the effect of giving animated elements "tails"
  tableCanvas.noStroke();
  //fill(#ffffff, 100);
  tableCanvas.fill(0, 50);
  tableCanvas.rect(0,0,canvasWidth,canvasHeight);
  
  tableCanvas.translate(scrollX, scrollY);
  
  if(showTraces) {
    traces.display();
  }
  
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
      
      if (showTraces) {
        traces.update(s);
        s.display("grayscale");
      } else {
        s.display("color");
      }
    }
    
  }
  
  traces.decay();
  
  for(int i=0; i<testSwarm.length; i++) {
    swarmSize[i] = testSwarm[i].swarm.size();
  }
  
//  if (frameRate < 45) {
//    maxAgents --;
//  } else if (frameRate > 50) {
//    maxAgents ++;
//  }
  
  if (numAgents > maxAgents) {
    int rand;
    int counter;
    while(numAgents > maxAgents) {
      
      // Picks a random agent from one of the swarms.  Larger swarms are more likely to be selected
      rand = int(random(0, numAgents));
      counter = 0;
      for (int i=0; i<testSwarm.length; i++) {
        counter += swarmSize[i];
        if (rand < counter) {
          rand = i;
          //println("random: " + rand);
          break;
        }
      }
      
      //kills a random agent in the selected swarm
      if (testSwarm[rand].swarm.size() > 0) {
        testSwarm[rand].swarm.get(int(random(testSwarm[rand].swarm.size()))).finished = true;
        numAgents--;
      }
    }
    adjust /= 0.99;
  } else {
    adjust *= 0.99;
  }
  //println("Adjust: " + adjust);

  
  tableCanvas.translate(-scrollX, -scrollY);
  
  textSize = 8;
  
  if (showInfo) {
    tableCanvas.pushMatrix();
    tableCanvas.translate(2*textSize, 2*textSize + scroll);
    
    // Background rectangle
    tableCanvas.fill(#555555, 50);
    tableCanvas.noStroke();
    tableCanvas.rect(0, 0, 32*textSize, (testSwarm.length+4)*1.5*textSize, textSize, textSize, textSize, textSize);
    
    // Text
    tableCanvas.translate(2*textSize, 2*textSize);
    for (int i=0; i<testSwarm.length; i++) {
      tableCanvas.fill(testSwarm[i].fill);
      tableCanvas.textSize(textSize);
      tableCanvas.text("Swarm[" + i + "]: ", 0,0);
      tableCanvas.text("Weight: " + int(1000.0/testSwarm[i].agentDelay) + "/sec", 10*textSize,0);
      tableCanvas.text("Size: " + testSwarm[i].swarm.size() + " agents", 20*textSize,0);
      tableCanvas.translate(0, 1.5*textSize);
    }
    tableCanvas.translate(0, 1.5*textSize);
    tableCanvas.text("Total Swarms: " + testSwarm.length,0,0);
    tableCanvas.translate(0, 1.5*textSize);
    tableCanvas.text("Total Agents: " + numAgents,0,0);
    tableCanvas.popMatrix();
  }
  
  tableCanvas.endDraw();
  
  image(tableCanvas, 0, 0);
  
  if (showFrameRate) {
    println("frameRate = " + frameRate);
  }
  
  time_0 = millis();
  
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
    case 't':
      showTraces = toggle(showTraces);
      break;
    case 'F':
      frameStep = toggle(frameStep);
      println("FrameStep = " + frameStep);
      break;
    case '+':
      updateSpeed(1);
      break;
    case '-':
      updateSpeed(-1);
      break;
  }
  
}

// variables for Scroll Bar
int y_0;
int scroll = 0;
int scroll_0 = 0;

//Move Variables for Network
int X_0, Y_0;
int scrollX = 0;
int scrollY = 0;
int scrollX_0 = 0;
int scrollY_0 = 0;

void mousePressed() {
  if (showInfo) {
    y_0 = mouseY;
  } else {
    X_0 = mouseX;
    Y_0 = mouseY;
  }
}

void mouseDragged() {
  if (showInfo) {
    scroll = scroll_0 + mouseY - y_0;
  } else {
    scrollX = scrollX_0 + mouseX - X_0;
    scrollY = scrollY_0 + mouseY - Y_0;
  }
}

void mouseReleased() {
  if (showInfo) {
    scroll_0 = scroll;
  } else {
    scrollX_0 = scrollX;
    scrollY_0 = scrollY;
  }
}
  

boolean toggle(boolean bool) {
  if (bool) {
    return false;
  } else {
    return true;
  }
}

void updateSpeed(int dir) {
  switch (dir) {
    case -1:
      speed /= 1.5;
      break;
    case 1:
      speed *= 1.5;
      break;
  }
  println("Speed: " + speed);
}
