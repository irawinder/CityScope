void keyPressed() {
  
  // Case-sensitive Characters 
  switch (key) {
    // Example
    case 'a':
      // Code action here
      break;
    case 'B':
      bg = toggleBW(bg);
      break;
  }
  
  //------arrow keys
  if (key == CODED) { 
    
    if (keyCode == LEFT) {
      // Code action here
    }  
    if (keyCode == RIGHT) {
      // Code action here
    }  
    if (keyCode == DOWN) {
      // Code action here
    }  
    if (keyCode == UP) {
      // Code action here
    }
    
  }
}

// Triggers action when mouse button held down
void mousePressed() {
  // Code action here
}

void mouseDragged() {
  // Code action here
}

void mouseReleased() {
  // Code action here
}

void mouseClicked() {
  // Code action here
}

// method for toggling booleans
boolean toggle(boolean bool) {
  if (bool) {
    return false;
  } else {
    return true;
  }
}

// method for interating mode
int nextMode(int mode, int maxMode) {
  if (mode < maxMode) {
    return mode + 1;
  } else {
    return 0;
  }
}

// method for toggling color between black and white
int toggleBW(int col) {
  if (col == 255) {
    return 0;
  } else if (col == 0) {
    return 255;
  } else {
    return 0;
  }
}
