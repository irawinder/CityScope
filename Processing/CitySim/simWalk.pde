// This set of variables and scripts are used to estimate walkabily of a given configuration of urban space 
   
  String[] walkScoreNames = {
    "Walkable Access to Jobs and Amenities",
    "Walkable Access to Housing",
    "Walkable Access to Open Space"
  }; 
  
  String[] walkWebNames = {
    "Jobs",
    "Housing",
    "Open Spc.",
    "Living",
    "Working",
    "#Jobs"
  };
  
  String[] assumptionNames = {
    "Residential Density [m^2/pp]",
    "Non-Residential Density [m^2/pp]",
    "Employment Rate [%]",
    "Walkable Distance [m]",
    "Open Space Requirement [m^2]"
  };
  
  Table walkSummary;
  Table walkAssumptions;
  
  // Simulation Options
  
    // Sample sizes for various confidence intervals:
    int sampleSize;
    int sampleSize90 = 68;
    int sampleSize95 = 385;
    int sampleSize99 = 16589;
    
    // Number of samples to aggregate
    int numSamples = 5;
  
  // Independent Variables
    
    //Minimum Park Area Needed
    int parkMin;
    
    //Employment Rate [% of population]
    float employmentRate;

    //Household Size [ppl/HH]
    float householdSize;
    
    //Max Walking Distance [m]
    float walkDistance;
    
    //Containment Rate (fraction of people willing to work in site)
    float containmentRate;
    
    float workDensity, liveDensity;

  // Dependent Variables
    
    //Area of a single Node [m^2]
    //Built Area, Open Area, etc...
    float nodeArea;
    
    //Walk distance in unitless nodes
    int walkDistanceNodes;
    
    // Areas of various use types
    float liveArea, workArea, parkArea;
    
    // Arrays that store amounts of access and Chance to various uses per node
    int[][][][] workAccess, liveAccess, parkAccess;
    int maxWorkAccess, maxLiveAccess, maxParkAccess;
    float[][][][] jobChance;
    float maxJobChance;
    
    // Averages of Various Scores
    float avgJobChance;
    float avgEmployeeChance;
    float avgEmployerChance;
    float avgParkChance;
    
    // Population
    int livePop; // How many people live here
    int workPop; // How many people live here who are able to work
    int jobsPop; // How many Jobs are here

  // Temp Values Changed multiple times in each iteration
  int uDist, vDist, zDist;
  int u, v, z, use;
  JSONObject pt, pt2, solution;

void initWalk(int maxU, int maxV, int maxZ, JSONArray points, float wlk_dst, float emp_rt, float hh_sz, float cnt_rt) {
  //Employment Rate [% of population]
  employmentRate = 0.48545;

  //Household Size [ppl/HH]
  householdSize = 2.5;
  
  //Max Walking Distance [m]
  walkDistance = 250.0;
  
  //Minimum Park Area Needed
  parkMin = 80*160;
  
  // Live/Work density [m^2/person]
  // NYC Values - Src: http://oldurbanist.blogspot.com/2011/12/living-space-working-space-and.html
  // Let's assume people in our City need 150% more space than a NYC'r (coefficient of 1.5)

  workDensity = 1.5*20.7;
  liveDensity = 1.5*66.3*employmentRate;
  
  //Containment Rate (fraction of people willing to work in site)
  containmentRate = 1.0;
  
  //Sample size used to run simulations
  sampleSize = sampleSize95/2;
  
  workAccess = new int[maxU][maxV][maxZ][numSamples+1];
  liveAccess = new int[maxU][maxV][maxZ][numSamples+1];
  parkAccess = new int[maxU][maxV][maxZ][numSamples+1];
  jobChance = new float[maxU][maxV][maxZ][numSamples+1];
 
  // Resets Node and Access Matrices to 0
  for (int i=0; i<maxLU_W*maxPieces; i++) {
    for (int j=0; j<maxLU_W*maxPieces; j++) {
      for (int k=0; k<maxLU_H; k++) {
        for (int l=0; l<numSamples+1; l++) {
          liveAccess[i][j][k][l] = 0;
          workAccess[i][j][k][l] = 0;
          parkAccess[i][j][k][l] = 0;
          jobChance[i][j][k][l] = 0;
        } // end l loop
      } // end k loop
    } //end j loop
  } //end i loop
  
  walkSummary = new Table();
  walkSummary.addColumn(walkWebNames[0], Table.FLOAT);
  walkSummary.addColumn(walkWebNames[1], Table.FLOAT);
  walkSummary.addColumn(walkWebNames[2], Table.FLOAT);
  walkSummary.addColumn(walkWebNames[3], Table.INT);
  walkSummary.addColumn(walkWebNames[4], Table.INT);
  walkSummary.addColumn(walkWebNames[5], Table.INT);
  walkSummary.addRow();
  
  walkAssumptions = new Table();
  walkAssumptions.addColumn(assumptionNames[0], Table.FLOAT);
  walkAssumptions.addColumn(assumptionNames[1], Table.FLOAT);
  walkAssumptions.addColumn(assumptionNames[2], Table.FLOAT);
  walkAssumptions.addColumn(assumptionNames[3], Table.FLOAT);
  walkAssumptions.addColumn(assumptionNames[4], Table.FLOAT);
  walkAssumptions.addRow();
  
  
  for (int i=0; i<numSamples; i++) {
    solveWalk(nodesJSON, walkDistance, employmentRate, householdSize, containmentRate);   
  }
  
}

void mergeUse(JSONArray points, int source, int merge) {
  for (int i = 0; i < points.size(); i++) {
    
    // Each input object copied into a temporary object
    JSONObject pt;
    try {
      pt = points.getJSONObject(i); 
    } catch(RuntimeException e){
      pt = points.getJSONObject(0);  
    }
    
    if (pt.getInt("use") == source) {
      points.getJSONObject(i).setInt("use", merge);
    }
    
  }
}

void solveWalk(JSONArray points, float wlk_dst, float emp_rt, float hh_sz, float cnt_rt) {
  //Each Node in 'JSONArray points' has the following fields:
    // 'use'  
    //   0 = Ground: Open
    //   1 = Ground: Street
    //   2 = Ground: Park
    //   3 = Building: Live
    //   4 = Building: Work
    //   -2 = Water
    // 'u'    
    // 'v'
    // 'z'
  
  // Converts any "Ammenities" Use to equivalent jobs
  mergeUse(points, 5, 4);
  
  // Calculates area of a node
  nodeArea = sq(nodeW);
  
  // Translates walk distance in meters to equivalent integer node distance
  walkDistanceNodes = int(wlk_dst/avgNodeW);
  
  // Shifts past iterations of Access and Chance down the array and resets matrices [0] and [1]
  for (int i=0; i<nodesU; i++) {
    for (int j=0; j<nodesV; j++) {
      for (int k=0; k<maxZ+1; k++) {
        for (int l=numSamples; l>1; l--) {
          liveAccess[i][j][k][l] = liveAccess[i][j][k][l-1];
          workAccess[i][j][k][l] = workAccess[i][j][k][l-1];
          parkAccess[i][j][k][l] = parkAccess[i][j][k][l-1];
          jobChance[i][j][k][l] = jobChance[i][j][k][l-1];
        }
        for (int l=0; l<2; l++) {
          liveAccess[i][j][k][l] = 0;
          workAccess[i][j][k][l] = 0;
          parkAccess[i][j][k][l] = 0;
          jobChance[i][j][k][l] = 0;
        } // end l loop
      } // end k loop
    } //end j loop
  } //end i loop
  
  // Resets Access and Chance Maximums
  maxLiveAccess = 0;
  maxWorkAccess = 0;
  maxParkAccess = 0;
  maxJobChance = 0;
  avgJobChance = 0;
  avgEmployerChance = 0;
  avgEmployeeChance = 0;
  avgParkChance = 0;
  liveArea=0;
  workArea=0;
  parkArea=0;
  
  // The following for-loop iterates through each Node of an input array and determines partial access values for jobs, homes, and parks
  for (int i = 0; i < points.size(); i++) {
    // Each input object copied into a temporary object
    JSONObject pt;
   
    try {
      pt = points.getJSONObject(i); 
    } catch(RuntimeException e){
      pt = points.getJSONObject(0);  
    }
    
    u = pt.getInt("u");
    v = pt.getInt("v");
    z = pt.getInt("z");
    use = pt.getInt("use");
    
    // Calculates number of each type of live/work/park nodes
    if (use == 2) {
      parkArea++;
    } else if (use == 3) {
      liveArea++;
    } else if (use == 4) {
      workArea++;
    }
    
    // loop that runs only for limited amount of sample runs
    int j = sampleSize;
    while (j > 0) {
      j--;
      
      JSONObject pt2;
      // Random objects from entire field copied into a temporary object
      try{
        pt2 = points.getJSONObject(int(random( points.size() - 1 )));
      } catch(RuntimeException e){
        pt2 = points.getJSONObject(0);  
      }
      
      // Orthogonal horizontal distance
      uDist = abs(pt2.getInt("u") - u);
      vDist = abs(pt2.getInt("v") - v);
      // Acounts for verticle walking distance at both origin and destination
      zDist = int((nodeH/nodeW)*(pt2.getInt("z") + z));
      
      // Checks if other node is within walking distance
      if (uDist + vDist + zDist <= walkDistanceNodes) { 
        switch(pt2.getInt("use")) {
          case 2: //is park
            parkAccess[u][v][z][1]++;
            break;
          case 3: //is live
            liveAccess[u][v][z][1]++;
            break;
          case 4: //is work
            workAccess[u][v][z][1]++;
            break;
        } //end switch
      } // end if
    } // end j loop
  } // end i loop
  
  //Normalizes Areas
  liveArea *= nodeArea;
  workArea *= nodeArea;
  parkArea *= nodeArea;
  
  // Determines Populations
  livePop = int(liveArea/liveDensity/employmentRate);
  workPop = int(liveArea/liveDensity);
  jobsPop = int(workArea/workDensity);
  
  // Aggregates multiple samples of nodes Access into a single, normalized array
  for (int i=0; i<nodesU; i++) {
    for (int j=0; j<nodesV; j++) {
      for (int k=0; k<maxZ+1; k++) {
        
        // Combines Samples into average Access Sample
        for (int l=1; l<numSamples+1; l++) {
          liveAccess[i][j][k][0] += liveAccess[i][j][k][l];
          workAccess[i][j][k][0] += workAccess[i][j][k][l];
          parkAccess[i][j][k][0] += parkAccess[i][j][k][l];
        }   
        
        // Normalizes Sample values to entire population
        liveAccess[i][j][k][0] *= float(points.size())/(sampleSize*numSamples);
        workAccess[i][j][k][0] *= float(points.size())/(sampleSize*numSamples);
        parkAccess[i][j][k][0] *= float(points.size())/(sampleSize*numSamples);
        
        // Weights Node Access Values according to live/work densities per area;
        liveAccess[i][j][k][0] *= (nodeArea/liveDensity);
        workAccess[i][j][k][0] *= (nodeArea/workDensity);
        parkAccess[i][j][k][0] *= nodeArea;
        
        // Sets Max Access Values
        if (maxLiveAccess < liveAccess[i][j][k][0]) {
          maxLiveAccess = liveAccess[i][j][k][0];
        }
        if (maxWorkAccess < workAccess[i][j][k][0]) {
          maxWorkAccess = workAccess[i][j][k][0];
        }
        if (maxParkAccess < parkAccess[i][j][k][0]) {
          maxParkAccess = parkAccess[i][j][k][0];
        }
        
      } // end k loop
    } //end j loop
  } //end i loop
  
  println("maxLiveAccess = " + maxLiveAccess);
  println("maxWorkAccess = " + maxWorkAccess);
  println("maxParkAccess = " + maxParkAccess);
  
  // The following for-loop iterates through each Node of an input array and determines JobChance Values
  for (int i = 0; i < points.size(); i++) {
    
    // Each input object copied into a temporary object
    JSONObject pt;
    try {
      pt = points.getJSONObject(i); 
    } catch(RuntimeException e){
      pt = points.getJSONObject(0);  
    }
    
    u = pt.getInt("u");
    v = pt.getInt("v");
    z = pt.getInt("z");
    use = pt.getInt("use");
    
    // If live or work node
    if (use == 3 || use == 4) {  
      
      int count = 0;
      
      // loop that runs only for limited amount of sample runs
      int j = sampleSize;
      while (j > 0) {
        j--;
        
        JSONObject pt2;
        
        // Random objects from entire field copied into a temporary object
        try {
          pt2 = points.getJSONObject(int(random( points.size() - 1 )));
        } catch(RuntimeException e){
          pt2 = points.getJSONObject(0);  
        }
        
        // If live or work node
        if (pt2.getInt("use") == 3 || pt2.getInt("use") == 4) {

          if ((use == 3 && pt2.getInt("use") == 4) || (use == 4 && pt2.getInt("use") == 3)) {
            // Orthogonal horizontal distance
            uDist = abs(pt2.getInt("u") - u);
            vDist = abs(pt2.getInt("v") - v);
            // Acounts for verticle walking distance at both origin and destination
            zDist = int((nodeH/nodeW)*(pt2.getInt("z") + z));
            
            // Checks if other node is within walking distance
            if (uDist + vDist + zDist <= walkDistanceNodes) { 
              
              // If complementary nodes
              if (use == 3 && pt2.getInt("use") == 4) { // Prevents divide by 0 error
                  if (liveAccess[pt2.getInt("u")][pt2.getInt("v")][pt2.getInt("z")][0] > 0) {
                  // Adds to probabilty of having access to job
                  jobChance[u][v][z][1] += 1.0/liveAccess[pt2.getInt("u")][pt2.getInt("v")][pt2.getInt("z")][0];
                  count++;
                }
              } else if (use == 4 && pt2.getInt("use") == 3) {
                if (workAccess[pt2.getInt("u")][pt2.getInt("v")][pt2.getInt("z")][0] > 0) { // Prevents divide by 0 error
                  // Adds to probabilty of having access to worker
                  jobChance[u][v][z][1] += 1.0/workAccess[pt2.getInt("u")][pt2.getInt("v")][pt2.getInt("z")][0];
                  count++;
                }
              }
            } // end if ((use == 3 && pt2.getInt("use") == 4) || (use == 4 && pt2.getInt("use") == 3))
          } // end if (uDist + vDist + zDist <= walkDistanceNodes)
        } // end if (pt2.getInt("use") == 3 || pt2.getInt("use") == 4)
      } // end while (j > 0)   
      
      if (count > 0) {
        if (use == 3) { //is live node
          if (workAccess[u][v][z][0] > 0) { // Prevents divide by 0 error
            // Normalizes Value for given sample size
            jobChance[u][v][z][1] = jobChance[u][v][z][1]/count*workAccess[u][v][z][0];
          }
        } else if (use == 4) { // is job node
          if (liveAccess[u][v][z][0] > 0) { // Prevents divide by 0 error
            // Normalizes Value for given sample size
            jobChance[u][v][z][1] = jobChance[u][v][z][1]/count*liveAccess[u][v][z][0];
          }
        }
      }
    
    
    } else if (use == 2 || use == 6 || use == 1) { //is park, parking, or street
      jobChance[u][v][z][0] = -1;
    }
  } // end for i loop
  
  int jobCounter = 0;
  int employerCounter = 0;
  int employeeCounter = 0;
  int parkCounter = 0;
  
  // Aggregates multiple samples of Chance values into a single, normalized array
  for (int i = 0; i < points.size(); i++) {
    // Each input object copied into a temporary object
    JSONObject pt;
    
    try {
      pt = points.getJSONObject(i); 
    } catch(RuntimeException e){
      pt = points.getJSONObject(0);  
    }
    
    u = pt.getInt("u");
    v = pt.getInt("v");
    z = pt.getInt("z");
    use = pt.getInt("use");

    // Checks if Live or Work
    if (use == 3 || use == 4) {
      // Combines Chance scores Samples into average Chance
      for (int l=1; l<numSamples+1; l++) {
        jobChance[u][v][z][0] += jobChance[u][v][z][l];
      }
      jobChance[u][v][z][0] /= numSamples;
      
      if (jobChance[u][v][z][0] > 1) { // Doesn't reward values greater than 100%
        avgJobChance += 1;
      } else {
        avgJobChance += jobChance[u][v][z][0];
      }
      jobCounter++;
      
      if (use == 3) {
        if (jobChance[u][v][z][0] > 1) { // Doesn't reward values greater than 100%
          avgEmployeeChance += 1;
        } else {
          avgEmployeeChance += jobChance[u][v][z][0];
        }
        employeeCounter++;
      } else if (use == 4) {
        if (jobChance[u][v][z][0] > 1) { // Doesn't reward values greater than 100%
          avgEmployerChance += 1;
        } else {
          avgEmployerChance += jobChance[u][v][z][0];
        }
        employerCounter++;
      }
      
      //Calculates Park Chance Value
      if (parkAccess[u][v][z][0] > parkMin) { // Does not reward values greater than parkMin
        avgParkChance += 1;
      }
      parkCounter++;
      
      // Sets Max Chance Values
      if (maxJobChance < jobChance[u][v][z][0]) {
        maxJobChance = jobChance[u][v][z][0];
      }
      
    }
  } //end i loop
  
  avgJobChance /= jobCounter;
  avgEmployerChance /= employerCounter;
  avgEmployeeChance /= employeeCounter;
  avgParkChance /= parkCounter;
    
  println("maxJobChance = " + maxJobChance);
  println("avgJobChance = " + avgJobChance);
  println("avgEmployeeChance = " + avgEmployeeChance);
  println("avgEmployerChance = " + avgEmployerChance);
  println("avgParkChance = " + avgParkChance);
  
  // Merges Input Values and WalkSim Values into a single solutionJSON
  
    // Deletes all elements in the solution array 'solutionJSON'
    clearJSONArray(solutionJSON);
    
    // Each solution object populated with fields and appendend to solution array
    for (int i = 0; i < points.size(); i++) {
      // Each input object copied into a temporary object
      JSONObject pt;
     
      try {
        pt = points.getJSONObject(i); 
      } catch(RuntimeException e){
        pt = points.getJSONObject(0);  
      }
      
      u = pt.getInt("u");
      v = pt.getInt("v");
      z = pt.getInt("z");
      use = pt.getInt("use");
    
      JSONObject solution = new JSONObject();
      solution.setInt("u", u);
      solution.setInt("v", v);
      solution.setInt("z", z);
      //solution.setInt("use", pt.getInt("use"));
      
      //solution.setFloat("liveAccess", liveAccess[u][v][z][0]);
      //solution.setFloat("workAccess", workAccess[u][v][z][0]);
      //solution.setFloat("parkAccess", parkAccess[u][v][z][0]);
      
      if (pt.getInt("use") == 4) {
        solution.setFloat(walkScoreNames[0], -1);
      } else {
        solution.setFloat(walkScoreNames[0], jobChance[u][v][z][0]);
      }
        
      if (pt.getInt("use") == 3) {
        solution.setFloat(walkScoreNames[1], -1);
      } else {
        solution.setFloat(walkScoreNames[1], jobChance[u][v][z][0]);
      }
      
      if (pt.getInt("use") == 2) {
        solution.setFloat(walkScoreNames[2], -1);
      } else {
        solution.setFloat(walkScoreNames[2], float(parkAccess[u][v][z][0])/parkMin);
      }
      
      
      
      // Placeholder for "score" read by Legotizer
//      if (pt.getInt("use") == 3) {
//        solution.setFloat("score", float(parkAccess[u][v][z][0])/parkMin);
//      } else {
//        solution.setFloat("score", -1);
//      }
      
      solutionJSON.append(solution);
    } // end 'i' loop
    
    walkSummary.setFloat(0, walkWebNames[0], avgEmployeeChance);
    walkSummary.setFloat(0, walkWebNames[1], avgEmployerChance);
    walkSummary.setFloat(0, walkWebNames[2], avgParkChance);
    walkSummary.setInt(0, walkWebNames[3], livePop);
    walkSummary.setInt(0, walkWebNames[4], workPop);
    walkSummary.setInt(0, walkWebNames[5], jobsPop);
    
    walkAssumptions.setFloat(0, assumptionNames[0], liveDensity);
    walkAssumptions.setFloat(0, assumptionNames[1], workDensity);
    walkAssumptions.setFloat(0, assumptionNames[2], employmentRate*100);
    walkAssumptions.setFloat(0, assumptionNames[3], walkDistance);
    walkAssumptions.setFloat(0, assumptionNames[4], parkMin);
    
    
} //end solveWalk method


