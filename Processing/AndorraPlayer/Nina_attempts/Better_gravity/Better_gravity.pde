//DECLARE
Ball myBall; //class, class instance
Ball myBall2; 
Ball myBall3;

void setup(){
  size(600, 600); 
  smooth();
  //INITIALIZE 
  myBall = new Ball(200, 200);
  myBall2 = new Ball(100, 400);
  myBall3 = new Ball(400, 200);
} 

void draw(){
  background(0);
  //CALL FUNCTIONALITY 
  myBall.run();
  fill(0, 0, 255);
  myBall2.run();
  fill(255, 0, 0);
  myBall3.run();
  fill(0, 255, 0);
}
