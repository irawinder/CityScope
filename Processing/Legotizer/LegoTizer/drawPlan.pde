PGraphics plan;
PImage planImage;
float planScaler = .5; //fraction of canvas width to make planGraphic
boolean drawPlan = true;
boolean drawPlanSat = true;
boolean drawPlanStatic = false;

void initializePlan() {
  plan = createGraphics(int(planScaler*width), int(planScaler*width*boardLength/boardWidth), P2D);
}

void drawPlan(int x, int y, int w, int h) {
  plan.beginDraw();
  plan.background(0);
  plan.noStroke();
  
  if (drawPlanSat) {
    plan.image(satellite_nosite, 0, 0, plan.width, plan.height);
  }
  
  // Rotate Plan
  lTranslate(boardWidth/2, boardLength/2);
  plan.rotate(0);
  lTranslate(-boardWidth/2, -boardLength/2);
  
  if (drawPlanStatic) {
    drawPlanStatic();
  }
  
  if (displayDynamic) {
    drawPlanDynamic();
  }
    
  plan.endDraw();
  
  if (drawPlan) {
    image(plan, x, y, w, h);
  }
  
  // Creates plan image for use in projection mapping
  planImage = plan.get();
}

void drawPlanDynamic() {
  // Indroduces a small gap just after 0,0 that acounts or half the width of a plexiglas grid width
  lTranslate(dynamicSpacer*gridGap/2, dynamicSpacer*gridGap/2);
  
  for (int i = 0; i<UMax; i++) {
    for (int j = 0; j<VMax; j++) {
      
      plan.noFill();
      
      if (gridOnly) { //Shows only plexiglas grid template w/out rendered pieces
        plan.fill(offColor);
      
      } else if (colorMode == 0 || colorMode == 1) { //renders dynamic pieces
        
        if  (siteInfo.getInt(i,j) == 1 || overrideStatic) { //is site
          if (codeArray[i][j][0] >= 0 && codeArray[i][j][0] < NPieces) { //has peice
            if ((vizMode == 0 && codeArray[i][j][0] == 1) || (vizMode == 1 && codeArray[i][j][0] == 8) || (vizMode == 2 && codeArray[i][j][0] == 2)) { //is Park
              plan.fill(parkColor);
            } else {
              plan.fill(bldgColor);
            }
          } else if (siteInfo.getInt(i,j) == 1 || (overrideStatic && !drawPlanStatic && !drawPlanSat) ) {
            //has no discernable piece on open "cell"; has no dicernable piece on closed "cell," and otherwise unobstructed by static layers
            plan.fill(openColor);
          }
        }
          
      } else if (colorMode == 2) { //renders heatmap
      
        if  (siteInfo.getInt(i,j) == 1 || overrideStatic) { //is site
          if (codeArray[i][j][0] >= 0 && codeArray[i][j][0] < NPieces) { //has peice
            if (heatMapActive[i][j] == 1) {
              plan.fill(255*(1 - heatMap[i][j]), 255*heatMap[i][j], 0);
            } else if ((vizMode == 0 && codeArray[i][j][0] == 1) || (vizMode == 1 && codeArray[i][j][0] == 8) || (vizMode == 2 && codeArray[i][j][0] == 2)) { //is Park
              plan.fill(mediumGray);
            } else {
              plan.fill(lightGray);
            }
          } else if (siteInfo.getInt(i,j) == 1 || (overrideStatic && !drawPlanStatic && !drawPlanSat) ) {
            //has no discernable piece on open "cell"; has no dicernable piece on closed "cell," and otherwise unobstructed by static layers
            plan.fill(offColor);
          }
        }
      }
       
      lRect(0, 0, boxW, boxW);
      
      // iterates along j axis
      lTranslate((boxW + dynamicSpacer*gridGap), 0); 
    }
    // iterates along i axis AND resets j axis
    lTranslate(-(boxW + dynamicSpacer*gridGap)*VMax, (boxW + dynamicSpacer*gridGap)); 
  }
  //reset i axis
  lTranslate(0, -(boxW + dynamicSpacer*gridGap)*UMax); 
  
  // reverses small gap just after 0,0 that acounts o half the width of a plexiglas grid width
  lTranslate(dynamicSpacer*(-gridGap)/2, dynamicSpacer*(-gridGap)/2);
}

void drawPlanStatic() {
  noStroke();
    
  // Indroduces a small gap just after 0,0 that acounts for half the width of a plexiglas grid width
  lTranslate(staticSpacer*gridGap/2, staticSpacer*gridGap/2);
  
  for (int i = 0; i < staticU; i++) {
    
    // Indroduces a small gap between 4x4 LU grids
    if (i % 4 == 0 && i > 0) {
      lTranslate(0, gridGap*staticSpacer);
    }
    
    for (int j = 0; j < staticV; j++) {  
      
      if (staticStructures.getInt(i,j) == -3) { // Is River
        if (colorMode == 2) {
          plan.fill(offColor);
        } else {
          plan.fill(riverColor);
        }
      } else if (staticStructures.getInt(i,j) == -2) { // Is Park
        if (colorMode == 2) {
          plan.fill(mediumGray);
        } else {
          plan.fill(parkColor);
        }
      } else if (staticStructures.getInt(i,j) == -1) { // Is Road
        if (colorMode == 2) {
          plan.fill(offColor);
        } else {
          plan.fill(roadColor);
        }
      } else if (staticStructures.getInt(i,j) == 0) { // Is Open Space
        if (colorMode == 2) {
          plan.fill(offColor);
        } else {
          plan.fill(openColor);
        }
      } else if (staticStructures.getInt(i,j) > 0) { // Is above ground structure
        if (colorMode == 2) {
          plan.fill(lightGray);
        } else {
          plan.fill(bldgColor);
        }
      }
      
      if (j % 4 == 0 && j > 0) {
        lTranslate(gridGap*staticSpacer, 0);
      }   
      
      if (staticStructures.getInt(i,j) != -10) { // Is Structure
        lRect(0, 0, LU_W, LU_W);        
      }
      // iterates along j axis  
      lTranslate(LU_W, 0);        
    }  
    // iterates along i axis AND resets j axis
    lTranslate(-LU_W*staticV - gridGap*(staticV/4-1)*staticSpacer, LU_W); 
  }
  //resets i axis
  lTranslate(0, -LU_W*staticU - gridGap*(staticU/4-1)*staticSpacer); 
  
  // Reverses a small gap just after 0,0 that acounts for half the width of a plexiglas grid width
  lTranslate(-staticSpacer*gridGap/2, -staticSpacer*gridGap/2);
}

// Modified 'translate()' function that allows plan
void lTranslate(float x, float y) {
  plan.translate(x*plan.width/boardWidth, y*plan.height/boardLength);
}

// Modified 'rect()' function that allows for plan
void lRect(float x, float y, float w, float h) {
  plan.rect (x*plan.width/boardWidth, y*plan.height/boardLength, w*plan.width/boardWidth, h*plan.height/boardLength);
}

// Modified 'line()' function that allows for plan
void lLine(float x1, float y1, float x2, float y2) {
  plan.line(x1*plan.width/boardWidth, y1*plan.height/boardLength, x2*plan.width/boardWidth, y2*plan.height/boardLength);
}

// Keyboard-oriented functions

void togglePlanDraw() {
  if (drawPlan == false) {
    drawPlan = true;
  } else {
    drawPlan = false;
  }
}

void togglePlanSat() {
  if (drawPlanSat == false) {
    drawPlanSat = true;
  } else {
    drawPlanSat = false;
  }
}

void togglePlanStat() {
  if (drawPlanStatic == false) {
    drawPlanStatic = true;
  } else {
    drawPlanStatic = false;
  }
}


void pickPlanFill(int c0, int c1, int c2) {
  switch(colorMode) {
    case 0:
      plan.fill(c0);
      break;
    case 1:
      plan.fill(c1);
      break;
    case 2:
      plan.fill(c2);
      break;
  }
}
