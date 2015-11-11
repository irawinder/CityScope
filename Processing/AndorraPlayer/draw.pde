PVector coord;

void drawTableCanvas() {
  tableCanvas.beginDraw();
  tableCanvas.background(#555555);
  
  tableCanvas.translate(marginWidthPix, marginWidthPix);
  
  tableCanvas.image(topo, 0, 0, topoWidthPix, topoHeightPix);
  
  
  // Draw Dots //
  
  setMercator(topoWidthPix, topoHeightPix);
  
  
  //println(w_shift + ", " + h_shift + ", " + topoWidthPix + ", " + topoHeightPix + ", " + marginWidthPix);
  
  
  
  tableCanvas.fill(#0000FF);
  
  for (int i=0; i<sampleOutput.getRowCount(); i+=2) {
    
    if (sampleOutput.getInt(i, "origin container") == 0) {
      
      // turns latitude and longitude of a point into canvas location within PGraphic topo
      coord = mercatorMap.getScreenLocation(new PVector(sampleOutput.getFloat(i, "origin lat"), sampleOutput.getFloat(i, "origin lon")));
      
      
      tableCanvas.ellipse(coord.x, coord.y, 30, 30);
    }
    
  }
  
  tableCanvas.fill(#FF0000);
  
  for (int i=0; i<tripAdvisor.getRowCount(); i+=2) {

    // turns latitude and longitude of a point into canvas location within PGraphic topo
    coord = mercatorMap.getScreenLocation(new PVector(tripAdvisor.getFloat(i, "Lat"), tripAdvisor.getFloat(i, "Long")));
    

    tableCanvas.ellipse(coord.x, coord.y, 30, 30);
    
  }
  
  tableCanvas.fill(#00FF00);
  
  for (int i=0; i<frenchWifi.getRowCount(); i+=2) {

    // turns latitude and longitude of a point into canvas location within PGraphic topo
    coord = mercatorMap.getScreenLocation(new PVector(frenchWifi.getFloat(i, "Source_lat"), frenchWifi.getFloat(i, "Source_long")));
    

    tableCanvas.ellipse(coord.x, coord.y, 30, 30);

    
  }
  
  
  tableCanvas.strokeWeight(20);
  
  tableCanvas.stroke(#FFFFFF);
  tableCanvas.line(mercatorMap.getScreenX(UpperLeft.y), mercatorMap.getScreenY(UpperLeft.x), mercatorMap.getScreenX(UpperRight.y), mercatorMap.getScreenY(UpperRight.x));
  tableCanvas.stroke(#FF0000);
  tableCanvas.line(mercatorMap.getScreenX(UpperRight.y), mercatorMap.getScreenY(UpperRight.x), mercatorMap.getScreenX(LowerRight.y), mercatorMap.getScreenY(LowerRight.x));
  tableCanvas.stroke(#00FF00);
  tableCanvas.line(mercatorMap.getScreenX(LowerRight.y), mercatorMap.getScreenY(LowerRight.x), mercatorMap.getScreenX(LowerLeft.y), mercatorMap.getScreenY(LowerLeft.x));
  tableCanvas.stroke(#0000FF);
  tableCanvas.line(mercatorMap.getScreenX(UpperLeft.y), mercatorMap.getScreenY(UpperLeft.x), mercatorMap.getScreenX(LowerLeft.y), mercatorMap.getScreenY(LowerLeft.x));

  tableCanvas.noStroke();
  
  unsetMercator(topoWidthPix, topoHeightPix);
  tableCanvas.translate(-marginWidthPix, -marginWidthPix);
  
//  //tableCanvas.image(theMovie, (marginWidth/tableWidth)*canvasWidth, (marginWidth/tableHeight)*canvasHeight, (topoWidth/tableWidth)*canvasWidth, (topoHeight/tableHeight)*canvasHeight);
//  
//  //framewidth = 1920; frameheight = 1080
//  //tableCanvas.image(theMovie, 0, -60, 3800, 2138);
//  
//  tableCanvas.stroke(255, 255, 255);
//  tableCanvas.fill(0, 0, 0);
//  
//  tableCanvas.rect(0, 0, canvasWidth/3, (marginWidth/tableWidth)*canvasWidth);
//  tableCanvas.rect(canvasWidth/3, 0, canvasWidth/3, (marginWidth/tableWidth)*canvasWidth);
//  tableCanvas.rect(2*canvasWidth/3, 0, canvasWidth/3, (marginWidth/tableWidth)*canvasWidth);
//  
//  tableCanvas.rect(0, (marginWidth/tableWidth)*canvasWidth, (marginWidth/tableWidth)*canvasWidth, canvasHeight-2*(marginWidth/tableWidth)*canvasWidth);
//  tableCanvas.rect(canvasWidth-(marginWidth/tableWidth)*canvasWidth, (marginWidth/tableWidth)*canvasWidth, (marginWidth/tableWidth)*canvasWidth, canvasHeight-2*(marginWidth/tableWidth)*canvasWidth);
//  
//  tableCanvas.rect(0, canvasHeight-(marginWidth/tableWidth)*canvasWidth, canvasWidth/3, (marginWidth/tableWidth)*canvasWidth);
//  tableCanvas.rect(canvasWidth/3, canvasHeight-(marginWidth/tableWidth)*canvasWidth, canvasWidth/3, (marginWidth/tableWidth)*canvasWidth);
//  tableCanvas.rect(2*canvasWidth/3, canvasHeight-(marginWidth/tableWidth)*canvasWidth, canvasWidth/3, (marginWidth/tableWidth)*canvasWidth);
  
  // End Margaret's Containers
  
  tableCanvas.endDraw();
}

void chopScreen(int projector) {
  
  offscreen.beginDraw();
  
  switch (projector) {
    
    case 0:
      offscreen.image(tableCanvas, 0, 0);
      break;
    case 1:
      offscreen.image(tableCanvas, -canvasWidth/2, 0);
      break;
    case 2:
      offscreen.image(tableCanvas, 0, -canvasHeight/2);
      break;
    case 3:
      offscreen.image(tableCanvas, -canvasWidth/2, -canvasHeight/2);
      break;
      
  }
  
  offscreen.endDraw();
  
}

public void setMercator(int w, int h) { //Run this function before drawing latitude and longitude-based data
  //Mercator Coordinates
  tableCanvas.translate(w/2, h/2);
  tableCanvas.rotate(rotation*TWO_PI/360);
  tableCanvas.translate(-w/2, -h/2);
  tableCanvas.translate(-w_shift, -h_shift);
}

public void unsetMercator(int w, int h) { //Run this function before drawing text, legends, etc
  //Canvas Coordinates
  tableCanvas.translate(w/2, h/2);
  tableCanvas.rotate(-rotation*TWO_PI/360);
  tableCanvas.translate(-w/2, -h/2);
  tableCanvas.translate(w_shift, h_shift);
}
