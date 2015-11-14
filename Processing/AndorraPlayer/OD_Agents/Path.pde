class Path {
  
  PVector[] nodes;
  
  int diam = 30;
  
  // Initializes a path between two points
  Path(float x0, float y0, float x1, float y1) {
    nodes = new PVector[2];
    nodes[0] = new PVector(x0, y0);
    nodes[1] = new PVector(x1, y1);
  }
  
  // Initializes a path between multiple points
  Path(PVector[] path) {
    nodes = new PVector[path.length];
    for (int i=0; i<path.length; i++) {
      nodes[i] = new PVector(path[i].x, path[i].y);
    }
  }
  
  void display(color c, int alpha) {
    fill(c, alpha);
    noStroke();
    
    for(int i=0; i<nodes.length; i++) {
      pushMatrix();
      translate(nodes[i].x, nodes[i].y);
      ellipse(0, 0, diam, diam);
      popMatrix();
    }
  }
  
}
