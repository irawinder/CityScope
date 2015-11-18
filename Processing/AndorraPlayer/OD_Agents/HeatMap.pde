class HeatMap {
  
  float[][] values;
  int mapW, mapH; // size in pixels
  int U, V; //Size in buckets
  float cellW, cellH;
  float decay;
  
  HeatMap(int u, int v, int w, int h) {
    values = new float[u][v];
    mapW = w;
    mapH = h;
    U = u;
    V = v;
    cellW = float(w)/u;
    cellH = float(h)/v;
    
    decay = 0.0001;
    
    for (int i=0; i<U; i++) {
      for (int j=0; j<V; j++) {
        values[i][j] = 0;
      }
    }
  }
  
  
  void update(Swarm s) {
    int dist;
    int u, v;
    
    for (Agent a : s.swarm) {
    
      u = int(U*a.location.x/float(mapW));
      v = int(V*a.location.y/float(mapH));
      
      if (u >= 0 && u < U && v >= 0 && v < V) {
        values[u][v] += .01;
      }
      
    }
  }
  
  void decay() {
    
    for (int i=0; i<U; i++) {
      for (int j=0; j<V; j++) {
        if (values[i][j] > 0) {
          //println(values[i][j]);
          values[i][j] -= decay;
        } 
        if( values[i][j] > 1) {
          values[i][j] = 1;
        } else if( values[i][j] < 0) {
          values[i][j] = 0;
        }
      }
    }
    
  }
  
  void display() {
    
    colorMode(HSB);
    noStroke();
    for (int i=0; i<U; i++) {
      for (int j=0; j<V; j++) {
        if (values[i][j] >= 0) {
          fill(0.25*255*values[i][j], 255, 255, 50);
          rect(0, 0, float(width)/U, float(height)/V);
        }
        translate(0, float(height)/V);
      }
      translate(0, -float(height));
      translate(float(width)/U, 0);
    }
    translate(-float(width), 0);
    colorMode(RGB);
    
  }
  
}
