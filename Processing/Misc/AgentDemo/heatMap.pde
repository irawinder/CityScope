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
  
  void update(Agent a) {
    int dist;
    int u, v;
    
    u = int(U*a.location.x/float(mapW));
    v = int(V*a.location.y/float(mapH));
    
    if (u >= 0 && u < U && v >= 0 && v < V) {
      values[u][v] += .01;
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
  
  void update(Horde h) {
    int dist;
    int u, v;
    
    for (Swarm s : h.horde) {
      for (Agent a : s.swarm) {
    
        u = int(U*a.location.x/float(mapW));
        v = int(V*a.location.y/float(mapH));
        
        if (u >= 0 && u < U && v >= 0 && v < V) {
          values[u][v] += .01;
        }
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
  
  void display(PGraphics p) {
    
    p.colorMode(HSB);
    p.noStroke();
    for (int i=0; i<U; i++) {
      for (int j=0; j<V; j++) {
        if (values[i][j] >= 0) {
          p.fill(0.25*255*values[i][j], 255, 255, 50);
          p.rect(0, 0, float(p.width)/U, float(p.height)/V);
        }
        p.translate(0, float(p.height)/V);
      }
      p.translate(0, -float(p.height));
      p.translate(float(p.width)/U, 0);
    }
    p.translate(-float(p.width), 0);
    p.colorMode(RGB);
    
  }
  
}
