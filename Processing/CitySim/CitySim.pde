/* CitySim By Ira Winder [jiw@mit.edu], CityScope Project, Changing Places Group, MIT Media Lab
 *
 * This code analyzes a cloud of nodes in real time.  Principally, nodes are read 
 * from a JSON file that is constantly updated by 'Legotizer' and placed in the 'legotizer_data' folder.
 * likewise, results are exported to JSON format in the appropriate legotizer_data folder
 *
 *
 * UPDATES:
 * 
 * v1.01: March 29, 2015 - Started writing script framework
 * v1.02: March 31, 2015 - Created Robust Handshake between Legotizer and CitySim
 *                       - Added support for multiple visualization modes from Legotizer
 *                       - Added solutionJSON export protocol, along with 'sim' test that exports gradient map based on z-height
 * v1.03: April  3, 2015 - Reorganized Tab Structure
 *                       - Added metadata.json as an input
 *                       - Created framework for multiple simulation modes; send simulation mode name off when 
 *                       - Heatmap values may now be previewed in interface
 *                       - Ready to write "simWalk"!
 * v1.04: April  5, 2015 - Made good Progress on "simWalk", including data sampling method and tabulation of accessNodes
 *                       - On startup, simulation first iterates N times accoring to 'numSamples' 
 * v1.05: April 11, 2015 - Finished First pass at 'JobChance' Score
 *                       - Added Coefficients that adjust weight of Live and Work Nodes (tentatively set to NYC values
 * v1.06: April 12, 2015 - Added "handshake" to Legotizer when CitySim first opens (sends "reciept" string via UDP)
 * v1.07: April 13, 2015 - Added summary variables and additional score information to export (including total populations, avg scores, etc)
 * v1.08: April 15, 2015 - Fixed bug that occasionally crashes sim when JSON object not found
 *                       - Reformated labels for export; turned off parks' score in parks access heatmap
 * v1.09: April 29, 2015 - This time JSONObject not found error ACTUALLY fixed
 *                       - Doubled minimum Park requirement for walkSim
 * v1.10: August 6, 2015 - Fixed "JSONArray must start with '['" bug
 * v1.11: August 10, 2015- Fixed Residential Pop Summary Variable
 *                       - Export live and work results as separate layers
 *                      
 * TO DO: 
 * 1. Add scores for walkability, jobs rating, worker rating, parks, etc using networks and sampling method
 */
 
float version = 1.11;

void setup() {
  size(1080,1080, P3D);
  frame.setResizable(true);
  initUDP();
  
  selectFolder("Please select the 'legotizer_data' folder:", "folderSelected");
  
}

void draw() {
  
  // These are essentially Setup functions, but they are run in the first draw frame to allow for the folder selection option
  if (dataSelected && !dataLoaded) {
    initializeInputJSON();
    initializeSolutionJSON();
    
    dataLoaded = true;
    
    // Loads new JSON Inputs from file
    loadInput("userNodes.json", demoIndex);
    initWalk(maxPieces*maxLU_W, maxPieces*maxLU_W, maxLU_H, nodesJSON);
     
    // Runs simulation
    runSimulation(demoIndex);
    
    // If Legotizer was opened before simulator, this creates a handshake between the two applications
    sendCommand("receipt", 6152);
  }
  
  //-------- Draw functions enabled -------------- //
  if (dataLoaded) {
    
    // Uncomment below functions to test speed of simulation loops
    
    //loadInput("userNodes.json", demoIndex);
    //runSimulation(demoIndex);
    
    background(0);
    if (!showSim) {
      
      drawUses();
      
    } else {
      
      if (simMode == 1) {
        drawScore(walkScoreNames);
      } else if (simMode == 0) {
        drawScore(testScoreNames);
      }
      
    }
  }
  
  //println(frameRate);
}
