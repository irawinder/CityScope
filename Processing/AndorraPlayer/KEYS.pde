void keyPressed() {
  switch (key) {
    case 'o': //show obstacle outlines
      showObstacles = toggle(showObstacles);
      break;
    case 'k': //show sources and sinks for agents
      showSource = toggle(showSource);
      break;
    case 'r': //reset agents and simulation
      testMode = nextMode(testMode, 1);
      initAgents();
      break;
    case 'f': //print framerate to console
      showFrameRate = toggle(showFrameRate);
      break;
    case 'S': //toggles display of swarms of agents
      showSwarm = toggle(showSwarm);
      break;
    case 'e': //shows network edges of motion
      showEdges = toggle(showEdges);
      break;
    case 'i': //shows info about swarms like weight and agent numbers
      showInfo = toggle(showInfo);
      break;
    case 'p': //makes a grid of obstacles
      testObstacles = toggle(testObstacles);
      testObstacles(testObstacles);
      break;
    case 't': //shows thermal/traces of where agents have been 
      showTraces = toggle(showTraces);
      break;
    case 'F': //toggles frameStep
      frameStep = toggle(frameStep);
      println("FrameStep = " + frameStep);
      break;
    case '+': //speed it up
      updateSpeed(1);
      break;
    case '-': //slow it down
      updateSpeed(-1);
      break;
    case 'c': //enter calibration mode 
      ks.toggleCalibration();
      break;
    case 'l': //loads course
      if (editObstacles) {
        if (mainCourse) {
          boundaries.loadCourse("data/course.tsv");
        } else {
          container.loadCourse("data/container.tsv");
        }
      } else {
        // loads the saved layout
        ks.load();
      }
      break;
    case 's'://save course
      if (editObstacles) {
        if (mainCourse) {
          boundaries.saveCourse("data/course.tsv");
        } else {
          container.saveCourse("data/container.tsv");
        }
      } else {
        // saves the layout
        ks.save();
      }
      break;
    case 'm': // changes draw mode
      if (drawMode < 1) {
        drawMode++;
      } else {
        drawMode = 0;
      }
      break;
    case 'g': // changes debug mode
      debug = toggle(debug);
      break;
    case 'd': //shows still data, makes it slow
      if (!showData && !loadData) {
        loadData = toggle(loadData);
        initData();
      }
      showData = toggle(showData);
      println("showData = " + showData);
      break;
    case 'T': // show topography 
      showTopo = toggle(showTopo);
      break;
    case 'E': // shows or hides obstale editor 
      editObstacles = toggle(editObstacles);
      println("editObstacles = " + editObstacles);
      break;
    case '': //hit the delete key 
      if (editObstacles) {
        if (mainCourse) {
          boundaries.removeVertex();
        } else {
          container.removeVertex();
        }
      }
      break;
    case 'A': //lets you add obstcles
      if (editObstacles) {
        if (mainCourse) {
          boundaries.addObstacle();
        } else {
          container.addObstacle();
        }
      }
      break;
    case 'R': //lets you remove obstacles 
      if (editObstacles) {
        if (mainCourse) {
          boundaries.removeObstacle();
        } else {
          container.removeObstacle();
        }
      }
      break;
    case ' ': //switch between the two obstacles to edit them 
      if (editObstacles) {
        if (mainCourse) {
          boundaries.nextIndex(); 
        } else {
          container.nextIndex();
        }
      }
      break;
    case 'N': //hops to next vertice 
      if (editObstacles) {
        if (mainCourse) {
          boundaries.nextVert();
        } else {
          container.nextVert();
        }
      }
      break;
    case 'V': //starts printing frames to file
      printFrames = toggle(printFrames);
      break;
    case 'b': //toggle background between black and white
      background = toggleBW(background);
      textColor = toggleBW(textColor);
      break;
    case 'H': //manually iterate to next Hour in data
      hourIndex = nextHour(hourIndex);
      setSwarmFlow(hourIndex);
      break;
    case 'I': //next data index
    
      if (hourIndex == 24) {
        hourIndex = 0;
      } else {
        hourIndex = hourIndex%24;
      }
      
      dateIndex = nextMode(dateIndex, dates.length-1);
      initData();
      initAgents();
      

      break;
  }
  
  //------arrow keys and how to code keys that aren't characters exactly----- 
  if (key == CODED) { 
    if (keyCode == LEFT) {
      if (editObstacles) {
        if (mainCourse) {
          boundaries.nudgeVertex(-1, 0);
        } else {
          container.nudgeVertex(-1, 0);
        }
      }
    }  
    if (keyCode == RIGHT) {
      if (editObstacles) {
        if (mainCourse) {
          boundaries.nudgeVertex(+1, 0);
        } else {
          container.nudgeVertex(+1, 0);
        }
      }
    }  
    if (keyCode == DOWN) {
      if (editObstacles) {
        if (mainCourse) {
          boundaries.nudgeVertex(0, +1);
        } else {
          container.nudgeVertex(0, +1);
        }
      }
    }  
    if (keyCode == UP) {
      if (editObstacles) {
        if (mainCourse) {
          boundaries.nudgeVertex(0, -1);
        } else {
          container.nudgeVertex(0, -1);
        }
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

int toggleBW(int col) {
  if (col == 255) {
    return 0;
  } else if (col == 0) {
    return 255;
  } else {
    return 0;
  }
}

int nextMode(int mode, int maxMode) {
  if (mode < maxMode) {
    return mode + 1;
  } else {
    return 0;
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
    if (mainCourse) {
      boundaries.addVertex(new PVector(mouseX, mouseY));
    } else {
      container.addVertex(new PVector(mouseX, mouseY));
    }
  }
}
