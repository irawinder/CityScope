//package com.ansonstewart.sumoplayer;

/*
import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;

import processing.core.PApplet;
import processing.core.PConstants;
import processing.data.FloatList;
import processing.data.StringList;

import com.google.transit.realtime.GtfsRealtime.FeedEntity;
import com.google.transit.realtime.GtfsRealtime.FeedMessage;

import de.fhpotsdam.unfolding.UnfoldingMap;
import de.fhpotsdam.unfolding.geo.Location;
import de.fhpotsdam.unfolding.marker.SimplePointMarker;
import de.fhpotsdam.unfolding.utils.ScreenPosition;

public class GtfsRt {
  GtfsRt(PApplet _p){
    p = _p;
  }
  
  URL u;
  InputStream inst = null;
  DataInputStream dis;
  StringList ids;
  FloatList xVals, yVals;
  ArrayList<Long> tss = new ArrayList<Long>();
  LinkedHashMap<Long,HashMap<String, VehDot>> dots = new LinkedHashMap<Long,HashMap<String, VehDot>>();
  HashMap<String, VehDot> v1, v2;
  Location[] locations;
  SimplePointMarker[] markers;
  long ts;
  
  public void setup(){

    
    
      
  }
  void read(){
    ids = new StringList();
    yVals = new FloatList();
    xVals = new FloatList();
    try {
      u = new URL("http://developer.mbta.com/lib/GTRTFS/Alerts/VehiclePositions.pb");
    } catch (MalformedURLException e1) {
      e1.printStackTrace();
    } //_Z3ThTUf3E6w2NWYJhOIpg
    
    // Open a file and read its binary data 
      //InputStream inst = com.ansonstewart.sumoplayer.SumoPlayer.class.getClassLoader().getResourceAsStream("data/fcd_dudley_sub.protomsg"); 
    try {
      inst = u.openStream();
    } catch (IOException e1) {
      e1.printStackTrace();
    }
        
    
    try {
      FeedMessage fm = FeedMessage.parseFrom(inst);
      ts = fm.getHeader().getTimestamp();
      tss.add(ts);
      dots.put(ts, new HashMap<String,VehDot>());
      for (FeedEntity ent: fm.getEntityList()){
        //Log route ids:
        
        PApplet.println(ent.getVehicle().getTrip().getRouteId());
        
        ids.append(ent.getVehicle().getTrip().getRouteId());
        xVals.append(ent.getVehicle().getPosition().getLatitude());
        yVals.append(ent.getVehicle().getPosition().getLongitude());
        //String id = ent.getId();
        String route = ent.getVehicle().getTrip().getRouteId();
        String vehicle = ent.getVehicle().getVehicle().getId();
        float xVal = ent.getVehicle().getPosition().getLatitude();
        float yVal = ent.getVehicle().getPosition().getLongitude();
        float bearing = ent.getVehicle().getPosition().getBearing();
        dots.get(ts).put(vehicle,new VehDot(route,xVal,yVal,bearing,0f,"MBTA"));
      }
      
    } catch (IOException e) {
      e.printStackTrace();
    }
      locations = new Location[ids.size()];
    markers = new SimplePointMarker[ids.size()];
      for (int k1 = 0; k1 < ids.size(); k1++) {
        locations[k1] = new Location(xVals.get(k1), yVals.get(k1));
        markers[k1] = new SimplePointMarker(locations[k1]);    
      }
    
      //PApplet.println(dots);
  }
  void printTimestamp(){
    PApplet.println(ts);
  }
  
  void vehicleKeyframe(int i){
    v1 = dots.get(tss.get(i-2));
    v2 = dots.get(tss.get(i-1));
    //PApplet.println(v1);
    //PApplet.println(v2);
  }
  
  void drawVehicles(UnfoldingMap m, float interpFactor, boolean labelBuses){
    for (String key: v2.keySet()){
      if (v1.containsKey(key)){
        VehDot vA = v1.get(key);
        VehDot vB = v2.get(key);
        ScreenPosition dotPosA = vA.marker.getScreenPosition(m);
        ScreenPosition dotPosB = vB.marker.getScreenPosition(m);
        float xA = dotPosA.x;
        float yA = dotPosA.y;
        float xB = dotPosB.x;
        float yB = dotPosB.y;
        //PApplet.println(vA.x + " " + vA.y);
        //float len = PApplet.dist(xA,yA,xB,yB)*3;
        //String id = vB.id;
        //String type = vB.type;
        float x = xA +(xB-xA)*interpFactor;
        float y = yA +(yB-yA)*interpFactor;
        
        float aA = PApplet.radians(vA.angle-90);
        float aB = PApplet.radians(vB.angle-90);
        float angle = aA;
          if (Math.abs(aA-aB)<PConstants.PI/2F){ 
            angle += interpFactor*(aB-aA);
          }
//        p.stroke(0,0,0,255);
//        p.strokeWeight(2);
//        p.curve(xAcp, yAcp, xA, yA, xB, yB, xBcp, yBcp);
//        p.noStroke();
//        
        //VehDot v = vA; //new VehDot(id, "blank", x, y, angle, type);
        //ScreenPosition dotPos = v.marker.getScreenPosition(m);
        
        p.pushMatrix();
            p.translate(x, y);
            
            if (vA.route != "Red"){
              p.fill(255,255,0,220);
                p.scale(m.getZoom()/26600);
                p.noStroke();
                p.ellipse(0,0,5,5);
            }
            else{
              p.rotate((angle));
                p.scale(m.getZoom()/26600);
              p.fill(255,0,0,255);
                p.noStroke();
                p.rect(-8f,-3f, 24f, 6f);
            }        
        p.popMatrix();
    }
  }
  }
  
  private PApplet p;      
}
*/
