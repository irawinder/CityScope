class HeatMap {
  
  float[][] values;
  int mapW, mapH; // size in pixels
  int U, V; //Size in buckets
  
  HeatMap(int u, int v, int w, int h) {
    values = new float[u][v];
    mapW = w;
    mapH = h;
    U = u;
    V = v;
    
    for (int i=0; i<U; i++) {
      for (int j=0; j<V; j++) {
        values[i][j] = -1;
      }
    }
  }
  
  void display() {
    
    colorMode(HSB);
    for (int i=0; i<U; i++) {
      for (int j=0; j<V; j++) {
        if (values[i][j] >= 0) {
          
        }
      }
    }
    colorMode(RGB);
    
  }
  
}
