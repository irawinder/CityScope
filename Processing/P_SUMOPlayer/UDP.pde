/*
 * Incoming Port: 6667
 * "Legotizer" Outgoing Port: 6152
 */

int[] IDArray;

import hypermedia.net.*;
UDP udp;  // define the UDP object

boolean busyImporting = false;
boolean viaUDP = true;

void initUDP() {
  
  if (viaUDP) {
    // Set up port to receive UDP messages
    udp = new UDP( this, 6667 );
    //udp.log( true );     // <-- printout the connection activity
    udp.listen( true );
  }
}

// method executes whenever UDP packet is received
void receive( byte[] data, String ip, int port ) {  // <-- extended handler
  
  // get the "real" message =
  String message = new String( data ); 
  // splits string into rows 
  String[] split = split(message, "\n");

  if (!busyImporting) {
    busyImporting = true;
    ImportData(split);
  }
}

void ImportData(String inputStr[]) {
  
  for (int i=0 ; i<inputStr.length;i++) {

    String tempS = inputStr[i];
    String[] split = split(tempS, "\t");
    
    if(split.length == 1) {
      println("Player recieved '" + split[0] + "' from P_SUMOController");
      sendCommand("receipt", 6152);
    }
    
    if(split.length == 2) {
      //println(split[0] + ", " + split[1]);
      IDArray[int(split[0])] = int(split[1]);
    }
    
  }
  
  busyImporting = false;
}

void sendCommand(String command, int port) {
  
  if (viaUDP) {
    String dataToSend = "";
    
    dataToSend += command;
    
    //udp.send( dataToSend, "18.85.55.241", port );
    udp.send( dataToSend, "localhost", port );
  }
  
}


