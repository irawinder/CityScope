//just a handy script to help with placement of stuff in respect to the canvas 
void setup() {
  size(640, 360);
  noStroke();
  background(#6699ff);
}

void draw() {
  ellipse(width/2, height/2, 20, 20);
  fill(0);
  ellipse(width/3, height/3, 20, 20);
  fill(100);
  ellipse(width/5, height/5, 20, 20);
  fill(0);
  ellipse(2*width/3, height/3, 20, 20);
  fill(100);
  ellipse(4*width/5, height/5, 20, 20);
  fill(250);
}
