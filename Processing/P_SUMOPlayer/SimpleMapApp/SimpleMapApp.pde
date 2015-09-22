

void setup() {
  size(1000, 1000, P2D);
  
  setupWarp();
}

void draw() {
  Warp();
  
}

public void keyPressed() {
  
  // Returns Scale
  switch(key) {
    case 'z':
      println("zoom: " + map.getZoomLevel());
      break;
    case 'h':
      println("height: " + map.getHeight());
      break;
    // Recalculates Scale
    case 's':
      setScale();
  }
  
}



