import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Pathing extends PApplet {

PGraphics tableCanvas;
int textColor = 255;
int background = 0;
ObstacleCourse boundaries = new ObstacleCourse();
ObstacleCourse container = new ObstacleCourse();

boolean redraw = true;

public void setup() {
  tableCanvas = createGraphics(1000, 500);
  size(tableCanvas.width, tableCanvas.height);
  
  initPathfinder(tableCanvas, 20);
}

public void draw() {
  
  if (redraw) {
    tableCanvas.beginDraw();
    tableCanvas.background(background);
    tableCanvas.endDraw();
    
    drawPathfinder(tableCanvas);
    
    image(tableCanvas, 0, 0);
    
    redraw = false;
  }
  
}

class ObstacleCourse {
  
  ObstacleCourse() {
    
  }
  
  public boolean testForCollision(PVector v) {
    return false;
  }
}
boolean showInfo = true;

public void drawPathfinder(PGraphics p) {
  
  finderTest.display(p);
  
  p.beginDraw();
  
  // Draw Nodes Visited in order to find path solution
  p.strokeWeight(1);
  p.stroke(abs(textColor-125));
  for (int i=0; i<testVisited.size(); i++) {
    p.ellipse(testVisited.get(i).x, testVisited.get(i).y, finderTest.getResolution(), finderTest.getResolution());
  }
  
  // Draw Path Edges
  p.strokeWeight(2);
  p.stroke(0xff007D00);
  for (int i=0; i<testPath.size()-1; i++) {
    p.line(testPath.get(i).x, testPath.get(i).y, testPath.get(i+1).x, testPath.get(i+1).y);
  }
  
  //Draw Origin
  p.strokeWeight(2);
  p.stroke(0xffFF0000);
  p.noFill();
  p.ellipse(A.x, A.y, finderTest.getResolution(), finderTest.getResolution());
  
  p.fill(textColor);
  p.text("origin", A.x + finderTest.getResolution(), A.y);
  
  //Draw Destination
  p.strokeWeight(2);
  p.stroke(0xff0000FF);
  p.noFill();
  p.ellipse(B.x, B.y, finderTest.getResolution(), finderTest.getResolution());
  
//  p.fill(textColor);
//  p.text("destination", B.x + finderTest.getResolution(), B.y);
  
  //Draw Path not Found Message
  if (testPath.size() < 2) {
    p.textAlign(CENTER);
    p.fill(textColor);
    p.text("Path not found. Try a new origin and destination", p.width/2, p.height/2);
    p.textAlign(LEFT);
  }
  
  if (showInfo) {
    
    p.pushMatrix();
    p.translate(0, 10);
    
    //Draw Background Rectangle
    p.fill(abs(textColor-25), 200);
    p.noStroke();
    p.rect(10, 4, 0.4f*p.width, 10*20+10 , 12, 12, 12, 12);
    
    //Draw Directions
    p.fill(abs(textColor-225), 255);
    p.text("Explanation:", 20, 20);
    p.text("A network, origin, and destination has been randomly generated.", 20, 40);
    p.text("A green line represents the shortest path.", 20, 60);
    p.text("Nodes are highlighted when visited by the pathfinding algorithm.", 20, 80);
    
    p.text("Directions:", 20, 120);
    p.text("Press 'r' to generate a new origin-destination pair", 20, 140);
    p.text("Press 'n' to generate a new network", 20, 160);
    p.text("Press 'b' to invert colors", 20, 180);
    p.text("Press 'h' to hide these directions", 20, 200);
    
    p.popMatrix();
  }
  
  p.fill(textColor);
  p.text("Pathfinder v1.0", 20, p.height - 40);
  p.text("Ira Winder, MIT Media Lab 2015", 20, p.height - 20);
  
  p.endDraw();
}
//------------- Initialize Pathfinding Objects

Pathfinder finderTopo, finderMargin;

// Pathfinder test and debugging Objects
Pathfinder finderTest;
PVector A, B;
ArrayList<PVector> testPath, testVisited;

public void initPathfinder(PGraphics p, int res) {
  finderTopo = new Pathfinder(p.width, p.height, res, boundaries);
  finderMargin = new Pathfinder(p.width, p.height, res, container);
  
  initOD(p);
  initNetwork(p, 10, 0.55f);
  initPath(finderTest, A, B);
  
  // Ensures that a valid path is always initialized upon start
  while (testPath.size() < 2) {
    println("Generating new origin-destination pair ...");
    initOD(p);
    initPath(finderTest, A, B);
  }
}

public void initNetwork(PGraphics p, int res, float cullRatio) {
  finderTest = new Pathfinder(p.width, p.height, res, cullRatio);
}

public void initPath(Pathfinder finder, PVector A, PVector B) {
  testPath = finder.findPath(A, B);
  testVisited = finder.getVisited();
}

public void initOD(PGraphics p) {
  A = new PVector(random(1.0f)*p.width, random(1.0f)*p.height);
  B = new PVector(random(1.0f)*p.width, random(1.0f)*p.height);
}
public void keyPressed() {
  switch(key) {
    case 'r':
      initOD(tableCanvas);
      initPath(finderTest, A, B);
      redraw = true;
      break;
    case 'n':
      initNetwork(tableCanvas, 10, 0.55f);
      initPath(finderTest, A, B);
      redraw = true;
      break;
    case 'h':
      showInfo = toggle(showInfo);
      redraw = true;
      break;
    case 'b': //toggle background between black and white
      background = toggleBW(background);
      textColor = toggleBW(textColor);
      redraw = true;
      break;
      
  }
}

public boolean toggle(boolean bool) {
  if (bool) {
    return false;
  } else {
    return true;
  }
}

public int toggleBW(int col) {
  if (col == 255) {
    return 0;
  } else if (col == 0) {
    return 255;
  } else {
    return 0;
  }
}
// The Pathfinder class allows one to the retreive a path (ArrayList<PVector>) that
// describes an optimal route.  The Pathfinder must be initialized as a graph (i.e. a network of nodes and edges).
// An ObstacleCourse object may be used to customize the Pathfinder Graph
//
// Development Notes/Process
// Step 1: Create a matrix of Nodes that exclude those overlapping with Obstacle Course
// Step 2: Generate Edges connect adjacent nodes 
// Step 3: Implement Djikkkijikkissar's Algorithm 
// Step 3.1 Convert canvas coordinates to pathfinding graph node index
// Step 3.2 Modify Swarm Class to retain Path object of some sort (Probably an ArrayList<PVector>)
// Step 4: Modify Swarm Behavior to follow path

class Pathfinder { 
  Graph network;
  
  int networkSize;
  float[] totalDist;
  int[] parentNode;
  boolean[] visited;
  ArrayList<Integer> allVisited;
  
  Pathfinder(int w, int h, float res, ObstacleCourse c) {
    network = new Graph(w, h, res);
    network.cullObstacles(c);
    network.generateEdges();
    
    networkSize = network.nodes.size();
    totalDist = new float[networkSize];
    parentNode = new int[networkSize];
    visited = new boolean[networkSize];
    
    allVisited = new ArrayList<Integer>();
  }
  
  Pathfinder(int w, int h, float res, float cullRatio) {
    network = new Graph(w, h, res);
    network.cullRandom(cullRatio);
    network.generateEdges();
    
    networkSize = network.nodes.size();
    totalDist = new float[networkSize];
    parentNode = new int[networkSize];
    visited = new boolean[networkSize];
    
    allVisited = new ArrayList<Integer>();
  }
  
  // a, b, represent respective index for start and end nodes in pathfinding network
  public ArrayList<PVector> findPath(PVector A, PVector B) {
    
    int a = getClosestNode(A);
    int b = getClosestNode(B);
    
    ArrayList<PVector> path = new ArrayList<PVector>();
    ArrayList<Integer> toVisit = new ArrayList<Integer>();
    
    // Clears last list of visited nodes
    for (int i=allVisited.size()-1; i>=0; i--) {
      allVisited.remove(i);
    }
    
    for (int i=0; i<networkSize; i++) {
      totalDist[i] = Float.MAX_VALUE;
      visited[i] = false;
    }
    totalDist[a] = 0;
    parentNode[a] = a;
    int current = a;
    toVisit.add(current);
    allVisited.add(current);
    
    // Loop runs until path is found or ruled out
    boolean complete = false;
    while(!complete) {
      
      // Cycles through all neighbors in current node
      for(int i=0; i<network.getNeighborCount(current); i++) { 
        
        // Resets the cumulative distance if shorter path is found
        float currentDist = totalDist[current] + getNeighborDistance(current, i);
        if (totalDist[getNeighbor(current, i)] > currentDist) {
          totalDist[getNeighbor(current, i)] = currentDist;
          parentNode[getNeighbor(current, i)] = current;
        }
        
        // Adds non-visited neighbors of current node to queue
        if (!visited[getNeighbor(current, i)]) {
          toVisit.add(getNeighbor(current, i));
          allVisited.add(getNeighbor(current, i));
          visited[getNeighbor(current, i)] = true;
        }
      }
      
      // Marks current node as visited and removes from queue
      visited[current] = true;
      toVisit.remove(0);
      
      // If there are still nodes in the queue, goes to the next.  
      if (toVisit.size() > 0) {
        
        current = toVisit.get(0);
        
        // Terminates loop if destination is reached
        if (current == b) {
          println("Total Distance to Distination: " + totalDist[current]);
          
          // Working backward from destination, rebuilds optimal path to origin from parentNode data
          path.add(0, B); //Canvas Coordinate of destination
          path.add(0, getNode(b) ); //PAthfinding node closest to destination
          current = b;
          while (!complete) {
            path.add(0, getNode(parentNode[current]) );
            current = parentNode[current];
            
            if (current == a) {
              complete = true;
              path.add(0, A); //Canvas Coordinate of origin
            }
          }
        }
      
      // If no more nodes left in queue, path is returned as unsolved
      } else {
        
        // Returns path-not-found
        complete = true;
        println("Path Not Found");
        
        // only returns the origin as path
        path.add(0, A);
      }
      
      
    }
    
    return path;
  }
  
  public ArrayList<PVector> getVisited() {
    
    ArrayList<PVector> visited = new ArrayList<PVector>();
    
    for (int i=0; i<allVisited.size(); i++) {
      visited.add(getNode(allVisited.get(i)));
    }
    
    return visited;
  }
    
  public float getResolution() {
    return network.SCALE;
  }
  
  public int getNeighbor(int current, int i) {
    return network.getNeighbor(current, i);
  }
  
  public float getNeighborDistance(int current, int i) {
    return network.getNeighborDistance(current, i);
  }
  
  // calculates the index of pathfinding node closest to the given canvas coordinate 'v'
  // returns -1 if node not found
  public int getClosestNode(PVector v) {
    int node = -1;
    float distance = Float.MAX_VALUE;
    float currentDist;
    
    for (int i=0; i<networkSize; i++) {
      currentDist = sqrt( sq(v.x-getNode(i).x) + sq(v.y-getNode(i).y) );
      if (currentDist < distance) {
        node = i;
        distance = currentDist;
      }
    }
    
    return node;
  }
  
  public PVector getNode(int i) {
    if (i < networkSize) {
      return network.nodes.get(i).node;
    } else {
      return new PVector(-1,-1);
    }
  }
    
  public void display(PGraphics p) {
    network.display(p);
  }
    
}

class Graph {
  
  ArrayList<Node> nodes;
  int U, V;
  float SCALE;
  
  // Using the canvas width and height in pixels, a gridded graph is generated with a pixel spacing of 'scale'
  Graph (int w, int h, float scale) {
    U = PApplet.parseInt(w/scale);
    V = PApplet.parseInt(h/scale);
    SCALE = scale;
    
    nodes = new ArrayList<Node>();
    
    for (int i=0; i<U; i++) {
      for (int j=0; j<V; j++) {
        nodes.add(new Node(i*SCALE + scale/2, j*SCALE + scale/2));
      }
    }
    
  }
  
  // Removes Nodes that intersect with set of obstacles
  public void cullObstacles(ObstacleCourse c) {
    for (int i=nodes.size()-1; i>=0; i--) {
      if(c.testForCollision(nodes.get(i).node)) {
        nodes.remove(i);
      }
    }
  }
  
  // Removes Random Nodes from graph.  Useful for debugging
  public void cullRandom(float percent) {
    for (int i=nodes.size()-1; i>=0; i--) {
      if(random(1.0f) < percent) {
        nodes.remove(i);
      }
    }
  }
  
  // Generates network of edges that connect adjacent nodes (including diagonals)
  public void generateEdges() {
    float dist;
    
    for (int i=0; i<nodes.size(); i++) {
      for (int j=0; j<nodes.size(); j++) {
        dist = sqrt(sq(nodes.get(i).node.x - nodes.get(j).node.x) + sq(nodes.get(i).node.y - nodes.get(j).node.y));
        
        if (dist < 2*SCALE && dist != 0) {
          nodes.get(i).addNeighbor(j, dist);
        }
      }
    }
    
  }
  
  public int getNeighborCount(int i) {
    if (i < nodes.size()) {
      return nodes.get(i).neighbors.size();
    } else {
      return 0;
    }
  }
  
  public int getNeighbor (int i, int j) {
    int neighbor = -1;
    
    if (getNeighborCount(i) > 0) {
      neighbor = nodes.get(i).neighbors.get(j);
    }
    
    return neighbor;
  }
  
  public float getNeighborDistance (int i, int j) {
    float dist = Float.MAX_VALUE;
    
    if (getNeighborCount(i) > 0) {
      dist = nodes.get(i).distance.get(j);
    }
    
    return dist;
  }
  
  public int getClosestNeighbor(int i) {
    int closest = -1;
    float dist = Float.MAX_VALUE;
    float currentDist;
    
    if (getNeighborCount(i) > 0) {
      for (int j=0; j<getNeighborCount(i); j++) {
        currentDist = nodes.get(i).distance.get(j);
        if (dist > currentDist) {
          dist = currentDist;
          closest = nodes.get(i).neighbors.get(j);
        }
      }
    }
    
    return closest;
  }
  
  public float getClosestNeighborDistance(int i) {
    float dist = Float.MAX_VALUE;
    int n = getClosestNeighbor(i);
    
    for (int j=0; j<getNeighborCount(i); j++) {
      if (nodes.get(i).neighbors.get(j) == n) {
        dist = nodes.get(i).distance.get(j);
      }
    }
    
    return dist;
  }
  
  public void display(PGraphics p) {
    
    p.beginDraw();
    
    // Formatting
    p.noFill();
    p.stroke(abs(textColor-200));
    p.strokeWeight(1);
    
    // Draws Tangent Circles Centered at pathfinding nodes
    for (int i=0; i<nodes.size(); i++) {
      p.ellipse(nodes.get(i).node.x, nodes.get(i).node.y, SCALE, SCALE);
    }
    
    // Draws Edges that Connect Nodes
    int neighbor;
    for (int i=0; i<nodes.size(); i++) {
      for (int j=0; j<nodes.get(i).neighbors.size(); j++) {
        neighbor = nodes.get(i).neighbors.get(j);
        //println(neighbor);
        p.line(nodes.get(i).node.x, nodes.get(i).node.y, nodes.get(neighbor).node.x, nodes.get(neighbor).node.y);
      }
    }
    p.endDraw();
  }
  
}

class Node {
  PVector node;
  
  // Variables to describe relationship to neighbors
  ArrayList<Integer> neighbors;
  ArrayList<Float> distance;
  
  
  Node (float x, float y) {
    node = new PVector(x,y);
    neighbors = new ArrayList<Integer>();
    distance = new ArrayList<Float>();
  }
  
  public void addNeighbor(int n, float d) {
    neighbors.add(n);
    distance.add(d);
  }
  
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Pathing" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
