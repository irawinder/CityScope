// Colortizer v3.8
// This software distorts webcam feeds into rectilinear matrices of color data.
// Run software to see key definitions
//
// By Ira Winder [jiw@mit.edu], CityScope Project, Changing Places Group, MIT Media Lab
// Produced for MIT-KACST Center for Complex Engineering Systems: CitySchema
// March, 2015

// REPORT ALL CHANGES WITH DATE AND USER IN THIS AREA:
// - March 3, 2015: Edited "scanExport" Tab to include addional column of information for rotation
// - March 3, 2015: Edited "scanGrid" Tab to have buffer condition to reduce noise of pattern reading
// - March 5, 2015: Added "gameClient" Tab to allow TCP connection to Rhino server. Also added method calls in "Colortizer" tabl and "scan" tab
// - March 6, 2015: Coded Keys '1,' '2,' '3,' '4,' and '5' to correspond with Rhino/SDL functions in "gameClient" tab
// - March 6, 2015: Coded '6' key to restart server connection to Rhino
// - March 14, 2015: Allowed functionalities in keys 1-6 to also be received via UDP (i.e. from Legotizer)
/*

SETUP:
Step 0: configure "int camera" to be associated with your camera and resolution of choice.  Use "Capture.list()" to explore cameras available in processing.
Step 1: Decide how many unique, distorted planes you need to scan.
Step 2: Decide how many uniqe grids of information needed for each plane
Step 3: Alter "int[] numGridAreas" accordingly
Step 4: Alter "scanExport" tab to relevant port on destination machine [i.e. udp.send( dataToSend, "localhost", 6152]
Step 5: Run application

APPLICATION:
- If you have trouble altering grid setting (UV dimensions, WX dimensions, etc), try altering "gridSettings.tsv" file

*/

// Position within array that describes available cameras
int camera = 0;

//Number of scan grids to be created on each warped image
// For example:
// {1,1,1,1} creates 4 scan grids, each on their own, separately programmed, distorted image
// {4} creates 4 scan grids, all sharing the same distorted image
int[] numGridAreas = {1}; // 1 grid for 1 distortion area

// Dimensions of surface being scanned
float vizRatio = float(16)/(16); //Must match measurements in reality, i.e. a table surface
int vizWidth = 400; //Resolution (in pixels)
int vizHeight = int(vizWidth/vizRatio);

void setup() {
  size(vizWidth*2+500, vizHeight*2, P2D);
  setupScan(); //Loads all Scan Objects (coordinates, reference colors, and conf>iguration) into memory with initial conditions and starts camera
  
  // Initiation of "gameClient" Tab Items
  initServer();
}

void draw() {
  background(0);
  runScan(vizWidth, vizHeight); //Updates and runs all scan objects
  //runViz();
  System.gc();
  
  
}
