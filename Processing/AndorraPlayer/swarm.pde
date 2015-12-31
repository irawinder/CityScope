class Swarm {
  
  boolean generateAgent = true;
  boolean cropAgents = true;
  
  ArrayList<Agent> swarm;
  ArrayList<PVector> path;
  
  float agentLife = canvasWidth+canvasHeight;
  float agentDelay;
  float maxSpeed;
  float counter = 0;
  color fill;
  int hitbox = 5;
  
  PVector origin, destination;
  PVector[] sink_vert = new PVector[4];
  Obstacle sink;
  
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
    
    if (a == b) {
      sink_vert[0] = new PVector(0, 0);
      sink_vert[1] = sink_vert[0];
      sink_vert[2] = sink_vert[0];
      sink_vert[3] = sink_vert[0];
    } else {
      sink_vert[0] = new PVector(destination.x - hitbox, destination.y - hitbox);
      sink_vert[1] = new PVector(destination.x + hitbox, destination.y - hitbox);
      sink_vert[2] = new PVector(destination.x + hitbox, destination.y + hitbox);
      sink_vert[3] = new PVector(destination.x - hitbox, destination.y + hitbox);
    }
    sink = new Obstacle(sink_vert);
    
    maxSpeed = maxS;
    agentLife *= 1 + (abs(a.x - b.x) + abs(a.y - b.y)) / (canvasWidth+canvasHeight);
    agentLife *= 40.0/maxSpeed;
    //println(agentLife);
    agentDelay = delay;
    swarm = new ArrayList<Agent>();
    fill = f;
    
    //All Agents do not spawn on first frame
    counter += -int(random(40));
  }
  
  void solvePath(Pathfinder f) {
    path = f.findPath(origin, destination);
  }
  
  void update() {
    
    counter ++ ;
    
    // Determines if a new agent is needed
    if (counter > adjust*agentDelay/speed) {
      generateAgent = true;
      counter = 0;
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
    
  }
  
  void display(String colorMode) {
    
    if (swarm.size() > 0) {
      
      for (Agent v : swarm){
        
        boolean collision = false;
        
        // Tests for Collision with Test Objects
        for (int i=0; i<testWall.length; i++) {
          if (testWall[i].pointInPolygon(v.location.x, v.location.y) ) {
            collision = true;
            //v.reverseCourse();
            v.roll(testWall[i].normalOfEdge(v.location.x, v.location.y, v.velocity.x, v.velocity.y));
            break;
          }
        }
        
        // Tests for Collision with obstacleCourse boundaries
        if (cropAgents) {
          // agents internal to table
          collision = boundaries.testForCollision(v);
        } else {
          // agents on margins of table
          collision = container.testForCollision(v);
        }
        
        
//        // Applies unique forcevector if collision detected....not so great
//        if (collision) {
//          //v.applyBehaviors(swarm, new PVector(v.location.x+random(-10, 10), v.location.y+random(-10, 10)));
//          //v.applyBehaviors(swarm, v.location);
//          v.update(int(agentLife/speed), sink);
//          // draws as red if collision detected
//          //v.display(#FF0000, 100);
//          collision = false;
//        } else {
//          v.applyBehaviors(swarm, destination);
//          v.update(int(agentLife/speed), sink);
//          // draws normally if collision detected
//          //v.display(fill, 100);
//        }
        
        // Updates agent behavior
        v.applyBehaviors(swarm, destination);
        v.update(int(agentLife/speed), sink);
        
        if (showSwarm) {
          if (!cropAgents) {
              if (v.location.y > marginWidthPix) {
//            if (v.location.x < 0.75*marginWidthPix || v.location.x > (tableCanvas.width - 0.75*marginWidthPix) || 
//                v.location.y < 0 || v.location.y > (tableCanvas.height - 0.75*marginWidthPix) ) {
                  if(colorMode.equals("color")) {
                      v.display(fill, 255);
                  } else if(colorMode.equals("grayscale")) {
                      v.display(#333333, 100);
                  } else {
                      v.display(fill, 100);
                  }
                }
          } else {
            if (v.location.x > 1.25*marginWidthPix && v.location.x < (tableCanvas.width - 1.25*marginWidthPix) && 
                v.location.y > 1.25*marginWidthPix && v.location.y < (tableCanvas.height - 1.25*marginWidthPix) ) {
                  if(colorMode.equals("color")) {
                      v.display(fill, 255);
                  } else if(colorMode.equals("grayscale")) {
                      v.display(#333333, 100);
                  } else {
                      v.display(fill, 100);
                  }
                }
          }
        }
      }
    }
  }
  
  // Draw Sources and Sinks
  void displaySource() {
    
    if (swarm.size() > 0) {
      tableCanvas.noFill();
      tableCanvas.stroke(fill, 100);
      
      //Draw Source
      tableCanvas.strokeWeight(2);
      tableCanvas.line(origin.x - swarm.get(0).r, origin.y - swarm.get(0).r, origin.x + swarm.get(0).r, origin.y + swarm.get(0).r);
      tableCanvas.line(origin.x - swarm.get(0).r, origin.y + swarm.get(0).r, origin.x + swarm.get(0).r, origin.y - swarm.get(0).r);
      
      //Draw Sink
      tableCanvas.strokeWeight(3);
      tableCanvas.ellipse(destination.x, destination.y, 30, 30);
    }
  }
  
  void displayEdges() {
    
    // Draws weighted lines from origin to destinations
    tableCanvas.stroke(fill, 50);
    tableCanvas.fill(fill, 50);
    if (agentDelay > 0) {
      tableCanvas.strokeWeight(5.0/agentDelay);
    } else {
      tableCanvas.noStroke();
    }
    
    
      
    if (origin != destination) {
      tableCanvas.line(origin.x, origin.y, destination.x, destination.y);
    } else {
      tableCanvas.noStroke();
      tableCanvas.ellipse(origin.x, origin.y, 1.0/agentDelay, 1.0/agentDelay);
    }
    tableCanvas.strokeWeight(1);
    tableCanvas.noStroke();
      
  }
  
  void displayPath() {
    tableCanvas.strokeWeight(2);
    
//    // Draw Path Nodes
//    for (int i=0; i<testPath.size(); i++) {
//      tableCanvas.stroke(#00FF00);
//      tableCanvas.ellipse(testPath.get(i).x, testPath.get(i).y, finderResolution, finderResolution);
//    }
    
    // Draw Path Edges
    for (int i=0; i<path.size()-1; i++) {
      tableCanvas.stroke(#00FF00);
      tableCanvas.line(path.get(i).x, path.get(i).y, path.get(i+1).x, path.get(i+1).y);
    }
    
    //Draw Origin
    tableCanvas.stroke(#FF0000);
    tableCanvas.ellipse(origin.x, origin.y, finderResolution, finderResolution);
    
    //Draw Destination
    tableCanvas.stroke(#0000FF);
    tableCanvas.ellipse(destination.x, destination.y, finderResolution, finderResolution);
  }
  
}
    
