boolean on = true;

PVector[] bright_lights, dim_lights, shades;
PVector[][] boxes;

float extent = 100;

void setup() {
  size(1500, 1000, P3D);
  
  bright_lights = new PVector[7];
  dim_lights = new PVector[1];
  boxes = new PVector[200][2];
  shades = new PVector[bright_lights.length];
  
  reset();
}

void draw() {
  background(0);
  noStroke();
  
  background(0);
  camera(1.25*extent, 1.25*extent, 1.25*extent, extent/3, extent/3, 0.0, 
  0.0, 0.0, -1.0);
  
  lightFalloff(1.0, 0.05, 0.0);
  
//  camera(1.5*extent, 1.5*extent, 0, 0.0, 0.0, 30, 
//  0.0, 0.0, -1.0);
  
  for (int i=0; i<bright_lights.length; i++) {
    if(on){
      colorMode(HSB);
      pointLight(shades[i].x, shades[i].y, shades[i].z, bright_lights[i].x, bright_lights[i].y, bright_lights[i].z);
    }
    
//    pushMatrix();
//    translate(bright_lights[i].x, bright_lights[i].y, bright_lights[i].z);
//    sphere(2);
//    popMatrix();
    
  }
  
  for (int i=0; i<dim_lights.length; i++) {
    colorMode(RGB);
    pointLight(255, 212, 67, dim_lights[i].x, dim_lights[i].y, dim_lights[i].z);
    
    pushMatrix();
    translate(dim_lights[i].x, dim_lights[i].y, dim_lights[i].z);
    sphere(4);
    popMatrix();
  }
  
  for (int i=0; i<boxes.length; i++) {
    pushMatrix();
    translate(boxes[i][0].x, boxes[i][0].y, boxes[i][1].z/2);
    fill(255);
    box(boxes[i][1].x, boxes[i][1].y, boxes[i][1].z);
    //translate(-boxes[i][0].x, -boxes[i][0].y, -boxes[i][0].z);
    popMatrix();
  }
  
//  pointLight(51, 102, 126, 100, 100, 100);
//  
//  if (on) {
//    
//    pointLight(51, 102, 126, -100, -100, 100);
//  }
//  
//  box(45, 45, 20);
//  
//  translate(50, 50);
//  box(45, 45, 20);
  
}

void keyPressed() {
  switch(key) {
    case 'o':
      if(on) {
        on = false;
      } else {
        on = true;
      }
      break;
    case 'r':
      reset();
      break;
  }
}

void reset() {
  
  for (int i=0; i<bright_lights.length; i++) {
    bright_lights[i] = new PVector(random(-2*extent, 2*extent), random(-extent, extent), 10);
    shades[i] = new PVector(255.0*i/shades.length, 255, 255);
  }
  
  for (int i=0; i<dim_lights.length; i++) {
    dim_lights[i] = new PVector(random(-extent, extent), random(-extent, extent), 10);
  }
  
  for (int i=0; i<boxes.length; i++) {
    boxes[i][0] = new PVector(random(-extent, extent), random(-extent, extent), 0);
    boxes[i][1] = new PVector(random(10, 20), random(10, 20), random(10, 30) );
  }
}
