class Swarm {
  
  boolean generateAgent = true;
  
  ArrayList<Agent> swarm;
  
  float agentLife = width+height;
  float agentDelay;
  float maxSpeed;
  float counter = 0;
  color fill;
  
  PVector origin, destination;
  
  Swarm (float delay, int life) {
    agentLife = life;
    agentDelay = delay;
    swarm = new ArrayList<Agent>();
  }
  
  Swarm (float delay, PVector a, PVector b, float maxS, color f) {
    origin = a;
    destination = b;
    maxSpeed = maxS;
    agentLife *= (abs(a.x - b.x) + abs(a.y - b.y)) / (width+height);
    agentLife *= 4.0/maxSpeed;
    //println(agentLife);
    agentDelay = delay;
    swarm = new ArrayList<Agent>();
    fill = f;
    
  }
  
  void update() {
    
    counter ++ ;
    
    // Determines if a new agent is needed
    if (counter == agentDelay) {
      generateAgent = true;
      counter = 0;
    }
    
    // Adds an agent
    if (generateAgent) {
      if (origin == null) {
        swarm.add(new Agent(random(width), random(height), 6, maxSpeed));
      } else {
        swarm.add(new Agent(origin.x, origin.y, 6, maxSpeed));
      }
      
      generateAgent = false;
    }
    
    // removes an agent if too old
    if (swarm.size() > 0) {
      for (int i=0; i<swarm.size(); i++){
        if (swarm.get(i).finished){
          swarm.remove(i);
        }
      }
    }
    
  }
  
  void display() {
    
//    // Draw lines from origin to destinations
//    stroke(#666666);
//    strokeWeight(2);
//    line(origin.x, origin.y, destination.x, destination.y);
//    strokeWeight(1);
//    noStroke();
    
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
          v.applyBehaviors(swarm, new PVector(random(width), random(height)));
          v.update(int(agentLife));
          // draws as red if collision detected
          //v.display(#FF0000, 100);
          collision = false;
        } else {
          v.applyBehaviors(swarm, destination);
          v.update(int(agentLife));
          // draws normally if collision detected
          //v.display(fill, 100);
        }
        v.display(fill, 100);
      }
    }
  }
  
}
    
