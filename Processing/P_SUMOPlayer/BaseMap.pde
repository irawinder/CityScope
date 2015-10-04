//package com.ansonstewart.sumoplayer;

import processing.core.PApplet;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.providers.*;

public class BaseMap {
  BaseMap (PApplet _p){
    p = _p;
  }
  
  UnfoldingMap currentMap, map1, map2;
  UnfoldingMap[] mapList;
  
  void setup(float lat, float lon, int zoom) {
	streamProvider mapbox = new streamProvider("api.mapbox.com", "ansoncfit","3f254fbf","pk.eyJ1IjoiYW5zb25jZml0IiwiYSI6IkVtYkNiRWMifQ.LnNJImFvUIYbeAT5SE3glA");
	map1 = new UnfoldingMap(p, mapbox);
	//map1 = new UnfoldingMap(p, new StamenMapProvider.TonerLite());
    //map1 = new UnfoldingMap(p, new OpenStreetMap.OSMGrayProvider());
    map2 = new UnfoldingMap(p, new Microsoft.AerialProvider());
    mapList = new UnfoldingMap[2];
    mapList[0]=map1;
    mapList[1]= map2;
    for (UnfoldingMap m: mapList){
      m.zoomAndPanTo(zoom, new Location(lat, lon));
      MapUtils.createDefaultEventDispatcher(p, m);
    }
    
    currentMap = map2;
  }
  
  public void resetMap(float lat, float lon, int zoom) {
    for (UnfoldingMap m: mapList){
      m.zoomAndPanTo(zoom, new Location(lat, lon));
      MapUtils.createDefaultEventDispatcher(p, m);
    }
  }
  
  private PApplet p;
  
}


