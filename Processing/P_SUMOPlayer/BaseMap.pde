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
  
  void setup() {
    map1 = new UnfoldingMap(p, new StamenMapProvider.TonerLite());
    map2 = new UnfoldingMap(p, new Microsoft.AerialProvider());
    mapList = new UnfoldingMap[2];
    mapList[0]=map1;
    mapList[1]= map2;
    for (UnfoldingMap m: mapList){
      m.zoomAndPanTo(16, new Location(42.329544, -71.083984));
      MapUtils.createDefaultEventDispatcher(p, m);
    }
    
    currentMap = map2;
  }
  
  private PApplet p;
  
}

