import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import javax.swing.JFrame; 
import deadpixel.keystone.*; 
import hypermedia.net.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Barebones extends PApplet {

int projectorWidth = 1920;
int projectorHeight = 1200;
int projectorOffset = 1842;

int screenWidth = 1842;
int screenHeight = 1026;

int displayU = 18;
int displayV = 22;

int IDMax = 15;

// Table Canvas Width and Height
int TABLE_IMAGE_HEIGHT = 1000;
int TABLE_IMAGE_WIDTH = 1000;

// Arrays that holds ID information of rectilinear tile arrangement.
int tablePieceInput[][][] = new int[displayU][displayV][2];

public void setup() {
  size(screenWidth, screenHeight, P3D);
  
  // Initial Projection-Mapping Canvas
  initializeProjection2D();
  
  // Allows application to receive information from Colortizer via UDP
  initUDP();
      
}

public void draw() {
  
  background(255);
  fill(0xffFF0000);
  rect(0,0,350, 350);
  
// Exports table Graphic to Projector
  projector = get(0, 0, TABLE_IMAGE_WIDTH, TABLE_IMAGE_HEIGHT);
  
}


public void keyPressed() {
  switch(key) {
    
    case '`': //  "Enable Projection (`)"
      toggle2DProjection();
      break;
  }
}
//
// This is a script that allows one to open a new canvas for the purpose 
// of simple 2D projection mapping, such as on a flat table surface
//
// Right now, only appears to work in windows...
//
// To use this example in the real world, you need a projector
// and a surface you want to project your Processing sketch onto.
//
// Simply press the 'c' key and drag the corners of the 
// CornerPinSurface so that they
// match the physical surface's corners. The result will be an
// undistorted projection, regardless of projector position or 
// orientation.
//
// You can also create more than one Surface object, and project
// onto multiple flat surfaces using a single projector.
//
// This extra flexbility can comes at the sacrifice of more or 
// less pixel resolution, depending on your projector and how
// many surfaces you want to map. 
//




// Visualization may show 2D projection visualization, or not
boolean displayProjection2D = false;
//int projectorOffset = screenWidth;

boolean testProjectorOnMac = false;

// defines Keystone settings from xml file in parent folder
Keystone ks;

// defines various drawing surfaces, all pre-calibrated, to project
CornerPinSurface surface;
PGraphics offscreen;
PImage projector;

// New Application Window Parameters
PFrame proj2D = null; // f defines window to open new applet in
projApplet applet; // applet acts as new set of setup() and draw() functions that operate in parallel

// Run Anything Needed to have Projection mapping work
public void initializeProjection2D() {
  println("Projector Info: " + projectorWidth + ", " + projectorHeight + ", " + projectorOffset);
  //toggleProjection(getButtonIndex(buttonNames[21]));
}

public class PFrame extends JFrame {
  public PFrame() {
    setBounds(0, 0, projectorWidth, projectorHeight );
    setLocation(projectorOffset, 0);
    applet = new projApplet();
    setResizable(false);
    setUndecorated(true); 
    setAlwaysOnTop(true);
    add(applet);
    applet.init();
    show();
    setTitle("Projection2D");
  }
}

public void showProjection2D() {
  if (proj2D == null) {
    proj2D = new PFrame();
  }
  proj2D.setVisible(true);
}

public void closeProjection2D() {
  proj2D.setVisible(false);
}

public void resetProjection2D() {
  initializeProjection2D();
  if (proj2D != null) {
    proj2D.dispose();
    proj2D = new PFrame();
    if (displayProjection2D) {
      showProjection2D();
    } else {
      closeProjection2D();
    }
  }
}

public class projApplet extends PApplet {
  public void setup() {
    // Keystone will only work with P3D or OPENGL renderers, 
    // since it relies on texture mapping to deform
    size(projectorWidth, projectorHeight, P2D);
    
    ks = new Keystone(this);;
    
    reset();
  }
  
  public void reset() {
    surface = ks.createCornerPinSurface(TABLE_IMAGE_HEIGHT, TABLE_IMAGE_HEIGHT, 20);
    offscreen = createGraphics(TABLE_IMAGE_HEIGHT, TABLE_IMAGE_HEIGHT);
    
    try{
      ks.load();
    } catch(RuntimeException e){
      println("No Keystone.xml.  Save one first if you want to load one.");
    }
  }
  
  public void draw() {
    
    // Convert the mouse coordinate into surface coordinates
    // this will allow you to use mouse events inside the 
    // surface from your screen. 
    PVector surfaceMouse = surface.getTransformedMouse();
    
    // most likely, you'll want a black background to minimize
    // bleeding around your projection area
    background(0);
    
    // Draw the scene, offscreen
    renderCanvas(offscreen, 0);
    surface.render(offscreen);
  
  }
  
  public void renderCanvas(PGraphics p, int x_offset) {
    // Draw the scene, offscreen
    p.beginDraw();
    p.clear();
    p.translate(x_offset, 0);
    p.image(projector, 0, 0);
    p.endDraw();
  }
  
  public void keyPressed() {
    switch(key) {
      case 'c':
        // enter/leave calibration mode, where surfaces can be warped 
        // and moved
        ks.toggleCalibration();
        break;
  
      case 'l':
        // loads the saved layout
        ks.load();
        break;
  
      case 's':
        // saves the layout
        ks.save();
        break;
      
      case '`': 
        if (displayProjection2D) {
          displayProjection2D = false;
          closeProjection2D();
        } else {
          displayProjection2D = true;
          showProjection2D();
        }
        break;
    }
  }
}

public void toggle2DProjection() {
  if (System.getProperty("os.name").substring(0,3).equals("Mac")) {
    testProjectorOnMac = !testProjectorOnMac;
    println("Test on Mac = " + testProjectorOnMac);
    println("Projection Mapping Currently not Supported for MacOS");
  } else {
    if (displayProjection2D) {
      displayProjection2D = false;
      closeProjection2D();
    } else {
      displayProjection2D = true;
      showProjection2D();
    }
  }
}


// Principally, this script ensures that a string is "caught" via UDP and coded into principal inputs of:
// - tablePieceInput[][] or tablePieceInput[][][2] (rotation)
// - UMax, VMax


int portIN = 6152;


UDP udp;  // define the UDP object

boolean busyImporting = false;
boolean viaUDP = true;
boolean changeDetected = false;
boolean outputReady = false;

public void initUDP() {
  if (viaUDP) {
    udp = new UDP( this, portIN );
    //udp.log( true );     // <-- printout the connection activity
    udp.listen( true );
  }
}

public void ImportData(String inputStr[]) {
  if (inputStr[0].equals("COLORTIZER")) {
    parseColortizerStrings(inputStr);
  }
  busyImporting = false;
}

public void parseColortizerStrings(String data[]) {
  
  for (int i=0 ; i<data.length;i++) {
    
    String[] split = split(data[i], "\t");
    
    // Checks maximum possible ID value
    if (split.length == 2 && split[0].equals("IDMax")) {
      IDMax = PApplet.parseInt(split[1]);
    }
    
    // Checks if row format is compatible with piece recognition.  3 columns for ID, U, V; 4 columns for ID, U, V, rotation
    if (split.length == 3 || split.length == 4) { 
      
      //Finds UV values of Lego Grid:
      int u_temp = PApplet.parseInt(split[1]);
      int v_temp = tablePieceInput.length - PApplet.parseInt(split[2]) - 1;
      
      if (split.length == 3 && !split[0].equals("gridExtents")) { // If 3 columns
          
        // detects if different from previous value
        if ( v_temp < tablePieceInput.length && u_temp < tablePieceInput[0].length ) {
          if ( tablePieceInput[v_temp][u_temp][0] != PApplet.parseInt(split[0]) ) {
            // Sets ID
            tablePieceInput[v_temp][u_temp][0] = PApplet.parseInt(split[0]);
            changeDetected = true;
          }
        }
        
      } else if (split.length == 4) {   // If 4 columns
        
        // detects if different from previous value
        if ( v_temp < tablePieceInput.length && u_temp < tablePieceInput[0].length ) {
          if ( tablePieceInput[v_temp][u_temp][0] != PApplet.parseInt(split[0]) || tablePieceInput[v_temp][u_temp][1] != PApplet.parseInt(split[3])/90 ) {
            // Sets ID
            tablePieceInput[v_temp][u_temp][0] = PApplet.parseInt(split[0]); 
            //Identifies rotation vector of piece [WARNING: Colortizer supplies rotation in degrees (0, 90, 180, and 270)]
            tablePieceInput[v_temp][u_temp][1] = PApplet.parseInt(split[3])/90; 
            changeDetected = true;
          }
        }
      }
    } 
  }
}

public void receive( byte[] data, String ip, int port ) {  // <-- extended handler
  // get the "real" message =
  String message = new String( data );
  //println("catch!"); 
  println(message);
  //saveStrings("data.txt", split(message, "\n"));
  String[] split = split(message, "\n");
  
  if (!busyImporting) {
    busyImporting = true;
    ImportData(split);
  }
}

public void sendCommand(String command, int port) {
  if (viaUDP) {
    String dataToSend = "";
    dataToSend += command;
    udp.send( dataToSend, "localhost", port );
  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Barebones" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
