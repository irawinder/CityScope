int[] IDArray;

String[] toggleNames;
String[] pieceNames;

int numtoggles, numPieces;

public void setupNeighborhoodDemo() {
  
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
  
}

public void setupStreetDemo() {
  
  numToggles = 3;
  
  IDArray = new int[numToggles];
  for (int i=0; i<IDArray.length; i++) {
    IDArray[i] = -1;
  }
  
  numPieces = 4;
  
  pieceNames = new String[numPieces];
  pieceNames[0] = "Status Quo Lane";
  pieceNames[1] = "Bike Lane";
  pieceNames[2] = "New Regular Bus Route";
  pieceNames[3] = "New Bus Rapid Transit (BRT) Route";
  
}

// Neighborhood Scale Toggles
public void updateIDArray_N() {
  
  // -1 - Status Quo Bus
  //  0 - Plain Bus Route
  //  1 - Enhanced Bus
  //  2 - Full BRT
  
  // Route A
  IDArray[0] = codeArray[0][3][0];
    
  // Route B
  IDArray[1] = codeArray[0][0][0];  
  
  // Route C
  IDArray[2] = codeArray[2][2][0];
    
  // Route D
  IDArray[3] = codeArray[3][2][0];
  
}

// Street Scale Toggles
public void updateIDArray_S() {
  
  // -1 - Status Quo
  //  3 - Bike Lane
  //  0 - Regular Bus
  //  1 - Enhanced Bus
  //  2 - BRT Bus
  
  // North Curb
  IDArray[0] = codeArray[11][6][0];
    
  // Center
  IDArray[1] = codeArray[5][6][0];  
  
  // South Curb
  IDArray[2] = codeArray[0][6][0];
  
}

public void printIDArray() {
  for(int i=0; i<IDArray.length; i++) {
    println("ID Array Index " + i + " = " + IDArray[i]);
  }
}
