import java.io.*;
import java.net.*;
import java.util.*;

SingleSocketServer myServer;
boolean server = false;
boolean render = false;

void setup() {
  size(200, 200);
  background(0);
  textAlign(CENTER);
  text("EchoServer is OFF", width/2, height/2);
  text("Press 'c' to activate", width/2, height/2+15);
}

void draw() {
  if (render) {
    background(#00FF00);
    fill(0);
    text("EchoServer is ON", width/2, height/2);
    render = false;
    server = true;
  } else if (server) {
    myServer = new SingleSocketServer();
  }
}

void keyPressed() {
  switch(key) {
    case 'c':
      render = true;
      break;
  }
}

public class SingleSocketServer {

 ServerSocket socket1;
 protected final static int port = 19999;
 Socket connection;

 boolean first;
 StringBuffer process;
 String TimeStamp;
 
 SingleSocketServer() {
    try{
      socket1 = new ServerSocket(port);
      System.out.println("SingleSocketServer Initialized");
      int character;
      
      while (true) {
        connection = socket1.accept();

        BufferedInputStream is = new BufferedInputStream(connection.getInputStream());
        InputStreamReader isr = new InputStreamReader(is);
        process = new StringBuffer();
        while((character = isr.read()) != 13) {
          process.append((char)character);
        }
        System.out.println(process);
        //need to wait 1/2 second for the app to update database
        //for demo purpose only
        try {
          Thread.sleep(500);
        }
        catch (Exception e){}
        TimeStamp = new java.util.Date().toString();
        String returnCode = "SingleSocketServer repsonded at "+ TimeStamp + (char) 13;
        BufferedOutputStream os = new BufferedOutputStream(connection.getOutputStream());
        OutputStreamWriter osw = new OutputStreamWriter(os, "US-ASCII");
        osw.write(returnCode);
        osw.flush();
     }
    }
    catch (IOException e) {}
      try {
        connection.close();
      }
      catch (IOException e) {}
  }
}
