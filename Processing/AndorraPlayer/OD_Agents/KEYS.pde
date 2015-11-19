void keyPressed() {
  
  switch (key) {
    case 'o':
      showObstacles = toggle(showObstacles);
      break;
    case 'k':
      showSource = toggle(showSource);
      break;
    case 'r':
      init(16, 16);
      break;
    case 'f':
      showFrameRate = toggle(showFrameRate);
      break;
    case 's':
      showSwarm = toggle(showSwarm);
      break;
    case 'e':
      showEdges = toggle(showEdges);
      break;
    case 'i':
      showInfo = toggle(showInfo);
      break;
    case 'p':
      placeObstacles = toggle(placeObstacles);
      placeObstacles(placeObstacles);
      break;
    case 't':
      showTraces = toggle(showTraces);
      break;
    case 'F':
      frameStep = toggle(frameStep);
      println("FrameStep = " + frameStep);
      break;
    case '+':
      updateSpeed(1);
      break;
    case '-':
      updateSpeed(-1);
      break;
  }
  
}

// variables for Scroll Bar
int y_0;
int scroll = 0;
int scroll_0 = 0;

//Move Variables for Network
int X_0, Y_0;
int scrollX = 0;
int scrollY = 0;
int scrollX_0 = 0;
int scrollY_0 = 0;

void mousePressed() {
  if (showInfo) {
    y_0 = mouseY;
  } else {
    X_0 = mouseX;
    Y_0 = mouseY;
  }
}

void mouseDragged() {
  if (showInfo) {
    scroll = scroll_0 + mouseY - y_0;
  } else {
    scrollX = scrollX_0 + mouseX - X_0;
    scrollY = scrollY_0 + mouseY - Y_0;
  }
}

void mouseReleased() {
  if (showInfo) {
    scroll_0 = scroll;
  } else {
    scrollX_0 = scrollX;
    scrollY_0 = scrollY;
  }
}
  

boolean toggle(boolean bool) {
  if (bool) {
    return false;
  } else {
    return true;
  }
}
