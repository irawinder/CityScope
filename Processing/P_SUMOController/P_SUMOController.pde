// Demo Mode 1 = Street Scale
// Demo Mode 2 = Neighborhood Scale

    int demoMode = 2;




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
}

void draw() {
  
  if (changeDetected) {

    // Sets Static Global Variables to a Demo of Choice
    switch (demoMode) {
      case 1:
        updateIDArray_S();
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
}
