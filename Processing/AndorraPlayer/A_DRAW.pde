boolean showData = true;
boolean showTopo = true;

// temp variable that holds coordinate location for a point to render
PVector coord;

void drawTable() {
  // most likely, you'll want a black background to minimize
  // bleeding around your projection area
  background(0);
  
  // Renders the tableCanvas as either a projection map or on-screen 
  switch (drawMode) {
    case 0: // On-Screen Rendering
      image(tableCanvas, 0, (height-tableCanvas.height)/2, tableCanvas.width, tableCanvas.height);
      break;
    case 1: // Projection-Mapping Rendering
      // render the scene, transformed using the corner pin surface
      for (int i=0; i<surface.length; i++) {
        chopScreen(i);
        surface[i].render(offscreen);
      }
      break;
  }
}

void drawTableCanvas() {
  
  tableCanvas.beginDraw();
  
  
      //-----------BEGIN Drawing Margin Information --------------//
        
        drawMargin();
      
      //-----------END Drawing Margin Information ----------------//
  
  
  
  
  // Offsets from margin in upper-left corner 
  tableCanvas.translate(marginWidthPix, marginWidthPix);
  
  
  
      //-----------BEGIN Drawing Topo Information Data--------------//
        
        if (showTopo) {
          drawTopo();
        }
    
      //-----------END Drawing Topo Information Data---------------//




  // Changes coordinate system for geolocated data
  setMercator(topoWidthPix, topoHeightPix);
  
  
  
  
      //-----------Begin Drawing Geolocated Data--------------//
        
        if (loadData) {
          if (showData) {
            drawData();
          }
        }
      
      //-----------End Drawing Geolocated Data---------------//
  
  
  // Reverses coordinate system for geolocated data
  unsetMercator(topoWidthPix, topoHeightPix);
  
  // Reverses margin offset
  tableCanvas.translate(-marginWidthPix, -marginWidthPix);
  
  
  //------ BEGIN Draw Movie------//
  //tableCanvas.image(theMovie, (marginWidth/tableWidth)*canvasWidth, (marginWidth/tableHeight)*canvasHeight, (topoWidth/tableWidth)*canvasWidth, (topoHeight/tableHeight)*canvasHeight);
  //------ END Draw Movie------//

  
  tableCanvas.endDraw();
}

void drawMargin() {
  
  // sets background, including Margin, to gray
  tableCanvas.background(#555555);
  
  // Sets line color to white      
  tableCanvas.stroke(#FFFFFF);
  
  // Makes rectangles transparent
  tableCanvas.noFill();
  
  // draws top containers
  tableCanvas.rect(0, 0, canvasWidth/3, (marginWidth/tableWidth)*canvasWidth);
  tableCanvas.rect(canvasWidth/3, 0, canvasWidth/3, (marginWidth/tableWidth)*canvasWidth);
  tableCanvas.rect(2*canvasWidth/3, 0, canvasWidth/3, (marginWidth/tableWidth)*canvasWidth);
  
  // draws side containers
  tableCanvas.rect(0, (marginWidth/tableWidth)*canvasWidth, (marginWidth/tableWidth)*canvasWidth, canvasHeight-2*(marginWidth/tableWidth)*canvasWidth);
  tableCanvas.rect(canvasWidth-(marginWidth/tableWidth)*canvasWidth, (marginWidth/tableWidth)*canvasWidth, (marginWidth/tableWidth)*canvasWidth, canvasHeight-2*(marginWidth/tableWidth)*canvasWidth);
  
  // draws bottom containers
  tableCanvas.rect(0, canvasHeight-(marginWidth/tableWidth)*canvasWidth, canvasWidth/3, (marginWidth/tableWidth)*canvasWidth);
  tableCanvas.rect(canvasWidth/3, canvasHeight-(marginWidth/tableWidth)*canvasWidth, canvasWidth/3, (marginWidth/tableWidth)*canvasWidth);
  tableCanvas.rect(2*canvasWidth/3, canvasHeight-(marginWidth/tableWidth)*canvasWidth, canvasWidth/3, (marginWidth/tableWidth)*canvasWidth);

}

void drawTopo() {
 
  // Draws Satellite images
  tableCanvas.image(topo, 0, 0, topoWidthPix, topoHeightPix);
  
}

void drawData() {
  
  // Currently renders 3 sets of sample data (CDRs, Wifi, and TripAdvisor)
  
  // CDR Data:
  // Sets fill color to blue
  tableCanvas.fill(#0000FF);
  for (int i=0; i<sampleOutput.getRowCount(); i+=2) { // iterates through each row
    if (sampleOutput.getInt(i, "origin container") == 0) { // checks if lat-long of point is actually on table
      
      // turns latitude and longitude of a point into canvas location within PGraphic topo
      coord = mercatorMap.getScreenLocation(new PVector(sampleOutput.getFloat(i, "origin lat"), sampleOutput.getFloat(i, "origin lon")));
      
      // Draw a circle 30 pixels in diameter at geolocation
      tableCanvas.ellipse(coord.x, coord.y, 30, 30);
    }
  }
  
  
  // TripAdvisor Data:
  // Sets fill color to red
  tableCanvas.fill(#FF0000);
  
  for (int i=0; i<tripAdvisor.getRowCount(); i+=2) {
    // turns latitude and longitude of a point into canvas location within PGraphic topo
    coord = mercatorMap.getScreenLocation(new PVector(tripAdvisor.getFloat(i, "Lat"), tripAdvisor.getFloat(i, "Long")));
    
    // Draw a circle 30 pixels in diameter at geolocation
    tableCanvas.ellipse(coord.x, coord.y, 30, 30);
  }
  
  
  // WiFi Data:
  // Sets fill color to green
  tableCanvas.fill(#00FF00);
  
  for (int i=0; i<frenchWifi.getRowCount(); i+=2) {
    // turns latitude and longitude of a point into canvas location within PGraphic topo
    coord = mercatorMap.getScreenLocation(new PVector(frenchWifi.getFloat(i, "Source_lat"), frenchWifi.getFloat(i, "Source_long")));
    
    // Draw a circle 30 pixels in diameter at geolocation
    tableCanvas.ellipse(coord.x, coord.y, 30, 30);
  }
  
  
  // Boundary Data:
  if (debug) {
    // Draws a boarder around the site using latitude and longitude of corner locations
    // Should line up with edge of topo canvas
    
    tableCanvas.strokeWeight(20);
    
    //Top (White)
    tableCanvas.stroke(#FFFFFF); //White
    tableCanvas.line(mercatorMap.getScreenX(UpperLeft.y), mercatorMap.getScreenY(UpperLeft.x), mercatorMap.getScreenX(UpperRight.y), mercatorMap.getScreenY(UpperRight.x));
    //Right (Red)
    tableCanvas.stroke(#FF0000); //Red
    tableCanvas.line(mercatorMap.getScreenX(UpperRight.y), mercatorMap.getScreenY(UpperRight.x), mercatorMap.getScreenX(LowerRight.y), mercatorMap.getScreenY(LowerRight.x));
    //Bottom (Green)
    tableCanvas.stroke(#00FF00); //Green
    tableCanvas.line(mercatorMap.getScreenX(LowerRight.y), mercatorMap.getScreenY(LowerRight.x), mercatorMap.getScreenX(LowerLeft.y), mercatorMap.getScreenY(LowerLeft.x));
    //Left (Blue)
    tableCanvas.stroke(#0000FF); //Blue
    tableCanvas.line(mercatorMap.getScreenX(UpperLeft.y), mercatorMap.getScreenY(UpperLeft.x), mercatorMap.getScreenX(LowerLeft.y), mercatorMap.getScreenY(LowerLeft.x));
  
    tableCanvas.strokeWeight(1);
  }
  
}

public void setMercator(int w, int h) { //Run this function before drawing latitude and longitude-based data
  //Mercator Coordinates
  tableCanvas.translate(w/2, h/2);
  tableCanvas.rotate(rotation*TWO_PI/360);
  tableCanvas.translate(-w/2, -h/2);
  tableCanvas.translate(-w_shift, -h_shift);
}

public void unsetMercator(int w, int h) { //Run this function after drawing latitude longitude data, before drawing text, legends, etc
  //Canvas Coordinates
  tableCanvas.translate(w/2, h/2);
  tableCanvas.rotate(-rotation*TWO_PI/360);
  tableCanvas.translate(-w/2, -h/2);
  tableCanvas.translate(w_shift, h_shift);
}
