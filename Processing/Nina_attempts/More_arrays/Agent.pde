//randomly colored circles and their properties that change with key motions 
class Agent {
 
  float x;
  float y;
  float xspeed;
  float yspeed;
  color red = color(255, 0, 0);
  color blue = color(0, 0, 255);
  color green = color(0, 255, 0);
   
  float agent_size;
 
  Agent(float xpos, float ypos, float csize) {
    x = width/2;
    y = height/2;
    //x += xpos;
    //y += ypos;
    agent_size = csize;
     
    xspeed = random(-5, 5);
    yspeed = random(-5, 5);
  }
 
  void update() {
    x += xspeed;
    y += yspeed; 
    if(keyPressed) {
    switch (key) {
    case 'l':
      xspeed = -10;
      yspeed = 1;
      break;
    case 'r':
      xspeed = 10;
      yspeed = -1;
      break;
    case 's':
      xspeed = random(0, 0); 
      yspeed = random(0, 0);
      break;
    case ' ':
      xspeed = random(-10, 10);
      yspeed = random(-1, 1);
      break;
    case 'u': 
      xspeed = random(-2, 2);
      yspeed = random(-1, 1); 
      x = width/2;
      y = height/2;
      break;
    }
  }
  }
  
  void checkCollisions() {
     
    float r = agent_size/2;
     
    if ( (x<r) || (x>width-r)){
      xspeed = -xspeed;
    } 
     
    if( (y<r) || (y>height-r)) {
      yspeed = -yspeed; 
    }
     
  }
   
  void drawAgent() {
    
   ellipse(x, y, agent_size, agent_size); 
   
   if ((x > width/3) && (y > height/3)) { 
   fill(red);
   } 
   
   if ((x < (width/3)*2) && (y < (height/3)*2)){
     fill(blue); 
   }
   
   if ((x > (width/3)*2) && (y > (height/3)*2)){
     fill(green);
   }
  
  }
   
   
}

 

