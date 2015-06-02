boolean showSim = true;

JSONArray solutionJSON;
// "Solution Nodes" are stripped of all information except their u,v,and z position.
// Solutions are then added as additional properties in each element. For example:
// 'u'    
// 'v'
// 'z'
// 'solution1'
// 'solution2' ... etc

void initializeSolutionJSON() {
  //Output Nodes
  solutionJSON = new JSONArray();
}


// Sim Mode Parameters
String[] simNames = {
  "Test",
  "WalkChance"
};
int simMode = 1; // Default simulation mode is "Walk"
int simN = simNames.length;


// Loads new JSON Inputs from file and runs simulation
void updateArrayJSON(String filename, int viz) {
  loadInput(filename, viz);
  runSimulation(viz);
}

void runSimulation(int viz) {
  // Updates Solution nodes with appropriate simulation Mode
  switch(simMode) {
    case 0:
      solveTest(nodesJSON);
      break;
    case 1:
      solveWalk(nodesJSON, walkDistance, employmentRate, householdSize, containmentRate);
      saveScoreNames(walkScoreNames, "scoreNames.tsv", viz);
      saveSummary(walkSummary, "summary.tsv", viz);
      break;
  }
  
  // Saves Solution Nodes to 'legotizer_data' folder for use by other applications
  saveSolution("solutionNodes.json", viz);
}

void saveSolution(String filename, int viz) {
  saveJSONArray(solutionJSON, legotizer_data + demoPrefix + demos[viz] + filename);
  println(simNames[simMode] + " Simulation Results saved to " + legotizer_data + demoPrefix + demos[viz] + filename);
}

void saveScoreNames(String[] names, String filename, int viz) {
  saveStrings(legotizer_data + demoPrefix + demos[viz] + filename, names);
  println("ScoreNames saved to " + legotizer_data + demoPrefix + demos[viz] + filename);
}

void saveSummary(Table summary, String filename, int viz) {
  saveTable(summary, legotizer_data + demoPrefix + demos[viz] + filename);
  println("Summary saved to " + legotizer_data + demoPrefix + demos[viz] + filename);
}

// Helper method that wipes a JSON array of all elements
void clearJSONArray(JSONArray json) {
 while (json.size() > 0) { 
   json.remove(0);
 }
}
