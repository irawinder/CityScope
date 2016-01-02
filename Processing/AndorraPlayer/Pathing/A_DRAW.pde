void drawPathfinder(PGraphics p) {
  finderTest.display(p);
  
  p.strokeWeight(2);
  
//  // Draw Path Nodes
//  for (int i=0; i<testPath.size(); i++) {
//    p.stroke(#00FF00);
//    p.ellipse(testPath.get(i).x, testPath.get(i).y, finderTest.getResolution(), finderTest.getResolution());
//  }
  
  // Draw Path Edges
  for (int i=0; i<testPath.size()-1; i++) {
    p.stroke(#00FF00);
    p.line(testPath.get(i).x, testPath.get(i).y, testPath.get(i+1).x, testPath.get(i+1).y);
  }
  
  //Draw Origin
  p.stroke(#FF0000);
  p.ellipse(A.x, A.y, finderTest.getResolution(), finderTest.getResolution());
  
  //Draw Destination
  p.stroke(#0000FF);
  p.ellipse(B.x, B.y, finderTest.getResolution(), finderTest.getResolution());
  
}
