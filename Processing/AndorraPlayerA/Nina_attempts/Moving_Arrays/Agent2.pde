//same properties as Agent class, but keys do the opposite things (just for fun) 
//and fill is white
class Agent2 {
 
  float x;
  float y;
  float xspeed;
  float yspeed;
   
  float agent_size;
 
  Agent2(float xpos, float ypos, float csize) {
    x = xpos;
    y = ypos;
    agent_size = csize;
     
    xspeed = random(-10, 10);
    yspeed = random(-1, 1);
  }
 
  void update2() {
    x += xspeed;
    y += yspeed; 
    if(keyPressed) {
    switch (key) {
    case '+': //these didn't work quite like what I wanted
      x += random(20, -20);
      y += random(0, 0);
      break;
    case '-': //these didn't work quite like what I wanted
      x -= random(0, 0);
      y -= random(20, 0);
      break;
    case 'l':
      xspeed = 10;
      yspeed = -1;
      break;
    case 'r':
      xspeed = -10;
      yspeed = 1;
      break;
    case 's':
      xspeed = random(-10, 10); 
      yspeed = random(-1, 1);
      break;
    case ' ':
      xspeed = random(0, 0);
      yspeed = random(0, 0);
      break;
    case 'u': 
      x -= 50; 
      y += 0; 
      break;
    }
  }
  }
  
  void checkCollisions2() {
     
    float r = agent_size/2;
     
    if ( (x<r) || (x>width-r)){
      xspeed = -xspeed;
    } 
     
    if( (y<r) || (y>height-r)) {
      yspeed = -yspeed; 
    }
     
  }
   
  void drawAgent2() {
     
    fill(255);
    ellipse(x, y, agent_size, agent_size);
     
  }
   
   
}

