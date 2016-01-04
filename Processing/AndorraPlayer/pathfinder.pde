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
  
  Pathfinder(int w, int h, float res, float cullRatio) {
    network = new Graph(w, h, res);
    network.cullRandom(cullRatio);
    refresh();
  }
  
  void applyObstacleCourse(ObstacleCourse c) {
    network.applyObstacleCourse(c);
    refresh();
  }
  
  void refresh() {
    network.generateEdges();
    networkSize = network.nodes.size();
    totalDist = new float[networkSize];
    parentNode = new int[networkSize];
    visited = new boolean[networkSize];
    allVisited = new ArrayList<Integer>();
  }
  
  // a, b, represent respective index for start and end nodes in pathfinding network
  ArrayList<PVector> findPath(PVector A, PVector B, boolean enable) {
    
    ArrayList<PVector> path = new ArrayList<PVector>();
    allVisited.clear();
    
    // If method is passed a false boolean, merely returns the origin and destinate as a eclidean path
    if (!enable) {
      
      path.add(A);
      path.add(B);
      
    } else {
      
      ArrayList<Integer> toVisit = new ArrayList<Integer>();
      
      int a = getClosestNode(A);
      int b = getClosestNode(B);
      
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
            //println("Total Distance to Distination: " + totalDist[current]);
            
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
          //println("Path Not Found");
          
          // only returns the origin as path
          path.add(0, A);
        }
      }
    }
    
    return path;
  }
  
  ArrayList<PVector> getVisited() {
    
    ArrayList<PVector> visited = new ArrayList<PVector>();
    
    for (int i=0; i<allVisited.size(); i++) {
      visited.add(getNode(allVisited.get(i)));
    }
    
    return visited;
  }
    
  float getResolution() {
    return network.SCALE;
  }
  
  int getNeighbor(int current, int i) {
    return network.getNeighbor(current, i);
  }
  
  float getNeighborDistance(int current, int i) {
    return network.getNeighborDistance(current, i);
  }
  
  // calculates the index of pathfinding node closest to the given canvas coordinate 'v'
  // returns -1 if node not found
  int getClosestNode(PVector v) {
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
  
  PVector getNode(int i) {
    if (i < networkSize) {
      return network.nodes.get(i).node;
    } else {
      return new PVector(-1,-1);
    }
  }
    
  void display(PGraphics p) {
    network.display(p);
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
  void applyObstacleCourse(ObstacleCourse c) {
    for (int i=nodes.size()-1; i>=0; i--) {
      if(c.testForCollision(nodes.get(i).node)) {
        nodes.remove(i);
      }
    }
  }
  
  // Removes Random Nodes from graph.  Useful for debugging
  void cullRandom(float percent) {
    for (int i=nodes.size()-1; i>=0; i--) {
      if(random(1.0) < percent) {
        nodes.remove(i);
      }
    }
  }
  
  // Generates network of edges that connect adjacent nodes (including diagonals)
  void generateEdges() {
    float dist;
    
    for (int i=0; i<nodes.size(); i++) {
      nodes.get(i).clearNeighbors();
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
    float dist = Float.MAX_VALUE;
    
    if (getNeighborCount(i) > 0) {
      dist = nodes.get(i).distance.get(j);
    }
    
    return dist;
  }
  
  int getClosestNeighbor(int i) {
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
  
  float getClosestNeighborDistance(int i) {
    float dist = Float.MAX_VALUE;
    int n = getClosestNeighbor(i);
    
    for (int j=0; j<getNeighborCount(i); j++) {
      if (nodes.get(i).neighbors.get(j) == n) {
        dist = nodes.get(i).distance.get(j);
      }
    }
    
    return dist;
  }
  
  void display(PGraphics p) {
    
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
  
  void clearNeighbors() {
    neighbors.clear();
    distance.clear();
  }
  
}
