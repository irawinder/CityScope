//Set to true if agents iterated by frame
//Set to false if agents iterated by time (useful for choppy framerate; but may cause agents to "jump")
boolean frameStep = true;

float time_0 = 0;
float speed = 1.5;

class Agent {
  
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
  
  void applyBehaviors(ArrayList<Agent> agents, PVector waypoint, boolean collision) {
     PVector separateForce = separate(agents);
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
  
  PVector separate(ArrayList<Agent> agents){
    float desiredseparation = r*1.1;
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
    if (prox < finderResolution/4) {
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

// A class for managing multiple agents
class Swarm {
  
  boolean generateAgent = true;
  boolean cropAgents = false;
  boolean detectCollisions = true;
  boolean immortal = false;
  int cropDir = 0; // 0 to crop to inside of TOPO, 1 to crop to Margins
  
  ArrayList<Agent> swarm;
  
//  float agentLife = canvasWidth+canvasHeight;
  float agentLife = Float.MAX_VALUE;
  float agentDelay;
  float maxSpeed;
  float counter = 0;
  color fill;
  int hitbox = 5;
  float finderResolution = hitbox*2;
  
  PVector origin, destination;
  
  Obstacle sink;
  
  ArrayList<PVector> path;
  
  Swarm () {
    agentLife = 0;
    agentDelay = 10000;
    swarm = new ArrayList<Agent>();
  }
  
  Swarm (float delay, int life) {
    agentLife = life;
    agentDelay = delay;
    swarm = new ArrayList<Agent>();
  }
  
  Swarm (float delay, PVector a, PVector b, float maxS, color f) {
    origin = a;
    destination = b;
    
    path = new ArrayList<PVector>();
    path.add(origin);
    path.add(destination);
    
    sink = hitBox(destination, hitbox, true);
    
    maxSpeed = maxS;
    agentDelay = delay;
    swarm = new ArrayList<Agent>();
    fill = f;
    
    //All Agents do not spawn on first frame
    counter += -int(random(40));
    
    temperStandingAgents();
  }
  
  void temperStandingAgents(boolean _external) {   
    // Makes sure that agents 'staying put' generate only enough to represent their numbers then stop
    // also that they don't blead into the margin or topo
    if (origin == destination || path.size() < 2) {
      //immortal = true;
      agentLife = 1000;
      cropAgents(_external);
    }
    
  }
  
  void temperStandingAgents() {   
    // Makes sure that agents 'staying put' generate only enough to represent their numbers then stop
    if (origin == destination || path.size() < 2) {
      agentLife = 1000;
      //immortal = true;
    }
  }
  
  void cropAgents(boolean _external) {
    if (_external) {
      cropAgents = true;
      cropDir = 1;
    } else {
      cropAgents = true;
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
    
    // Remove all existing agents from swarms since they will be following wrong path
    swarm.clear();
    
    path = f.findPath(origin, destination, enable);
    finderResolution = f.getResolution();

//    // Agent generation slowed down to constant rate if path not found
//    if (path.size() == 1) {
//      agentDelay = 1;
//    }
    
//    // Agents cull themselves at origin if path not found
//    if (path.size() == 1) {
//      sink = hitBox(origin, hitbox, true);
//    }
    
    if (dataMode == 1) {
      // Generates only 10 agents
      if (path.size() == 1) {
        immortal = true;
      }
    }
  }
  
  void update() {
    
    counter ++ ;
    
    // Determines if a new agent is needed
    if (counter > adjust*agentDelay/speed && !immortal) {
      generateAgent = true;
      counter = 0;
    }
    
    if (immortal) {
      int staticNum = 4;
      
      while (swarm.size() < staticNum) {
        swarm.add(new Agent(origin.x, origin.y, 6, maxSpeed, path.size()));
      }
      while (swarm.size() > staticNum) {
        swarm.remove(0);
      }
    }
    
    // Adds an agent
    if (generateAgent) {
      if (origin == null) {
        swarm.add(new Agent(random(canvasWidth), random(canvasHeight), 6, maxSpeed, path.size()));
      } else {
        swarm.add(new Agent(origin.x, origin.y, 6, maxSpeed, path.size()));
      }
      
      generateAgent = false;
    }
    
    // removes an agent if too old or reached destination
    if (swarm.size() > 0) {
      for (int i=0; i<swarm.size(); i++){
        if (swarm.get(i).dead){
          swarm.remove(i);
        }
      }
    }
    
    // Updates existing agents in swarm
    if (swarm.size() > 0) {
      
      for (Agent v : swarm){
        
        // Slows Agent Down if Exists in Margin, Outside of Topography
        if (!topoBoundary.testForCollision(v)) {
          v.maxspeed = maxSpeed/2;
        } else {
          // Speeds agent up to natural swarm rate
          v.maxspeed = maxSpeed;
        }
        
        // Updates agent behavior
        v.applyBehaviors(swarm, path.get(v.pathIndex), detectCollisions);
        v.update(int(agentLife/speed), sink, path.get(v.pathIndex), finderResolution);
      }
    }
  }
  
  void display(PGraphics p, String colorMode) {
    if (swarm.size() > 0) {
      for (Agent v : swarm){
        
        if (!cropAgents) {
          
          if(colorMode.equals("color")) {
            // Draws colored agents
            v.display(p, fill, 150);
          } else if(colorMode.equals("grayscale")) {
            // Draws grayscaled agents
            v.display(p, #333333, 100);
          } else {
            v.display(p, fill, 100);
          }
              
        } else {
          
          if (cropDir == 0) {
            
            // Crops Agent if Exists in Margin, Outside of Topography
            if (topoBoundary.testForCollision(v)) {
  
              if(colorMode.equals("color")) {
                // Draws colored agents
                v.display(p, fill, 150);
              } else if(colorMode.equals("grayscale")) {
                // Draws grayscaled agents
                v.display(p, #333333, 100);
              } else {
                v.display(p, fill, 100);
              }
                  
            }
          } else if (cropDir == 1) {
            
            // Crops Agent if Exists in Margin, Outside of Topography
            if (!topoBoundary.testForCollision(v)) {
  
              if(colorMode.equals("color")) {
                // Draws colored agents
                v.display(p, fill, 255);
              } else if(colorMode.equals("grayscale")) {
                // Draws grayscaled agents
                v.display(p, #333333, 100);
              } else {
                v.display(p, fill, 100);
              }
            }
          }
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
  
  void displayEdges(PGraphics p) {
    
    // Draws weighted lines from origin to destinations
    p.stroke(fill, 50);
    p.fill(fill, 50);
    
    float w = 5.0/agentDelay;
   
    if (w > 0.2*p.height) {
      w = 0.2*p.height;
    }
    
    if (agentDelay > 0) {
      p.strokeWeight(w);
    } else {
      p.noStroke();
    }
    
    
      
    if (origin != destination) {
      p.line(origin.x, origin.y, destination.x, destination.y);
    } else {
      p.noStroke();
      p.ellipse(origin.x, origin.y, w, w);
    }
    p.strokeWeight(1);
    p.noStroke();
      
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
  
  int agentCount;
  
  Horde() {
    horde = new ArrayList<Swarm>();
    agentCount = 0;
  }
  
  void addSwarm(float freq, PVector a, PVector b, float maxS, color f) {
    horde.add(new Swarm(freq, a, b, maxS, f));
  }
  
  void clearHorde() {
    horde.clear();
    agentCount = 0;
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
    horde.get(i).agentDelay = freq;
  }
  
  void setFrequency(float freq) {
    for (int i=0; i<horde.size(); i++) {
      horde.get(i).agentDelay = freq;
    }
  }
  
  void solvePaths(Pathfinder p, boolean enablePathfinding) {
    for (int i=0; i<horde.size(); i++) {
      getSwarm(i).solvePath(p, enablePathfinding);
    }
  }
  
  void update() {
    agentCount = 0;
    
    for (int i=0; i<horde.size(); i++) {
      getSwarm(i).update();
      agentCount += horde.get(i).swarm.size();
    }
    
  }
  
//  void display(PGraphics p) {
//    numAgents = 0;
//    
//    for (Swarm s : swarms) {
//      s.update();
//      numAgents += s.swarm.size();
//    }
//    
//    for (Swarm s : swarms) {
//        
//      if (showTraces) {
//        traces.update(s);
//        if (showSwarm) {
//          s.display(p, "grayscale");
//        }
//      } else {
//        if (showSwarm) {
//          s.display(p, "color");
//        }
//      }
//    }
//    
//    if (showTraces) {
//      traces.decay();
//    }
//    
//    for(int i=0; i<swarms.length; i++) {
//      swarmSize[i] = swarms[i].swarm.size();
//    }
//    
//    if (numAgents > maxAgents) {
//      int rand;
//      int counter;
//      while(numAgents > maxAgents) {
//        
//        // Picks a random agent from one of the swarms.  Larger swarms are more likely to be selected
//        rand = int(random(0, numAgents));
//        counter = 0;
//        for (int i=0; i<swarms.length; i++) {
//          counter += swarmSize[i];
//          if (rand < counter) {
//            rand = i;
//            //println("random: " + rand);
//            break;
//          }
//        }
//        
//        //kills a random agent in the selected swarm
//        if (swarms[rand].swarm.size() > 0) {
//          swarms[rand].swarm.get(int(random(swarms[rand].swarm.size()))).finished = true;
//          numAgents--;
//          //text("TWEAK", 20,20);
//          
//        }
//      }
//      adjust /= 0.9;
//    } else {
//      adjust *= 0.99;
//    }
//    
//    // Ensures that hourIndex doesn't null point
//    if (hourIndex > summary.getRowCount()) {
//       hourIndex = summary.getRowCount()-1;
//    }
//    
//    p.fill(textColor);
//    p.textSize(1.5*textSize);
//    if (dataMode == 2 || dataMode == 3) {
//      p.text("Total Agents Rendered: " + numAgents, marginWidthPix, 0.4*marginWidthPix);
//      //p.text("Adjust: " + int(adjust), marginWidthPix, 0.7*marginWidthPix);
//      //p.text("Total Agents in OD: " + summary.getInt(hourIndex, "TOTAL"), 7*marginWidthPix, 0.4*marginWidthPix);
//    }
//    
//    textSize = 8;
//    
//    if (showInfo) {
//      p.pushMatrix();
//      p.translate(2*textSize, 2*textSize + scroll);
//      
//      // Background rectangle
//      p.fill(#555555, 50);
//      p.noStroke();
//      p.rect(0, 0, 32*textSize, (swarms.length+4)*1.5*textSize, textSize, textSize, textSize, textSize);
//      
//      // Text
//      p.translate(2*textSize, 2*textSize);
//      for (int i=0; i<swarms.length; i++) {
//        p.fill(swarms[i].fill);
//        p.textSize(textSize);
//        p.text("Swarm[" + i + "]: ", 0,0);
//        p.text("Weight: " + int(1000.0/swarms[i].agentDelay) + "/sec", 10*textSize,0);
//        p.text("Size: " + swarms[i].swarm.size() + " agents", 20*textSize,0);
//        p.translate(0, 1.5*textSize);
//      }
//      p.translate(0, 1.5*textSize);
//      p.text("Total Swarms: " + swarms.length,0,0);
//      p.translate(0, 1.5*textSize);
//      p.text("Total Agents: " + numAgents,0,0);
//      p.popMatrix();
//    }
//    
//    time_0 = millis();
//  }
  
}

