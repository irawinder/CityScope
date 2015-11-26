//----mouse interaction and random colors---
void setup(){
  size(1000, 1000);
}
  
void draw() {
  if (mousePressed) {
    //if mouse is actually pressed down color changes
    fill(random(255), random(255), random(255));
    stroke(#0000ff);
  } else {
    fill(255);
    stroke(0);
  }
  ellipse(mouseX, mouseY, 80, 80);
  fill(0);
  triangle(mouseX, mouseY, mouseX, mouseY-100, mouseX+50, mouseY+50);
  //if any key pressed redraws background to random color to look like everything was erased 
  if (keyPressed) {
    fill(random(255), random(255), random(255)); 
    noStroke(); 
    ellipse(500, 500, 2700, 2700); 
  }
}
