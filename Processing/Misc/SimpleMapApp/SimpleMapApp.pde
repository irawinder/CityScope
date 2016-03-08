

void setup() {
  size(2000, 2000, P2D);
  
  setupMap();
  
  setupCrop();
  setupOps();
  //setup_ImageProj();
}

void draw() {
  
  drawMap();
  
  Crop();
  imageOps();
}

public void keyPressed() {
  
  // Returns Scale
  switch(key) {
    case 'z':
      println("zoom: " + map.getZoomLevel());
      break;
    case 'c':
      println("center: " + map.getCenter().getLat() + ", " + map.getCenter().getLon());
      break;
    // Recalculates Scale
    case 's':
      setScale();
      break;
    // Recalculates Scale
    case 'r':
      resetMap();
      break;
    // Save Snapshot
    case 'v':
      crop.save("crop.png");
      break;
  }
  
}



