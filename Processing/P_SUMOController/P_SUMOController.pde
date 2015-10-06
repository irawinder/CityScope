// Ira!

// Demo Mode 1 = Street Scale
// Demo Mode 2 = Neighborhood Scale

    int demoMode = 2;


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
  frame.setResizable(true);
    
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
        
               
        invalid = false;
                //               A                    B                   C                  D
               if (IDArray[0] == -1 && IDArray[1] == -1 && IDArray[2] == -1 && IDArray[3] == -1) {
          scenarioID = 0;
        } else if (IDArray[0] == 0 && IDArray[1] == -1 && IDArray[2] == -1 && IDArray[3] == -1) {
          scenarioID = 1;
        } else if (IDArray[0] == 1 && IDArray[1] == -1 && IDArray[2] == -1 && IDArray[3] == -1) {
          scenarioID = 2;
        } else if (IDArray[0] == 2 && IDArray[1] == -1 && IDArray[2] == -1 && IDArray[3] == -1) {
          scenarioID = 3;
        } else if (IDArray[0] == -1 && IDArray[1] == 0 && IDArray[2] == -1 && IDArray[3] == -1) {
          scenarioID = 4;
        } else if (IDArray[0] == -1 && IDArray[1] == 1 && IDArray[2] == -1 && IDArray[3] == -1) {
          scenarioID = 5;
        } else if (IDArray[0] == -1 && IDArray[1] == 2 && IDArray[2] == -1 && IDArray[3] == -1) {
          scenarioID = 6;
        } else if (IDArray[0] == -1 && IDArray[1] == -1 && IDArray[2] == 0 && IDArray[3] == -1) {
          scenarioID = 7;
        } else if (IDArray[0] == -1 && IDArray[1] == -1 && IDArray[2] == 1 && IDArray[3] == -1) {
          scenarioID = 8;
        } else if (IDArray[0] == -1 && IDArray[1] == -1 && IDArray[2] == 2 && IDArray[3] == -1) {
          scenarioID = 9;
        } else if (IDArray[0] == -1 && IDArray[1] == -1 && IDArray[2] == -1 && IDArray[3] == 0) {
          scenarioID = 10;
        } else if (IDArray[0] == -1 && IDArray[1] == -1 && IDArray[2] == -1 && IDArray[3] == 1) {
          scenarioID = 11;
        } else if (IDArray[0] == -1 && IDArray[1] == -1 && IDArray[2] == -1 && IDArray[3] == 2) {
          scenarioID = 12;
        } else if (IDArray[0] == 0 && IDArray[1] == 0 && IDArray[2] == -1 && IDArray[3] == -1) {
          scenarioID = 13;
        } else if (IDArray[0] == 1 && IDArray[1] == 1 && IDArray[2] == -1 && IDArray[3] == -1) {
          scenarioID = 14;
        } else if (IDArray[0] == 2 && IDArray[1] == 2 && IDArray[2] == -1 && IDArray[3] == -1) {
          scenarioID = 15;
        } else if (IDArray[0] == -1 && IDArray[1] == 0 && IDArray[2] == 0 && IDArray[3] == -1) {
          scenarioID = 16;
        } else if (IDArray[0] == -1 && IDArray[1] == 1 && IDArray[2] == 1 && IDArray[3] == -1) {
          scenarioID = 17;
        } else if (IDArray[0] == -1 && IDArray[1] == 2 && IDArray[2] == 2 && IDArray[3] == -1) {
          scenarioID = 18;
        } else if (IDArray[0] == -1 && IDArray[1] == 0 && IDArray[2] == -1 && IDArray[3] == 0) {
          scenarioID = 19;
        } else if (IDArray[0] == -1 && IDArray[1] == 1 && IDArray[2] == -1 && IDArray[3] == 1) {
          scenarioID = 20;
        } else if (IDArray[0] == -1 && IDArray[1] == 2 && IDArray[2] == -1 && IDArray[3] == 2) {
          scenarioID = 21;
        } else {
          scenarioID = 0;
          invalid = true;
        }
        
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
  
    
  if (invalid && demoMode == 2) {
    textSize(0.3*height);
    textAlign(CENTER);
    fill(#FF0000);
    text("Nope!", width/2, 0.6*height);
    fill(#FFFFFF);
  }
  
}
