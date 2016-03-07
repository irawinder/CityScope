void keyPressed() {
  switch(key) {
    case 'h': 
      toggleHelp();
      break;
    case 'g': 
      toggleStaticSpacer();
      break;
    case ';': 
      toggleDynamicSpacer();
      updateBoard();
      initializePlan();
      break;
    case '/': 
      togglePieceW();
      break;
    case '.': 
      togglePieceH();
      break;
    case '?': 
      toggleStaticW();
      break;
    case '>': 
      toggleStaticH();
      break;
    case 'q': 
      toggleStructureMode();
      updateAllNodes();
      break;
    case 'o': 
      nextBasemap();
      break;
    case 'i': 
      prevBasemap();
      break;
    case 'O': 
      nextBasemapPlan();
      break;
    case 'I': 
      prevBasemapPlan();
      break;
    case ' ':
      toggleColorMode();
      break;
    case 'm': 
      drawPerspective = toggle(drawPerspective);
      break;
    case 's': 
      toggleStaticDraw();
      forceSimUpdate();
      break;
    case 'S':
      saveCodeArray();
      break;
    case 'L':
      loadCodeArray();
      break;
    case 'c': 
      changeTestCodes();
      forceSimUpdate();
      break;
    case 'd': 
      toggleDynamicDraw();
      forceSimUpdate();
      break;
    case 't': 
      renderPerspective = toggle(renderPerspective);
      break;
    case 'r': 
      rotateCamera();
      renderPerspective();
      break;
    /**
    * case 'R' (01/12/16 YS)
    */
    case 'R':
      toggleDDP();
      break;
    case 'v': 
      changeDemo();
      break;
    case 'a': 
      toggleAxes();
      break;
    case 'p': 
      showPulse = toggle(showPulse);
      break;
    case 'z': 
      toggleStaticOverride();
      updateAllNodes();
      break;
    case '[': 
      togglePlanSat();
      break;
    case ']': 
      togglePlanStat();
      break;
    case 'l': 
      togglePlanDraw();
      break;
    case 'k': 
      rotatePieces();
      updateAllNodes();
      break;
    case 'f': 
      displayFramerate = toggle(displayFramerate);
      break;
    case '`':
      toggle2DProjection();
      break;
    case 'P': 
      resetProjection2D();
      break;
    case 'e': 
      toggleImageDraw();
      break;
    case 'b': 
      toggleScoreWebDraw();
      break;
    case 'w': 
      changeImageMode();
      break;
    case 'x': 
      drawInfo = toggle(drawInfo);
      break;
    case 'n':
      renderPlan = toggle(renderPlan);
      break;
    case 'N':
      changeNodes();
      break;
    case '=':
      forceSimUpdate();
      break;
    case 'F':
      toggleFaux3D();
      break;
    case '1':
      sendCommand("1", 6669);
      break;
    case '2':
      sendCommand("2", 6669);
      break;
    case '3':
      sendCommand("3", 6669);
      break;
    case '4':
      sendCommand("4", 6669);
      break;
    case '5':
      sendCommand("5", 6669);
      break;
    case '6':
      sendCommand("6", 6669);
      break;
    case '-':
      projH[canvasIndex]--;
      saveProjectorLocation();
      //Renders Perspective and Plan Despite No forced Simulation Update
      renderPerspective();
      renderPlan();
    
      break;
    case '+':
      projH[canvasIndex]++;
      saveProjectorLocation();
      //Renders Perspective and Plan Despite No forced Simulation Update
      renderPerspective();
      renderPlan();
    
      break;
    case 'C':
      canvasIndex = nextMode(canvasIndex, numProj-1);
      break;
    case 'D':
      // Ping Karthik's Server
      pingCloud = toggle(pingCloud);
      break;
  }
  
  if (key == CODED) { 
    if (keyCode == LEFT) {
      projU[canvasIndex]--;
      saveProjectorLocation();
    }  
    if (keyCode == RIGHT) {
      projU[canvasIndex]++;
      saveProjectorLocation();
    }  
    if (keyCode == DOWN) {
      projV[canvasIndex]++;
      saveProjectorLocation();
    }  
    if (keyCode == UP) {
      projV[canvasIndex]--;
      saveProjectorLocation();
    }
    
    //Renders Perspective and Plan Despite No forced Simulation Update
    renderPerspective();
    renderPlan();
        
  }
}

int nextMode(int mode, int maxMode) {
  if (mode < maxMode) {
    return mode + 1;
  } else {
    return 0;
  }
}

boolean toggle(boolean bool) {
  if (bool) {
    println("false");
    return false;
  } else {
    println("true");
    return true;
  }
}

