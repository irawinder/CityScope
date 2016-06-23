/** 
 * Application to read and display Kendall Square Data on CityScope 
 *
 *  Dynamic Vizualizations: 
 *  - ContextLabs Industry Cluster Data Visualization (Ira Winder)
 *  - TwitterScope V7 (Carson Smuts)
 *  - Mobility Demonstration Video (Mo Hadhrawi)
 *
 *  Basemaps: 
 *  - Google Maps
 *  - Google Satellite
 *  - WindFlow Simulation
 *  - Insolation Simulation
 *  - Mobility Systems
 *
 * (c) 2014 Ira Winder, jamesira.com
 */

String version = "1.1";

PImage screenCapture; //PIMage used to hold canvas information for projection distortion in "Image_Ops"

boolean splitProjection = true;

boolean debug = false; // Initial debug state
boolean help = false; // Initial help state
boolean auto = false; //Initial Automation state


boolean showBase = true; //Initial basemap state
boolean showPenta = true; //Initial penta state
boolean showTwitter = true; //Initial Twitter State
boolean showMovie = false;

int canvas_width = 1280;
int canvas_height = 1280;

//Amount of degrees rectangular canvas is rotated from horizontal latitude axis. These values specific to Kendall Square.
float rotation = -9.74; //degrees
float lat1 = 42.368912156588415; // Uppermost Latitude on canvas
float lat2 = 42.358922371673074; // Lowermost Latitude on canvas
float lon1 = -71.090762482750293; // Uppermost Longitude on canvas
float lon2 = -71.07729187107644; // Lowermost Longitude on canvas

// Creates larger canvas, rotated, that bounds and intersects 4 corners of original 
float lg_width = canvas_height*sin(abs(rotation)*2*PI/360) + canvas_width*cos(abs(rotation)*2*PI/360);
float lg_height = canvas_width*sin(abs(rotation)*2*PI/360) + canvas_height*cos(abs(rotation)*2*PI/360);

float w_shift = (lg_width-canvas_width)/2;
float h_shift = (lg_height-canvas_height)/2;

BaseMaps baseMaps;

int frame_count = 0;

MercatorMap mercatorMap; // rectangular projection environment to convert latitude and longitude into pixel locations on the canvas

void setup() {
  
  size(canvas_width, canvas_height, P2D);
  
  baseMaps = new BaseMaps(basemap_filenames, overlay_filename, width, height);
  
  // Creates projection environment to convert latitude and longitude into pixel locations on the canvas
  mercatorMap = new MercatorMap(lg_width, lg_height, lat1, lat2, lon1, lon2);
  
  setupPenta();
  setupTwitter(); // setup TwitterScope
  //setupMovie();
  
  //setup image OPS
  if (splitProjection) {
    setupOps();
    setup_ImageProj();
  }
}


void draw() {
  
  background(0);
  setPulse();
  
  if (foundHashTag) {
    image(baseMaps.getIndexedBaseMap(7), 0, 0);
  } else if (showBase) {
    image(baseMaps.getBaseMap(), 0, 0);
  }
    
  if (showTwitter || foundHashTag) {
    colorMode(RGB,255);
    drawTwitter();
  } else if (showPenta) {
    drawPenta();
  } else if (showMovie) {
    //drawMovie();
  }
  
  drawLoadBar();
  drawMapInfo();
  
  //Image and Projection Operations
  if (splitProjection) {
    screenCapture = get();
    imageOps();
    
    drawUI();
    
  }
  
  if ((frame_count + 1) % change_rate == 0) {
    if (auto) {
      nextSlide();
    }
    frame_count=0;
  }
    
  frame_count++;
  
  if ( debug == true ) { 
    println(frame_count);
    save("canvas.jpg");
  }
}

private void drawUI() {
  background(0);
  noStroke();
  
  //display heatmap that is known to be empty of values, makes P2D applet layers work FOR SOME GOD-FORSAKEN REASON
  setMercator();
  drawAliasedHeatMap(nullmap, 0, 0, 0, 0);
  unsetMercator();
  
  textSize(minTextSize*3);
  fill(#FF0000);
  text("CitySCOPE V" + version, 60, 80);
  translate(40,120);
  drawDirections();
}

private void drawDirections(){
  textAlign(LEFT);
  fill(#FFFFFF);
  textFont(font1);
  textSize(minTextSize+5);
  
  text("Use 'UP' and 'DOWN' arrows to change data type", 20, 40);
  text("Use 'LEFT' and 'RIGHT' arrows to change data layer", 20, 20);
  text("Press 'a' start and stop automatic slide progression", 20, 60);
  text("Press 'r' to refresh data", 20, 80);
  text("Press 't' to refresh colors", 20, 100);
  text("Press 'c' to refresh WordCloud", 20, 120);
  text("Press 'p' to turn pulse on and off", 20, 140);
  text("Press 'b' to change basemap", 20, 160);
  text("Press 'd' to hide and show geodata", 20, 180);
  text("Press 'g' to hide and show debug text", 20, 200);
  text("Press 'e' to hide and show heatmap", 20, 220);
  text("Press 'w' to hide and show twitter", 20, 240);
  fill(#00FF00);
  text("Press 'h' to hide and show help text on model", 20, 260);
}

private void drawLoadBar() {
  stroke(#CCCCCC);
  strokeWeight(2);
  
  textAlign(LEFT);
  textSize(minTextSize);
  colorMode(RGB, 255);
  fill(65, 170, 219, (sin+1)/2*255);
  text("Tweet to the model with #cityscope !", width-w_cloud-20, height-50);
  
  if (showPenta || showTwitter || foundHashTag) {
    line(width-w_cloud-20, height-60, width-20, height-60);
  } else {
    line(width-w_cloud-20, height-60, width-w_cloud/2-20, height-60);
  }
  
  if (auto) {
    if (displayindex == 0) {
      fill(0, 0, 1, 1);
    }
    else {
      fill(t[displayindex], 1, 1, 1);
    }
    if (showPenta || showTwitter || foundHashTag) {
      ellipse(width-w_cloud-20+((float)frame_count/change_rate)*w_cloud, height-60, 10, 10);
    } else {
      ellipse(width-w_cloud-20+((float)frame_count/change_rate)*w_cloud/2, height-60, 10, 10);
    }
  }
  noStroke();
}

private void drawMapInfo() {
  fill(#FFFFFF);
  textFont(font1);
  textSize(minTextSize);
  textAlign(LEFT);
  text("Basemap: " + baseMaps.getBaseMapName(), width-w_cloud-20, canvas_height-15);
  textFont(font3);
  textSize(1.75*minTextSize);
  text("Kendall Square", width-w_cloud-20, height-30);
}

public void nextSlide() {
  if (pentaSlide < pentaSlideShow.length-1) { // Checks if still in data slide
    if (pentaSlideShow[pentaSlide][1] == 0 && showHeat==false) { // checks if data slide is showing all layers without heatmap
      showHeat = true;
    } else { // if not, goes to next slide, makes sure heat map is off
      showHeat = false;
      pentaSlide++; 
    }
  } else { // if data slide show is over..
    if (pentaSlideShow[pentaSlide][1] == 0 && showHeat==false) {//shows last slide one more time with heat map, if last slide is showing all data
      showHeat = true; 
    } else if (showTwitter==false && baseMaps.getIndex() == 0) { //turns on TwitterScope
      showTwitter = true;
    } else if (showTwitter) {
      showTwitter = false;
      baseMaps.nextBaseMap();
      showPenta = false;
      change_rate *= 2;
    } else if (baseMaps.getIndex() < baseMaps.numBaseMaps()-1) { //Otherwise, moves on to showing different base-layer types
      showPenta = false;
      baseMaps.nextBaseMap();
    } else { //speeds up change rate again when finished showing base layers
      change_rate /= 2;
      baseMaps.nextBaseMap();
      showPenta = true;
      showHeat = false;
      pentaSlide = 0; 
    }
  }
  fieldindex = pentaSlideShow[pentaSlide][0];
  displayindex = pentaSlideShow[pentaSlide][1];
}

public void setMercator() { //Run this function before drawing latitude and longitude-based data
  //Mercator Coordinates
  translate(width/2, height/2);
  rotate(rotation*TWO_PI/360);
  translate(-width/2, -height/2);
}

public void unsetMercator() { //Run this function before drawing text, legends, etc
  //Canvas Coordinates
  translate(width/2, height/2);
  rotate(-rotation*TWO_PI/360);
  translate(-width/2, -height/2);
}

void keyPressed() {
  if (key == CODED) { 
    frame_count=0;
    if (keyCode == LEFT) {
      if (displayindex>0) {
        displayindex--; }
      else if (displayindex == 0) {
        displayindex = numlayers-1; }
      while (sum[0][displayindex] == 0) {
        if (displayindex>0) {
          displayindex--; }
        else if (displayindex == 0) {
          displayindex = numlayers-1; }
      }
        
      if (debug == true) { println("displayindex = " + displayindex); }
    }  
    else if (keyCode == RIGHT) {
      if (displayindex < numlayers-1) {
        displayindex++; }
      else if (displayindex == numlayers-1) {
        displayindex = 0; }
      while (sum[0][displayindex] == 0) {
        if (displayindex < numlayers-1) {
          displayindex++; }
        else if (displayindex == numlayers-1) {
          displayindex = 0; }
      }
      
      if (debug == true) { println("displayindex = " + displayindex); }
    }
    else if (keyCode == UP) {
      if (fieldindex>0) {
        fieldindex--; }
      else if (fieldindex == 0) {
        fieldindex=numfields-1; }
      if (debug == true) { 
        println("fieldindex = " + fieldindex); 
      }
    }  
    else if (keyCode == DOWN) {
      if (fieldindex < numfields-1) {
        fieldindex++; }
      else if (fieldindex == numfields-1) {
        fieldindex = 0; }  
      if (debug == true) { 
        println("fieldindex = " + fieldindex); 
      }
    }
  }
  
  switch(key) {
    case 'b': //changes basemap to display
      baseMaps.nextBaseMap();
      break;
    case 'a': //sets applet to run automatically
      if (auto == true) {
        auto = false;
      }
      else {
        auto = true;
        frame_count = 0;
        pentaSlide = 0;
        fieldindex = pentaSlideShow[0][0];
        displayindex = pentaSlideShow[0][1];
        baseMaps.setBaseMap(0);
        showTwitter = false;
        showPenta = true;
        showHeat = false;
        showBase = true;
      }
      println("auto = " + auto); 
      break;
    case 'e': //sets heatmap on and off
      if (showHeat == true) {
        showHeat = false;
      }
      else {
        showHeat = true;
      }
      println("showHeat = " + showHeat); 
      break;
    case 's': //toggle basemap
      if (showBase == true) {
        showBase = false;
      }
      else {
        showBase = true;
      }
      println("showBase = " + showBase); 
      break;
    case 'p': //toggle data
      if (showPenta == true) {
        showPenta = false;
      }
      else {
        showPenta = true;
      }
      println("showPenta = " + showPenta); 
      break;  
    case 'h': // toggles help text
      if (help == true) {
        help = false;
      }
      else {
        help = true;
      }
      println("help = " + help); 
      break;
    case 'd': //toggles pulse
      if (showData == true) {
        showData = false;
      }
      else {
        showData = true;
      }
      println("showData = " + showData); 
      break;
    case 'g': //toggles debug
      if (debug == true) {
        debug = false;
      }
      else {
        debug = true;
      }
      println("debug = " + debug); 
      break;  
    case 'w': //toggles debug
      if (showTwitter == true) {
        showTwitter = false;
      }
      else {
        showTwitter = true;
      }
      println("showTwitter = " + showTwitter); 
      break;  
    case 'c':
      initializeCloud(); //Refreshes word cloud
      break;
    case 't':
      t = layerHues(numlayers, minhue, maxhue); 
      initializeCloud(); //Refreshes word cloud
      break;
    case 'r':
      initializeData();
      initializeMaps();
      initializeCloud();
      break;
    case 'm': //Turns movie on and off
      if (showMovie == true) {
        showMovie = false;
      }
      else {
        showMovie = true;
      }
      println("showMovie = " + showMovie); 
      break;
  }
}
