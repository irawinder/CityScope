/*This code was basically me trying to figure out a way to make the ellipses that are going to different containers go off the canvas.
I gave them all tails to keep track of their paths because I wanted to make paths for the containers, but that didn't happen becuase I realized
this probably isn't the best way to approach the problem
SO I just did random inputs to make something and just trying to learn more and more Processing 
I also had to make the ellipses and background interact with one another, so I'm still trying to work out how to apply this to the actual simulation 
*/ 


//Agent object
Agent agent;

void setup() {
  size(1200,426);
  background(100);
  // Make object to use for later 
  agent = new Agent(); 
}

void draw() {
  noStroke();
  fill(255,10);
  rect(0,0,width,height);
  
  // Call functions on Agent object.
  agent.update();
  agent.checkEdges();
  agent.display(); 
}

class Agent {

  // vectors for motion
  PVector origin;
  PVector velocity;

  Agent() {
    origin = new PVector(random(width),random(height)); //this would be the origin container, but just used random points for this code
    velocity = new PVector(random(-2,2),random(-2,2));
  } //just did random inputs but would feed in data if used for accurate simulation 

  void update() {
    origin.add(velocity);
  }

  void display() {
    stroke(0);
    fill(0);
    ellipse(origin.x,origin.y,35,35);
  }

  void checkEdges() {
//this is just to check edges like examples I've seen, but I would want to drive them to their destination containers
    if (origin.x > width) {
      origin.x = 0;
    } else if (origin.x < 0) {
      origin.x = width;
    }
    
    if (origin.y > height) {
      origin.y = 0;
    } else if (origin.y < 0) {
      origin.y = height;
    }

  }

}
