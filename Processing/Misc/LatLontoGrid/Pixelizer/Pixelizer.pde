/* Pixelizer is a script that transforms a cloud of weighted latitude-longitude points 
 * into a discrete, pixelized aggregation data set.  Input is a TSV file
 * of weighted lat-lon and output is a JSON.
 *
 *      ---------------> + U-Axis 
 *     |
 *     |
 *     |
 *     |
 *     |
 *     |
 *   + V-Axis
 * 
 * Ira Winder (jiw@mit.edu)
 * Mike Winder (mhwinder@gmail.com)
 * Write Date: January, 2015
 * 
 */

// Library needed for ComponentAdapter()
import java.awt.event.*;

// 0 = Denver
// 1 = San Jose
int modeIndex = 0;

// Set this to false if you know that you don't need to regenerate data every time Software is run
boolean pixelizeData = true;

// Set this to true to display the main menu upon start
boolean showMainMenu = true;
boolean showFrameRate = false;

// Display Matrix Size (cells rendered to screen)
int displayV = 22*4; // Height of Lego Table
int displayU = 18*4; // Width of Lego Table
int gridPanV, gridPanU; // Integers that describe how much to offset grid pixels when drawing

int scaler, gridU, gridV;
void setGridParameters() {
  scaler = int(maxGridSize/gridSize);
  // Total Matrix Size (includes cells beyond extents of screen)
  gridV = displayV*scaler; // Height of Lego Table
  gridU = displayU*scaler; // Width of Lego Table
  // Integers that describe how much to offset grid pixels when drawing
  gridPanV = (gridV-displayV)/2;
  gridPanU = (gridU-displayU)/2;
}

// How big your applet window is, in pixels
int canvasWidth = 800;
int canvasHeight = int(canvasWidth * float(displayV)/displayU);

//Global Text and Background Color
int textColor = 255;
int background = 0;
String align = "RIGHT";

// Class that holds a button menu
Menu mainMenu, hideMenu;

void setup() {
  size(canvasWidth, canvasHeight);
  
  // Window may be resized after initialized
  frame.setResizable(true);
  
  // Recalculates relative positions of canvas items if screen is resized
  frame.addComponentListener(new ComponentAdapter() { 
     public void componentResized(ComponentEvent e) { 
       if(e.getSource()==frame) { 
         loadMenu(width, height);
       } 
     } 
   }
   );
  
  setGridParameters();
  initDataGraphics();
  
  // Reads point data from TSV file, converts to JSON, prints to JSON, and reads in from JSON
  loadData(gridU, gridV, modeIndex);
  reRender();
  
  // Loads and formats menu items
  loadMenu(canvasWidth, canvasHeight);
}

void loadData(int gridU, int gridV, int index) {
  // determines which dataset to Load
  switch(index) {
    case 0:
      denverMode();
      break;
    case 1:
      sanjoseMode();
      break;
  }
  
  // Processes lat-long data and saves to aggregated JSON grid
  if (pixelizeData) {
    pixelizeData(this.gridU, this.gridV);
  }
  
  // Loads pixel data into heatmap
  loadPixelData();
  
  // Loads Basemap file
  loadBasemap();
}

void loadMenu(int canvasWidth, int canvasHeight) {
  // Initializes Menu Items (canvas width, canvas height, button width[pix], button height[pix], 
  // number of buttons to offset downward, String[] names of buttons)
  hideMenu = new Menu(canvasWidth, canvasHeight, 170, 20, 0, hide, align);
  mainMenu = new Menu(canvasWidth, canvasHeight, 170, 20, 2, menuOrder, align);
  // Selects one of the mutually exclusive heatmps
  depressHeatmapButtons();
  // Selects one of the mutually exclusive pixel scales
  depressZoomButtons(gridSize);
  // Checks whether these true/false button should be pressed
  pressButton(showBasemap, getButtonIndex(buttonNames[14]));
  pressButton(showFrameRate, getButtonIndex(buttonNames[15]));
}

void draw() {
  
  background(background);
  
  // Draws a Google Satellite Image
  renderBasemap();
  
  image(h, 0, 0, width, height);
  
  if (showStores) {
    image(s, 0, 0, width, height);
  }
  
  image(l, 0, 0, width, height);
  
  image(i, 0, 0, width, height);
  
  // Draws Menu
  hideMenu.draw();
  if (showMainMenu) {
    mainMenu.draw();
  }
  
  if (showFrameRate) {
    text("FrameRate: " + frameRate, 10, 15);
  }
  
}
  
