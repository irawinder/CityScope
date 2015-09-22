/**
 * An application with a basic interactive map. You can zoom and pan the map.
 */

import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.providers.*;

UnfoldingMap map;

PImage get;
PGraphics g, crop;

float counter;

float C = 2*PI*6372798.2; // Circumference of Earth
float lat =  42.329544;
float lon = -71.083984;
int zoom = 15;

float modelWidth  = 2000.0; // width of model in meters
float modelHeight = 2000.0; // height of model in meters
float modelRotation = .5*PI; // rotation of model in radians clockwise from north

float scale; // distance represented by one pixel

int modelW_Pix;
int modelH_Pix;

void setup() {
  size(800, 600, P2D);
  g = createGraphics(800, 600);
  
  map = new UnfoldingMap(this, new Microsoft.AerialProvider());
  map.zoomAndPanTo(new Location( lat, lon), zoom);
  MapUtils.createDefaultEventDispatcher(this, map);
  
  setScale();
}

void draw() {
  
  map.draw();
  
  //background(0);
  
  g.beginDraw();
  g.background(0);
  g.translate(width/2, height/2);
  g.rotate(modelRotation);
  g.translate(-width/2, -height/2);
  g.image(get(), 0, 0);
  g.endDraw();
  
  crop.beginDraw();
  crop.background(0);
  crop.translate(-(g.width-crop.width)/2, -(g.height-crop.height)/2);
  crop.image(g,0,0);
  crop.translate((g.width-crop.width)/2, (g.height-crop.height)/2);
  crop.endDraw();
  
  image(crop,0,0);
  
}

void setScale() {
  zoom = map.getZoomLevel();
  
  // Scale Equation:
  // http://wiki.openstreetmap.org/wiki/Zoom_levels
  scale = C*cos( (lat/360.0)*(2*PI) )/ pow(2, zoom+8);
  println("scale: " + scale);
  
  modelW_Pix = int(modelWidth/scale);
  modelH_Pix = int(modelHeight/scale);
  
  crop = createGraphics(modelW_Pix, modelH_Pix);
}

public void keyPressed() {
  
  // Returns Scale
  switch(key) {
    case 'z':
      println("zoom: " + map.getZoomLevel());
      break;
    case 'h':
      println("height: " + map.getHeight());
      break;
    // Recalculates Scale
    case 's':
      setScale();
  }
  
}



