boolean showPaths = false;
boolean showGrid = false;
boolean showPathInfo = false;
boolean showSource = true;
boolean showEdges = false;
boolean showSwarm = true;
boolean showInfo = false;
boolean showTraces = false;
boolean showDemoMap = false;
boolean showVoronoi = true;

boolean button3_down = false;
boolean button4_down = false;
boolean button7_down = false;
boolean button11_down = false;
boolean button12_down = false;
boolean button13_down = false;
boolean button14_down = false;
boolean button15_down = false;
boolean button30_down = false;
boolean button31_down = false;

// Makes darker colors more visible when projecting
int masterAlpha = 15;
float schemeScaler = 0.5;
int background = 0;
int textColor = 255;
int grayColor = int(abs(background - (255.0/2)*schemeScaler));

// temp variable that holds coordinate location for a point to render
PVector coord;

// temp variable that holds coordinate locations for a line to render
PVector[] line = new PVector[2];

void drawTableCanvas(PGraphics p) {
  
  //Updates Agent Data to Display
  if (showSwarm) {
    swarmHorde.update();
    swarmHorde2.update();
    swarmHorde3.update();
    swarmHorde4.update();
    swarmHorde5.update();
    swarmHorde6.update();
    swarmHorde7.update();
    swarmHorde8.update();
    swarmHorde9.update();
    swarmHorde10.update();
    swarmHorde11.update();
    swarmHorde12.update();
    swarmHorde13.update();
    swarmHorde14.update();
    swarmHorde15.update();
    swarmHorde16.update();
  }
  
  //Updates Heatmap Data to Display
  if (showTraces) {
    traces.update(swarmHorde);
    traces.decay();
  }
  
  
  // holds time from last frame
  time_0 = millis();
  
  // Begin Draw Functions
  p.beginDraw();
 
  
      // Instead of solid background draws a translucent overlay every frame.
      // Provides the effect of giving animated elements "tails"
      p.noStroke();
      p.fill(background, 75);
      p.rect(0,0,p.width,p.height);
      
      // Displays demoMap
      if(showDemoMap) {
        p.image(demoMap, 0, 0, width, height);
      }
      
      // Displays Heatmap
      if(showTraces) {
        traces.display(p);
      }
  
      // Displays ObstacleCourses
      if (showObstacles) {
        
        if (finderMode == 1) { 
          // Obstacles for gridded Pathfinder Network
          grid.display(p, textColor, 100);
        } else if (finderMode == 2) { 
          // Obstacles for custom Pathfinder Network
          boundaries.display(p, textColor, 100);
        }
          else if (finderMode == 3) {
          grid.display(p, textColor, 100);
        }
      }
      
      // Draws pathfinding nodes onto Canvas
      if (showGrid) {
        p.image(pFinderGrid, 0, 0);
      }
      
      // Draws shortest paths for OD nodes
      if (showPaths) {
        p.image(pFinderPaths, 0, 0);
      }
      
      // Show Markers for Sources and Sinks of Angents
      if (showSource) {
        p.image(sources_Viz, 0, 0);
      }
      
      // Show OD Network for Agents
      if (showEdges) {
        p.image(edges_Viz, 0, 0);
      }
    
      // Renders Agent 'dots' and corresponding obstacles and heatmaps
      if (showSwarm) {
        swarmHorde.display(p, showTraces);
        swarmHorde2.display(p, showTraces);
        swarmHorde3.display(p, showTraces);
        swarmHorde4.display(p, showTraces);
        swarmHorde5.display(p, showTraces);
        swarmHorde6.display(p, showTraces);
        swarmHorde7.display(p, showTraces);
        swarmHorde8.display(p, showTraces);
        swarmHorde9.display(p, showTraces);
        swarmHorde10.display(p, showTraces);
        swarmHorde11.display(p, showTraces);
        swarmHorde12.display(p, showTraces);
        swarmHorde13.display(p, showTraces);
        swarmHorde14.display(p, showTraces);
        swarmHorde15.display(p, showTraces);
        swarmHorde16.display(p, showTraces);
      }
      
      if (dataMode != 0) {
        swarmHorde.displaySummary(p);
      }
      
      if (showInfo) {
        swarmHorde.displaySwarmList(p);
      }
      
      drawCredit(p);
    if (showPathInfo && dataMode != 0) {
    //Draw Background Rectangle
    p.fill(abs(textColor-25), 200);
    p.noStroke();
    p.rect(10, 40, 0.3*p.width, 10*10+10-20, 12, 12, 12, 12);
    
    //Draw Directions
    p.fill(abs(textColor-225), 255);
    p.textSize(12);
    p.text("Explanation:", 20, 60);
    p.text("Agent based modeling.", 20, 80);
    }
      
  p.endDraw();
}

void drawTestFinder(PGraphics p, Pathfinder f, ArrayList<PVector> path, ArrayList<PVector> visited) {
  
  // Draw Base Network
  f.display(p);
  
  // Draw Nodes Visited in order to find path solution
  p.strokeWeight(1);
  int base = 255;
  p.stroke(abs( background - base*schemeScaler));
  for (int i=0; i<visited.size(); i++) {
    p.ellipse(visited.get(i).x, visited.get(i).y, f.getResolution(), f.getResolution());
  }
  
  // Draws Edges that Connect Nodes Visited to Parent Nodes
  int neighbor;
  for (int i=0; i<f.allVisited.size(); i++) {
    for (int j=0; j<f.network.nodes.get(f.allVisited.get(i)).neighbors.size(); j++) {
      neighbor = f.network.nodes.get(f.allVisited.get(i)).neighbors.get(j);
      //println(neighbor);
      p.line(f.network.nodes.get(f.allVisited.get(i)).node.x, f.network.nodes.get(f.allVisited.get(i)).node.y, f.network.nodes.get(neighbor).node.x, f.network.nodes.get(neighbor).node.y);
    }
  }
  
  // Draw Path Edges
  p.strokeWeight(2);
  p.stroke(#007D00);
  for (int i=0; i<path.size()-1; i++) {
    p.line(path.get(i).x, path.get(i).y, path.get(i+1).x, path.get(i+1).y);
  }
  
  p.endDraw();
  p.beginDraw();
  
  //Draw Origin
  p.strokeWeight(2);
  p.stroke(#ff0000);
  p.noFill();
  p.ellipse(A.x, A.y, f.getResolution(), f.getResolution());
  
  p.fill(textColor);
  p.text("origin", A.x + f.getResolution(), A.y);
  
  //Draw Destination
  p.strokeWeight(2);
  p.stroke(#0000FF);
  p.noFill();
  p.ellipse(B.x, B.y, f.getResolution(), f.getResolution());
  
//  p.fill(textColor);
//  p.text("destination", B.x +finderTest f.getResolution(), B.y);
  
  //Draw Path not Found Message
  if (path.size() < 2) {
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
    p.rect(10, 4, 0.4*p.width, 10*10+10-20, 12, 12, 12, 12);
    
    //Draw Directions
    p.fill(abs(textColor-225), 255);
    if(dataMode == 0){
    p.text("Explanation:", 20, 20);
    p.text("A network, origin, and destination has been randomly generated.", 20, 40);
    p.text("A green line represents the shortest path.", 20, 60);
    p.text("Nodes are highlighted when visited by the pathfinding algorithm.", 20, 80);
    }
    
    
    p.popMatrix();
  }
  
  p.endDraw();
  p.beginDraw();
}

void drawCredit(PGraphics p) {
  p.fill(textColor);
  p.textAlign(LEFT);
  p.text("Pathfinder v1.1", 20, p.height - 40);
  p.text("Ira Winder, MIT Media Lab 2015", 20, p.height - 20);
}


void loading(PGraphics p, String item) {

  p.beginDraw();
  
  int w, h;
  boolean showName;
  
  // Draw Background Rectangle
  p.fill(abs(textColor-25), 200);
  p.stroke(textColor);
  p.strokeWeight(2);
  
  int x, y;
  
  x = p.width/2;
  y = p.height/2;
  
  if (!initialized) {
    p.background(0);
    w = 400;
    h = 50;
    showName = true;
    p.rect(x - w/2 , y - h/2 + 12/2 , w, h , 12, 12, 12, 12);
  } else {
    w = 400;
    h = 25;
    showName = false;
    p.rect(x - w/2 , y - h + 3*12/4 , w, h , 12, 12, 12, 12);
  }
  p.noStroke();
  
  // Text
  p.textAlign(CENTER);
  p.fill(abs(textColor-225), 255);
  p.textSize(12);
  p.text("Loading " + item + "...", x, y);
  if (showName) {
    p.text("Ira Winder, MIT Media Lab", x, y + 20);
  }
  
  p.endDraw();
}

void setScheme() {
  // Adjusts Colors and Transparency 
  masterAlpha = 25;
  schemeScaler = 0.4;
  grayColor = int(abs(background - (255.0/2)*schemeScaler));
}

// Reinitialize any PGraphics that use masterAlpha and schemaScaler
void refreshGraphicScheme(PGraphics p) {
  pFinderGrid_Viz(p);
}

void adjustAlpha(int a) {
   masterAlpha += a;
      if (a > 0) {
     schemeScaler += 0.05;
   } else {
     schemeScaler -= 0.05;
   }
   
   if (masterAlpha < 0) {
     masterAlpha = 0;
   }
   if (masterAlpha > 255) {
     masterAlpha = 255;
   }
   if (schemeScaler < 0) {
     schemeScaler = 0;
   }
   if (schemeScaler > 1) {
     schemeScaler = 1;
   }
}
