int screenW, screenH;

int[] IDArray;

String[] toggleNames;
String[] pieceNames;

int numToggles, numPieces;

PImage streetScore_template;
PImage streetScore_OFF;

// Integer -1, 0, and +1 that describes whether model has changed from basecase
int[] baseChange;

public void setupNeighborhoodDemo() {
  
  summary = loadTable("neighborhood_data/summary.csv");
  
  screenW = 1824;
  screenH = 1014;
  
  numToggles = 4;
  
  IDArray = new int[numToggles];
  for (int i=0; i<IDArray.length; i++) {
    IDArray[i] = -1;
  }
    
  numPieces = 4;
  
  pieceNames = new String[numPieces];
  pieceNames[0] = "Status Quo";
  pieceNames[1] = "New Regular Bus Route";
  pieceNames[2] = "New Enhanced Bus Route";
  pieceNames[3] = "New Bus Rapid Transit (BRT) Route";
  
  toggleNames = new String[numToggles];
  toggleNames[0] = "Washington St.";
  toggleNames[1] = "Blue Hill Ave.";
  toggleNames[2] = "CrossTown";
  toggleNames[3] = "Harvard";
  
}

public void setupStreetDemo() {
  
  summary = loadTable("street_data/summary.csv");
  
  streetScore_template = loadImage("street_data/D_SB_BLK.png");
  streetScore_OFF = loadImage("street_data/D_SB_BLK.png");

  screenW = 1920;
  screenH = 1080;

//  screenW = 900;
//  screenH = 600;
  
  numToggles = 3;
  
  IDArray = new int[numToggles];
  for (int i=0; i<IDArray.length; i++) {
    IDArray[i] = -1;
  }
  
  numPieces = 5;
  
  pieceNames = new String[numPieces];
  pieceNames[0] = "Status Quo";
  pieceNames[1] = "New Regular Bus Route";
  pieceNames[2] = "New Enhanced Bus Route";
  pieceNames[3] = "New Bus Rapid Transit (BRT) Route";
  pieceNames[4] = "New Bike Lane";
  
  toggleNames = new String[numToggles];
  toggleNames[0] = "North Curb";
  toggleNames[1] = "Median";
  toggleNames[2] = "South Curb";
}

// Neighborhood Scale Toggles
public void updateIDArray_N() {
  
  // -1 - Status Quo Bus
  //  0 - Plain Bus Route
  //  1 - Enhanced Bus
  //  2 - Full BRT
  
  // Route A
  IDArray[0] = codeArray[0][0][0];
    
  // Route B
  IDArray[1] = codeArray[0][3][0];  
  
  // Route C
  IDArray[2] = codeArray[2][2][0];
    
  // Route D
  IDArray[3] = codeArray[3][2][0];
  
}

// Street Scale Toggles
public void updateIDArray_S() {
  
  // -1 - Status Quo
  //  0 - Regular Bus
  //  1 - Enhanced Bus
  //  2 - BRT Bus
  //  3 - Bike Lane
  
  // North Curb
  IDArray[0] = codeArray[11][6][0];
    
  // Center
  IDArray[1] = codeArray[5][6][0];  
  
  // South Curb
  IDArray[2] = codeArray[0][6][0];
  
}

public void printIDArray() {
  for(int i=0; i<IDArray.length; i++) {
    
    if (IDArray[i]+1 < pieceNames.length) {
      println("ID Array Index " + i + ", " + toggleNames[i] + " = " + pieceNames[IDArray[i]+1]);
    }
  }
}
