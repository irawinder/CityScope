/**
  *  Scripts for Importing CSV Data to CityScope
  * (c) 2014 Ira Winder, jamesira.com
  *
  */

// String Array that defines which fields to parse into layers
String[] field = new String[]{"Frequency", "Resilience", "Mindshare Indicator", "Execution Potential", "Capital Invested"}; 

// Table to hold ContextLab's Innovation Cluster Data.  In the future would be preferable to link to online reference
Table pentalytics;
Table pruned; //Cleaned to only include plotable points
boolean[][] isValid; // Keeps track of whether row in table has valid, displayble data

// Holds all nodes with lat, long, and weight values
PVector[][][] coord;

int numclusters = 63; //Number of unique Cluster Categories
//    Layer 0 = All data,           ID= 0
//    Layers 1 through 63,          ID= 1 through 63

int numfields = field.length; //Number of weight types (for now Execution, MindShare, and Resilience)
int numlayers = numclusters+1;
int[] layerID = new int[numlayers];

// Initial Data layer to display
int displayindex = 0;

// Initial Field to display
int fieldindex = 0;

//Holds names of each cluster
String[] clusters = new String[numlayers];

// Counts number of data points for each layer
int[][] count = new int[numfields][numlayers];
int count_max;

// Sum of each dataset's weights
float[][] sum;

// Max weight of each field type for each data layer's heatmap
float[][] max_weight;
float[][] min_weight;

void initializeData() {
  
  // Sum of each dataset's weights
  sum = new float[numfields][numlayers];

  // Max weight of each field type for each data layer's heatmap
  max_weight = new float[numfields][numlayers];
  min_weight = new float[numfields][numlayers];
  
  // Sets Counters and Sums, etc
  for (int i=0; i<numlayers; i++) { 
    layerID[i] = i;
    for (int j=0; j<numfields; j++) {
      count[j][i] = 0;
      sum[j][i] = 0;
      max_weight[j][i] = 0;
      min_weight[j][i] = 1000000000;
    }
  }
  
  
  // Prunes pentalytics data to only datapoints with known lat, long, and weight
  
  isValid = new boolean[numfields][pentalytics.getRowCount()]; // Positions 0-3 reserved for ID, Cluster, Latitude, and Longitude
  
  pruned = new Table();
  pruned.addColumn("ID");
  pruned.addColumn("Cluster");
  pruned.addColumn("Latitude");
  pruned.addColumn("Longitude");
  for (int i=0; i<numfields; i++) {
    pruned.addColumn(field[i]);
  }
  
  clusters[0] = "All Industries"; //First Data Layers always set to display all aggregated industries
  
  for (int i=0; i<pentalytics.getRowCount(); i++) { //Cycles through each row in raw data
    
    // Populates Layer field names based off of entire dataset
    for (int j=1; j<numlayers; j++) {
      if (pentalytics.getInt(i, "ID") == layerID[j] || layerID[j] == 0) {
        if (clusters[j] == null) {
          clusters[j] = pentalytics.getString(i, "Cluster");
        }
      }
    } 
    
    // If row has valid longitude, continue checking
    if (pentalytics.getString(i, "Latitude").length() != 0 && pentalytics.getString(i, "Latitude") != null) {
      // If row is valid for at least 1 of any field, set to true
      for ( int j=0; j<numfields; j++ ) {
        isValid[j][i] = false; //initializes row validity as false
        if (pentalytics.getString(i, field[j]).length() != 0 && pentalytics.getString(i, field[j]) != null) { //Tests to see if latitude, longtide, and weight values are null.  If not, counts toward heatmap
          isValid[j][i] = true;
        }
      }
    }
    
    //If Validity is True, add row to pruned Table
    if (isValid[0][i] || isValid[1][i]) { 
      TableRow newRow = pruned.addRow();
      newRow.setInt("ID", pentalytics.getInt(i, "ID"));
      newRow.setString("Cluster", pentalytics.getString(i, "Cluster"));
      newRow.setFloat("Latitude", pentalytics.getFloat(i, "Latitude"));
      newRow.setFloat("Longitude", pentalytics.getFloat(i, "Longitude"));
      for ( int j=0; j<numfields; j++ ) {
        if (isValid[j][i]) { //Tests to see if weight value is null
          newRow.setFloat(field[j], pentalytics.getFloat(i, field[j]));
        }
      }
    }
  }
  
  count_max = pruned.getRowCount();
  
  if ( debug == true ) { 
    println("count_max = " + count_max); 
  }
  
  // Define size of Vector Arrays
  coord = new PVector[numfields][numlayers][count_max];
  
  // Sets values of vector arrays for each layer
  for (int h=0; h<numfields; h++) {
    for (int i=0; i<count_max; i++) {
      for (int j=0; j<numlayers; j++) {
        if ((pruned.getInt(i, "ID") == layerID[j] || layerID[j] == 0) && pruned.getFloat(i, field[h]) > 0) {
          coord[h][j][count[h][j]] = mercatorMap.getScreenLocation(new PVector(pruned.getFloat(i, "Latitude"), pruned.getFloat(i, "Longitude"))); //Sets x,y coordinate of node, in pixels
          coord[h][j][count[h][j]].set(coord[h][j][count[h][j]].x+random(coord_jiggle), coord[h][j][count[h][j]].y+random(coord_jiggle), pruned.getFloat(i, field[h])); //Sets weight of node
          if (coord[h][j][count[h][j]].x >=0 && coord[h][j][count[h][j]].x <=canvas_width && coord[h][j][count[h][j]].y >=0 && coord[h][j][count[h][j]].x <=canvas_height) { //Checks to see if value is on canvas
            sum[h][j] += pruned.getFloat(i, field[h]); // Calculates total Resilience of ALL Nodes
            if (max_weight[h][j] < pruned.getFloat(i, field[h])) {
              max_weight[h][j] = pruned.getFloat(i, field[h]);
            }
            if (min_weight[h][j] > pruned.getFloat(i, field[h])) {
              min_weight[h][j] = pruned.getFloat(i, field[h]);
            }
          }
          count[h][j]++;
        }
      }
    }
  }

  if (debug == true) {
    for (int i=0; i<numlayers; i++) {
      println("clusters[" + i + "] = " + clusters[i]);
    }
    for (int j=0; j<numfields; j++) {
      for (int i=0; i<numlayers; i++) {
        println("count[" + j + "][" + i + "] = " + count[j][i]);
      }
    }
    saveTable(pruned, "pruned.csv");
  }
}
