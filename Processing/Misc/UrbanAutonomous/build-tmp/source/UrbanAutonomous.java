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

public class UrbanAutonomous extends PApplet {

//laptop resolution 1920 x 1080
//16blocks x 16blocks
//1block = 5tiles x 5tiles
//1tile = 10pixels x  10pixels
//Simulation Window: 800 x 800pixels
//Operation Window: x pixels

//vehicle speed 20km/h 20,000m/60min 2000m/6min 333m/min 33.3m/0.1min
//1block 133.3m -> 1tile 33.3m -> 2.128km-square
//1tile/0.1min
//1 simulation sec = 0.1min -> 10sec = 1min,  600sec(10min)=60min(1h) 240min(4h)=24h
//0.1 simulation sec = 0.1min ->1min=1h 24min = 24h
//1step =0.1min , 10step 1min , 600step 1h, 14400step =24h
//start time 00:00~24:00, 0:00->0step[0.1min](currentTime), 24:00-> 14400step[0.1min](currentTime)

//View
//AllocatedDepartureDemand:pink
//unallocatedDepartureDemand:red
//AllocatedArrivalDemand:light blue
//unallocatedArrivalDemand:blue



int projectorWidth = 1920;
int projectorHeight = 1200;
int projectorOffset = 1842;

int screenWidth = 1842;
int screenHeight = 1026;

public static int displayU = 18;
public static int displayV = 22;

int IDMax = 15;

// Table Canvas Width and Height
int TABLE_IMAGE_HEIGHT = 1000;
int TABLE_IMAGE_WIDTH = 1000;

// Arrays that holds ID information of rectilinear tile arrangement.
public static int tablePieceInput[][][] = new int[displayU][displayV][2];


public static DragStatus dragStatus;
public static OperationWindow opw;
public static Status status;
public static PImage hwImg, lwImg, hrImg, lrImg, roadImg, intersectionImg, noneImg, backgroundImg, congestionImg,sideDisplayImg;
public static Tile[][] simCoordinate;
public static int vehicleColor;
public static int allocatedDepartureColor;
public static int unallocatedDepartureColor;
public static int allocatedArrivalColor;
public static int unallocatedArrivalColor;
public static int hubColor;
public static int hubVehicleColor;
public static int hubPeripheralVehicleColor;
public static int hubEffectiveLengthColor;
public static PGraphics legendPg, demandPg;
public static int brushNumber;

	// Temporary
	public static SimParam simParam;
	public static MapBlock mapBlock;
	public static BasicTile basicTile;
	public static MapBlockBrushs mapBlockBrushs;
	public static MapBlockStack mapBlockStack;
	public static Disp disp;
	public static DemandStack demandStack;
	public static VehicleStack vehicleStack;
	// public static OperationDisp operationDisp;
	public static FileControl fileControl;
	// public static Hub hubA, hubB;
	public static HubStack hubStack;
	// public static HubVehicle hubVehicle;
	public static UDPSocket udpSocket;

	PGraphics captionG,mainG;

	public void setup() {
		mainG=createGraphics(1000,1200);

		//size(screenWidth, screenHeight, P3D);

  		// Initial Projection-Mapping Canvas
  		initializeProjection2D();

  		// Allows application to receive information from Colortizer via UDP
  		initUDP();


		// SimulationWindow
		size(1000, 1000);

		// OperationWindow
		//new PFrame(1000, 0, 1900, 875);
		new PFrame(0, 0, 1842, 1026);

		// Status
		status = Status.CONFIG;
		dragStatus = DragStatus.NORMAL;

		// Load Image
		loadTileImage();
		backgroundImg = loadImage("operationWindow.jpg");
		sideDisplayImg = loadImage("sideDisplay.jpg");

		// Legend Symbol
		//vehicleColor = color(255, 128, 0, 255);
		vehicleColor = color(255, 255, 255, 255);
		allocatedDepartureColor = color(0, 128, 0, 255);
		unallocatedDepartureColor = color(0, 128, 0, 255);
		allocatedArrivalColor = color(0, 0, 255, 255);
		unallocatedArrivalColor = color(0, 0, 255, 255);
		//allocatedDepartureColor = color(0, 255, 127, 127);
		//unallocatedDepartureColor = color(0, 128, 0, 127);
		//allocatedArrivalColor = color(0, 255, 255, 127);
		//unallocatedArrivalColor = color(0, 0, 255, 127);
		hubColor = color(0, 255, 0, 200);
		hubEffectiveLengthColor = color(0, 255, 0, 64);
		hubVehicleColor = color(142, 0, 204, 200);
		hubPeripheralVehicleColor = color(200, 255, 200, 200);

		// Temporary
		simParam = new SimParam();
		udpSocket = new UDPSocket(this);

		hubStack = new HubStack(this);

		brushNumber = 0;
		basicTile = new BasicTile();
		mapBlockBrushs = new MapBlockBrushs(this, 5);
		mapBlockStack = new MapBlockStack(this);
		//disp = new Disp(this);
		disp = new Disp(mainG,this);
		demandStack = new DemandStack();
		simCoordinate = new Tile[UrbanAutonomous.simParam.maxX*5][UrbanAutonomous.simParam.maxY*5];
		vehicleStack = new VehicleStack();

		//mapBlockStack.loadRuralMap();

		mapBlockStack.updateCoordinate();// reflect change of mapblock to demand
											// generation
		mapBlockStack.mapImgCreation();// map image creation for display
		mapBlockBrushs.brushImgCreation();// brush image creation for operation
											// display
		legendSymbolImgCreation(); // create legend symbol image for operation
									// display
		demandGenerationImgCreation(); // create demand image for operation
		// display
		fileControl = new FileControl();
	}

	public void draw() {
		if(simParam.mapType==2){ //custom map
			mapBlockStack.customMapGen();
			mapBlockStack.updateCoordinate();// reflect change of mapblock to // // // demand // generation
			mapBlockStack.mapImgCreation();// map image creation for display
		}
		// Exports table Graphic to Projector
 		projector = get(0, 0, TABLE_IMAGE_WIDTH, TABLE_IMAGE_HEIGHT);

		simParam.update();

		demandStack.demandLifetimeControl();
		demandStack.demandGen(simParam.currentDemandSize, simParam.demandInterval * 10);// numberOfDemand,DemandGenerationInterval(steps)
		demandStack.demandAllocation();
		demandStack.demandHubAllocation();
		vehicleStack.allVehicleMovement();
		hubStack.hubVehicleA.move();
		hubStack.hubPeripheralVehicleA.move();
		hubStack.hubPeripheralVehicleB.move();

		// Display
		disp.show();

		//image(mainG,180,0,725,725);
		image(mainG,180,0,905,1090);
		image(sideDisplayImg,0,0,180,1000);
		//image(mainG,0,0,1000,1200);
	}

	public void loadTileImage() {
		hwImg = loadImage("hwTile.png");
		lwImg = loadImage("lwTile.png");
		hrImg = loadImage("hrTile.png");
		lrImg = loadImage("lrTile.png");
		roadImg = loadImage("roadTile.png");
		intersectionImg = loadImage("intersectionTile.png");
		noneImg = loadImage("noneTile.png");
		congestionImg = loadImage("congestion.png");
	}

	public void keyPressed() {
		switch(key) {
   		 case '`': //  "Enable Projection (`)"
   		 toggle2DProjection();
   		 break;
   		}
   	}
   	public void mousePressed() {
   		int x = (int) (mouseX / 50);
   		int y = (int) (mouseY / 50);

   		if (simParam.mapType == 2) {
   			mapBlockStack.mapBlockArray[x][y] = mapBlockBrushs.selectedBrush;
   			fileControl.customMap[UrbanAutonomous.simParam.maxX * y + x] = brushNumber;
			mapBlockStack.updateCoordinate();// reflect change of mapblock to // // // demand // generation
			mapBlockStack.mapImgCreation();// map image creation for display
		}
		// Hub Relocation
		hubRelocation();
	}

	public void hubRelocation() {
		if (dist(hubStack.hubA.x * 10, hubStack.hubA.y * 10, mouseX, mouseY) < 20) {
			dragStatus = DragStatus.HUBA;
		} else if (dist(hubStack.hubB.x * 10, hubStack.hubB.y * 10, mouseX, mouseY) < 20) {
			dragStatus = DragStatus.HUBB;
		}
	}

	public void mouseReleased() {
		if (dragStatus == DragStatus.HUBA) {
			hubStack.ax = modifyHubPoint(mouseX);
			hubStack.ay = modifyHubPoint(mouseY);
			hubStack.init();
		} else if (dragStatus == DragStatus.HUBB) {
			hubStack.bx = modifyHubPoint(mouseX);
			hubStack.by = modifyHubPoint(mouseY);
			hubStack.init();
		}
		dragStatus = DragStatus.NORMAL;
	}

	public int modifyHubPoint(int x) {
		int result = 0;
		result = x / 10 / 5 * 5 + 2;
		return result;
	}

	public void legendSymbolImgCreation() {
		int offset = 0;
		legendPg = createGraphics(20, 180);
		legendPg.beginDraw();
		legendPg.background(255);
		legendPg.stroke(255);
		legendPg.stroke(1);

		// LandUse
		legendPg.image(hwImg, offset, 0, 20, 20);
		legendPg.image(lwImg, offset, 20, 20, 20);
		legendPg.image(hrImg, offset, 40, 20, 20);
		legendPg.image(lrImg, offset, 60, 20, 20);

		legendPg.ellipseMode(CENTER);
		// allocated departure
		legendPg.fill(allocatedDepartureColor);
		legendPg.ellipse(offset + 10, 90, 10, 10);
		// unallocated departure
		legendPg.fill(unallocatedDepartureColor);
		legendPg.ellipse(offset + 10, 110, 10, 10);
		// allocated arrival
		legendPg.fill(allocatedArrivalColor);
		legendPg.ellipse(offset + 10, 130, 10, 10);
		// unallocated arrival
		legendPg.fill(unallocatedArrivalColor);
		legendPg.ellipse(offset + 10, 150, 10, 10);
		// Vehicle(fleet)
		legendPg.fill(vehicleColor);
		legendPg.ellipse(offset + 10, 170, 10, 10);
		legendPg.endDraw();
	}

	public void demandGenerationImgCreation() {
		int offset = 150;
		demandPg = createGraphics(870, 260);
		demandPg.beginDraw();
		// demandPg.background(255);
		demandPg.clear();
		demandPg.stroke(255);
		demandPg.stroke(1);
		demandPg.image(hwImg, 0, 0, 50, 50);
		demandPg.image(lwImg, 0, 70, 50, 50);
		demandPg.image(hrImg, 0, 140, 50, 50);
		demandPg.image(lrImg, 0, 210, 50, 50);

		for (int i = 0; i < 720; i++) {
			demandPg.line(offset + i, 20 - (basicTile.hwTile.departureProbabilityArray[i / 30] * 100 / 5), offset + i,
				20);
			demandPg.line(offset + i, 50 - (basicTile.hwTile.arrivalProbabilityArray[i / 30] * 100 / 5), offset + i,
				50);
			demandPg.line(offset + i, 90 - (basicTile.lwTile.departureProbabilityArray[i / 30] * 100 / 5), offset + i,
				90);
			demandPg.line(offset + i, 120 - (basicTile.lwTile.arrivalProbabilityArray[i / 30] * 100 / 5), offset + i,
				120);
			demandPg.line(offset + i, 160 - (basicTile.hrTile.departureProbabilityArray[i / 30] * 100 / 5), offset + i,
				160);
			demandPg.line(offset + i, 190 - (basicTile.hrTile.arrivalProbabilityArray[i / 30] * 100 / 5), offset + i,
				190);
			demandPg.line(offset + i, 230 - (basicTile.lrTile.departureProbabilityArray[i / 30] * 100 / 5), offset + i,
				230);
			demandPg.line(offset + i, 260 - (basicTile.lrTile.arrivalProbabilityArray[i / 30] * 100 / 5), offset + i,
				260);
		}
		demandPg.endDraw();
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
PFrameI proj2D = null; // f defines window to open new applet in
projApplet applet; // applet acts as new set of setup() and draw() functions that operate in parallel

// Run Anything Needed to have Projection mapping work
public void initializeProjection2D() {
  println("Projector Info: " + projectorWidth + ", " + projectorHeight + ", " + projectorOffset);
  //toggleProjection(getButtonIndex(buttonNames[21]));
}

public class PFrameI extends JFrame {
  public PFrameI() {
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
    proj2D = new PFrameI();
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
    proj2D = new PFrameI();
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
    String[] appletArgs = new String[] { "UrbanAutonomous" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
