// Step 1: Create a matrix of Nodes that exclude those overlapping with Obstacle Course

// Step 2: Generate Edges connect adjacent nodes 

// Step 3: Implement Djikkkijikkissar's Algorithm to output path for each Swarm

// Step 4: Modify Swarm Behavior to follow path

Pathfinder finder;
PVector A, B;
ArrayList<PVector> testPath;

void initPathfinder() {
  finder = new Pathfinder(tableCanvas.width, tableCanvas.height, 20, boundaries);
  
  // debugging check
  pathTest();
}

void pathTest() {
  int a = int(random(finder.network.nodes.size()-1));
  int b = int(random(finder.network.nodes.size()-1));
  testPath = finder.findPath(a, b);
  A = finder.network.nodes.get(a).node;
  B = finder.network.nodes.get(b).node;
}

void drawPathfinder() {
  finder.display();
  
  tableCanvas.strokeWeight(2);
  
  for (int i=0; i<testPath.size(); i++) {
    tableCanvas.stroke(#00FF00);
    tableCanvas.ellipse(testPath.get(i).x, testPath.get(i).y, 20, 20);
    println(testPath.get(i).x + ", " + testPath.get(i).y);
  }
  println("--");
  
  tableCanvas.stroke(#FF0000);
  tableCanvas.ellipse(A.x, A.y, 20, 20);
  
  tableCanvas.stroke(#0000FF);
  tableCanvas.ellipse(B.x, B.y, 20, 20);
  println(A.x + ", " + A.y);
  println(B.x + ", " + B.y);
  println("-");
  
}

class Pathfinder { 
  Graph network;
  
  int networkSize;
  float[] totalDist;
  int[] parentNode;
  boolean[] visited;
  ArrayList<Integer> toVisit;
  
  Pathfinder(int w, int h, float tol, ObstacleCourse c) {
    network = new Graph(w, h, tol);
    network.cullObstacles(c);
    network.generateEdges();
    
    networkSize = network.nodes.size();
    totalDist = new float[networkSize];
    parentNode = new int[networkSize];
    visited = new boolean[networkSize];
    
  }
  
  // a, b, represent respective index for start and end nodes in pathfinding network
  ArrayList<PVector> findPath(int a, int b) {
    
    ArrayList<PVector> path = new ArrayList<PVector>();
    ArrayList<Integer> toVisit = new ArrayList<Integer>();
    
    for (int i=0; i<networkSize; i++) {
      totalDist[i] = Integer.MAX_VALUE;
      visited[i] = false;
    }
    totalDist[a] = 0;
    parentNode[a] = a;
    int current = a;
    toVisit.add(current);
    
    boolean complete = false;
    while(!complete) {
      
      for(int i=0; i<network.getNeighborCount(current); i++) { // Cycles through al neighbors in current node
        float currentDist = totalDist[current] + network.getNeighborDistance(current, i);
        // Resets the cumulative distance if shorter path is found
        if (totalDist[network.getNeighbor(current, i)] > currentDist) {
          totalDist[network.getNeighbor(current, i)] = currentDist;
          parentNode[network.getNeighbor(current, i)] = current;
        }
        
        if (!visited[network.getNeighbor(current, i)]) {
          toVisit.add(network.getNeighbor(current, i));
          visited[network.getNeighbor(current, i)] = true;
        }
      }
      
      visited[current] = true;
      //path.add(network.nodes.get(current).node);
      toVisit.remove(0);
      current = toVisit.get(0);
      
      if (current == b) {
        complete = true;
        println("complete");
      }
    }
 
    path.add(0, network.nodes.get(b).node);
    current = b;
    complete = false;
    while (!complete) {
      path.add(0, network.nodes.get(parentNode[current]).node);
      current = parentNode[current];
      
      if (current == a) {
        complete = true;
      }
    }
    
    return path;
  }
    
  void display() {
    network.display();
  }
    
}

class Graph {
  
  ArrayList<Node> nodes;
  int U, V;
  float SCALE;
  
  // Using the canvas width and height in pixels, a gridded graph is generated with a pixel spacing of 'scale'
  Graph (int w, int h, float scale) {
    U = int(w/scale);
    V = int(h/scale);
    SCALE = scale;
    
    nodes = new ArrayList<Node>();
    
    for (int i=0; i<U; i++) {
      for (int j=0; j<V; j++) {
        nodes.add(new Node(i*SCALE + scale/2, j*SCALE + scale/2));
      }
    }
    
  }
  
  // Removes Nodes that intersect with set of obstacles
  void cullObstacles(ObstacleCourse c) {
    for (int i=nodes.size()-1; i>=0; i--) {
      if(c.testForCollision(nodes.get(i).node)) {
        nodes.remove(i);
      }
    }
  }
  
  // Generates network of edges that connect adjacent nodes (including diagonals)
  void generateEdges() {
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
  
  int getNeighborCount(int i) {
    if (i < nodes.size()) {
      return nodes.get(i).neighbors.size();
    } else {
      return 0;
    }
  }
  
  int getNeighbor (int i, int j) {
    int neighbor = -1;
    
    if (getNeighborCount(i) > 0) {
      neighbor = nodes.get(i).neighbors.get(j);
    }
    
    return neighbor;
  }
  
  float getNeighborDistance (int i, int j) {
    float dist = Integer.MAX_VALUE;
    
    if (getNeighborCount(i) > 0) {
      dist = nodes.get(i).distance.get(j);
    }
    
    return dist;
  }
  
  int getClosestNeighbor(int i) {
    int closest = -1;
    float dist = Integer.MAX_VALUE;
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
  
  float getClosestNeighborDistance(int i) {
    float dist = Integer.MAX_VALUE;
    int n = getClosestNeighbor(i);
    
    for (int j=0; j<getNeighborCount(i); j++) {
      if (nodes.get(i).neighbors.get(j) == n) {
        dist = nodes.get(i).distance.get(j);
      }
    }
    
    return dist;
  }
  
  void display() {
    
    // Formatting
    tableCanvas.noFill();
    tableCanvas.stroke(textColor);
    tableCanvas.strokeWeight(1);
    
    // Draws Tangent Circles Centered at pathfinding nodes
    for (int i=0; i<nodes.size(); i++) {
      tableCanvas.ellipse(nodes.get(i).node.x, nodes.get(i).node.y, SCALE, SCALE);
    }
    
    // Draws Edges that Connect Nodes
    int neighbor;
    for (int i=0; i<nodes.size(); i++) {
      for (int j=0; j<nodes.get(i).neighbors.size(); j++) {
        neighbor = nodes.get(i).neighbors.get(j);
        //println(neighbor);
        tableCanvas.line(nodes.get(i).node.x, nodes.get(i).node.y, nodes.get(neighbor).node.x, nodes.get(neighbor).node.y);
      }
    }
    
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
  
  void addNeighbor(int n, float d) {
    neighbors.add(n);
    distance.add(d);
  }
  
}
