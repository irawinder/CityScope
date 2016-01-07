
// create an empty array for 200 MovingAgent objects
Agent[] AgentArray = new Agent[50];
 
void setup() {
  size(1200, 800);
  smooth();
   
  // create the objects and populate the array with them
  for(int i=0; i<AgentArray.length; i++) {
    AgentArray[i] = new Agent(100,100,10);  
  }
}

 
void draw() {
  background(0);
  // iterate through every moving Agent
  for(int i=0; i<AgentArray.length; i++) {
    AgentArray[i].update();
    AgentArray[i].checkCollisions();
    AgentArray[i].drawAgent();
  }
}
 
