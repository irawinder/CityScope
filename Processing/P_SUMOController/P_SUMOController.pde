// Ira

// Demo Mode 1 = Street Scale
// Demo Mode 2 = Neighborhood Scale

    int demoMode = 1;


boolean invalid = false;

void setup() {
  
  initUDP();
  initializeGrid();
  
  // Sets Static Global Variables to a Demo of Choice
  switch (demoMode) {
    case 1:
      setupStreetDemo();
      break;
      
    case 2:
      setupNeighborhoodDemo();
      
      break;
  }
  
  //Debug Size
//  screenW = 1000;
//  screenH = 600;
  
  size(screenW, screenH);
  
  setupSummary();
  background(0);
}

void draw() {
  
  background(0);
  
  if (changeDetected) {

    // Sets Static Global Variables to a Demo of Choice
    switch (demoMode) {
      case 1:
        updateIDArray_S();
        
        invalid = false;
      
        if (IDArray[0] == 1 && IDArray[2] == 1 && IDArray[1] == -1) {
          scenarioID = 1;
        } else if (IDArray[0] == -1 && IDArray[2] == -1 && IDArray[1] == 2) {
          scenarioID = 2;
        } else if (IDArray[0] == -1 && IDArray[2] == 3 && IDArray[1] == 2) {
          scenarioID = 3;
        } else if (IDArray[0] == 0 && IDArray[2] == 0 && IDArray[1] == -1) {
          scenarioID = 0;
        } else {
          scenarioID = 0;
          invalid = true;
        }
        
        break;
        
      case 2:
        updateIDArray_N();
        break;
    }
    
    printIDArray();
    
    String IDs = "";
    
    for(int i=0; i<IDArray.length; i++) {
      IDs += i + "\t" + IDArray[i] + "\n";
    }
    
    //sendCommand("changeDetected", 6667);
    sendCommand(IDs, 6667);
    changeDetected = false;
    
  }
  
  drawSummary();
}
