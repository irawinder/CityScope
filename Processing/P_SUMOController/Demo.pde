int[] IDArray;

public void setupNeighborhoodDemo() {

  IDArray = new int[4];
  for (int i=0; i<IDArray.length; i++) {
    IDArray[i] = -1;
  }
  
}

public void setupStreetDemo() {

  IDArray = new int[3];
  for (int i=0; i<IDArray.length; i++) {
    IDArray[i] = -1;
  }
  
}

// Neighborhood Scale Toggles
public void updateIDArray_N() {
  
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
