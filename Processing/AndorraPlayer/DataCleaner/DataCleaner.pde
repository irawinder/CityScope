Table sampleOutput;
Table localTowers;

// Objects for converting Latitude-Longitude to Canvas Coordinates
   
    // corner locations for topographic model (latitude and longitude)
    PVector UpperLeft = new PVector(42.505086, 1.509961);
    PVector UpperRight = new PVector(42.517066, 1.544024);
    PVector LowerRight = new PVector(42.508161, 1.549798);
    PVector LowerLeft = new PVector(42.496164, 1.515728);
    
    //Amount of degrees rectangular canvas is rotated from horizontal latitude axis
    float rotation = 25.5000; //degrees
    float lat1 = 42.517066; // Uppermost Latitude on canvas
    float lat2 = 42.496164; // Lowermost Latitude on canvas
    float lon1 = 1.509961; // Leftmost Longitude on canvas
    float lon2 = 1.549798; // Rightmost Longitude on canvas

void setup() {
  size(100, 100);
  localTowers();
}

void draw() {
  
}

// This script searches a large data set of points and creates a 
// table of the locations specified within the specified boundaries
// eliminating repeats
void localTowers() {
  
  sampleOutput = loadTable("data/outputUpdate.csv", "header");
  localTowers = new Table();
  localTowers.addColumn("Lat");
  localTowers.addColumn("Lon");
  
  for (int i=sampleOutput.getRowCount()-1; i >= 0; i--) {
    if (sampleOutput.getFloat(i, "origin lat") < lat2 || sampleOutput.getFloat(i, "origin lat") > lat1 ||
        sampleOutput.getFloat(i, "origin lon") < lon1 || sampleOutput.getFloat(i, "origin lon") > lon2) {
      sampleOutput.removeRow(i);
    }
  }
  
  boolean matchFound;
  
  for (int i=0; i<sampleOutput.getRowCount(); i++) {
    
    matchFound = false;
    
    for (int j=0; j<localTowers.getRowCount(); j++) {
      if (sampleOutput.getFloat(i, "origin lat") == localTowers.getFloat(j, "Lat") 
      &&  sampleOutput.getFloat(i, "origin lon") == localTowers.getFloat(j, "Lon")) {
        matchFound = true;
        break;
      }
    }
    
    if (!matchFound) {
      println("Tower Added! " + i);
      localTowers.addRow();
      localTowers.setFloat(localTowers.getRowCount()-1, "Lat", sampleOutput.getFloat(i, "origin lat"));
      localTowers.setFloat(localTowers.getRowCount()-1, "Lon", sampleOutput.getFloat(i, "origin lon"));
    }
  }
  
  println(sampleOutput.getRowCount());
  println(localTowers.getRowCount());
  saveTable(localTowers, "localTowers.tsv");
}

