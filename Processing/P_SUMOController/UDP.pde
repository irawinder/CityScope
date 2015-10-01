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

int UMax, VMax;

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
    
    // Checks if row formatted for UMax and VMax
    if (split.length == 2) {
      UMax = int(split[1]);
      VMax = int(split[0]);
    }
    
    // Checks if row format is compatible with piece recognition.  3 columns for ID, U, V; 4 columns for ID, U, V, rotation
    if (split.length == 3 || split.length == 4) { 
      
      //Finds UV values of Lego Grid:
      
      if (split.length == 3) { // If 3 columns
        
        // detects if different from previous value
        if ( codeArray[int(split[2])][int(split[1])][0] != int(split[0]) ) {
          
          // Sets ID
          codeArray[int(split[2])][int(split[1])][0] = int(split[0]);
          
          changeDetected = true;
        }
        
      } else if (split.length == 4) {   // If 4 columns
        
        // detects if different from previous value
        if ( codeArray[int(split[2])][int(split[1])][0] != int(split[0]) || codeArray[int(split[2])][int(split[1])][1] != int(split[3])/90 ) {
          
          // Sets ID
          codeArray[int(split[2])][int(split[1])][0] = int(split[0]); 
          
          //Identifies rotation vector of piece [WARNING: Colortizer supplies rotation in degrees (0, 90, 180, and 270)]
          codeArray[int(split[2])][int(split[1])][1] = int(split[3])/90; 
          
          changeDetected = true;
          
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

