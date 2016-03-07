// Principally, this script ensures that a string is "caught" via UDP and coded into principal inputs of:
// - codeArray[][] or codeArray[][][2] (rotation)
// - UMax, VMax

//
// Incoming Port: 6152
// "Colortizer" Ougoing Port:  6669
// "NodeSimulator" Outgoing Port: 6667
//


import hypermedia.net.*;
UDP udp;  // define the UDP object

boolean busyImporting = false;
boolean viaUDP = true;
boolean pingCloud = false;

// boolean for detecting "handshake" from simulation app
boolean receipt = true;

// set to true when external sim app notifies Legotizer that its data is ready
boolean readSolution = false;

void initUDP() {
  
  if (viaUDP) {
    udp = new UDP( this, 6152 );
    //udp.log( true );     // <-- printout the connection activity
    udp.listen( true );
  }
}

void ImportData(String inputStr[]) {
  parseCodeStrings(inputStr);
  busyImporting = false;
}

void parseCodeStrings(String data[]) {
  
  for (int i=0 ; i<data.length;i++) {
    
    String[] split = split(data[i], "\t");
    
    if(split.length == 1) {
      if (split[0].equals("receipt")) {
        //println("'" + split[0] + "' received by Legotizer");
        //loadSolutionJSON(solutionJSON, "solutionNodes.json", vizMode);
        receipt = true;
        readSolution = true;
      } else if (split[0].equals("")) {
  
      } else {
        // println("'" + split[0] + "' received by Legotizer");
        // heatMapName = split[0];      
      }
    }

//    As of Jan 2016 Colortizer no longer exports UMax and VMax
//    // Checks if row formatted for UMax and VMax
//    if (split.length == 2 && dimensionOverRide) {
//      UMax = int(split[1]);
//      VMax = int(split[0]);
//      updateBoard();
//    }

    // If row has two elements identifying the gridIndex being used in Colortizer (usually reports 0)
    if (split.length == 2 && split[0].equals("gridIndex")) {
      // When first running, Table siteOffsets not always loaded, creating a crash...
      try {
        siteOffsetU = siteOffsets.getInt(int(split[1]), 0);
        siteOffsetV = siteOffsets.getInt(int(split[1]), 1);
      } catch(RuntimeException e){
        siteOffsetU = 0;
        siteOffsetV = 0;
        println("Caught at 'void pareseCodeStrings()' in 'if (split.length == 2 ...)'");
      }
      //println("Site Offset for Grid " + split[1] + ": " + siteOffsetU + ", " + siteOffsetV);
    }
    
    // Checks if row format is compatible with piece recognition.  3 columns for ID, U, V; 4 columns for ID, U, V, rotation
    if (split.length == 3 || split.length == 4) { 
      
      //Finds UV values of Lego Grid:
      int u_temp = int(split[1]) + siteOffsetU;
      int v_temp = int(split[2]) + siteOffsetV;
      
      if (split.length == 3) { // If 3 columns
          
        // detects if different from previous value
        if ( v_temp < codeArray.length && u_temp < codeArray[0].length ) {
          if ( codeArray[v_temp][u_temp][0] != int(split[0]) ) {
            // Sets ID
            codeArray[v_temp][u_temp][0] = int(split[0]);
            
            //sendCommand(inputStr[i], 6667);
            
            changeDetected = true;
            simCounter = simTime;
          }
        }
        
      } else if (split.length == 4) {   // If 4 columns
        
        // detects if different from previous value
        if ( v_temp < codeArray.length && u_temp < codeArray[0].length ) {
          if ( codeArray[v_temp][u_temp][0] != int(split[0]) || codeArray[v_temp][u_temp][1] != int(split[3])/90 ) {
            // Sets ID
            codeArray[v_temp][u_temp][0] = int(split[0]); 
            
            //Identifies rotation vector of piece [WARNING: Colortizer supplies rotation in degrees (0, 90, 180, and 270)]
            codeArray[v_temp][u_temp][1] = int(split[3])/90; 
            
            //sendCommand(inputStr[i], 6667);
            
            changeDetected = true;
            simCounter = simTime;
          }
        }
      }
      
    } 
  }
}

void receive( byte[] data, String ip, int port ) {  // <-- extended handler
  
  // get the "real" message =
  String message = new String( data ); 
  //println(message);
  //saveStrings("data.txt", split(message, "\n"));
  String[] split = split(message, "\n");
  
  if (!busyImporting) {
    //println("import!");
    busyImporting = true;
    ImportData(split);
  }
  
}

void sendCommand(String command, int port) {
  
  if (viaUDP) {
    String dataToSend = "";
    
    dataToSend += command;
    
    //udp.send( dataToSend, "18.85.55.241", port );
    udp.send( dataToSend, "localhost", port );
  }
  
}

void pingCloud(String message, String ip, int port) {
  udp.send(message, ip, port);
} 

