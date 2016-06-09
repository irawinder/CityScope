class Swarm {
  
  boolean generateAgent = true;
  
  ArrayList<Agent> swarm;
  
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
    
    sink_vert[0] = new PVector(destination.x - hitbox, destination.y - hitbox);
    sink_vert[1] = new PVector(destination.x + hitbox, destination.y - hitbox);
    sink_vert[2] = new PVector(destination.x + hitbox, destination.y + hitbox);
    sink_vert[3] = new PVector(destination.x - hitbox, destination.y + hitbox);
    sink = new Obstacle(sink_vert);
    
    maxSpeed = maxS;
    agentLife *= (abs(a.x - b.x) + abs(a.y - b.y)) / (canvasWidth+canvasHeight);
    agentLife *= 20.0/maxSpeed;
    //println(agentLife);
    agentDelay = delay;
    swarm = new ArrayList<Agent>();
    fill = f;
    
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
        swarm.add(new Agent(random(canvasWidth), random(canvasHeight), 6, maxSpeed));
      } else {
        swarm.add(new Agent(origin.x, origin.y, 6, maxSpeed));
      }
      
      generateAgent = false;
    }
    
    // removes an agent if too old or reached destination
    if (swarm.size() > 0) {
      for (int i=0; i<swarm.size(); i++){
        if (swarm.get(i).finished){
          swarm.remove(i);
        }
      }
    }
    
  }
  
  void display(String colorMode) {
    
    if (swarm.size() > 0) {
      
      for (Agent v : swarm){
        
        boolean collision = false;
        
        for (int i=0; i<testWall.length; i++) {
          
          if (testWall[i].pointInPolygon(v.location.x, v.location.y) ) {
            collision = true;
            //v.reverseCourse();
            v.roll(testWall[i].normalOfEdge(v.location.x, v.location.y, v.velocity.x, v.velocity.y));
            break;
          }
          
        }
        
        
        if (collision) {
          v.applyBehaviors(swarm, new PVector(random(canvasWidth), random(canvasHeight)));
          v.update(int(agentLife/speed), sink);
          // draws as red if collision detected
          //v.display(#FF0000, 100);
          collision = false;
        } else {
          v.applyBehaviors(swarm, destination);
          v.update(int(agentLife/speed), sink);
          // draws normally if collision detected
          //v.display(fill, 100);
        }
        
        if(colorMode.equals("color")) {
            v.display(fill, 100);
        } else if(colorMode.equals("grayscale")) {
            v.display(#333333, 100);
        } else {
            v.display(fill, 100);
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
    if (agentDelay > 0) {
      tableCanvas.strokeWeight(100.0/agentDelay);
    } else {
      tableCanvas.noStroke();
    }
    tableCanvas.line(origin.x, origin.y, destination.x, destination.y);
    tableCanvas.strokeWeight(1);
    tableCanvas.noStroke();
  }
  
}
    
