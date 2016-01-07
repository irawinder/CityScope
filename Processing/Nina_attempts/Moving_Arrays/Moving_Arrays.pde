/*this is me working with arrays of objects and getting them to move and stuff*/ 


// create an empty array for 100 MovingAgent objects
Agent[] AgentArray = new Agent[100];
// create an empty array for 100 MovingAgent2 objects
Agent2[] Agent2Array = new Agent2[100];
 
void setup() {
  size(1200, 426);
  smooth();
   
  // create the objects and populate the array with them
  for(int i=0; i<AgentArray.length; i++) {
    AgentArray[i] = new Agent(100,100,10);  
  }
  for(int i=0; i<Agent2Array.length; i++) { 
    Agent2Array[i] = new Agent2(200, 200, 10);
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
  for(int i=0; i<Agent2Array.length; i++){
    Agent2Array[i].update2(); 
    Agent2Array[i].checkCollisions2();
    Agent2Array[i].drawAgent2();
  }
}
 
