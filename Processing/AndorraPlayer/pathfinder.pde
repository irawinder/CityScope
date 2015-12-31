// Step 1: Create a matrix of Nodes that exclude those overlapping with Obstacle Course

// Step 2: Generate Edges connect adjacent nodes 

// Step 3: Implement Djikkkijikkissar's Algorithm to output path for each Swarm

// Step 4: Modify Swarm Behavior to follow path

Pathfinder finder;

void initPathfinder() {
  finder = new Pathfinder(tableCanvas.width, tableCanvas.height, 20, boundaries);
}

void drawPathfinder() {
  finder.display();
}

class Pathfinder { 
  Graph network;
  float[] totalDist;
  
  Pathfinder(int w, int h, float tol, ObstacleCourse c) {
    network = new Graph(w, h, tol);
    network.cullObstacles(c);
    network.generateEdges();
    
    totalDist = new float[network.nodes.size()];
  }
  
  // a, b, represent respective index for start and end nodes in pathfinding network
  ArrayList<PVector> findPath(int a, int b) {
    
    for (int i=0; i<totalDist.length; i++) {
      totalDist[i] = Integer.MAX_VALUE;
    }
    
    ArrayList<PVector> path = new ArrayList<PVector>();
    
    
    
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
