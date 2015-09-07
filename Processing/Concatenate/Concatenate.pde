/*
Version - V0.1

// By Karthik Patanjali [pkn@mit.edu], CityScope Project, Changing Places Group, MIT Media Lab
// Copyright September, 2015

This sketch is to be run along with multiple colortizer scripts from multiple table modules.

Instructions:
1) Make Multiple copies of colortizer folder locally for each camera feed. Name them colortizer01, colortizer02, etc and remember to change the 
   name of the colortizer.pde to match the folder name. 
2) Modify the camera array number to point to the correct camera in each of the colortizer.pde file.
3) Modify the port number in the scanExport tab of the colortizer to 6001,6002,6003 and 6004.
4) Run all the colortizer scripts simultaneously with this sketch.
5) This sketch would send the concatenated data to PORT 6152.
Note: IP Addresses would need to be modified instead of just port numbers if Colortizer scripts are run from different computers.
Incoming port: 6666
Outgoing port: 6152




*/
import hypermedia.net.*;

int PORT_RX = 6666; // receiver port
int PORT_TX = 6152; // transmitter port

int Ucorrection = 22,Vcorrection = 20;

// data holders for the data received from UDP
String data01="", data02="", data03="", data04="";
boolean newDataReceived = false;


String HOST_IP="localhost"; 
UDP udpRX, udpTX;

void setup(){
    size(800,600);
    udpRX = new UDP(this,PORT_RX,HOST_IP);
    //udpRX.log( true );     // <-- printout the connection activity
    udpRX.listen( true );
    
    udpTX = new UDP(this,PORT_TX,HOST_IP);
    udpTX.log( true ); 
}

void draw() {
//    background(0);
    fill(0,10);
    rect(0,0,width,height);
    stroke(255);
    noFill();
    rect(200,150,195,195);
    rect(400,150,195,195);
    rect(200,350,195,195);
    rect(400,350,195,195);
    fill(255);
    text("6001", 280, 250);
    text("6002", 480, 250);
    text("6003", 280, 450);
    text("6004", 480, 450);

    if (newDataReceived){
      //  Transmit data through UDP after combining the data.
      // 
      String toSend ="";
      
      if (data04.length() != 0) {
          toSend += data04;
//          toSend += "\n";
      }
      if (data03.length() != 0) {
          toSend += data03;
//          toSend += "\n";
      }
      if (data02.length() != 0) {
          toSend += data02;          
//          toSend += "\n";
      }
      if (data01.length() != 0) {
          toSend += data01;
//          toSend += "\n";
      }
      
      toSend += 2*Ucorrection+"\t"+2*Vcorrection;
      text("SENDING DATA...", 50, 50);
      saveStrings("data.txt", split(toSend, "\n"));
      udpTX.send( toSend, "localhost", 6152 );
      newDataReceived = false;
    }
}

void receive( byte[] data, String HOST_IP, int PORT_RX ) {  // <-- extended handler
  newDataReceived = true;
  // get the "real" message =
  String message = new String( data );
  processData(message, PORT_RX);
  //println(message+" from "+PORT_RX+" port.");
  }
  
void processData(String messageRX, int portRX){
  
  if (portRX == 6001){
      data01 = dataCorrect(messageRX,0,0);
      rect(200,150,195,195);
  }
  
  if (portRX == 6002){
      data02 = dataCorrect(messageRX,Ucorrection,0);
      rect(400,150,195,195); 
  }
  
  if (portRX == 6003){
      data03 = dataCorrect(messageRX,0,Vcorrection);
      rect(200,350,195,195);
  }
  
  if (portRX == 6004){
      data04 = dataCorrect(messageRX,Ucorrection,Vcorrection);
      rect(400,350,195,195);
  }  
}

// this module separates the data and corrects U and V values based on table placement)



String dataCorrect(String msg, int uCorr, int vCorr) {
  
  String[] inputStr = split(msg, "\n");
  
  String newOutput=""; //this holds the whole new string created by modification.
  
  for (int i=0 ; i<inputStr.length;i++) {

    String tempS = inputStr[i];
    String[] split = split(tempS, "\t");
    
    
    // Checks if row formatted for UMax and VMax
//    if (split.length == 2) {
//      UMax = int(split[0]);
//      VMax = int(split[1]);
//      updateBoard();
//    }
//    
    // Checks if row format has 4 columns - for ID, U, V, rotation
    if (split.length == 4) {
      
      // add the correction factor to the original u and v values.
        int newU = int(split[1]) + uCorr;
        int newV = int(split[2]) + vCorr;
          
        newOutput += split[0] + "\t" + newU + "\t" + newV + "\t" + split[3] + "\n";
   
        }

      }
      return newOutput;
    } 
 
