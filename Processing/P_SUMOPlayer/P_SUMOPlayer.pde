// Demo Mode 1 = Street Scale
// Demo Mode 2 = Neighborhood Scale

    int demoMode = 2;



// Unfolding Map Location
float lat;
float lon;
int zoom;

float modelWidth; // width of model in meters
float modelHeight; // height of model in meters
float modelRotation; // rotation of model in radians clockwise from north

int drawWidth;
int drawHeight;

boolean showOverlay = true;
int overlayIndex = 0;

//// SUMOPlayer Tab Global Variables
int timer, animationTimer; 
int frame;
float playbackSpeed = 1; 
int fr = 25; //fps
boolean labelBuses, rt = false;
int rtStep = 0;
String[] tokens;
int tokenIndex = 0;
PImage[] overlay;
PImage[] underlay;
int streetScalar;
int underlayIndex = 0;
boolean invalid = false;

int scenarioID = 0;

public void setup() {
  
  initUDP();
  
  // Sets Static Global Variables to a Demo of Choice
  switch (demoMode) {
    case 1:
      setupStreetDemo();
      setupM_SUMO();
      break;
      
    case 2:
      setupNeighborhoodDemo();
      setupU_SUMO();
      break;
  }
    
  //Screen size
  size(drawWidth,drawHeight,P2D);
  
  // Allocates Memory for Cropped Rendering
  switch (demoMode) {
    case 1:
      setupM_Crop();
      break;
      
    case 2:
      setupU_Crop();
      break;
  }
  
  
  // Allocates memory for 'slicing' a redering for multiple screens
  setupOps();
  
  // Attempts to turn projection map canvases on
  toggle2DProjection();
  
  background(0);
}

public void draw() {
  
  // Draws Demo of Choice
  switch (demoMode) {
    
    case 1:
      
      invalid = false;
      
      if (IDArray[0] == 1 && IDArray[2] == 1 && IDArray[1] == -1) {
        underlayIndex = 1;
        tokenIndex = 1;
      } else if (IDArray[0] == -1 && IDArray[2] == -1 && IDArray[1] == 2) {
        underlayIndex = 2;
        tokenIndex = 2;
      } else if (IDArray[0] == -1 && IDArray[2] == 3 && IDArray[1] == 2) {
        underlayIndex = 3;
        tokenIndex = 2;
      } else if (IDArray[0] == 0 && IDArray[2] == 0 && IDArray[1] == -1) {
        underlayIndex = 0;
        tokenIndex = 0;
      } else {
        underlayIndex = 0;
        tokenIndex = 0;
        invalid = true;
      }
      
      //println(underlayIndex);
      
      //Draw Underlay
      drawUnderlay();
      
      if (invalid == false) {
        // Draws Agents into primary graphic
        drawM_SUMO();
      } else {
        fill(#FF0000);
        textSize(height/10);
        textAlign(CENTER);
        //text("INVALID", 0.45*width, 0.55*height);
      }
      
      // Crops Graphic to Physical Model Area
      M_Crop();
      break;
      
    case 2:
    
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
      
      if (invalid == false && scenarioID == 0) {
        // Draws Agents into primary graphic
        drawU_SUMO();
      } else {  
        background(0);
      }
      
      // Crops Graphic to Physical Model Area
      U_Crop();
      
      if (invalid == false && scenarioID == 0) {
        //do nothing
      } else {
        crop.beginDraw();
        crop.image(overlay[6],0,0,crop.width,crop.height);
        crop.endDraw();
      }
      
      if (showOverlay) {
        
        // Overlays any static PNGs onto Cropped Image
        
        crop.beginDraw();
  //    crop.image(overlay[overlayIndex],0,0,crop.width,crop.height);
  
        // Orange Line
        crop.image(overlay[5],0,0,crop.width,crop.height);
        
        if (invalid == false && scenarioID == 0) {
          //Landmarks
          crop.image(overlay[0],0,0,crop.width,crop.height);
        }
        
        // Corridor A
        if (IDArray[0] > -1 && IDArray[1] == -1 && IDArray[2] == -1 && IDArray[3] == -1 ) {
          crop.image(overlay[1],0,0,crop.width,crop.height);
          crop.image(overlay[1],0,0,crop.width,crop.height);
          crop.image(overlay[1],0,0,crop.width,crop.height);
          crop.image(overlay[10],0,0,crop.width,crop.height);
          
          // Dudley Stn
          crop.image(overlay[17],0,0,crop.width,crop.height);
          
          drawA();
        }
        
        // Corridor B
        if (IDArray[1] > -1 && IDArray[0] == -1 && IDArray[2] == -1 && IDArray[3] == -1 ) {
          crop.image(overlay[2],0,0,crop.width,crop.height);
          crop.image(overlay[2],0,0,crop.width,crop.height);
          crop.image(overlay[2],0,0,crop.width,crop.height);
          crop.image(overlay[11],0,0,crop.width,crop.height);
          
          // Dudley Stn
          crop.image(overlay[17],0,0,crop.width,crop.height);
          
          drawB();
        }
        
        // Corridor C
        if (IDArray[2] > -1 && IDArray[1] == -1 && IDArray[0] == -1 && IDArray[3] == -1 ) {
          crop.image(overlay[3],0,0,crop.width,crop.height);
          crop.image(overlay[3],0,0,crop.width,crop.height);
          crop.image(overlay[3],0,0,crop.width,crop.height);
          crop.image(overlay[12],0,0,crop.width,crop.height);
          
          // Dudley Stn
          crop.image(overlay[17],0,0,crop.width,crop.height);
          
          drawC();
        }
        
        // Corridor D
        if (IDArray[3] > -1 && IDArray[1] == -1 && IDArray[2] == -1 && IDArray[0] == -1 ) {
          crop.image(overlay[4],0,0,crop.width,crop.height);
          crop.image(overlay[4],0,0,crop.width,crop.height);
          crop.image(overlay[4],0,0,crop.width,crop.height);
          crop.image(overlay[13],0,0,crop.width,crop.height);
          
          // Dudley Stn
          crop.image(overlay[17],0,0,crop.width,crop.height);
          
          drawD();
        }
        
        
        // Corridor BA
        if (IDArray[0] > -1 && IDArray[1] > -1 && IDArray[2] == -1 && IDArray[3] == -1 ) {
          crop.image(overlay[7],0,0,crop.width,crop.height);
          crop.image(overlay[7],0,0,crop.width,crop.height);
          crop.image(overlay[7],0,0,crop.width,crop.height);
          crop.image(overlay[14],0,0,crop.width,crop.height);
          
          // Dudley Stn
          crop.image(overlay[17],0,0,crop.width,crop.height);
          
          drawB();
          drawA();
        }
        
        // Corridor BC
        if (IDArray[0] == -1 && IDArray[1] > -1 && IDArray[2] > -1 && IDArray[3] == -1 ) {
          crop.image(overlay[8],0,0,crop.width,crop.height);
          crop.image(overlay[8],0,0,crop.width,crop.height);
          crop.image(overlay[8],0,0,crop.width,crop.height);
          crop.image(overlay[15],0,0,crop.width,crop.height);
          
          // Dudley Stn
          crop.image(overlay[17],0,0,crop.width,crop.height);
          
          drawB();
          drawC();
        }
        
        // Corridor BD
        if (IDArray[0] == -1 && IDArray[1] > -1 && IDArray[2] == -1 && IDArray[3] > -1 ) {
          crop.image(overlay[9],0,0,crop.width,crop.height);
          crop.image(overlay[9],0,0,crop.width,crop.height);
          crop.image(overlay[9],0,0,crop.width,crop.height);
          crop.image(overlay[16],0,0,crop.width,crop.height);
          
          // Dudley Stn
          crop.image(overlay[17],0,0,crop.width,crop.height);
          
          drawB();
          drawD();
        }
        
        crop.endDraw();
      } 
        
      break;
  }
  

  
  //Splits Cropped Image onto Multiple Screens
  imageOps();
  
  //println("Xmax = " + Xmax + " ; Ymax = " + Ymax + " ; Xmin = " + Xmin + " ; Ymin = " + Ymin);
  
}

void drawA(){
 
  float x = 39.0;
  float y = 29.25;
  crop.fill(#FFFFFF);
  crop.noStroke();
  
  crop.rect(int(crop.width*(x/48.0)),int(crop.height*(y/48.0)), int(crop.width*(1.0/48.0)),int(crop.height*(1.0/48.0)) );
  
}

void drawB(){
 
  float x = 42.0;
  float  y = 29.25;
  crop.fill(#7DD5ED);
  crop.noStroke();
  
  crop.rect(int(crop.width*(x/48.0)),int(crop.height*(y/48.0)), int(crop.width*(1.0/48.0)),int(crop.height*(1.0/48.0)) );
  
}

void drawC(){
 
  float x = 41.0;
  float y = 31.25;
  crop.fill(#F3E05E);
  crop.noStroke();
  
  crop.rect(int(crop.width*(x/48.0)),int(crop.height*(y/48.0)), int(crop.width*(1.0/48.0)),int(crop.height*(1.0/48.0)) );
  
}

void drawD(){
 
  float x = 41.0;
  float y = 32.25;
  crop.fill(#E092DF);
  crop.noStroke();
  
  crop.rect(int(crop.width*(x/48.0)),int(crop.height*(y/48.0)), int(crop.width*(1.0/48.0)),int(crop.height*(1.0/48.0)) );
  
}



