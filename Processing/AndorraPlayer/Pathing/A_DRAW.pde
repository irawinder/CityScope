boolean showInfo = true;

void drawPathfinder(PGraphics p) {
  
  finderTest.display(p);
  
  p.beginDraw();
  
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
  
  if (showInfo) {
    
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
  
  p.endDraw();
}
