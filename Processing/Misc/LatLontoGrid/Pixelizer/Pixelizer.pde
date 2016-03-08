/* Pixelizer is a script that transforms a cloud of weighted latitude-longitude data 
 * into a discrete, pixelized density of the weighted data.  Input is a TSV file
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

// For some reason switching modes with 'm' results in null JSON Objects?

// 0 = Denver
// 1 = San Jose
int modeIndex = 0;

// Set this to false if you know that you don't need to regenerate data every time Software is run
boolean pixelizeData = true;

void setup() {
  size(canvasWidth, canvasHeight);
  
  // Window may be resized after initialized
  frame.setResizable(true);
  
  // Loads everything up
  load();
}

void draw() {

  // Draws a Google Satellite Image
  renderBasemap();
  
  // Draws false color heatmap to canvas
  renderData();
  
  // Draws Outlines of Lego Data Modules (a 4x4 lego stud piece)
  renderLines();
}

void keyPressed() {
  switch(key) {
    case 'm': // changes data mode between Denver and San Jose
      modeIndex = next(modeIndex, 1);
      load();
      break;
  }
}

// iterates an index parameter
int next(int index, int max) {
  if (index == max) {
    index = 0;
  } else {
    index ++;
  }
  println(index);
  return index;
}

void load() {
  // determines which dataset to lode
  switch(modeIndex) {
    case 0:
      denverMode();
      break;
    case 1:
      sanjoseMode();
      break;
  }
  // Processes lat-long data and saves to aggregated JSON grid
  if (pixelizeData) {
    pixelizeData();
  }
  // Loads pixel data into heatmap
  loadPixelData();
  // Loads Basemap file
  loadBasemap();
}
    
    
  
