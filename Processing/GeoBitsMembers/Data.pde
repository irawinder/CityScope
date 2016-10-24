// Data Extents Parameters

    // Display Matrix Size (cells rendered to screen)
    int inputUMax = 18;
    int inputVMax = 22;
    int IDMax = 15;
    int legoPerPiece = 4;
    int displayV = inputVMax*legoPerPiece; // Height of Lego Table
    int displayU = inputUMax*legoPerPiece; // Width of Lego Table
    int gridPanV, gridPanU; // Integers that describe how much to offset grid pixels when drawing
    int scaler, gridU, gridV;
    
    // Demand Parameters
    int WEEKS_IN_YEAR = 52;
    int DAYS_IN_YEAR = 365;
    float WALMART_MARKET_SHARE = 0.02; // 2.0%
    float HOUSEHOLD_SIZE = 2.54;

    void resetGridParameters() {
//      scaler = int(MAX_GRID_SIZE/gridSize);
      // Total Matrix Size (includes cells beyond extents of screen)
      gridV = displayV*scaler; // Height of Lego Table
      gridU = displayU*scaler; // Width of Lego Table
      // Integers that describe how much to offset grid pixels when drawing
      gridPanV = (gridV-displayV)/2;
      gridPanU = (gridU-displayU)/2;
//      resetMousePan();
    }

// Raster Basemap Data based on Google Maps
    
    
// Methods for reloading data when changing zoom level, area of analysis, etc
    
    // Set this to false if you know that you don't need to regenerate data every time Software is run
    boolean pixelizeData = true;

    void reloadData(int gridU, int gridV, int index) {
      
      // Loads extents of Input data
      initInputData(); 
      
      // Loads extents of Output data
      initOutputData(); 
      clearOutputData();
      println("faux data loaded");
      
    }


    
// Initialize Input Data (store locations, lockers, etc)
    
    // Input Matrices
    int[][] facilities, market, obstacles, form;
    
    // Runs once when initializes
    void initInputData() {
      facilities = new int[gridU][gridV];
      market = new int[gridU][gridV];
      obstacles = new int[gridU][gridV];
      form = new int[gridU][gridV];
      for (int u=0; u<gridU; u++) {
        for (int v=0; v<gridV; v++) {
          facilities[u][v] = 0;
          market[u][v] = 0;
          obstacles[u][v] = 0;
          form[u][v] = 0;
        }
      }
    }
    
// Initialize Output Data (Cost, Allocations, etc)

    // Output Matrices
    float[][] totalCost, deliveryCost;
    int[][] allocation, vehicle;
    boolean[][] cellAllocated;
    
    // minMax Values:
    float totalCostMIN, totalCostMAX;
    float deliveryCostMIN, deliveryCostMAX;
    float allocationMIN, allocationMAX;
    float vehicleMIN, vehicleMAX;
    
    // Runs once when initializes
    void initOutputData() {
      totalCost = new float[gridU][gridV];
      deliveryCost = new float[gridU][gridV];
      allocation = new int[gridU][gridV];
      cellAllocated = new boolean[gridU][gridV];
      vehicle = new int[gridU][gridV];
      for (int u=0; u<gridU; u++) {
        for (int v=0; v<gridV; v++) {
          totalCost[u][v] = 0;
          deliveryCost[u][v] = 0;
          allocation[u][v] = 0;
          cellAllocated[u][v] = false;
          vehicle[u][v] = 0;
        }
      }
    }
    
    void fauxOutputData() {
      fauxFloatData(totalCost, 100);
      fauxFloatData(deliveryCost, 100);
      fauxIntData(allocation, 7);
      fauxIntData(vehicle, 7);
    }
    
    void clearOutputData() {
      clearFloatData(totalCost, 0);
      clearFloatData(deliveryCost, Float.POSITIVE_INFINITY);
      clearIntData(allocation, 0);
      clearIntData(vehicle, 0);
      clearBooleanData(cellAllocated, false);
    }
    
    // Create Faux Data Set for Debugging
    void fauxIntData(int[][] data, int maxInput) {
      for (int i=0; i<data.length; i++) {
        for (int j=0; j<data[0].length; j++) {
          data[i][j] = int(random(-0.99, maxInput));
        }
      }
    }
    
    // Create Faux Data Set for Debugging
    void fauxFloatData(float[][] data, int maxInput) {
      for (int i=0; i<data.length; i++) {
        for (int j=0; j<data[0].length; j++) {
          data[i][j] = random(0, maxInput);
        }
      }
    }
    
    void clearIntData(int[][] data, int clearValue) {
      for (int i=0; i<data.length; i++) {
        for (int j=0; j<data[0].length; j++) {
          data[i][j] = clearValue;
        }
      }
    }
    
    void clearFloatData(float[][] data, float clearValue) {
      for (int i=0; i<data.length; i++) {
        for (int j=0; j<data[0].length; j++) {
          data[i][j] = clearValue;
        }
      }
    }
    
    void clearBooleanData(boolean[][] data, boolean clearValue) {
      for (int i=0; i<data.length; i++) {
        for (int j=0; j<data[0].length; j++) {
          data[i][j] = clearValue;
        }
      }
    }
    
// Method that opens a folder
String folderPath;
void folderSelected(File selection) {
  if (selection == null) { // Notifies console and closes program
    println("User did not select a folder");
    exit();
  } else { // intitates the rest of the software
    println("User selected " + selection.getAbsolutePath());
    folderPath = selection.getAbsolutePath() + "/";
    // some other startup function
  }
}
