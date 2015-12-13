class Ball {
//GLOBAL VARIABLES
float x = 0; 
float y = 0;
float xspeed = 2;
float yspeed = 3;
float gravity = .2;
  
//CONSTRUCTOR
Ball(float _x, float _y){
  x = _x;
  y = _y; 

}
//FUNCTIONS
void run(){
  display();
  move();
  bounce();
  gravity();
}

void gravity(){
  yspeed += gravity;
}

void bounce(){
  if(x > width || x < 0){
  xspeed = xspeed * -1;
  }
  if(y > height || y < 0){
  yspeed = yspeed * -1;
  }
}
  
void move(){
  x += xspeed; 
  y += yspeed;
}
 
void display(){
  ellipse(x, y, 20, 20);
}

}
