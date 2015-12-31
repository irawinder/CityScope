boolean showData = false;
boolean showTopo = true;
boolean showPaths = false;

// temp variable that holds coordinate location for a point to render
PVector coord;

// temp variable that holds coordinate locations for a line to render
PVector[] line = new PVector[2];

color french = #2D34EA;
color spanish = #E5953F;
color other = #666666;
  
void drawTable() {
  // most likely, you'll want a black background to minimize
  // bleeding around your projection area
  background(0);
  
  // Renders the tableCanvas as either a projection map or on-screen 
  switch (drawMode) {
    case 0: // On-Screen Rendering
      //image(tableCanvas, 0, (height-tableCanvas.height)/2, tableCanvas.width, tableCanvas.height);
      image(tableCanvas, 0, 0, tableCanvas.width, tableCanvas.height);
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
  
  // Instead of solid background draws a translucent overlay every frame.
  // Provides the effect of giving animated elements "tails"
  tableCanvas.noStroke();
  //fill(#ffffff, 100);
  tableCanvas.fill(background, 75);
  tableCanvas.rect(0,0,canvasWidth,canvasHeight);
  
      //-----------BEGIN Drawing Margin Information --------------//
        
        drawMargin();
      
      //-----------END Drawing Margin Information ----------------//
      
      
      // draws pathfinding nodes onto Canvas
      if (showPaths) {
        drawPathfinder();
      }
  
  
  
  // Offsets from margin in upper-left corner 
  tableCanvas.translate(marginWidthPix, marginWidthPix);
  
  
  
      //-----------BEGIN Drawing Topo Information Data--------------//
        
        if (showTopo) {
          drawTopo();
        }
    
      //-----------END Drawing Topo Information Data---------------//
  
  
  
  
      //-----------Begin Drawing Geolocated Data--------------//
        
        if (loadData) {
          if (showData) {
            drawData();
          }
        }
        
        PVector geo;
        
        geo = mercatorMap.getGeo(new PVector( mouseX-marginWidthPix, mouseY-marginWidthPix));
        //println(geo.x + ", " + geo.y);
        coord = mercatorMap.getScreenLocation(geo);
        tableCanvas.fill(#00FF00);
        tableCanvas.ellipse(coord.x, coord.y, 10, 10);
      
      //-----------End Drawing Geolocated Data---------------//
  
  // Reverses margin offset
  tableCanvas.translate(-marginWidthPix, -marginWidthPix);
  
  
  //------ BEGIN Draw Movie------//
  //tableCanvas.image(theMovie, (marginWidth/tableWidth)*canvasWidth, (marginWidth/tableHeight)*canvasHeight, (topoWidth/tableWidth)*canvasWidth, (topoHeight/tableHeight)*canvasHeight);
  //------ END Draw Movie------//
  
  tableCanvas.endDraw();
}

void drawMargin() {
  
  // sets colors and weight
  tableCanvas.fill(background);
  tableCanvas.noStroke();
  
  // Top
  tableCanvas.rect(0, 0, canvasWidth, marginWidthPix); 
  // Bottom
  tableCanvas.rect(0, marginWidthPix + topoHeightPix, canvasWidth, marginWidthPix); 
  // Left
  tableCanvas.rect(0, marginWidthPix, marginWidthPix, canvasHeight); 
  // Right
  tableCanvas.rect(marginWidthPix + topoWidthPix, marginWidthPix, marginWidthPix, canvasHeight); 
  
  int[][] lineMatrix = { {2, 3},
                         {4, 5},
                         {5, 6} };
  
  tableCanvas.stroke(grayColor);
  tableCanvas.strokeWeight(marginWidthPix/4);
  tableCanvas.fill(grayColor);
  
  for (int i=0; i<lineMatrix.length; i++) {
    tableCanvas.line(container_Locations[lineMatrix[i][0]].x, container_Locations[lineMatrix[i][0]].y, container_Locations[lineMatrix[i][1]].x, container_Locations[lineMatrix[i][1]].y);
  }
  
  
  tableCanvas.strokeJoin(ROUND);
  tableCanvas.noFill();
  
  // St. Julia
  tableCanvas.beginShape();
  tableCanvas.vertex(container_Locations[1].x, container_Locations[1].y);
  tableCanvas.vertex(container_Locations[1].x, marginWidthPix + 0.5*topoHeightPix);
  tableCanvas.vertex(marginWidthPix, marginWidthPix + 0.5*topoHeightPix);
  tableCanvas.endShape();
  
  // La Massana
  tableCanvas.beginShape();
  tableCanvas.vertex(container_Locations[2].x, container_Locations[2].y);
  tableCanvas.vertex(container_Locations[2].x, marginWidthPix + 0.75*topoHeightPix);
  tableCanvas.vertex(1.0*marginWidthPix + topoWidthPix, marginWidthPix + 0.75*topoHeightPix);
  tableCanvas.endShape();
  
  // Encamp
  tableCanvas.beginShape();
  tableCanvas.vertex(container_Locations[4].x, container_Locations[4].y);
  tableCanvas.vertex(1.0*marginWidthPix + 0.96*topoWidthPix, container_Locations[4].y);
  tableCanvas.vertex(1.0*marginWidthPix + 0.96*topoWidthPix, 1.0*marginWidthPix + topoHeightPix);
  tableCanvas.endShape();
  
  tableCanvas.stroke(background);
  tableCanvas.strokeWeight(marginWidthPix/8);
  tableCanvas.fill(textColor);
  
  tableCanvas.endDraw();
  tableCanvas.beginDraw();
  
  for (int i=1; i<container_Locations.length; i++) {
    tableCanvas.ellipse(container_Locations[i].x, container_Locations[i].y, 0.5*marginWidthPix, 0.5*marginWidthPix);
  }
  
  tableCanvas.textSize(24*(projectorWidth/1920.0));
  
  tableCanvas.translate(container_Locations[1].x, container_Locations[1].y);
  tableCanvas.rotate(PI/2);
  tableCanvas.textAlign(CENTER);
  tableCanvas.text(container_Names[1], 0, marginWidthPix/2);
  tableCanvas.textAlign(LEFT);
  tableCanvas.rotate(-PI/2);
  tableCanvas.translate(-container_Locations[1].x, -container_Locations[1].y);
  
  for (int i=2; i<4; i++) {
    tableCanvas.translate(container_Locations[i].x, container_Locations[i].y);
    tableCanvas.rotate(-PI/2);
    tableCanvas.textAlign(CENTER);
    tableCanvas.text(container_Names[i], 0, marginWidthPix/2);
    tableCanvas.textAlign(LEFT);
    tableCanvas.rotate(PI/2);
    tableCanvas.translate(-container_Locations[i].x, -container_Locations[i].y);
  }
  
  for (int i=4; i<7; i++) {
    tableCanvas.translate(container_Locations[i].x, container_Locations[i].y);
    //tableCanvas.rotate(-PI/2);
    tableCanvas.textAlign(CENTER);
    tableCanvas.text(container_Names[i], 0, marginWidthPix/2);
    tableCanvas.textAlign(LEFT);
    //tableCanvas.rotate(PI/2);
    tableCanvas.translate(-container_Locations[i].x, -container_Locations[i].y);
  }
  
  tableCanvas.textSize(36*(projectorWidth/1920.0));
  tableCanvas.text(container_Names[0], marginWidthPix, tableCanvas.height-7*marginWidthPix/12);
  
  tableCanvas.textSize(24*(projectorWidth/1920.0));
  tableCanvas.text("Tourists |", marginWidthPix, tableCanvas.height-2*marginWidthPix/12);
  
  tableCanvas.fill(#00FF00);
  tableCanvas.text(dates[dateIndex] + ", " + "Hour: " + hourIndex%24 + ":00 - " + (hourIndex+1)%24 + ":00", 
                   5*marginWidthPix, tableCanvas.height-7*marginWidthPix/12);
  
  tableCanvas.fill(spanish);
  tableCanvas.text("Spanish", 4.5*marginWidthPix, tableCanvas.height-2*marginWidthPix/12);
  
  tableCanvas.fill(french);
  tableCanvas.text("French", 3.0*marginWidthPix, tableCanvas.height-2*marginWidthPix/12);
  
  tableCanvas.fill(other);
  tableCanvas.text("Other", 6.0*marginWidthPix, tableCanvas.height-2*marginWidthPix/12);

}

void drawTopo() {
 
  // Draws Satellite images
  tableCanvas.tint(255, 15);
  //tableCanvas.filter(GRAY);
  tableCanvas.image(topo, 0, 0, topoWidthPix, topoHeightPix);
  tableCanvas.tint(255, 255);
  
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
  
  for (int i=0; i<tripAdvisor.getRowCount(); i++) {
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
    line[0] = mercatorMap.getScreenLocation(UpperLeft);
    line[1] = mercatorMap.getScreenLocation(UpperRight);
    tableCanvas.line(line[0].x, line[0].y, line[1].x, line[1].y);
    //Right (Red)
    tableCanvas.stroke(#FF0000); //Red
    line[0] = mercatorMap.getScreenLocation(UpperRight);
    line[1] = mercatorMap.getScreenLocation(LowerRight);
    tableCanvas.line(line[0].x, line[0].y, line[1].x, line[1].y);
    //Bottom (Green)
    tableCanvas.stroke(#00FF00); //Green
    line[0] = mercatorMap.getScreenLocation(LowerRight);
    line[1] = mercatorMap.getScreenLocation(LowerLeft);
    tableCanvas.line(line[0].x, line[0].y, line[1].x, line[1].y);
    //Left (Blue)
    tableCanvas.stroke(#0000FF); //Blue
    line[0] = mercatorMap.getScreenLocation(UpperLeft);
    line[1] = mercatorMap.getScreenLocation(LowerLeft);
    tableCanvas.line(line[0].x, line[0].y, line[1].x, line[1].y);
  
    tableCanvas.strokeWeight(1);
  }
  
}

void drawLineGraph() {
  
  fill(#FFFFFF);
  translate(float(1)/(maxHour+6)*width, 1.45*canvasHeight);
  text("Hr", 0, textSize);
  
  int graphHeight = 2*marginWidthPix;
  
  textAlign(CENTER);
  for (int i=0; i<=maxHour; i+=3) {
    float hor = float(i+2)/(maxHour+6)*width;
    text(i%24, hor, textSize);
  }
  
  
  noStroke();
  fill(french, 200);
  beginShape();
  vertex(float(0+2)/(maxHour+6)*width, 0 - 2*textSize);
  for (int i=0; i<=maxHour; i++) {
    float hor = float(i+2)/(maxHour+6)*width;
    vertex(hor, -graphHeight*summary.getFloat(i, "TOTAL")/maxFlow - 2*textSize);
  }
  vertex(float(maxHour+2)/(maxHour+6)*width, 0 - 2*textSize);
  endShape();
  
  noStroke();
  fill(spanish, 200);
  beginShape();
  vertex(float(0+2)/(maxHour+6)*width, 0 - 2*textSize);
  for (int i=0; i<=maxHour; i++) {
    float hor = float(i+2)/(maxHour+6)*width;
    vertex(hor, -graphHeight*(summary.getFloat(i, "TOTAL")-summary.getFloat(i, "FRENCH"))/maxFlow - 2*textSize);
  }
  vertex(float(maxHour+2)/(maxHour+6)*width, 0 - 2*textSize);
  endShape();
  
  noStroke();
  fill(other, 200);
  beginShape();
  vertex(float(0+2)/(maxHour+6)*width, 0 - 2*textSize);
  for (int i=0; i<=maxHour; i++) {
    float hor = float(i+2)/(maxHour+6)*width;
    vertex(hor, -graphHeight*(summary.getFloat(i, "TOTAL")-summary.getFloat(i, "FRENCH")-summary.getFloat(i, "SPANISH"))/maxFlow - 2*textSize);
  }
  vertex(float(maxHour+2)/(maxHour+6)*width, 0 - 2*textSize);
  endShape();
  
  textAlign(LEFT);
  textSize(18*(projectorWidth/1920.0));
  
  float hor = float(hourIndex+2)/(maxHour+6)*width;
  stroke(#00FF00, 150);
  fill(#00FF00);
  strokeWeight(2);
  line(hor, -graphHeight - 4*textSize, hor, -1.75*textSize);
  text(hourIndex%24 + ":00 - " + (hourIndex%24+1) + ":00", 
                   hor + 0.5*textSize, -graphHeight - 3*textSize);
  text(date, 
                   hor + 0.5*textSize, -graphHeight - 3*textSize + 2.5*textSize);
  
//  fill(french);
//  text(int(100*summary.getFloat(hourIndex, "FRENCH") / summary.getFloat(hourIndex, "TOTAL")) + "%", 
//                   hor + 0.5*textSize, -graphHeight - 3*textSize);
//  fill(spanish);
//  text(int(100*summary.getFloat(hourIndex, "SPANISH") / summary.getFloat(hourIndex, "TOTAL")) + "%", 
//                   hor + 0.5*textSize, -graphHeight - 3*textSize + 2*textSize);
//  fill(other);
//  text(int(100*summary.getFloat(hourIndex, "OTHER") / summary.getFloat(hourIndex, "TOTAL")) + "%", 
//                   hor + 0.5*textSize, -graphHeight - 3*textSize + 4*textSize);
  
  
  noStroke();
  
  translate(float(0+2)/(maxHour+6)*width, -1.5*graphHeight);
  
  fill(#FFFFFF);
  textSize(24*(projectorWidth/1920.0));
  textAlign(LEFT);
  text("Tourists |", 0, 0);
  
  fill(spanish);
  text("Spanish", 3.5*marginWidthPix, 0);
  
  fill(french);
  text("French", 2.0*marginWidthPix, 0);
  
  fill(other);
  text("Other", 5.0*marginWidthPix, 0);
}
