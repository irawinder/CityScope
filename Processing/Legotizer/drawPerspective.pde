
int coordMode = 0; //0 is Processing normal, 1 is OPENGL cam callibration

// Display static or dynamic model information
boolean displayStatic = true;
boolean displayDynamic = true;

//shows only plexiglas grid template
boolean gridOnly = false;

boolean displaySatellite = true;

// Allows Detected Dynamic Pieces to display over static geometry
// WARNING: does not delete static geometry.  may result in colliding geometries
boolean overrideStatic = true;

// Designate Structure Style
int structureMode = 0; //0 for 1x1, lowres structures, 1 for higher res 4x4 structures of same tile size

// Designate color style
int colorMode = 0; //0 for building uses, 1 for generic form

// Designate Satellite Type
int satMode = 1;

// 0 means "use" cloud; 1 means "solution" cloud
int nodeMode = 0;

// Boolean that describes whether static Lego buildings fit within the same.
// plastic spacers as movable tiles, or are independent of the spacer.
int staticSpacer = 0;    // 0 to have no plastic spacer in static model, 1 to have spacer
int staticBaseH_LU = 3;  // [LU] number of lego units high for base
int staticBasePlate = 1; // 0 has thin gray lego baseplate; 1 does have thin gray lego baseplate

// Boolean that describes whether dynamic Lego buildings have plastic spacer
int dynamicSpacer = 1;   // 0 to have no plastic spacer in dynamic model, 1 to have spacer
int dynamicBaseH_LU = 3; // [LU] number of lego units high for base

boolean drawAxes = false;

// per tile temp values for residential, academic/institutional, office, and retail amounts
int res, off, ret, ins;

float ht;
float nodeGap = 0.98;

void drawPerspective() {
  
  background(0);
  
  if (drawAxes) {
    drawAxes();                //Draws Axes in Positive directions
  }
  
  if (displayStatic) {
    drawStaticModel();         //Draws Static 3D Model
  }
  
  if (displayDynamic) {
    drawDynamicModel();        //Draws Dynamic 3D Model
  }
}

//Draws Static Model
void drawStaticModel() {
  
  noStroke();
  
  // Indroduces a small gap just after 0,0 that acounts for half the width of a plexiglas grid width
  pTranslate(staticSpacer*gridGap/2, 0, staticSpacer*gridGap/2);
  
  for (int i = 0; i < staticU; i++) {
    
    // Indroduces a small gap between 4x4 LU grids
    if (i % 4 == 0 && i > 0) {
      pTranslate(gridGap*staticSpacer, 0, 0);
    }
    
    for (int j = 0; j < staticV; j++) {  
      
      if (staticStructures.getInt(i,j) == -3) { // Is River
        checkFill(riverColor);
        ht = (1 - staticSpacer)*dynamicSpacer*(gridH) + staticBasePlate*baseH + 1*boxH;
      } else if (staticStructures.getInt(i,j) == -2) { // Is Park
        checkFill(parkColor);
        ht = (1 - staticSpacer)*dynamicSpacer*(gridH) + staticBasePlate*baseH + (staticBaseH_LU*boxH);
      } else if (staticStructures.getInt(i,j) == -1) { // Is Road
        checkFill(roadColor);
        ht = (1 - staticSpacer)*dynamicSpacer*(gridH) + staticBasePlate*baseH + (staticBaseH_LU*boxH);
      } else if (staticStructures.getInt(i,j) == 0) { // Is Open Space
        checkFill(openColor);
        ht = (1 - staticSpacer)*dynamicSpacer*(gridH) + staticBasePlate*baseH + (staticBaseH_LU*boxH);
      } else if (staticStructures.getInt(i,j) > 0) { // Is above ground structure
        if (colorMode == 2) {
          fill(lightGray);
        } else {
          fill(bldgColor);
        }
        ht = (1 - staticSpacer)*dynamicSpacer*(gridH) + staticBasePlate*baseH + (staticBaseH_LU*boxH) + staticH_LU*boxH*staticStructures.getInt(i,j);
      }
      
      if (j % 4 == 0 && j > 0) {
        pTranslate(0, 0, gridGap*staticSpacer);
      }   
      
      if (staticStructures.getInt(i,j) != -10) { // Is Structure

      pTranslate(LU_W/2, 0, LU_W/2);

      
        if (staticStructures.getInt(i,j) <= 0 && !displaySatellite) { // Is NOT above ground structure and satellite overlay is off
          drawBox(ht, 0, LU_W);     
        } else if (staticStructures.getInt(i,j) > 0) { //Is Above Ground, draws "open space" block under building
          drawBox(ht-staticBaseH_LU*boxH, staticBaseH_LU*boxH, LU_W); 
          checkFill(openColor);
          drawBox(staticBaseH_LU*boxH, 0, LU_W); 
        }
        
        pTranslate(-LU_W/2, 0, -LU_W/2);
        
      }
      // iterates along j axis  
      pTranslate(0, 0, LU_W);        
    }  
    // iterates along i axis AND resets j axis
    pTranslate(LU_W, 0, -LU_W*staticV - gridGap*(staticV/4-1)*staticSpacer); 
  }
  //resets i axis
  pTranslate(-LU_W*staticU - gridGap*(staticU/4-1)*staticSpacer, 0, 0); 
  
  // reverses a small gap just after 0,0 that acounts for half the width of a plexiglas grid width
  pTranslate(staticSpacer*(-gridGap)/2, 0, staticSpacer*(-gridGap)/2);

}

void drawDynamicModel() {
  
  noStroke();
  
  // Indroduces a small gap just after 0,0 that acounts or half the width of a plexiglas grid width
  pTranslate(dynamicSpacer*gridGap/2, 0, dynamicSpacer*gridGap/2);
  
  for (int i = 0; i<UMax; i++) {
    for (int j = 0; j<VMax; j++) {  
      pTranslate(boxW/2, 0, boxW/2);
      
      if (gridOnly) { //Shows only plexiglas grid template w/out rendered pieces
        fill(offColor);
        drawBox(0, 0.0, boxW);
        
      } else { //renders dynamic pieces 
        
        if (!drawNodes) {
          pRotateY((-codeArray[i][j][1]+pieceRotation)%4*PI/2);
        }
        
        if  (siteInfo.getInt(i,j) == 1 || overrideStatic) { //is site
          if (codeArray[i][j][0] >= 0 && codeArray[i][j][0] < NPieces) { //has peice
            if (structureMode == 0) { // 1x1 pieces used
            
              if (!drawNodes) {
                draw1x1Structure(i, j);
              } else {
                draw1x1Nodes(i, j, pieceH_LU*boxH, 0);
              }
              
            } else if (structureMode == 1) { // 4x4 pieces used
            
              if (!drawNodes) {
                draw4x4Structure(i, j, pieceH_LU*boxH, boxH*(dynamicBaseH_LU-1), LU_W, structures4x4.get(codeArray[i][j][0]));
              } else {
                draw4x4Nodes(i, j, pieceH_LU*boxH, 0, LU_W);
              }
              
            }
            
          } else if (siteInfo.getInt(i,j) == 1 || (overrideStatic && !displayStatic) ) { //Has no dicernable Piece
            checkFill(openColor);
            
            if (!drawNodes) { 
              //Draws Base
              drawBox(dynamicBaseH_LU*boxH, 0.0, boxW);
              
            } else {
              if (structureMode == 0) { // 1x1 pieces used
                draw1x1Nodes(i, j, pieceH_LU*boxH, 0);
              } else if (structureMode == 1) { // 4x4 pieces used
                draw4x4Nodes(i, j, LU_H*pieceH_LU, 0, LU_W);
              }
            }
            
          }
        }
        
        if (!drawNodes) {
          pRotateY(-(-codeArray[i][j][1]+pieceRotation)%4*PI/2);
        }
      }
      
      pTranslate(-boxW/2, 0, -boxW/2);
        
      // iterates along j axis
      pTranslate(0, 0, boxW + dynamicSpacer*gridGap); 
    }
    // iterates along i axis AND resets j axis
    pTranslate(boxW + dynamicSpacer*gridGap, 0, -(boxW + dynamicSpacer*gridGap)*VMax); 
  }
  //reset i axis
  pTranslate(-(boxW + dynamicSpacer*gridGap)*UMax, 0, 0); 
  
  // reverses small gap just after 0,0 that acounts or half the width of a plexiglas grid width
  pTranslate(dynamicSpacer*(-gridGap)/2, 0, dynamicSpacer*(-gridGap)/2);
}

// Draws Reconfigurable 1x1 Tiles
void draw1x1Structure(int i, int j) {
  
  // Automatics stackes uses in the following order, from ground-most to top-most:
  // Road, Park, Retail, Office, Institutional, then Residential
  
  float nudge = boxH/2;
  if (structures1x1.getInt(codeArray[i][j][0], 2) == 1) { //is road
    //Draws Street
    if (colorMode == 0) { // Building and Land Use Mode
      fill(openColor);
    } else if (colorMode == 1) { // Generic Building Form Mode
      fill(openColor);
    } else if (colorMode == 2) { // Heatmap
      fill(offColor);
    }
    drawBox(staticBaseH_LU*boxH, 0, boxW);
    checkFill(roadColor);
    drawBox(nudge, staticBaseH_LU*boxH, boxW);
  } else if (structures1x1.getInt(codeArray[i][j][0], 3) == 1) { //is park
    //Draws Park Space
    if (colorMode == 0) { // Building and Land Use Mode
      fill(openColor);
    } else if (colorMode == 1) { // Generic Building Form Mode
      fill(openColor);
    } else if (colorMode == 2) { // Heatmap
      fill(offColor);
    }
    drawBox(staticBaseH_LU*boxH, 0, boxW);
    checkFill(parkColor, mediumGray);
    drawBox(nudge, staticBaseH_LU*boxH, boxW);
  }
  
  res = structures1x1.getInt(codeArray[i][j][0], 4);
  off = structures1x1.getInt(codeArray[i][j][0], 5);
  ret = structures1x1.getInt(codeArray[i][j][0], 6);
  ins = structures1x1.getInt(codeArray[i][j][0], 7);
  
  if (ret > 0) { // Has built area
    //Draws Base
    checkFill(openColor);
    drawBox(staticBaseH_LU*boxH, 0.0, boxW);
    
    if (colorMode == 0) { // Building and Land Use Mode
      fill(retailColor);
    } else if (colorMode == 1) { // Generic Building Form Mode
      fill(bldgColor);
    } else if (colorMode == 2) { // Heatmap
      if (heatMapActive[i][j] == 1) { 
        fill(255*(1 - heatMap[i][j]), 255*heatMap[i][j], 0);
      } else {
        fill(lightGray);
      }
    }
    drawBox(pieceH_LU*boxH*ret, staticBaseH_LU*boxH, boxW);
  }
  if (off > 0) { // Has built area
    //Draws Base
    checkFill(openColor);
    drawBox(staticBaseH_LU*boxH, 0.0, boxW);
    
    if (colorMode == 0) { // Building and Land Use Mode
      fill(officeColor);
    } else if (colorMode == 1) { // Generic Building Form Mode
      fill(bldgColor);
    } else if (colorMode == 2) { // Heatmap
      if (heatMapActive[i][j] == 1) { 
        fill(255*(1 - heatMap[i][j]), 255*heatMap[i][j], 0);
      } else {
        fill(lightGray);
      }
    }
    drawBox(pieceH_LU*boxH*off, staticBaseH_LU*boxH + pieceH_LU*boxH*(ret), boxW);
  }
  if (ins > 0) { // Has built area
    //Draws Base
    checkFill(openColor);
    drawBox(staticBaseH_LU*boxH, 0.0, boxW);
    
    if (colorMode == 0) { // Building and Land Use Mode
      fill(academicColor);
    } else if (colorMode == 1) { // Generic Building Form Mode
      fill(bldgColor);
    } else if (colorMode == 2) { // Heatmap
      if (heatMapActive[i][j] == 1) { 
        fill(255*(1 - heatMap[i][j]), 255*heatMap[i][j], 0);
      } else {
        fill(lightGray);
      }
    }
    drawBox(pieceH_LU*boxH*ins, staticBaseH_LU*boxH + pieceH_LU*boxH*(ret+off), boxW);
  }
  if (res > 0) { // Has built area
    //Draws Base
    checkFill(openColor);
    drawBox(staticBaseH_LU*boxH, 0.0, boxW);
    
    if (colorMode == 0) { // Building and Land Use Mode
      fill(residentialColor);
    } else if (colorMode == 1) { // Generic Building Form Mode
      fill(bldgColor);
    } else if (colorMode == 2) { // Heatmap
      if (heatMapActive[i][j] == 1) { 
        fill(255*(1 - heatMap[i][j]), 255*heatMap[i][j], 0);
      } else {
        fill(lightGray);
      }
    }
    drawBox(pieceH_LU*boxH*res, staticBaseH_LU*boxH + pieceH_LU*boxH*(ret+off+ins), boxW);
  }
}

// Draws 1x1 Nodes
void draw1x1Nodes(int u, int v, float HT, float offset) {
  
  // Automatically stacks uses in the following order, from ground-most to top-most:
  // Road, Park, Retail, Office, Institutional, then Residential
  
  for (int k=0; k<useCloud.nodes[0][0].length; k++) {
    
    if (useCloud.nodes[u][v][k] == -1) {
      break;
    }
    
    if (nodeMode == 0) {
      findFill(u, v, useCloud.nodes[u][v][k]);
    } else if (nodeMode == 1) {
      if (solutionCloud[u][v][k] == -1) {
        fill(lightGray);
      } else {
        fill(255*(1-solutionCloud[u][v][k]), 255*solutionCloud[u][v][k], 0);
      }
    }
    
    pTranslate(0, k*pieceH_LU*LU_H+(3*LU_H-HT+(staticBaseH_LU-3)*LU_H), 0);
    drawBox(nodeGap*HT, offset, nodeGap*pieceW_LU*LU_W);
    pTranslate(0, -k*pieceH_LU*LU_H-(3*LU_H-HT+(staticBaseH_LU-3)*LU_H), 0);
  }
  
}

//Draws Reconfigurable 4x4 Piece
void draw4x4Structure(int u, int v, float HT, float offset, float buildingWidth, Table type) {
  
  //Draws Base
  checkFill(openColor);
  drawBox(offset, 0.0, boxW);
  
  pTranslate(-boxW/2+LU_W/2, 0, -boxW/2+LU_W/2);
  
  
  for (int j=0; j<4; j++) {
    for (int k=0; k<4; k++) {
      for (int i=0; i<type.getColumnCount()/4; i++) {
        if (type.getInt(k, i*4+j) != -1) {
          findFill(u,v,type.getInt(k, i*4+j));
          
          
          if (i == 0) { // Draws first layer as one LU thick, no matter thickness of pieces above
            pTranslate(k*LU_W, pieceH_LU*i*LU_H, j*LU_W);
            drawBox(LU_H, offset, buildingWidth);
            pTranslate(-k*LU_W, pieceH_LU*i*LU_H, -j*LU_W);
          } else {  // Draws aboveground pieces at standard heights
            pTranslate(k*LU_W, pieceH_LU*(i-1)*LU_H, j*LU_W);
            drawBox(HT, dynamicBaseH_LU*LU_H, buildingWidth);
            pTranslate(-k*LU_W, pieceH_LU*(-(i-1))*LU_H, -j*LU_W);
          }
          
        }
      }
    }
  }
  pTranslate(boxW/2-LU_W/2, 0, boxW/2-LU_W/2);
}

void draw4x4Nodes(int u, int v, float HT, float offset, float buildingWidth) {
  
  pTranslate(-boxW/2+LU_W/2, 0, -boxW/2+LU_W/2);
  
  for (int j=0; j<4; j++) {
    for (int k=0; k<4; k++) {
      for (int i=0; i<useCloud.nodes[0][0].length; i++) {
        if (useCloud.nodes[u*4+j][v*4+k][i] != -1) { 
          if (nodeMode == 0) {
            findFill(u, v, useCloud.nodes[u*4+j][v*4+k][i]);
          } else if (nodeMode == 1) {
            if (solutionCloud[u*4+j][v*4+k][i] < 0) {
              fill(offColor);
              if (useCloud.nodes[u*4+j][v*4+k][i] > 1) { //Makes parks, live, and work brighter gray in heatmap
                fill(lightGray);
              }
            } else {
              fill(255*(1-solutionCloud[u*4+j][v*4+k][i]), 255*solutionCloud[u*4+j][v*4+k][i], 0);
            }
          }
          
          pTranslate(k*LU_W, i*HT+(3*LU_H-HT+(staticBaseH_LU-3)*LU_H), j*LU_W);
          drawBox(nodeGap*HT, offset, nodeGap*LU_W);
          pTranslate(-k*LU_W, -i*HT-(3*LU_H-HT+(staticBaseH_LU-3)*LU_H), -j*LU_W);
        }
      }
    }
  }
  pTranslate(boxW/2-LU_W/2, 0, boxW/2-LU_W/2);
}

void drawAxes() {
  //Axes
  stroke(#FF0000);
  pLine(0,0,0, 1000, 0, 0);
  stroke(#00FF00);
  pLine(0,0,0, 0, 0, 1000);
  stroke(#0000FF);
  pLine(0,0,0, 0, 1000, 0);
  
  stroke(#FFFFFF);
  
  if (gridOnly) {
    for (int i = 1; i<=VMax; i++) {
      pLine(0, 0, i*gridW, boardLength, 0, i*gridW);
      for (int j = 1; j<=UMax; j++) { 
        pLine(j*gridW, 0, 0, j*gridW, 0, boardWidth);
      }
    }
  }
}

void drawSatellite() {
  switch(satMode) {
    case 0:
      if (vizMode == 1) { //for riyadhMode only
        pMap(satelliteLG, boardWidth, boardLength, boardWidth*519/1311, boardLength*519/1311, (1 - staticSpacer)*(dynamicSpacer*gridH + baseH) + (staticBaseH_LU+0.1)*LU_H);
      }
      break;
    case 1:
      pMap(satellite_nosite, boardWidth, boardLength, 0, 0, (1 - staticSpacer)*(dynamicSpacer*gridH + baseH) + (staticBaseH_LU+0.1)*LU_H);
      break;
    case 2:
      pMap(satellite, boardWidth, boardLength, 0, 0, (1 - staticSpacer)*(dynamicSpacer*gridH + baseH) + (staticBaseH_LU+0.1)*LU_H);
      break;
  }
}

void flip() {
  if ( flip == 1 ) {
    flip = -1;
  } else {
    flip = 1;
  }
}

// Takes block height, vertical offset, and square block width to draw a box
void drawBox(float HT, float offset, float buildingWidth) {
  pTranslate(0, HT/2+offset, 0);
  pBox(buildingWidth, HT, buildingWidth);
  pTranslate(0, -HT/2-offset, 0);
}

// Takes sphere height, vertical offset
void drawSphere(float HT, float offset) {
  pTranslate(0, HT/2+offset, 0);
  sphere(HT);
  pTranslate(0, -HT/2-offset, 0);
}

// Modified 'translate()' function that allows for two coordinate systems
void pTranslate(float x, float z, float y) {
  if (coordMode == 0) {
    translate(x, flip*z, y);
  } else {
    translate(x, -y, flip*(-z));
  }
}

// Modified 'box()' function that allows for two coordinate systems
void pBox(float x, float z, float y) {
  if (coordMode == 0) {
    box(x, z, y);
  } else {
    box(x, y, z);
  }
}

// Modified 'rotateY()' function that allows for two coordinate systems
void pRotateY(float rad) {
  if (coordMode == 0) {
    rotateY(rad);
  } else {
    rotateZ(rad);
  }
}

// Modified 'line()' function that allows for two coordinate systems
void pLine(float x1, float z1, float y1, float x2, float z2, float y2) {
  if (coordMode == 0) {
    line(x1, flip*z1, y1, x2, flip*z2, y2);
  } else {
    line(x1, -y1, flip*(-z1), x2, -y2, flip*(-z2));
  }
}

// Modified 'point()' function that allows for two coordinate systems
void pPoint(float x, float z, float y) {
  if (coordMode == 0) {
    point(x, flip*z, y);
  } else {
    point(x, -y, flip*(-z));
  }
}

// Draws Texture Maps in Model Coordinate System
void pMap(PImage img, float w, float h, float wO, float hO, float ht) { 
  beginShape();
  texture(img);
  if (coordMode == 0) {
    vertex( -hO, ht,  -wO, 0, 0);
    vertex( -hO, ht, w+wO, img.width, 0);
    vertex(h+hO, ht, w+wO, img.width, img.height);
    vertex(h+hO, ht,  -wO, 0, img.height);
  } else {
    vertex( -hO,    wO, -ht, 0, 0);
    vertex( -hO, -w-wO, -ht, img.width, 0);
    vertex(h+hO, -w-wO, -ht, img.width, img.height);
    vertex(h+hO,    wO, -ht, 0, img.height);
  }
  endShape();
    
}

// If in heatmap mode, changes fill to "offColor," something more gray and dull
void checkFill(int col, int off) {
  if (colorMode == 2) {
    fill(off);
  } else {
    fill(col);
  }
}

// If in heatmap mode, changes fill to "offColor," something more gray and dull
void checkFill(int col) {
  if (colorMode == 2) {
    fill(offColor);
  } else {
    fill(col);
  }
}

void findFill(int u, int v, int value) {
  switch(value) {
    case -2:
      checkFill(riverColor);
      break;
    case 0:
      checkFill(openColor);
      break;
    case 1:
      checkFill(roadColor);
      break;
    case 2:
      checkFill(parkColor, mediumGray);
      break;
    case 3:
      if (colorMode == 0) { // Building and Land Use Mode
        fill(residentialColor);
      } else if (colorMode == 1) { // Generic Building Form Mode
        fill(bldgColor);
      } else if (colorMode == 2) { // Heatmap
        if (heatMapActive[u][v] == 1) {
          fill(255*(1 - heatMap[u][v]), 255*heatMap[u][v], 0);
        } else {
          fill(lightGray);
        }
      }
      break;
    case 4:
      if (colorMode == 0) { // Building and Land Use Mode
        fill(officeColor);
      } else if (colorMode == 1) { // Generic Building Form Mode
        fill(bldgColor);
      } else if (colorMode == 2) { // Heatmap
        if (heatMapActive[u][v] == 1) {
          fill(255*(1 - heatMap[u][v]), 255*heatMap[u][v], 0);
        } else {
          fill(lightGray);
        }
      }
      break;
    case 5:
      if (colorMode == 0) { // Ammenity Land Use Mode
        fill(retailColor);
      } else if (colorMode == 1) { // Generic Building Form Mode
        fill(bldgColor);
      } else if (colorMode == 2) { // Heatmap
        if (heatMapActive[u][v] == 1) {
          fill(255*(1 - heatMap[u][v]), 255*heatMap[u][v], 0);
        } else {
          fill(lightGray);
        }
      }
      break;
    case 6:
      checkFill(lightGray); //Parking Lot
      break;
  }
}

// Keyboard-oriented functions:

void toggleImageDraw() {
  if (displaySatellite == false) {
    displaySatellite = true;
  } else {
    displaySatellite = false;
  }
}

void toggleScoreWebDraw() {
  if (displayScoreWeb == false) {
    displayScoreWeb = true;
  } else {
    displayScoreWeb = false;
  }
}

void changeImageMode() {
  if (satMode < 2) {
    satMode ++;
  } else {
    satMode = 0;
  }
}

void changeScoreWebMode() {
  if (webMode < 2) {
    webMode ++;
  } else {
    webMode = 0;
  }
}

void toggleNodes() {
  if (drawNodes == false) {
    drawNodes = true;
    println(drawNodes);
    loadSummary();
  } else {
    drawNodes = false;
    println(drawNodes);
    //loadSDLSummary();
    loadSummary();
  }
}

void toggleAxes() {
  if (drawAxes == false) {
    drawAxes = true;
  } else {
    drawAxes = false;
  }
}

void toggleGridOnly() {
  if (gridOnly == false) {
    gridOnly = true;
  } else {
    gridOnly = false;
  }
}

void toggleStaticOverride() {
  if (overrideStatic == false) {
    overrideStatic = true;
    //displayStatic = false;
  } else {
    overrideStatic = false;
    //displayStatic = true;
  }
}

void toggleDynamicDraw() {
  if (displayDynamic == false) {
    displayDynamic = true;
  } else {
    displayDynamic = false;
  }
}

void toggleStatsDraw() {
  if (drawStats == false) {
    drawStats = true;
    println("No Content Yet Supported");
  } else {
    drawStats = false;
  }
}

void toggleColorMode() {
  switch(colorMode) {
    case 0:
      drawNodes = true;
      nodeMode = 0;
      colorMode = 1;
      break;
    case 1:
      colorMode = 2;
      nodeMode = 1;
      drawNodes = true;
      scoreIndex = 0;
      heatMapName = scoreNames[scoreIndex];
      
      //same as key command '='
      changeDetected = true;
      simCounter = simTime;
      saveMetaJSON("metadata.json");
      checkSendNodesJSON("user");
      break;
    case 2:
      if (scoreIndex < scoreNames.length-1) {
        scoreIndex++;
        heatMapName = scoreNames[scoreIndex];
        
        //same as key command '='
        changeDetected = true;
        simCounter = simTime;
        saveMetaJSON("metadata.json");
        checkSendNodesJSON("user");
      } else {
        drawNodes = true;
        nodeMode = 0;
        colorMode = 0;
      }
      break;
  }
}

void toggleStaticDraw() {
  if (displayStatic == false) {
    displayStatic = true;
  } else {
    displayStatic = false;
  }
}

void toggleStaticSpacer() {
  if (staticSpacer == 0) {
    staticSpacer = 1;
    println("Static model now has plastic spacer.");
  } else {
    staticSpacer = 0;
    println("Static model now has no plastic spacer.");
  }
}

void toggleDynamicSpacer() {
  if (dynamicSpacer == 0) {
    dynamicSpacer = 1;
    println("Dynamic model now has plastic spacer.");
  } else {
    dynamicSpacer = 0;
    println("Dynamic model now has no plastic spacer.");
  }
}

void changeNodes() {
  if (nodeMode < 1) {
    nodeMode++;
  } else {
    nodeMode = 0;
  }  
}
