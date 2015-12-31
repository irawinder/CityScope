// Step 1: Create a matrix of Nodes that exclude those overlapping with Obstacle Course

// Step 2: Generate Edges connect adjacent nodes 

// Step 3: Implement Djikkkijikkissar's Algorithm to output path for each Swarm

// Step 4: Modify Swarm Behavior to follow path

Graph testGraph;

void initGraph() {
  testGraph = new Graph(tableCanvas.width, tableCanvas.height, 20);
  testGraph.cullObstacles(boundaries);
}

void drawGraph() {
  testGraph.display();
}

class Graph {
  
  ArrayList<PVector> nodes;
  int U, V;
  float SCALE;
  
  // Using the canvas width and height in pixels, a gridded graph is generated with a pixel spacing of 'scale'
  Graph (int w, int h, float scale) {
    U = int(w/scale);
    V = int(h/scale);
    SCALE = scale;
    
    nodes = new ArrayList<PVector>();
    
    for (int i=0; i<U; i++) {
      for (int j=0; j<V; j++) {
        nodes.add(new PVector(i*SCALE + scale/2, j*SCALE + scale/2));
      }
    }
    
  }
  
  void cullObstacles(ObstacleCourse c) {
    for (int i=nodes.size()-1; i>=0; i--) {
      if(c.testForCollision(nodes.get(i))) {
        nodes.remove(i);
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
      tableCanvas.ellipse(nodes.get(i).x, nodes.get(i).y, SCALE, SCALE);
    }
  }
  
}

class Pathfinder { 
  
}
