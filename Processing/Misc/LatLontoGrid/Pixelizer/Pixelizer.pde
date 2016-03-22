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

int projectorWidth = 1920;
int projectorHeight = 1080;

int screenWidth = 1200;
int screenHeight = 800;

// Set this to false if you know that you don't need to regenerate data every time Software is run
boolean pixelizeData = true;

// Set this to true to display the main menu upon start
boolean showMainMenu = true;
boolean showFrameRate = false;

boolean showStores = true;
boolean showDeliveryData = false;
boolean showPopulationData = true;
boolean showBasemap = true;

boolean flagResize = false;

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
  resetMousePan();
}

// How big your applet window is, in pixels
int tableWidth = 800;
int tableHeight = int(tableWidth * float(displayV)/displayU);

//Global Text and Background Color
int textColor = 255;
int background = 0;
String align = "RIGHT";

// Class that holds a button menu
Menu mainMenu, hideMenu;

void setup() {
  size(screenWidth, screenHeight);
  
  // Window may be resized after initialized
  frame.setResizable(true);
  
  // Recalculates relative positions of canvas items if screen is resized
  frame.addComponentListener(new ComponentAdapter() { 
     public void componentResized(ComponentEvent e) { 
       if(e.getSource()==frame) { 
         flagResize = true;
       } 
     } 
   }
   );
  
  setGridParameters();
  initDataGraphics();
  
  // Reads point data from TSV file, converts to JSON, prints to JSON, and reads in from JSON
  loadData(gridU, gridV, modeIndex);
  
  // Renders Minimap
  renderMiniMap(miniMap);
  
  reRender();
  
  // Loads and formats menu items
  loadMenu(tableWidth, tableHeight);
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
  
  // Initializes Basemap file
  initializeBaseMap();
  
  // Loads Basemap from subset of file
  loadBasemap();
}

void loadMenu(int screenWidth, int screenHeight) {
  // Initializes Menu Items (screenWidth, screenHeight, button width[pix], button height[pix], 
  // number of buttons to offset downward, String[] names of buttons)
  hideMenu = new Menu(screenWidth, screenHeight, 170, 20, 0, hide, align);
  mainMenu = new Menu(screenWidth, screenHeight, 170, 20, 2, menuOrder, align);
  // Selects one of the mutually exclusive heatmps
  depressHeatmapButtons();
  // Selects one of the mutually exclusive population maps
  depressPopulationButtons();
  // Selects one of the mutually exclusive pixel scales
  depressZoomButtons(gridSize);
  // Checks whether these true/false button should be pressed
  pressButton(showStores, getButtonIndex(buttonNames[6]));
  pressButton(showBasemap, getButtonIndex(buttonNames[14]));
  pressButton(showFrameRate, getButtonIndex(buttonNames[15]));
  pressButton(showDeliveryData, getButtonIndex(buttonNames[16]));
  pressButton(showPopulationData, getButtonIndex(buttonNames[17]));
  
  if (!showPopulationData) {
    for (int i=18; i<=19; i++) {
      mainMenu.buttons[getButtonIndex(buttonNames[i])].show = false;
    }
  } else {
    for (int i=18; i<=19; i++) {
      mainMenu.buttons[getButtonIndex(buttonNames[i])].show = true;
    }
  }
  
  if (!showDeliveryData) {
    for (int i=2; i<=5; i++) {
      mainMenu.buttons[getButtonIndex(buttonNames[i])].show = false;
    }
  } else {
    for (int i=2; i<=5; i++) {
      mainMenu.buttons[getButtonIndex(buttonNames[i])].show = true;
    }
  }
  
  mainMenu.buttons[getButtonIndex(buttonNames[0])].isPressed = true;
  mainMenu.buttons[getButtonIndex(buttonNames[1])].isPressed = true;
  mainMenu.buttons[getButtonIndex(buttonNames[10])].isPressed = true;
  mainMenu.buttons[getButtonIndex(buttonNames[20])].isPressed = true;
}

void draw() {
  
  if (flagResize) {
    initScreenOffsets();
    loadMenu(screenWidth, screenHeight);
    flagResize = false;
  }
  
  background(background);
  
  table.beginDraw();
  table.clear();
  table.background(background);
  
  // Draws a Google Satellite Image
  renderBasemap(table);
  
  if (showPopulationData){
    table.image(p, 0, 0);
  }
  
  if (showDeliveryData) {
    table.image(h, 0, 0);
  }
  
  if (showStores) {
    table.image(s, 0, 0);
  }
  
  table.image(l, 0, 0);
  
  renderCursor(c);
  table.image(c, 0, 0);
  
  table.endDraw();
  
  image(table, tablex_0, tabley_0, tablex_1, tabley_1);
  
  
  
  
  screen.beginDraw();
  screen.clear();
  
  renderInfo(i, 2*tablex_0 + tablex_1, tabley_0, mapRatio*tablex_1, mapRatio*tabley_1);
  screen.image(i, 0, 0);
  
  
  // Draws Menu
  buttonHovering = false;
  hideMenu.draw(screen);
  if (showMainMenu) {
    mainMenu.draw(screen);
  }
  
  screen.endDraw();
  
  image(screen, 0, 0);
  
}
  
