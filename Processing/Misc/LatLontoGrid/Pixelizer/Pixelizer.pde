/* Pixelizer is a script that transforms a cloud of weighted latitude-longitude points 
 * into a discrete, pixelized aggregation data set.  Input is a TSV file
 * of weighted lat-lon and out put is a JSON.
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

// Set this to true to display the main menue upon start
boolean showMainMenu = true;

// Matrix Size (probably influence by how many pixels you want to render on your canvas)
int gridV = 22*4; // Height of Lego Table
int gridU = 18*4; // Width of Lego Table

// How big your applet window is, in pixels
int canvasWidth = 800;
int canvasHeight = int(canvasWidth * float(gridV)/gridU);

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
  
  // Reads point data from TSV file, converts to JSON, and reads in from JSON
  loadData(gridU, gridV, modeIndex);
  
  // Loads and formats menue items
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
  hideMenu = new Menu(canvasWidth, canvasHeight, 170, 25, 0, hide, align);
  mainMenu = new Menu(canvasWidth, canvasHeight, 170, 25, 2, buttonNames, align);
  // Selects on one of the mutually exclusive heatmps
  depressHeatmapButtons(3, 6);
  // Selects on one of the pixel scales
  depressHeatmapButtons(15, 17, gridSize);
}

void draw() {

  // Draws a Google Satellite Image
  renderBasemap();
  
  // Draws false color heatmap to canvas
  renderData();
  
  // Draws Outlines of Lego Data Modules (a 4x4 lego stud piece)
  renderLines();
  
  printStats();
  
  // Draws Menu
  hideMenu.draw();
  if (showMainMenu) {
    mainMenu.draw();
  }
  
}
  
