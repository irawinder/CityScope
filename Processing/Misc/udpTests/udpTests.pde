/**
 * (./) udp.pde - how to use UDP library as unicast connection
 * (cc) 2006, Cousot stephane for The Atelier Hypermedia
 * (->) http://hypermedia.loeil.org/processing/
 *
 * Create a communication between Processing<->Pure Data @ http://puredata.info/
 * This program also requires to run a small program on Pd to exchange data  
 * (hum!!! for a complete experimentation), you can find the related Pd patch
 * at http://hypermedia.loeil.org/processing/udp.pd
 * 
 * -- note that all Pd input/output messages are completed with the characters 
 * ";\n". Don't refer to this notation for a normal use. --
 */

// import UDP library
import hypermedia.net.*;

Table test;;
UDP udp;  // define the UDP object

/**
 * init
 */
void setup() {
  
  test = loadTable("test.csv");
  // create a new datagram connection on port 6000
  // and wait for incomming message
  udp = new UDP( this, 6000 );
  //udp.log( true ); 		// <-- printout the connection activity
  udp.listen( true );
}

//process events
void draw() {
  size (100,100);
  
  if (millis() % 1000 < 150) {
    background(255);
    sendData(test, "18.189.21.70", 5005);
  } else {
    background(0);
  }
}
  
/** 
 * on key pressed event:
 * send the current key value over the network
 */
void keyPressed() {
    
    String message  = str( key );	// the message to send
    String ip       = "18.189.21.70";	// the remote IP address
    int port        = 5005;		// the destination port
    
    // formats the message for Pd
    message = message+";\n";
    // send the message
    //udp.send( message, ip, port );
    println(message);
    
    
}

/**
 * To perform any action on datagram reception, you need to implement this 
 * handler in your code. This method will be automatically called by the UDP 
 * object each time he receive a nonnull message.
 * By default, this method have just one argument (the received message as 
 * byte[] array), but in addition, two arguments (representing in order the 
 * sender IP address and his port) can be set like below.
 */
// void receive( byte[] data ) { 			// <-- default handler
void receive( byte[] data, String ip, int port ) {	// <-- extended handler
  
  
  // get the "real" message =
  // forget the ";\n" at the end <-- !!! only for a communication with Pd !!!
  data = subset(data, 0, data.length-2);
  String message = new String( data );
  
  // print the result
  println( "receive: \""+message+"\" from "+ip+" on port "+port );
}

void sendData(Table table, String ip, int port) {
 
  String dataToSend = "";
  
  //top value
  dataToSend += table.getString(0,0);
  dataToSend += "\n" ;
  
  for (int v=1; v<table.getRowCount(); v++) {
    for (int u=0; u<table.getColumnCount(); u++) {

      // Grid Value
      dataToSend += table.getInt(v, u);
      
      if (u < table.getColumnCount() - 1) {
        dataToSend += ",";
      }
      
    }
    if (v < table.getRowCount() - 1) {
      dataToSend += "\n";
    }
  }
 
  udp.send( dataToSend, ip, port );
  saveStrings("export.csv", split(dataToSend, "\n"));
}

