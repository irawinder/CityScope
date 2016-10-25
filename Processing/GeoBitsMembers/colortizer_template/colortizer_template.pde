

// Display Matrix Size (cells rendered to screen)
int inputUMax = 20;
int inputVMax = 22;
int IDMax = 15;
int legoPerPiece = 4;
int displayV = inputVMax*legoPerPiece; // Height of Lego Table
int displayU = inputUMax*legoPerPiece; // Width of Lego Table
int gridPanV, gridPanU; // Integers that describe how much to offset grid pixels when drawing
int scaler, gridU, gridV;
    
// Arrays that holds ID information of rectilinear tile arrangement.
int tablePieceInput[][][] = new int[displayU/4][displayV/4][2];

void setup() {
  initUDP();
  size(500, 500);
  background(0);
}

void draw() {
  for (int u=0; u<tablePieceInput.length; u++) {
    for (int v=0; v<tablePieceInput[0].length; v++) {
      if (tablePieceInput[u][v][0] == -1) 
        fill(#FF0000);
      else
        fill(#00FF00);
        
      rect(u*10, v*10, 5, 5); 
    }
  }
}
