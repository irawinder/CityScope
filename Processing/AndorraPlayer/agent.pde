//Set to true if agents iterated by frame
//Set to false if agents iterated by time (useful for choppy framerate; but may cause agents to "jump")
boolean frameStep = true;

float time_0 = 0;
float speed = 0.4444444;

void updateSpeed(int dir) {
  switch (dir) {
    case -1:
      speed /= 1.5;
      break;
    case 1:
      speed *= 1.5;
      break;
  }
  println("Speed: " + speed);
}

class Agent {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;
  float maxspeed;
  int age;
  float tolerance = 1;
  float fade = 1;
  
  boolean finished = false;
  boolean dead = false;
  
  int pathIndex, pathLength;
  
  Agent(float x, float y, int rad, float maxS, int pLength) {
    r = rad;
    tolerance *= r;
    location = new PVector(x + random(-tolerance, tolerance), y + random(-tolerance, tolerance));
    maxspeed = maxS;
    maxforce = 0.2;
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    age = 0;
    pathIndex = 0;
    pathLength = pLength;
  }
  
  
  
  void applyForce(PVector force){
    acceleration.add(force);

  }
  
  void reverseCourse() {
    velocity.x *= random(-20);
    velocity.y *= random(-20);
  }
  
  void roll(PVector normalForce) {
    PVector negNorm = new PVector(-1*normalForce.x, -1*normalForce.y);
    if (PVector.angleBetween(velocity, normalForce) > PVector.angleBetween(velocity, negNorm)) {
      normalForce.mult(-1);
    }
    normalForce.setMag(.5);
    applyForce(normalForce);
  }
  
  void applyBehaviors(ArrayList<Agent> agents, PVector waypoint) {
     PVector separateForce = separate(agents);
     PVector seekForce = seek(new PVector(waypoint.x + random(-tolerance, tolerance),waypoint.y + random(-tolerance, tolerance)));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  
  PVector seek(PVector target){
      PVector desired = PVector.sub(target,location);
      desired.normalize();
      desired.mult(maxspeed);
      PVector steer = PVector.sub(desired,velocity);
      steer.limit(maxforce);
      return steer;
  
  }
  
  PVector separate(ArrayList<Agent> agents){
    float desiredseparation = r*1.5;
    //float desiredseparation = r*0.5;
    PVector sum = new PVector();
    int count = 0;
    
    for(Agent other : agents) {
      float d = PVector.dist(location, other.location);
      
      if ((d > 0 ) && (d < desiredseparation)){
        
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(d);
        sum.add(diff);
        count++;
      }
    }
    if (count > 0){
      sum.div(count);
      sum.normalize();
      sum.mult(maxspeed);
      sum.sub(velocity);
      sum.limit(maxforce);
    }
   return sum;   
  }
  
  void update(int life, Obstacle sink, PVector waypoint) {
    // Update velocity
    velocity.add(acceleration);
    
    if (frameStep) {
      location.add(new PVector(speed*velocity.x, speed*velocity.y));
    } else {
      location.add(new PVector(speed*0.0625*velocity.x*(millis()-time_0), speed*0.0625*velocity.y*(millis()-time_0)));
    }
        
    // Limit speed
    velocity.limit(maxspeed);
    
    // Reset acceleration to 0 each cycle
    acceleration.mult(0);
    
    // Check if agent at end of life
    age ++;
    if (age > life*maxspeed/4) {
      finished = true;
    }
    
    if (finished) {
      //fade -= .1;
      fade -= 1;
      if (fade <= 0) {
        dead = true;
      }
    }
    
    // Checks if Agents reached current waypoint
    float prox = abs( (location.x - waypoint.x) + (location.y - waypoint.y) );
    if (prox < finderResolution) {
      pathIndex++;
      if (pathIndex >= pathLength) {
        pathIndex = pathLength - 1;
      }
    }
    
    //Checks if Agent reached destination
    if (sink.pointInPolygon(location.x, location.y)) {
      finished = true;
    }
     
    
  }
  
  void display(color fill, int alpha) {
    tableCanvas.fill(fill, fade*alpha);
    tableCanvas.noStroke();
    tableCanvas.pushMatrix();
    tableCanvas.translate(location.x, location.y);
    tableCanvas.ellipse(0, 0, r, r);
    tableCanvas.popMatrix();
  }
  
}

