// Principally, this script ensures that a string is "caught" via UDP and coded into principal inputs of:
// - tablePieceInput[][] or tablePieceInput[][][2] (rotation)
// - UMax, VMax


int portIN = 6152;

import hypermedia.net.*;
UDP udp;  // define the UDP object

boolean busyImporting = false;
boolean viaUDP = true;
boolean changeDetected = false;
boolean outputReady = false;

void initUDP() {
  if (viaUDP) {
    udp = new UDP( this, portIN );
    //udp.log( true );     // <-- printout the connection activity
    udp.listen( true );
  }
}

void ImportData(String inputStr[]) {
  if (inputStr[0].equals("COLORTIZER")) {
    parseColortizerStrings(inputStr);
  }
  busyImporting = false;
}

void parseColortizerStrings(String data[]) {
  
  for (int i=0 ; i<data.length;i++) {
    
    String[] split = split(data[i], "\t");
    
    // Checks maximum possible ID value
    if (split.length == 2 && split[0].equals("IDMax")) {
      IDMax = int(split[1]);
    }
    
    // Checks if row format is compatible with piece recognition.  3 columns for ID, U, V; 4 columns for ID, U, V, rotation
    if (split.length == 3 || split.length == 4) { 
      
      //Finds UV values of Lego Grid:
      int u_temp = int(split[1]);
      int v_temp = tablePieceInput.length - int(split[2]) - 1;
      
      if (split.length == 3 && !split[0].equals("gridExtents")) { // If 3 columns
          
        // detects if different from previous value
        if ( v_temp < tablePieceInput.length && u_temp < tablePieceInput[0].length ) {
          if ( tablePieceInput[v_temp][u_temp][0] != int(split[0]) ) {
            // Sets ID
            tablePieceInput[v_temp][u_temp][0] = int(split[0]);
            changeDetected = true;
          }
        }
        
      } else if (split.length == 4) {   // If 4 columns
        
        // detects if different from previous value
        if ( v_temp < tablePieceInput.length && u_temp < tablePieceInput[0].length ) {
          if ( tablePieceInput[v_temp][u_temp][0] != int(split[0]) || tablePieceInput[v_temp][u_temp][1] != int(split[3])/90 ) {
            // Sets ID
            tablePieceInput[v_temp][u_temp][0] = int(split[0]); 
            //Identifies rotation vector of piece [WARNING: Colortizer supplies rotation in degrees (0, 90, 180, and 270)]
            tablePieceInput[v_temp][u_temp][1] = int(split[3])/90; 
            changeDetected = true;
          }
        }
      }
    } 
  }
}

void receive( byte[] data, String ip, int port ) {  // <-- extended handler
  // get the "real" message =
  String message = new String( data );
  //println("catch!"); 
  //println(message);
  //saveStrings("data.txt", split(message, "\n"));
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
    udp.send( dataToSend, "localhost", port );
  }
}

