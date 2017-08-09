int projectorWidth = 1920;
int projectorHeight = 1200;
int projectorOffset = 1842;

int screenWidth = 1842;
int screenHeight = 1026;

int displayU = 18;
int displayV = 22;

int IDMax = 15;

// Table Canvas Width and Height
int TABLE_IMAGE_HEIGHT = 1000;
int TABLE_IMAGE_WIDTH = 1000;

// Arrays that holds ID information of rectilinear tile arrangement.
int tablePieceInput[][][] = new int[displayU][displayV][2];

void setup() {
  size(screenWidth, screenHeight, P3D);
  
  // Initial Projection-Mapping Canvas
  initializeProjection2D();
  
  // Allows application to receive information from Colortizer via UDP
  initUDP();
      
}

void draw() {
  
  background(255);
  fill(#FF0000);
  rect(0,0,350, 350);
  
// Exports table Graphic to Projector
  projector = get(0, 0, TABLE_IMAGE_WIDTH, TABLE_IMAGE_HEIGHT);
  
}
