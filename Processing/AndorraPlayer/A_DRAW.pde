boolean showData = false;
boolean showTopo = true;
boolean showPaths = false;
boolean showPathInfo = true;

int background = 0;
int textColor = 255;
int grayColor = int(255.0/4);

// temp variable that holds coordinate location for a point to render
PVector coord;

// temp variable that holds coordinate locations for a line to render
PVector[] line = new PVector[2];

color french = #2D34EA;
color spanish = #E5953F;
color other = #666666;

void drawTableCanvas(PGraphics p) {
  p.beginDraw();
  
      // Instead of solid background draws a translucent overlay every frame.
      // Provides the effect of giving animated elements "tails"
      p.noStroke();
      p.fill(background, 75);
      p.rect(0,0,canvasWidth,canvasHeight);
      
      // Draw Margin Information
      if (load_non_essential_data) {
        drawMargin(p);
      }
      
      // Allows dragging of Table Area Info
      p.translate(scrollX, scrollY);
      
      // Offsets from margin in upper-left corner 
      // Points geolocated with MercatorMap class should be rendered within this section
      p.translate(marginWidthPix, marginWidthPix);
            
            // Draw raster image of topography
            if (showTopo) {
              drawTopo(p);
            }
            
            // Draw Sample Geographic data (debugging purposes)
            if (load_non_essential_data) {
              if (showData) {
                drawData(p);
              }
            }
      
      // Reverses margin offset
      p.translate(-marginWidthPix, -marginWidthPix);

      
      // Displays Heatmap
      if(showTraces) {
        traces.display();
      }
  
      // Displays ObstacleCourses
      if (showObstacles) {
        grid.display(p, textColor, 100);
        boundaries.display(p, textColor, 100);
        topoBoundary.display(p, textColor, 100);
      }

      // Draws pathfinding nodes onto Canvas
      if (showPaths) {
        drawPathfinder(p);
      }
      
      // Renders Agent 'dots' and corresponding obstacles and heatmaps
      drawSwarms(p);
     
      // Revereses dragging of Table Area Info
      p.translate(-scrollX, -scrollY); 
  
  p.endDraw();
}





void drawMargin(PGraphics p) {
  
  // sets colors and weight
  p.fill(background);
  p.noStroke();
  
  // Top
  p.rect(0, 0, canvasWidth, marginWidthPix); 
  // Bottom
  p.rect(0, marginWidthPix + topoHeightPix, canvasWidth, marginWidthPix); 
  // Left
  p.rect(0, marginWidthPix, marginWidthPix, canvasHeight); 
  // Right
  p.rect(marginWidthPix + topoWidthPix, marginWidthPix, marginWidthPix, canvasHeight); 
  
  int[][] lineMatrix = { {2, 3},
                         {4, 5},
                         {5, 6} };
  
  p.stroke(grayColor);
  p.strokeWeight(marginWidthPix/4);
  p.fill(grayColor);
  
  for (int i=0; i<lineMatrix.length; i++) {
    p.line(container_Locations[lineMatrix[i][0]].x, container_Locations[lineMatrix[i][0]].y, container_Locations[lineMatrix[i][1]].x, container_Locations[lineMatrix[i][1]].y);
  }
  
  
  p.strokeJoin(ROUND);
  p.noFill();
  
  // St. Julia
  p.beginShape();
  p.vertex(container_Locations[1].x, container_Locations[1].y);
  p.vertex(container_Locations[1].x, marginWidthPix + 0.5*topoHeightPix);
  p.vertex(marginWidthPix, marginWidthPix + 0.5*topoHeightPix);
  p.endShape();
  
  // La Massana
  p.beginShape();
  p.vertex(container_Locations[2].x, container_Locations[2].y);
  p.vertex(container_Locations[2].x, marginWidthPix + 0.75*topoHeightPix);
  p.vertex(1.0*marginWidthPix + topoWidthPix, marginWidthPix + 0.75*topoHeightPix);
  p.endShape();
  
  // Encamp
  p.beginShape();
  p.vertex(container_Locations[4].x, container_Locations[4].y);
  p.vertex(1.0*marginWidthPix + 0.96*topoWidthPix, container_Locations[4].y);
  p.vertex(1.0*marginWidthPix + 0.96*topoWidthPix, 1.0*marginWidthPix + topoHeightPix);
  p.endShape();
  
  p.endDraw();
  p.beginDraw();
  
  p.stroke(background, 255);
  p.strokeWeight(marginWidthPix/8);
  p.fill(grayColor);
  
  for (int i=1; i<container_Locations.length; i++) {
    p.ellipse(container_Locations[i].x, container_Locations[i].y, 0.5*marginWidthPix, 0.5*marginWidthPix);
  }
  
  p.textSize(24*(projectorWidth/1920.0));
  
  p.translate(container_Locations[1].x, container_Locations[1].y);
  p.rotate(PI/2);
  p.textAlign(CENTER);
  p.text(container_Names[1], 0, marginWidthPix/2);
  p.textAlign(LEFT);
  p.rotate(-PI/2);
  p.translate(-container_Locations[1].x, -container_Locations[1].y);
  
  for (int i=2; i<4; i++) {
    p.translate(container_Locations[i].x, container_Locations[i].y);
    p.rotate(-PI/2);
    p.textAlign(CENTER);
    p.text(container_Names[i], 0, marginWidthPix/2);
    p.textAlign(LEFT);
    p.rotate(PI/2);
    p.translate(-container_Locations[i].x, -container_Locations[i].y);
  }
  
  for (int i=4; i<7; i++) {
    p.translate(container_Locations[i].x, container_Locations[i].y);
    //p.rotate(-PI/2);
    p.textAlign(CENTER);
    p.text(container_Names[i], 0, marginWidthPix/2);
    p.textAlign(LEFT);
    //p.rotate(PI/2);
    p.translate(-container_Locations[i].x, -container_Locations[i].y);
  }
  
  p.textSize(36*(projectorWidth/1920.0));
  p.text(container_Names[0], marginWidthPix, p.height-7*marginWidthPix/12);
  
  p.textSize(24*(projectorWidth/1920.0));
  p.text("Tourists |", marginWidthPix, p.height-2*marginWidthPix/12);
  
  p.fill(#00FF00);
  p.text(dates[dateIndex] + ", " + "Hour: " + hourIndex%24 + ":00 - " + (hourIndex+1)%24 + ":00", 
                   5*marginWidthPix, p.height-7*marginWidthPix/12);
  
  p.fill(spanish);
  p.text("Spanish", 4.5*marginWidthPix, p.height-2*marginWidthPix/12);
  
  p.fill(french);
  p.text("French", 3.0*marginWidthPix, p.height-2*marginWidthPix/12);
  
  p.fill(other);
  p.text("Other", 6.0*marginWidthPix, p.height-2*marginWidthPix/12);
  
  p.endDraw();
  p.beginDraw();

}



void drawTopo(PGraphics p) {
 
  // Draws Satellite images
  p.tint(255, 15);
  //p.filter(GRAY);
  p.image(topo, 0, 0, topoWidthPix, topoHeightPix);
  p.tint(255, 255);
  
}



void drawData(PGraphics p) {
  
  // Currently renders 3 sets of sample data (Local Cell Towers, Wifi, and TripAdvisor)
  
  
  
  // CDR Data:
  // Sets fill color to blue
  p.noStroke();
  p.fill(#0000FF, 150);
  for (int i=0; i<localTowers.getRowCount(); i+=2) { // iterates through each row
      
    // turns latitude and longitude of a point into canvas location within PGraphic topo
    coord = mercatorMap.getScreenLocation(new PVector(localTowers.getFloat(i, "Lat"), localTowers.getFloat(i, "Lon")));
    
    // Draw a circle 30 pixels in diameter at geolocation
    p.ellipse(coord.x, coord.y, 30, 30);
    
  }
  
  
  // TripAdvisor Data:
  // Sets fill color to red
  p.noStroke();
  p.fill(#FF0000, 150);
  for (int i=0; i<tripAdvisor.getRowCount(); i++) {
    // turns latitude and longitude of a point into canvas location within PGraphic topo
    coord = mercatorMap.getScreenLocation(new PVector(tripAdvisor.getFloat(i, "Lat"), tripAdvisor.getFloat(i, "Long")));
    
    // Draw a circle 30 pixels in diameter at geolocation
    p.ellipse(coord.x, coord.y, 30, 30);
  }
  
  
  // WiFi Data:
  // Sets fill color to green
  p.noStroke();
  p.fill(#00FF00, 150);
  for (int i=0; i<frenchWifi.getRowCount(); i+=2) {
    // turns latitude and longitude of a point into canvas location within PGraphic topo
    coord = mercatorMap.getScreenLocation(new PVector(frenchWifi.getFloat(i, "Source_lat"), frenchWifi.getFloat(i, "Source_long")));
    
    // Draw a circle 30 pixels in diameter at geolocation
    p.ellipse(coord.x, coord.y, 30, 30);
  }
  
  
  // Boundary Data:
  if (debug) {
    // Draws a boarder around the site using latitude and longitude of corner locations
    // Should line up with edge of topo canvas
    
    p.fill(0, 0);
    p.strokeWeight(20);
    
    //Top (White)
    p.stroke(#FFFFFF); //White
    line[0] = mercatorMap.getScreenLocation(UpperLeft);
    line[1] = mercatorMap.getScreenLocation(UpperRight);
    p.line(line[0].x, line[0].y, line[1].x, line[1].y);
    //Right (Red)
    p.stroke(#FF0000); //Red
    line[0] = mercatorMap.getScreenLocation(UpperRight);
    line[1] = mercatorMap.getScreenLocation(LowerRight);
    p.line(line[0].x, line[0].y, line[1].x, line[1].y);
    //Bottom (Green)
    p.stroke(#00FF00); //Green
    line[0] = mercatorMap.getScreenLocation(LowerRight);
    line[1] = mercatorMap.getScreenLocation(LowerLeft);
    p.line(line[0].x, line[0].y, line[1].x, line[1].y);
    //Left (Blue)
    p.stroke(#0000FF); //Blue
    line[0] = mercatorMap.getScreenLocation(UpperLeft);
    line[1] = mercatorMap.getScreenLocation(LowerLeft);
    p.line(line[0].x, line[0].y, line[1].x, line[1].y);
  
    p.strokeWeight(1);
  }
  
  // Test that Mouse location is filtered through geo-locator correctly
  PVector geo;
  geo = mercatorMap.getGeo(new PVector( mouseX-marginWidthPix, mouseY-marginWidthPix));
  //println(geo.x + ", " + geo.y);
  coord = mercatorMap.getScreenLocation(geo);
  p.fill(#00FF00);
  p.noStroke();
  p.ellipse(coord.x, coord.y, 10, 10);
  
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



void drawPathfinder(PGraphics p) {
  
  finderTest.display(p);
  
  // Draw Nodes Visited in order to find path solution
  p.strokeWeight(1);
  p.stroke(abs(textColor-125));
  for (int i=0; i<testVisited.size(); i++) {
    p.ellipse(testVisited.get(i).x, testVisited.get(i).y, finderTest.getResolution(), finderTest.getResolution());
  }
  
  // Draw Path Edges
  p.strokeWeight(2);
  p.stroke(#007D00);
  for (int i=0; i<testPath.size()-1; i++) {
    p.line(testPath.get(i).x, testPath.get(i).y, testPath.get(i+1).x, testPath.get(i+1).y);
  }
  
  //Draw Origin
  p.strokeWeight(2);
  p.stroke(#FF0000);
  p.noFill();
  p.ellipse(A.x, A.y, finderTest.getResolution(), finderTest.getResolution());
  
  p.fill(textColor);
  p.text("origin", A.x + finderTest.getResolution(), A.y);
  
  //Draw Destination
  p.strokeWeight(2);
  p.stroke(#0000FF);
  p.noFill();
  p.ellipse(B.x, B.y, finderTest.getResolution(), finderTest.getResolution());
  
//  p.fill(textColor);
//  p.text("destination", B.x + finderTest.getResolution(), B.y);
  
  //Draw Path not Found Message
  if (testPath.size() < 2) {
    p.textAlign(CENTER);
    p.fill(textColor);
    p.text("Path not found. Try a new origin and destination", p.width/2, p.height/2);
    p.textAlign(LEFT);
  }
  
  if (showPathInfo) {
    
    p.pushMatrix();
    p.translate(0, 10);
    
    //Draw Background Rectangle
    p.fill(abs(textColor-25), 200);
    p.noStroke();
    p.rect(10, 4, 0.4*p.width, 10*20+10 , 12, 12, 12, 12);
    
    //Draw Directions
    p.fill(abs(textColor-225), 255);
    p.text("Explanation:", 20, 20);
    p.text("A network, origin, and destination has been randomly generated.", 20, 40);
    p.text("A green line represents the shortest path.", 20, 60);
    p.text("Nodes are highlighted when visited by the pathfinding algorithm.", 20, 80);
    
    p.text("Directions:", 20, 120);
    p.text("Press 'r' to generate a new origin-destination pair", 20, 140);
    p.text("Press 'n' to generate a new network", 20, 160);
    p.text("Press 'b' to invert colors", 20, 180);
    p.text("Press 'h' to hide these directions", 20, 200);
    
    p.popMatrix();
  }
  
  p.fill(textColor);
  p.text("Pathfinder v1.0", 20, p.height - 40);
  p.text("Ira Winder, MIT Media Lab 2015", 20, p.height - 20);
}



void drawSwarms(PGraphics p) {
  
  numAgents = 0;
  
  for (Swarm s : swarms) {
    s.update();
    numAgents += s.swarm.size();
  }
  
  for (Swarm s : swarms) {
    if (showSource) {
      s.displaySource(p);
    }
    
    if (showEdges) {
      s.displayEdges(p);
    }
    
    if (showPaths) {
      s.displayPath(p);
    }
      
    if (showTraces) {
      traces.update(s);
      s.display(p, "grayscale");
    } else {
      s.display(p, "color");
    }
  }
  
  if (showTraces) {
    traces.decay();
  }
  
  for(int i=0; i<swarms.length; i++) {
    swarmSize[i] = swarms[i].swarm.size();
  }
  
  if (numAgents > maxAgents) {
    int rand;
    int counter;
    while(numAgents > maxAgents) {
      
      // Picks a random agent from one of the swarms.  Larger swarms are more likely to be selected
      rand = int(random(0, numAgents));
      counter = 0;
      for (int i=0; i<swarms.length; i++) {
        counter += swarmSize[i];
        if (rand < counter) {
          rand = i;
          //println("random: " + rand);
          break;
        }
      }
      
      //kills a random agent in the selected swarm
      if (swarms[rand].swarm.size() > 0) {
        swarms[rand].swarm.get(int(random(swarms[rand].swarm.size()))).finished = true;
        numAgents--;
        //text("TWEAK", 20,20);
        
      }
    }
    adjust /= 0.9;
  } else {
    adjust *= 0.99;
  }
  
  // Ensures that hourIndex doesn't null point
  if (hourIndex > summary.getRowCount()) {
     hourIndex = summary.getRowCount()-1;
  }
  
  p.fill(textColor);
  p.textSize(1.5*textSize);
  p.text("Total Agents Rendered: " + numAgents, marginWidthPix, 0.4*marginWidthPix);
  p.text("Adjust: " + int(adjust), marginWidthPix, 0.7*marginWidthPix);
  p.text("Total Agents in OD: " + summary.getInt(hourIndex, "TOTAL"), 7*marginWidthPix, 0.4*marginWidthPix);
  
  textSize = 8;
  
  if (showInfo) {
    p.pushMatrix();
    p.translate(2*textSize, 2*textSize + scroll);
    
    // Background rectangle
    p.fill(#555555, 50);
    p.noStroke();
    p.rect(0, 0, 32*textSize, (swarms.length+4)*1.5*textSize, textSize, textSize, textSize, textSize);
    
    // Text
    p.translate(2*textSize, 2*textSize);
    for (int i=0; i<swarms.length; i++) {
      p.fill(swarms[i].fill);
      p.textSize(textSize);
      p.text("Swarm[" + i + "]: ", 0,0);
      p.text("Weight: " + int(1000.0/swarms[i].agentDelay) + "/sec", 10*textSize,0);
      p.text("Size: " + swarms[i].swarm.size() + " agents", 20*textSize,0);
      p.translate(0, 1.5*textSize);
    }
    p.translate(0, 1.5*textSize);
    p.text("Total Swarms: " + swarms.length,0,0);
    p.translate(0, 1.5*textSize);
    p.text("Total Agents: " + numAgents,0,0);
    p.popMatrix();
  }
  
  time_0 = millis();
}
