//Set to true if Pedestrians iterated by frame
//Set to false if Pedestrians iterated by time (useful for choppy framerate; but may cause Pedestrians to "jump")
boolean frameStep = true;
float time_0 = 0;
float speed = 1;

int num = 0;

class Pedestrian {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;
  float maxspeed;
  int age;
  float tolerance = 1;
  float fade;
  float maxFade = 2;
  
  boolean finished = false;
  boolean dead = false;
  
  int pathIndex, pathLength;
  
  Pedestrian(float x, float y, int rad, float maxS, int pLength) {
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
    fade = maxFade;
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
  
  void applyBehaviors(ArrayList<Pedestrian> Pedestrians, PVector waypoint, boolean collision) {
     PVector separateForce = separate(Pedestrians);
     PVector seekForce = seek(new PVector(waypoint.x + random(-tolerance, tolerance),waypoint.y + random(-tolerance, tolerance)));
     if (collision) {
       separateForce.mult(3);
       applyForce(separateForce);
     }
     seekForce.mult(1);
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
  
  PVector separate(ArrayList<Pedestrian> Pedestrians){
    float desiredseparation = r*1.1;
    //float desiredseparation = r*0.5;
    PVector sum = new PVector();
    int count = 0;
    
    for(Pedestrian other : Pedestrians) {
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
  
  void update(int life, Obstacle sink, PVector waypoint, float finderResolution) {
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
    
    // Check if Pedestrian at end of life
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
    
    // Checks if Pedestrians reached current waypoint
    float prox = abs( (location.x - waypoint.x) + (location.y - waypoint.y) );
    if (prox < finderResolution/4) {
      pathIndex++;
      if (pathIndex >= pathLength) {
        pathIndex = pathLength - 1;
      }
    }
    
    //Checks if Pedestrian reached destination
    if (sink.pointInPolygon(location.x, location.y)) {
      finished = true;
    }
     
    
  }
  
  void display(PGraphics p, color fill, int alpha) {
    p.fill(fill, (fade/maxFade)*alpha);
    p.noStroke();
    p.pushMatrix();
    p.translate(location.x, location.y);
    p.ellipse(0, 0, r, r);
    p.popMatrix();
  }
  
}

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

// A class for managing multiple Pedestrians
class Swarm {
  
  boolean generatePedestrian = true;
  boolean cropPedestrians = false;
  boolean detectCollisions = true;
  boolean immortal = false;
  int cropDir = 0; // 0 to crop to inside of TOPO, 1 to crop to Margins
  
  ArrayList<Pedestrian> swarm;
  
  float PedestrianLife = Float.MAX_VALUE;
  float PedestrianDelay;
  float maxSpeed;
  float counter = 0;
  color fill;
  int hitbox = 5;
  float finderResolution = hitbox*2;
  
  PVector origin, destination;
  
  Obstacle sink;
  
  ArrayList<PVector> path;
  
  Swarm () {
    PedestrianLife = 0;
    PedestrianDelay = 10000;
    swarm = new ArrayList<Pedestrian>();
  }
  
  Swarm (float delay, int life) {
    PedestrianLife = life;
    PedestrianDelay = delay;
    swarm = new ArrayList<Pedestrian>();
  }
  
  Swarm (float delay, PVector a, PVector b, float maxS, color f) {
    origin = a;
    destination = b;
    
    path = new ArrayList<PVector>();
    path.add(origin);
    path.add(destination);
    
    sink = hitBox(destination, hitbox, true);
    
    maxSpeed = maxS;
    PedestrianDelay = delay;
    swarm = new ArrayList<Pedestrian>();
    fill = f;
    
    //All Pedestrians do not spawn on first frame
    counter += -int(random(40));
    
    temperStandingPedestrians();
  }
  
  void temperStandingPedestrians(boolean _external) {   
    // Makes sure that Pedestrians 'staying put' generate only enough to represent their numbers then stop
    // also that they don't blead into the margin or topo
    if (origin == destination || path.size() < 2) {
      //immortal = true;
      PedestrianLife = 1000;
      cropPedestrians(_external);
    }
    
  }
  
  void temperStandingPedestrians() {   
    // Makes sure that Pedestrians 'staying put' generate only enough to represent their numbers then stop
    if (origin == destination || path.size() < 2) {
      PedestrianLife = 1000;
      //immortal = true;
    }
  }
  
  void cropPedestrians(boolean _external) {
    if (_external) {
      cropPedestrians = true;
      cropDir = 1;
    } else {
      cropPedestrians = true;
      cropDir = 0;
    }
  }
  
  Obstacle hitBox(PVector coord, int r, boolean make) {

    PVector[] hitBox = new PVector[4];
    
    if (!make) { // Creates, essentially, a useless hitbox with no area
      hitBox[0] = new PVector(0, 0);
      hitBox[1] = new PVector(0, 0);
      hitBox[2] = new PVector(0, 0);
      hitBox[3] = new PVector(0, 0);
    } else {
      hitBox[0] = new PVector( - r,  - r);
      hitBox[1] = new PVector( + r,  - r);
      hitBox[2] = new PVector( + r,  + r);
      hitBox[3] = new PVector( - r,  + r);
    }
    
    for (int i=0; i<hitBox.length; i++) {
      hitBox[i].add(coord);
    }
    
    return new Obstacle(hitBox);
  }
    
  void defaultPath() {
    path.clear();
    path.add(origin);
    path.add(destination);
  }
  
  void solvePath(Pathfinder f, boolean enable) {
    
    // Remove all existing Pedestrians from swarms since they will be following wrong path
    swarm.clear();
    
    path = f.findPath(origin, destination, enable);
    finderResolution = f.getResolution();

//    // Pedestrian generation slowed down to constant rate if path not found
//    if (path.size() == 1) {
//      PedestrianDelay = 1;
//    }
    
//    // Pedestrians cull themselves at origin if path not found
//    if (path.size() == 1) {
//      sink = hitBox(origin, hitbox, true);
//    }
    
      // Generates only 10 Pedestrians
      if (path.size() == 1) {
        immortal = true;
      }
  }
  
  void update(float _rateScaler) {
    
    counter ++ ;
    
    // Determines if a new Pedestrian is needed
    if (counter > _rateScaler*PedestrianDelay/speed && !immortal) {
      generatePedestrian = true;
      counter = 0;
    }
    
    if (immortal) {
      int staticNum = 4;
      
      while (swarm.size() < staticNum) {
        swarm.add(new Pedestrian(origin.x, origin.y, 5, maxSpeed, path.size()));
      }
      while (swarm.size() > staticNum) {
        swarm.remove(0);
      }
    }
    
    // Adds an Pedestrian
    if (generatePedestrian) {
      swarm.add(new Pedestrian(origin.x, origin.y, 5, maxSpeed, path.size()));
      generatePedestrian = false;
    }
    
    // removes an Pedestrian if too old or reached destination
    if (swarm.size() > 0) {
      for (int i=0; i<swarm.size(); i++){
        if (swarm.get(i).dead){
          swarm.remove(i);
        }
      }
    }
    
    // Updates existing Pedestrians in swarm
    if (swarm.size() > 0) {
      
      for (Pedestrian v : swarm){
        // Updates Pedestrian behavior
        v.applyBehaviors(swarm, path.get(v.pathIndex), detectCollisions);
        v.update(int(PedestrianLife/speed), sink, path.get(v.pathIndex), finderResolution);
      }
    }
  }
  
  void display(PGraphics p, String colorMode) {
    if (swarm.size() > 0) {
      for (Pedestrian v : swarm){
        if(colorMode.equals("color")) {
          // Draws colored Pedestrians
          v.display(p, fill, 150);
        } else if(colorMode.equals("grayscale")) {
          // Draws grayscaled Pedestrians
          v.display(p, #333333, 100);
        } else {
          v.display(p, fill, 100);
        }
      }
    }
  }
  
  // Draw Sources and Sinks
  void displaySource(PGraphics p) {
    p.noFill();
    p.stroke(textColor, 100);
    
    //Draw Source
    p.strokeWeight(2);
    p.line(origin.x - 5, origin.y - 5, origin.x + 5, origin.y + 5);
    p.line(origin.x - 5, origin.y + 5, origin.x + 5, origin.y - 5);
    
    //Draw Sink
    p.strokeWeight(3);
    p.ellipse(destination.x, destination.y, 30, 30);
  }
  
 
  
  void displayPath(PGraphics p) {
    p.strokeWeight(2);
    
//    // Draw Path Nodes
//    for (int i=0; i<testPath.size(); i++) {
//      p.stroke(#00FF00);
//      p.ellipse(testPath.get(i).x, testPath.get(i).y, finderResolution, finderResolution);
//    }
    
    // Draw Path Edges
    for (int i=0; i<path.size()-1; i++) {
      p.stroke(#00FF00);
      p.line(path.get(i).x, path.get(i).y, path.get(i+1).x, path.get(i+1).y);
    }
    
    //Draw Origin
    p.stroke(#FF0000);
    p.ellipse(origin.x, origin.y, finderResolution, finderResolution);
    
    //Draw Destination
    p.stroke(#0000FF);
    p.ellipse(destination.x, destination.y, finderResolution, finderResolution);
  }
  
}

// A class for managing multiple Swarms
class Horde {
  
  ArrayList<Swarm> horde;
  ArrayList<Integer> PedestrianCounts;
 
  int PedestrianCount;
  int hordeIndex;
  int maxPedestrians;
  float rateScaler;  // dynamic scalar used to nomralize Pedestrian generation rate
  float popScaler; // number between 0 and 1 to describe how much of 'maxPedestrians' to utilize
  
  Horde(int _maxPedestrians) {
    horde = new ArrayList<Swarm>();
    PedestrianCounts = new ArrayList<Integer>();
    PedestrianCount = 0;
    hordeIndex = 0;
    rateScaler = 1.0;
    popScaler = 1.0;
    maxPedestrians = _maxPedestrians;
  }
  
  void popScaler(float _popScaler) {
    popScaler = _popScaler;
  }
  
  void addSwarm(float freq, PVector a, PVector b, float maxS, color f) {
    horde.add(new Swarm(freq, a, b, maxS, f));
    PedestrianCounts.add(0);
  }
  
  void clearHorde() {
    horde.clear();
    PedestrianCounts.clear();
    PedestrianCount = 0;
  }
  
  void cullRandomPedestrian() {
    int rand, counter;
    while(PedestrianCount > popScaler*maxPedestrians) {
      // Picks a random swarm.  Likelihood a specific swarm is selected is proportional to its size
      rand = int(random(0, PedestrianCount));
      counter = 0;
      for (int i=0; i<getSwarmCount(); i++) {
        counter += PedestrianCounts.get(i);
        if (rand < counter) {
          rand = i;
          break;
        }
      }
      //kills a random Pedestrian in the selected swarm
      if (PedestrianCounts.get(rand) > 0) {
        getSwarm(rand).swarm.get(int(random(PedestrianCounts.get(rand)))).finished = true;
        PedestrianCount--;
      }
    }
  }
  
  Swarm getSwarm(int i) {
    if ( i > horde.size() - 1 ) {
      return new Swarm();
    } else {
      return horde.get(i);
    }
  }
  
  int getSwarmCount() {
    return horde.size();
  }
  
  void setFrequency(int i, float freq) {
    horde.get(i).PedestrianDelay = freq;
  }
  
  void setFrequency(float freq) {
    for (int i=0; i<horde.size(); i++) {
      horde.get(i).PedestrianDelay = freq;
    }
  }
  
  void solvePaths(Pathfinder p, boolean enablePathfinding) {
    for (int i=0; i<horde.size(); i++) {
      getSwarm(i).solvePath(p, enablePathfinding);
    }
  }
  
  void displayPaths(PGraphics p) {
    for (int i=0; i<horde.size(); i++) {
      getSwarm(i).displayPath(p);
    }
  }
  
  void displaySource(PGraphics p) {
    for (int i=0; i<horde.size(); i++) {
      getSwarm(i).displaySource(p);
    }
  }

  
  void update() {
    PedestrianCount = 0;
    
    for (int i=0; i<horde.size(); i++) {
      getSwarm(i).update(rateScaler);
      PedestrianCounts.set(i, horde.get(i).swarm.size() );
      PedestrianCount += PedestrianCounts.get(i);
    }
    
    // Pedestrian Culling to Ensure Horde Stays Below Threshold
    if (PedestrianCount > popScaler*maxPedestrians) {
      cullRandomPedestrian();
      rateScaler /= 0.9;
    } else {
      rateScaler *= 0.99;
    }
  }
  
  void display(PGraphics p) {
    for (int i=0; i<horde.size(); i++) {
        horde.get(i).display(p, "color");
    }
  }
 
  
}


