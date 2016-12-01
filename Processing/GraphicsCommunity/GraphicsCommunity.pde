import de.fhpotsdam.unfolding.mapdisplay.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.tiles.*;
import de.fhpotsdam.unfolding.interactions.*;
import de.fhpotsdam.unfolding.ui.*;
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.mapdisplay.shaders.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.texture.*;
import de.fhpotsdam.unfolding.events.*;
import de.fhpotsdam.utils.*;
import de.fhpotsdam.unfolding.providers.*;

import de.fhpotsdam.unfolding.providers.Microsoft;

MercatorMap mercatorMap;
UnfoldingMap map;
BarScaleUI scale;
boolean cars, transit, ped;

ArrayList<PVector>Pedestrians = new ArrayList<PVector>(); //bikes included lol
ArrayList<PVector>Cars = new ArrayList<PVector>();
ArrayList<PVector>Transit = new ArrayList<PVector>();

Table points;

PGraphics dots;
 
void setup() {
  cars = true;
  ped = true;
  transit = true;
  size(1200, 800);
  //Options for map tiles
  //map = new UnfoldingMap(this, new Microsoft.RoadProvider());
  map = new UnfoldingMap(this, new OpenStreetMap.OpenStreetMapProvider());
  //map = new UnfoldingMap(this, new StamenMapProvider.WaterColor());
  
  
  MapUtils.createDefaultEventDispatcher(this, map);
  Location Boston = new Location(42.365, -71.095);
  map.zoomAndPanTo(Boston, 14);
  
  //bar scale thing
  scale = new BarScaleUI(this, map);
  PFont font;
    font = loadFont("Dialog-14.vlw");
  scale.setStyle(0, 1, 0, font);
  
  //data stuff
  points = loadTable("data/points.csv", "header");
    
  for(int i = 0; i<points.getRowCount(); i++){
     if(points.getString(i, "AFFILIATION").equals("1") == false && points.getString(i, "AFFILIATION").equals("2") == false
     && points.getString(i, "AFFILIATION").equals("3") == false && points.getString(i, "AFFILIATION").equals("4") == false
     && points.getString(i, "AFFILIATION").equals("U") == false){

         //Generating pedestrians 
         if(points.getString(i, "COMMUTE_TYPE").equals("WLK") == true|| points.getString(i, "COMMUTE_TYPE").equals("WLK_PUB") == true ||
         points.getString(i, "COMMUTE_TYPE").equals("BIC") == true || points.getString(i, "COMMUTE_TYPE").equals("BIC_PUB") == true
         || points.getString(i, "COMMUTE_TYPE").equals("BIC_DRV") == true || points.getString(i, "COMMUTE_TYPE").equals("BIC_DRV_PUB") == true){
               Pedestrians.add(new PVector(points.getFloat(i, "YCoord"), points.getFloat(i, "XCoord")));
         }
         
         //Generating cars
         if(points.getString(i, "COMMUTE_TYPE").equals("WLK_PUB") == true || points.getString(i, "COMMUTE_TYPE").equals("BIC_DRV_PUB") == true
         || points.getString(i, "COMMUTE_TYPE").equals("DRV_PUB") == true || points.getString(i, "COMMUTE_TYPE").equals("CRP_PUB") == true){
               Transit.add(new PVector(points.getFloat(i, "YCoord"), points.getFloat(i, "XCoord")));
         }

         //Generating transit
         if(points.getString(i, "COMMUTE_TYPE").equals("BIC_DRV") == true || points.getString(i, "COMMUTE_TYPE").equals("BIC_DRV_PUB") == true
         || points.getString(i, "COMMUTE_TYPE").equals("DRV") == true || points.getString(i, "COMMUTE_TYPE").equals("DRV_PUB") == true
         || points.getString(i, "COMMUTE_TYPE").equals("DRV_HOM") == true || points.getString(i, "COMMUTE_TYPE").equals("TAX") == true
         || points.getString(i, "COMMUTE_TYPE").equals("CRP2") == true || points.getString(i, "COMMUTE_TYPE").equals("CRP6") == true
         || points.getString(i, "COMMUTE_TYPE").equals("VAN") == true || points.getString(i, "COMMUTE_TYPE").equals("CRP_PUB") == true
         || points.getString(i, "COMMUTE_TYPE").equals("DRP") == true){
               Cars.add(new PVector(points.getFloat(i, "YCoord"), points.getFloat(i, "XCoord")));
         }
         
     }
   }
   
   println(Cars.size(), Pedestrians.size(), Transit.size());
   
   //PGraphic for dots 
   dots = createGraphics(width, height);
   mercatorMap = new MercatorMap(width, height, CanvasBox().get(0).x, CanvasBox().get(1).x, CanvasBox().get(0).y, CanvasBox().get(1).y, 0);
      draw_dots();
    
}

void draw() {
  //top, bottom, left, right
  mercatorMap = new MercatorMap(width, height, CanvasBox().get(0).x, CanvasBox().get(1).x, CanvasBox().get(0).y, CanvasBox().get(1).y, 0);
  map.draw();
  translate(950, 0);
  translate(0, -740);
  scale.draw();
  translate(-950, 0);
  translate(0, 740);
  image(dots, 0, 0); 
}

void mouseDragged(){
  dots.clear();
  draw_dots();
}

float size = 5;

void draw_dots(){
  dots.beginDraw();
  if(cars){
  dots.fill(#cd18dd);
  }
  if(ped){
  dots.fill(#1ba330);
  }
  if(transit){
  dots.fill(#1d7ce2);
  }
  PVector loc = new PVector(42.359676, -71.060636);
  PVector eloc = mercatorMap.getScreenLocation(loc);
  if(cars){
  for(int i = 0; i<Cars.size(); i++){
    PVector thing = mercatorMap.getScreenLocation(Cars.get(i));
    dots.noStroke();
     dots.fill(#cd18dd);
    dots.ellipse(thing.x, thing.y, size, size);
    }
  }
  if(ped){
    for(int i = 0; i<Pedestrians.size(); i++){
    PVector thing = mercatorMap.getScreenLocation(Pedestrians.get(i));
    dots.noStroke();
    dots.fill(#1ba330);
    dots.ellipse(thing.x, thing.y, size, size);
    }
  }
  
  if(transit){
    for(int i = 0; i<Transit.size(); i++){
    PVector thing = mercatorMap.getScreenLocation(Transit.get(i));
    dots.noStroke();
    dots.fill(#1d7ce2);
    dots.ellipse(thing.x, thing.y, size, size);
    }
    
  }
  
  PVector MIT = mercatorMap.getScreenLocation(new PVector(42.3601, -71.0942));
  dots.fill(0);
  dots.ellipse(MIT.x, MIT.y, 20, 20);
  dots.textSize(20);
  dots.text("MIT", MIT.x + 15, MIT.y+5);
  
  dots.endDraw();
}
 

public ArrayList<PVector> CanvasBox() {
      ArrayList<PVector> canvas = new ArrayList<PVector>();
         float a = 0;
         float b = 0;
         float c = width;
         float d = height;
         PVector topleft = map.getLocation(a, b);
         PVector bottomright = map.getLocation(c, d);
         canvas.add(topleft);
         canvas.add(bottomright);
      return canvas;
};

void keyPressed(){
    dots.clear();
}


