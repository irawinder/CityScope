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
  //localTowers();
  
  OD_Data("20140602");
  OD_Data("20140815");
  OD_Data("20141102");
  OD_Data("20141109");
  OD_Data("20141225");
//  OD_Data("mtb");
//  OD_Data("outputCirq");
//  OD_Data("volta");
}

void draw() {
  
}

Table inputOD, network, outputOD;
ArrayList<String> dates;
// This script searchs an array of origin-destination data and outputs two files:
// (1) A "Network File" With all of the unique edges identified in the data set
// (2) An optimized OD-matrix that describes the state of the OD-Network at various times.
//
// The input data is in the following format with the following columns: 
//  1. Date 
//    {2014-06-02, 2014-08-15, 2014-11-09, 2014-12-25}
//  2. Hour of the day
//    [0,23]
//  3. Nationality
//    [French, Spanish and other]
//  3. Latitude of the origin
//  4. Longitude of the origin 
//  5. Index of the container of the origin. 
//  6, Latitude of the destination. 
//  7. Longitude of the destination. 
//  8. Index of the container of the destination. 
//  9. Amount of travelers traveling from origin i to destination j. 
//
// ** INPUT FILE SHOULD BE PRESORTED BY DATE, THEN HOUR
// ** IF Multiple dates are included in OD data, make sure each date is consecutive and includes an entire 24-hour period
void OD_Data(String date) {
  
  inputOD = loadTable("data/CDR_" + date + ".csv", "header");
  //inputOD = loadTable("data/CDR.csv", "header");
  dates = new ArrayList<String>();
  
  network = new Table();
  network.addColumn("EDGE_ID");
  network.addColumn("LAT_D"); // Destination Latitude
  network.addColumn("LON_D"); // Destination Longitude
  network.addColumn("CON_D"); // Destination Container
  network.addColumn("LAT_O"); // Origin Latitude
  network.addColumn("LON_O"); // Origin Latitude
  network.addColumn("CON_O"); // Origin Latitude
  network.addColumn("NATION");// Nationality of Edge
  
  outputOD = new Table();
  outputOD.addColumn("HOUR");
  outputOD.addColumn("EDGE_ID");
  outputOD.addColumn("AMOUNT");
  
  int numRows = inputOD.getRowCount();
  int edgeCount = 0;
  int dayCount = 0;
  int edgeID = 0;
  int maxContainer = 7;
  boolean firstRow = true;
  
  println("Begin Processing");
  
  //Cycles through each row of an input data set
  for (int i=0; i<numRows; i++) {
    
    // Only uses a value if container ID is valid
    if (inputOD.getInt(i, "origin_container") < maxContainer && inputOD.getInt(i, "destination_container") < maxContainer) {
    
      // If first row of an input data set, prime first row of each output table
      if (firstRow) {
        
        firstRow = false;
        
        dates.add(inputOD.getString(i, "date"));
        println("new day, " + inputOD.getString(i, "date"));
        
        edgeCount++;
        TableRow edge = network.addRow();
        edge.setInt("EDGE_ID", edgeCount-1);
        edge.setFloat("LAT_D", inputOD.getFloat(i, "destination_lat"));
        edge.setFloat("LON_D", inputOD.getFloat(i, "destination_lon"));
        edge.setInt("CON_D", inputOD.getInt(i, "destination_container"));
        edge.setFloat("LAT_O", inputOD.getFloat(i, "origin_lat"));
        edge.setFloat("LON_O", inputOD.getFloat(i, "origin_lon"));
        edge.setInt("CON_O", inputOD.getInt(i, "origin_container"));
        edge.setString("NATION", inputOD.getString(i, "country"));
        edgeID = edge.getInt("EDGE_ID");
        
        TableRow output = outputOD.addRow();
        output.setInt("HOUR", inputOD.getInt(i, "hour") + 24*dayCount);
        output.setInt("EDGE_ID", edgeID);
        output.setInt("AMOUNT", inputOD.getInt(i, "amount"));
        
      } else { // This runs for all rows after first row
        
        // Checks if still on same day of data
        if ( inputOD.getString(i, "date").equals(dates.get(dayCount)) ) {
          // Do nothing
        } else {
          dayCount++;
          dates.add(inputOD.getString(i, "date"));
          println("new day, " + inputOD.getString(i, "date"));
        }
        
        boolean edgeMatch = false;
        boolean containerMatch = false;
        boolean externalOD = false;
        
        // Checks if OD info occurs outside of container zero
        if ( inputOD.getInt(i, "origin_container") != 0 || inputOD.getInt(i, "destination_container") != 0 ) {
          externalOD = true; 
        }
         
        // Cycles through the current network file
        for (int j=0; j<network.getRowCount(); j++) {
          
          // Checks if containers match and constitute an trip that crosses the boundary of container 0
          if (externalOD) {
            if ( inputOD.getInt(i, "origin_container") == network.getInt(j, "CON_O") && 
                 inputOD.getInt(i, "destination_container") == network.getInt(j, "CON_D") &&
                 inputOD.getString(i, "country").equals( network.getString(j, "NATION") ) 
                ) {
          
              containerMatch = true;
              edgeID = network.getInt(j, "EDGE_ID");
              break;
              
            }
          }
          
          // Checks if Latitude and Longitude Match as long as the trip occurs within container 0
          else {
            if ( inputOD.getFloat(i, "origin_lat") == network.getFloat(j, "LAT_O") && inputOD.getFloat(i, "origin_lon") == network.getFloat(j, "LON_O") &&
                 inputOD.getFloat(i, "destination_lat") == network.getFloat(j, "LAT_D") && inputOD.getFloat(i, "destination_lon") == network.getFloat(j, "LON_D") &&
                 inputOD.getString(i, "country").equals( network.getString(j, "NATION") )   
               ) {
                   
               edgeMatch = true;
               edgeID = network.getInt(j, "EDGE_ID");
               break;
            }
          }
        }
        
        // If Edge condition is unique within container 0, adds a new one to the network with a unique ID network 
        if (!edgeMatch && !externalOD) {
          edgeCount++;
          
          TableRow edge = network.addRow();
          edge.setInt("EDGE_ID", edgeCount-1);
          edge.setFloat("LAT_D", inputOD.getFloat(i, "destination_lat"));
          edge.setFloat("LON_D", inputOD.getFloat(i, "destination_lon"));
          edge.setInt("CON_D", inputOD.getInt(i, "destination_container"));
          edge.setFloat("LAT_O", inputOD.getFloat(i, "origin_lat"));
          edge.setFloat("LON_O", inputOD.getFloat(i, "origin_lon"));
          edge.setInt("CON_O", inputOD.getInt(i, "origin_container"));
          edge.setString("NATION", inputOD.getString(i, "country"));
          
          edgeID = edge.getInt("EDGE_ID");
        }
        
        // If Edge condition is unique within container 0, adds a new one to the network with a unique ID network 
        else if (!containerMatch && externalOD) {
          edgeCount++;
          
          TableRow edge = network.addRow();
          edge.setInt("EDGE_ID", edgeCount-1);
          edge.setFloat("LAT_D", 0);
          edge.setFloat("LON_D", 0);
          edge.setInt("CON_D", inputOD.getInt(i, "destination_container"));
          edge.setFloat("LAT_O", 0);
          edge.setFloat("LON_O", 0);
          edge.setInt("CON_O", inputOD.getInt(i, "origin_container"));
          edge.setString("NATION", inputOD.getString(i, "country"));
          
          edgeID = edge.getInt("EDGE_ID");
        }
        
        // Adds Optimized OD information to output table
        TableRow output = outputOD.addRow();
        output.setInt("HOUR", inputOD.getInt(i, "hour") + 24*dayCount); //Adds 24 hours to time of each consecutive unique date
        output.setInt("EDGE_ID", edgeID);
        output.setInt("AMOUNT", inputOD.getInt(i, "amount"));
        
      }
    } 
  }
  
  //Merges same-named ODs if OD is external to container and happens during same hour
  int n = 0;
  boolean match;
  while (n < outputOD.getRowCount()) {  
    
    numRows = outputOD.getRowCount();
    match = false;
    
    for (int j=numRows-1; j>=n; j--) {
      if ( outputOD.getInt(n, "EDGE_ID") == outputOD.getInt(j, "EDGE_ID") && 
           outputOD.getInt(n, "HOUR")    == outputOD.getInt(j, "HOUR")
          ) {
           
          outputOD.setInt(n, "AMOUNT", outputOD.getInt(n, "AMOUNT") + outputOD.getInt(j, "AMOUNT") );
          
          outputOD.removeRow(j);
          match = true;
      }
    }
    n++;
    
    if (match) {
      println("Progress: " + 100.0*float(n)/numRows + "%");
    }
  }

     
  println("#Rows in Input File: " + inputOD.getRowCount()); 
  println("#Edges in Network: " + network.getRowCount());
  println("#Rows in Output File: " + outputOD.getRowCount());
  println("#Unique Dates In File: " + dates.size());
  
  for (int i=0; i<dates.size(); i++) {
    println("Date " + (i+1) + ": " + dates.get(i));
  }
  
  saveTable(network, date + "_network.tsv");
  saveTable(outputOD, date + "_OD.tsv");
  
  println("Finished and saved!");
}


Table sampleOutput, localTowers;
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

