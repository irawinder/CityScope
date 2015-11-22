void keyPressed() {
  switch (key) {
    case 'o':
      showObstacles = toggle(showObstacles);
      break;
    case 'k':
      showSource = toggle(showSource);
      break;
    case 'r':
      initAgents(16, 16);
      break;
    case 'f':
      showFrameRate = toggle(showFrameRate);
      break;
    case 'S':
      showSwarm = toggle(showSwarm);
      break;
    case 'e':
      showEdges = toggle(showEdges);
      break;
    case 'i':
      showInfo = toggle(showInfo);
      break;
    case 'p':
      testObstacles = toggle(testObstacles);
      testObstacles(testObstacles);
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
    case 'c':
      // enter/leave calibration mode, where surfaces can be warped 
      // and moved
      ks.toggleCalibration();
      break;
    case 'l':
      if (editObstacles) {
        boundaries.loadCourse("data/course.tsv");
      } else {
        // loads the saved layout
        ks.load();
      }
      break;
    case 's':
      if (editObstacles) {
        boundaries.saveCourse();
      } else {
        // saves the layout
        ks.save();
      }
      break;
    case 'm':
      // changes draw mode
      if (drawMode < 1) {
        drawMode++;
      } else {
        drawMode = 0;
      }
      break;
    case 'g':
      // changes debug mode
      debug = toggle(debug);
      break;
    case 'd':
      if (!showData && !loadData) {
        loadData = toggle(loadData);
        initData();
      }
      showData = toggle(showData);
      println("showData = " + showData);
      break;
    case 'T':
      // toggle topo
      showTopo = toggle(showTopo);
      break;
    case 'E':
      // toggle obstacles editor
      editObstacles = toggle(editObstacles);
      println("editObstacles = " + editObstacles);
      break;
    case '':
      if (editObstacles) {
        boundaries.removeVertex();
      }
      break;
    case 'A':
      if (editObstacles) {
        boundaries.addObstacle();
      }
      break;
    case 'R':
      if (editObstacles) {
        boundaries.removeObstacle();
      }
      break;
    case ' ':
      if (editObstacles) {
        boundaries.nextIndex();
      }
      break;
    case 'N':
      if (editObstacles) {
        boundaries.nextVert();
      }
      break;
  }
  
  if (key == CODED) { 
    if (keyCode == LEFT) {
      if (editObstacles) {
        boundaries.nudgeVertex(-1, 0);
      }
    }  
    if (keyCode == RIGHT) {
      if (editObstacles) {
        boundaries.nudgeVertex(+1, 0);
      }
    }  
    if (keyCode == DOWN) {
      if (editObstacles) {
        boundaries.nudgeVertex(0, +1);
      }
    }  
    if (keyCode == UP) {
      if (editObstacles) {
        boundaries.nudgeVertex(0, -1);
      }
    }
  }
}

boolean toggle(boolean bool) {
  if (bool) {
    return false;
  } else {
    return true;
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

void mouseClicked() {
  if (editObstacles) {
    boundaries.addVertex(new PVector(mouseX, mouseY));
  }
}
