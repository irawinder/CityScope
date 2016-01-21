// Created to test feasibility of passing JSON strings

JSONArray nodesJSON;
JSONArray context;
JSONObject[][][] obj;

JSONArray solutionJSON;

int simTime = 14;
int simCounter= 0;

String[] scoreNames;
int scoreIndex = 0;

/*
* DDP declaration (01/12/16 YS)
* DDPClient is initialized in main setup function. (Legotizer tab)
*/
boolean enableDDP = false;
String DDPAddress = "104.131.183.20";
import ddpclient.*;
DDPClient ddp;

void loadContext() {
  context = loadJSONArray(legotizer_data + demoPrefix + demos[vizMode] + "context/context.json");
  
  //Hamburg Data, created by Ryan Zhang (had to hack it around a bit to fit to model)
  if (vizMode == 4) {
    JSONObject voxel;
    for (int i=0; i<context.size(); i++) {
      voxel = context.getJSONObject(i);
      voxel.setInt("u", 175-voxel.getInt("u"));
    }
  }
}

void initializeNodesJSON() {

  nodesJSON = new JSONArray();
  obj = new JSONObject[maxPieces*maxLU_W][maxPieces*maxLU_W][maxLU_H];
  
  for (int u=0; u<maxPieces*maxLU_W; u++) {
    for (int v=0; v<maxPieces*maxLU_W; v++) {
      for (int i=0; i<maxLU_H; i++) {
        obj[u][v][i] = new JSONObject();
      }
    }
  }
  
  scoreNames = loadStrings(legotizer_data + demoPrefix + demos[vizMode] + "scoreNames.tsv");
  println(scoreNames + "simulation layers loaded.");
}

void clearJSONArray(JSONArray json) {
 while (json.size() > 0) { 
   json.remove(0);
 }
}



void saveNodesJSON(String filename) {
  
  clearJSONArray(nodesJSON);
  // Evaluates to 1 or 4 LU
  int LU = 1+structureMode*3;
  int counter = 0;
  
  // Conversion Units for exporting nodes in meters
  float axisOffset, vDist, hDist, gapDist;
  if (structureMode == 0 && pieceW_LU == 4) {
    axisOffset = scaler/LU_W*(gridGap*dynamicSpacer + pieceW_LU*LU_W/2);
    hDist = scaler/LU_W*(pieceW_LU*LU_W);
  } else {
    axisOffset = scaler/LU_W*(gridGap*dynamicSpacer + LU_W/2);
    hDist = scaler/LU_W*(LU_W);
  }
  vDist = scaler/LU_W*(pieceH_LU*LU_H);
  gapDist = scaler/LU_W*gridGap*dynamicSpacer;
  
  //println("axisOffset: " + axisOffset);
  //println("hDist: " + hDist);
  //println("vDist: " + vDist);
  //println("gapDist: " + gapDist);
  
  for (int u=0; u<UMax; u++) {
    for (int v=0; v<VMax; v++) {
      for (int i=0; i<LU; i++) {
        for (int j=0; j<LU; j++) {
          for (int z=0; z<maxLU_H; z++) {
            
            /* Commented out since pieces with voids introduced in Barcelona model...
            // breaks loop if void detected
            if (useCloud.nodes[u*LU + j][v*LU + i][z] == -1) {
              break;
            }
            */
            
            int use = int(useCloud.nodes[u*LU + j][v*LU + i][z]);
            
            if (use > 1) { // if park, live, or work
              obj[u*LU + i][v*LU + j][z].setInt("use", use);
              
              // Exports u,v,z values in meters
              //obj[u*LU + i][v*LU + j][z].setFloat("u_m", (u*LU + j)*hDist + u*gapDist + axisOffset);
              //obj[u*LU + i][v*LU + j][z].setFloat("v_m", (v*LU + i)*hDist + v*gapDist + axisOffset);
              //obj[u*LU + i][v*LU + j][z].setFloat("z_m",        (z)*vDist );
              
              // Legotizer dimensions included so that vizualizer data file can be created and returned
              obj[u*LU + i][v*LU + j][z].setFloat("u", (u*LU + j));
              obj[u*LU + i][v*LU + j][z].setFloat("v", (v*LU + i));
              obj[u*LU + i][v*LU + j][z].setFloat("z",        (z));
              nodesJSON.append(obj[u*LU + i][v*LU + j][z]);
              counter++;
            }
          }
        }
      }
    }
  }
  
  saveJSONArray(nodesJSON, legotizer_data + demoPrefix + demos[vizMode] + filename);
  println(counter + " nodes saved to " + legotizer_data + demoPrefix + demos[vizMode] + filename);
}

void checkSendNodesJSON(String filename) {
  // Checks if conditions are ideal to send updated information to a simulation script:
  // 1. Checks if there has actually been a change in the data since last simulation
  // 2. Checks if Simulation has acknowledged the receipt of previous simulation result sent
  
  if (changeDetected) {
    
    updateAllNodes();
    //println("I updated the nodes!");
    
    if (receipt) {
      // Run functions and simulations to update any dependent parameters
  
      saveNodesJSON(filename + "Nodes.json");
      
      //Sends 'resimulate' command to Simulation
      sendCommand("resimulate_" + filename + "\t" + vizMode, 6667);
      receipt = false;
      
      if (simCounter == 0) {
        changeDetected = false;
      } else {
        simCounter--;
      }
      /**
      * Sending DDP (01/12/16 YS)
      */
      if(enableDDP){  
        ddp.setProcessing_delay(50);
        // record 172ms good-enough
        ddp.call("sendCapture",new Object[]{smashNodes(nodesJSON).toString()}); 
        //ddp.call("sendCapture",new Object[]{nodesJSON.toString()});
      } 
      
    }
  }
}

/**
* smashNodes (01/12/16 YS)
* This function Conpresses the 'nodesJSON'
* {"v1u1":"123000000","v1u2":"32423440","String keyaddress":"String blocktype",,"v64u90":"333300000"}
* 
*/
JSONObject smashNodes(JSONArray _nodesJSON){
  int maxZ = 10;
  JSONObject smashed = new JSONObject();
  for(int i=0;i<_nodesJSON.size();i++){
    JSONObject block = _nodesJSON.getJSONObject(i);
    String uvkey = "v"+block.getInt("v")+"u"+block.getInt("u");
    
    int use = block.getInt("use");
    int z = block.getInt("z");
    String use_levels;
    
    try{
      use_levels = smashed.getString(uvkey);
    }catch(RuntimeException e){
      use_levels = new String(new char[maxZ]).replace("\0","0");
    }
    
    use_levels = use_levels.substring(0,z)+use+use_levels.substring(z+1);

    smashed.setString(uvkey,use_levels);
    
  }
  
  return smashed;
}

/**
* toggleDDP (01/12/16 YS)
* 
*/
void toggleDDP(){
  enableDDP = !enableDDP;
}

void loadSolutionJSON(JSONArray solution, String filename, String names, int viz) {
    
  try{
    solution = loadJSONArray(legotizer_data + demoPrefix + demos[viz] + filename); 
    scoreNames = loadStrings(legotizer_data + demoPrefix + demos[viz] + names);
    updateSolution(solution);
  } catch(RuntimeException e){
    println(filename + " incomplete file");
  }
}


