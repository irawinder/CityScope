boolean keyLoaded = true;
char initKey;
boolean show_directions = false;

void keyPressed() {
  switch (key) {
    case '0': //ReBoots App
      setLoader("Andorra Player | Version " + version);
      // runs key_0() next frame
      break;
    case 'o': //show obstacle outlines
      showObstacles = toggle(showObstacles);
      break;
    case 'k': //show sources and sinks for agents
      showSource = toggle(showSource);
      break;
    case 'r': //reset agents and simulation
      setLoader("New Agents");
      // runs key_r() next frame
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
    case 'h': //shows info about paths
      showPathInfo = toggle(showPathInfo);
      pFinderGrid_Viz(tableCanvas);
      break;
    case 'p': //makes a grid of obstacles
      setLoader("Gridded Obstacles");
      // runs key_p() next frame
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
    case 'l': //loads course
      if (editObstacles) {
        boundaries.loadCourse("data/course.tsv");
      }
      break;
    case 's'://save course
      if (editObstacles) {
        boundaries.saveCourse("data/course.tsv");
      }
      break;
    case 'D': //Toggles various data and visualization modes
      setLoader("Data Mode " + nextMode(dataMode, 3));
      // runs key_D() next frame
      break;
    case 'E': // shows or hides obsticale editor 
      setLoader("Obstacles Editor");
      // runs key_E() next frame
      break;
    case '': //hit the delete key 
      if (editObstacles) {
        boundaries.removeVertex();
      }
      break;
    case 'A': //lets you add obstcles
      if (editObstacles) {
        boundaries.addObstacle();
      }
      break;
    case 'R': //lets you remove obstacles 
      if (editObstacles) {
        boundaries.removeObstacle();
      }
      break;
    case ' ': //switch between the two obstacles to edit them 
      if (editObstacles) {
        boundaries.nextIndex();
      }
      break;
    case 'N': //hops to next vertice 
      if (editObstacles) {
        boundaries.nextVert();
      }
      break;
    case 'V': //starts printing frames to file
      printFrames = toggle(printFrames);
      break;
    case 'b': //toggle background between black and white
      background = toggleBW(background);
      textColor = toggleBW(textColor);
      grayColor = int(abs(background - (255.0/2)*schemeScaler));
      pFinderGrid_Viz(tableCanvas);
      break;
    case 'P': //toggle display of shortest paths
      showPaths = toggle(showPaths);
      break;
    case 'G': //toggle display for pathing grip
      showGrid = toggle(showGrid);
      break;
    case 'X': 
      setLoader("New Origin-Destination Pair");
      // runs key_X() next frame
      break;
    case 'n': // randomize/reset current network for pathfinding
      setLoader("New Pathfinder Network");
      // runs key_n() next frame
      break;
    case '>': // Toggle network for pathfinding
      setLoader("Pathfinder Mode " + nextMode(finderMode, 3));
      // runs key_RightCarrot() next frame
      break;
    case '<': // Enable/Disable Pathfinding
      setLoader("Pathfinder: " + toggle(enablePathfinding));
      // runs key_LeftCarrot() next frame
      break;
    case '{': // Decrease Alpha
      adjustAlpha(-10);
      pFinderGrid_Viz(tableCanvas);
      grayColor = int(abs(background - (255.0/2)*schemeScaler));
      println("schemeScaler: " + schemeScaler);
      println("masterAlpha: " + masterAlpha);
      break;
    case '}': // Increase Alpha
      adjustAlpha(+10);
      pFinderGrid_Viz(tableCanvas);
      grayColor = int(abs(background - (255.0/2)*schemeScaler));
      println("schemeScaler: " + schemeScaler);
      println("masterAlpha: " + masterAlpha);
      break;
  }
  
  //------arrow keys and how to code keys that aren't characters exactly----- 
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

// Running this method will display a loading screen when 
// running a method placed in "initKey()".
// Useful for laggy commands
void setLoader(String txt) {
  drawDelay = 2;
  keyLoaded = false;
  loadText = txt;
  initKey = key;
  println(initKey);
  loading(tableCanvas, loadText);
}

void setLoader(String txt, char k) {
  drawDelay = 2;
  keyLoaded = false;
  loadText = txt;
  initKey = k;
  println(initKey);
  loading(tableCanvas, loadText);
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

void mousePressed() {
  y_0 = mouseY;
    }

void mouseDragged() {
  scroll = scroll_0 + mouseY - y_0;
}

void mouseReleased() {
  scroll_0 = scroll;
}

void mouseClicked() {
  if (editObstacles && (button24.over() == false)&&(button25.over() == false)&&(button26.over() == false)&&
  (button27.over() == false) && (button28.over() == false) && (button29.over() == false) && (button16.over() == false) && (button32.over() == false) && (button33.over() == false)
  && (button34.over() == false) && (button35.over() == false) && (button36.over() == false) ) {
    boundaries.addVertex(new PVector(mouseX, mouseY));
  }
  
  if (menu.over()){
    show_menu = true;
    println(show_menu);
  }
  
  if (menu2.over()){
    show_menu = false;
    println(show_menu);
  }
  
  if(show_menu == true){
  
  String k; //use this string k every time there's a button that runs setloader
   if(button16.over()){
     k = "E";
   setLoader("Obstacles Editor", k.charAt(0));
 }
  

  if(editObstacles == false){
  if(button.over()){ //refreshes visualization in both data modes 
    if(dataMode == 1){
    setLoader("New Agents");
    key_r();
    } 
    if(dataMode != 1){
       setLoader("New Origin-Destination Pair");
       key_X();
    }
  }
  
  if(button10.over()){
     k = "n";
     setLoader("New Pathfinder Network", k.charAt(0));
   }
  
  if(button2.over()){ //new grid 
   setLoader("Pathfinder Mode " + nextMode(finderMode, 3));
   key_RightCarrot();
   println(finderMode);
     if(finderMode == 2){
       k = "p"; 
       setLoader("Gridded Obstacles", k.charAt(0));
     }
  }
  
  if(button3.over()){ //toggles info display
      button3_down = toggle(button3_down);
      showPathInfo = toggle(showPathInfo);
      pFinderGrid_Viz(tableCanvas);
    /*if(dataMode == 1){ 
      showInfo = toggle(showInfo);
    }
    if(dataMode != 1){
      showPathInfo = toggle(showPathInfo);
      pFinderGrid_Viz(tableCanvas);
    }
    */
  }
  
  if(button31.over()){
    showInfo = toggle(showInfo);
    button31_down = toggle(button31_down);
  }
  
  
  if(button4.over()){ //inverts colors
    button4_down = toggle(button4_down);
    background = toggleBW(background);
      textColor = toggleBW(textColor);
      grayColor = int(abs(background - (255.0/2)*schemeScaler));
      pFinderGrid_Viz(tableCanvas);
  }

  if(menu5.over()){ //bumps up transparency
      adjustAlpha(+10);
      pFinderGrid_Viz(tableCanvas);
      grayColor = int(abs(background - (255.0/2)*schemeScaler));
      println("schemeScaler: " + schemeScaler);
      println("masterAlpha: " + masterAlpha);
  }
  
  if(menu6.over()){ //bumps down transparency
    adjustAlpha(-10);
      pFinderGrid_Viz(tableCanvas);
      grayColor = int(abs(background - (255.0/2)*schemeScaler));
      println("schemeScaler: " + schemeScaler);
      println("masterAlpha: " + masterAlpha);
  }
  
  if(button7.over()){ //enable/disable pathfinding
    button7_down = toggle(button7_down);
    enablePathfinding = toggle(enablePathfinding);
    refreshFinder(tableCanvas);
  }
  
  if(button8.over()){ //next datamode
    setLoader("Data Mode " + nextMode(dataMode, 3));
    key_D();
  }
  
  }
  
  
 if(dataMode == 1){
 if(editObstacles==false){ 
  if(menu9.over()){ //speed up
   updateSpeed(-1);
  }
  
  if(menu10.over()){ //slow down
    updateSpeed(1);
   }
  
  if(button11.over()){ //prints framerate 
     showFrameRate = toggle(showFrameRate);
     button11_down = toggle(button11_down);
  }
  
  if(button12.over()){ //shows/hides agents
       showSwarm = toggle(showSwarm);
       button12_down = toggle(button12_down);
  }
  
  if(button30.over()){ //show/hide sources
    showSource = toggle(showSource);
    button30_down = toggle(button30_down);
  }
  
 if(button13.over()){ //show/hide traces
      showTraces = toggle(showTraces);
      button13_down = toggle(button13_down);
    }
 
 if(button14.over()){ //show/hide edges
      showEdges = toggle(showEdges); 
      button14_down = toggle(button14_down);
 }
      
 if(button15.over()){ //show/hide paths
      showPaths = toggle(showPaths);
      button15_down = toggle(button15_down);
 }
 }
  
 }
 
 if(editObstacles == true){
   
   if(button34.over()){
   boundaries.addObstacle();
   }
   
   if(button35.over()){
    boundaries.saveCourse("data/course.tsv");
    editObstacles = toggle(editObstacles);
   }
   
     if(button36.over()){
   boundaries.loadCourse("data/course.tsv");
   editObstacles = toggle(editObstacles);
   }
   
   if(button33.over()){
    if (editObstacles) {
        boundaries.nextIndex();
      }
   }
     if(button32.over()){
    show_directions = toggle(show_directions);
  }
   if(button17.over()){//sources
     showSource = toggle(showSource);
   }
   
   if(button18.over()){//agents
     showSwarm = toggle(showSwarm);
   }
   
   if(button19.over()){//traces
     showTraces = toggle(showTraces);
   }
   
   if(button20.over()){ //edges
     showEdges = toggle(showEdges); 
   }
   
   if(menu21.over()){ //speed up
     updateSpeed(1);
   }
   
   if(menu22.over()){//slow down
     updateSpeed(-1);
   }
   
   if(button23.over()){//print framerate
     showFrameRate = toggle(showFrameRate);
   }
   
   if(button24.over()){//save
   boundaries.saveCourse("data/course.tsv");
   }
   
   if(button25.over()){//load
    boundaries.loadCourse("data/course.tsv");
   }
   
   if(button26.over()){//add
   boundaries.addObstacle();
   }
   
   if(button27.over()){//remove
   boundaries.removeObstacle();
   }
   
   if(button28.over()){//jump
   boundaries.nextVert();
   }
   
   if(button29.over()){//remove vertex
   boundaries.removeVertex();
   }
 }
  
  }

 
}

// Runs on a delay
void keyInit() {
  switch(initKey) {
    case '0':
      key_0();
      break;
    case 'D':
      key_D();
      break;
    case '>':
      key_RightCarrot();
      break;
    case '<':
      key_LeftCarrot();
      break;
    case 'n':
      key_n();
      break;
    case 'E':
      key_E();
      break;
    case 'p':
      key_p();
      break;
    case 'r':
      key_r();
      break;
    case 'X':
      key_X();
      break;
  }
}
  
void key_0() {
  // Restarts the whole sh'bang
  initCanvas();
  initContent(tableCanvas);
  tableCanvas.beginDraw();
  tableCanvas.background(background);
  tableCanvas.endDraw();
}

void key_D() {
  //Toggles various data and visualization modes
  dataMode = nextMode(dataMode, 1);
  initContent(tableCanvas);
}

void key_RightCarrot() {
  // Toggle network for pathfinding
  finderMode = nextMode(finderMode, 3);
  refreshFinder(tableCanvas);
}

void key_LeftCarrot() {
  // Enable/Disable Pathfinding
  enablePathfinding = toggle(enablePathfinding);
  refreshFinder(tableCanvas);
}

void key_n() {
  // randomize/reset current network for pathfinding
  resetFinder(tableCanvas, 10, finderMode);
  refreshFinder(tableCanvas);
}

void key_E() {
  // shows or hides obstale editor 
  editObstacles = toggle(editObstacles);
  println("editObstacles = " + editObstacles);
  if (!editObstacles) { //if deactivapting editor, reinitializes custom network
    // Resets the network for custom mode
    resetFinder(tableCanvas, 10, 2); // '2' for custom mode
    refreshFinder(tableCanvas);
  } else { // If activating editor, sets finder mode to custom
    finderMode = 2;
    refreshFinder(tableCanvas);
    showObstacles = true;
  }
}

void key_p() {
  //makes a grid of obstacles
  testObstacles = toggle(testObstacles);
  testObstacles(tableCanvas, testObstacles);
  // Resets the network for gridded mode
  resetFinder(tableCanvas, 10, 1); // '1' for gridded mode
  refreshFinder(tableCanvas);
}

void key_r() {
  //reset agents and simulation
  initAgents(tableCanvas);
}

void key_X() {
  // randomize locations of origin and destination paths
  initOD(tableCanvas);
  initPath(pFinder, A, B);
  pFinderGrid_Viz(tableCanvas);
}
