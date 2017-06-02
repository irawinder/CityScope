float xpos;
float ypos;
int rectWidth = 20;
boolean over = false;
boolean locked = false;
float transx = 0.0; 
float transy = 0.0; 


void setup() 

{
  size(200, 200);
  xpos = width/2.0;
  ypos = height/2.0;
  rectMode(CENTER);  

}



void draw() 

{ 
  background(0);

  // Test if the cursor is over the box 
  if (mouseX > xpos-rectWidth && mouseX < xpos+rectWidth && mouseY > ypos-rectWidth && mouseY < ypos+rectWidth) {
      over = true;  
      if(!locked) { 
        stroke(255); 
        fill(153);
      } 
    } 
    
    else {
      stroke(153);
      fill(153);
      over = false;
    }

  // Draw the box
  rect(xpos, ypos, rectWidth, rectWidth);
}



void mousePressed() {
  if(over) { 
    locked = true; 
    fill(255, 255, 255);

  } else {
    locked = false;
  }

  transx = mouseX-xpos; 
  transy = mouseY-ypos; 
}



void mouseDragged() {
  if(locked) {
    xpos = mouseX-transx; 
    ypos = mouseY-transy; 
  }
}



void mouseReleased() {
  locked = false;
}
