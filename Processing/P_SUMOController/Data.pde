// maxPieces: Maximum Number of pieces in one dimension, U or V
int maxPieces = 100;

// Arrays that holds ID information of rectilinear tile arrangement.
int codeArray[][][] = new int[maxPieces][maxPieces][2]; 
boolean changeDetected = false;

void initializeGrid() {
  
  // Sets default values before Colortizer Inputs received
  setupArray(codeArray);
  
}

void setupArray(int[][][] array) {
  // Sets grid to have "no object" (-1) with no rotation (0)
  for (int i=0; i<array.length; i++) {
    for (int j=0; j<array[0].length; j++) {
      array[i][j][0] = -1;
      array[i][j][1] = 0;
    }
  }
}
