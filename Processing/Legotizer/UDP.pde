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
  
  for (int i=0 ; i<inputStr.length;i++) {

    String tempS = inputStr[i];
    String[] split = split(tempS, "\t");
    
    if(split.length == 1) {
      if (split[0].equals("receipt")) {
        println("'" + split[0] + "' received by Legotizer");
        //loadSolutionJSON(solutionJSON, "solutionNodes.json", vizMode);
        receipt = true;
        readSolution = true;
      } else if (split[0].equals("")) {

      } else {
        // println("'" + split[0] + "' received by Legotizer");
        // heatMapName = split[0];      
      }
    }
    
    // Checks if row formatted for UMax and VMax
    if (split.length == 2) {
      UMax = int(split[1]);
      VMax = int(split[0]);
      updateBoard();
    }
    
    // Checks if row format is compatible with piece recognition.  3 columns for ID, U, V; 4 columns for ID, U, V, rotation
    if (split.length == 3 || split.length == 4) { 
      
      //Finds UV values of Lego Grid:
      
      if (split.length == 3) { // If 3 columns
        
        // detects if different from previous value
        if ( codeArray[int(split[2])][int(split[1])][0] != int(split[0]) ) {
          // Sets ID
          codeArray[int(split[2])][int(split[1])][0] = int(split[0]);
          
          //sendCommand(inputStr[i], 6667);
          
          changeDetected = true;
          simCounter = simTime;
        }
        
      } else if (split.length == 4) {   // If 4 columns
        
        // detects if different from previous value
        if ( codeArray[int(split[2])][int(split[1])][0] != int(split[0]) || codeArray[int(split[2])][int(split[1])][1] != int(split[3])/90 ) {
          // Sets ID
          codeArray[int(split[2])][int(split[1])][0] = int(split[0]); 
          
          //Identifies rotation vector of piece [WARNING: Colortizer supplies rotation in degrees (0, 90, 180, and 270)]
          codeArray[int(split[2])][int(split[1])][1] = int(split[3])/90; 
          changeDetected = true;
          simCounter = simTime;
        }

      }
    } 
  }

  
  busyImporting = false;
}

void receive( byte[] data, String ip, int port ) {  // <-- extended handler
  
  // get the "real" message =
  String message = new String( data ); 
  //println(message);
  saveStrings("data.txt", split(message, "\n"));
  String[] split = split(message, "\n");

  if (!busyImporting) {
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

