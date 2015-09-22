//Reads vehicle locations at timesteps into Processing
//from a SUMO floating car data (FCD) xml output 
//package com.ansonstewart.sumoplayer;

import de.fhpotsdam.unfolding.UnfoldingMap;
import de.fhpotsdam.unfolding.geo.Location;
import de.fhpotsdam.unfolding.marker.SimplePointMarker;
import de.fhpotsdam.unfolding.utils.ScreenPosition;
import processing.core.PApplet;
import processing.core.PConstants;
import processing.data.XML;

//import com.ansonstewart.sumoplayer.VehDot;

//import java.io.File;
//import java.nio.file.Path;
import java.util.*;

public class FcdXml {
  //Make Processing functions available
  FcdXml(PApplet _p){
    p = _p;
  }
  
  Location[] locations;
  SimplePointMarker[] markers;
  LinkedHashMap<Integer,HashMap<String, VehDot>> dots;
  XML xml;
  int[] frameIndex;
  XML[] timeSteps;
  int numFrames;
  HashMap<String, VehDot> v1, v2;
  //File fcdFile = new File("C:/Users/Anson/Processing-SumoReader/Sumo Player/bin/data/000011.xml");
  //Path fcdPath = fcdFile.toPath();
  
  void setup(String tokenVector){
    xml = p.loadXML(tokenVector+".xml");
    timeSteps = xml.getChildren("timestep");
    numFrames = timeSteps.length;
    dots = new LinkedHashMap<Integer,HashMap<String, VehDot>>(); //overall hashmap, for timesteps and vehicle id/marker hashmap
    for (int i = 0; i < numFrames; i++) {
      dots.put(i, new HashMap<String,VehDot>());
      
      //build dots for markers
      XML[] vehDotsXml = timeSteps[i].getChildren("vehicle");
      int numVehDots = vehDotsXml.length;
        
      for (int j = 0; j < numVehDots; j++){
          String id = vehDotsXml[j].getString("id");
          Float y = vehDotsXml[j].getFloat("x");
          Float x = vehDotsXml[j].getFloat("y");
          Float angle = vehDotsXml[j].getFloat("angle");
          Float speed = vehDotsXml[j].getFloat("speed");
          String type = vehDotsXml[j].getString("type");
          dots.get(i).put(id,new VehDot("blank",x,y,angle,speed,type));
          }
        
      //build dots for pedestrians (which lack type field)
        XML[] perDotsXml = timeSteps[i].getChildren("person");
        int numPerDots = perDotsXml.length;
        for (int j = 0; j < numPerDots; j++){
          String id = perDotsXml[j].getString("id");
          Float y = perDotsXml[j].getFloat("x");
          Float x = perDotsXml[j].getFloat("y");
          Float speed = perDotsXml[j].getFloat("speed");
          Float angle = perDotsXml[j].getFloat("angle");
          dots.get(i).put(id,new VehDot("blank",x,y,angle,speed,"person"));
          }
      }
      
    PApplet.println(numFrames + " frames (" +numFrames/60 + " minutes) loaded.");
  }
  
  void vehicleKeyframe(int i){
    v1 = dots.get(i);
    v2 = dots.get(i+1);
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
        
        float len = PApplet.dist(xA,yA,xB,yB)*2f;
        String id = key;
        String type = vB.type;
        float xAcp = xB - len*PApplet.cos(PApplet.radians(vA.angle-90));
        float yAcp = yB + len*PApplet.sin(PApplet.radians(vA.angle-90));
        float xBcp = xA + len*PApplet.cos(PApplet.radians(vB.angle-90));
        float yBcp = yA - len*PApplet.sin(PApplet.radians(vB.angle-90));
        float aA = PApplet.radians(vA.angle-90)+PConstants.PI;
        float aB = PApplet.radians(vB.angle-90)+PConstants.PI;
        float x, y, tx, ty;
        float angle = aA;
        float speed = vA.speed;
        //PApplet.println(vA.x + " " + vA.y);
        //PApplet.println(PApplet.dist(vA.x, vA.y, vB.x, vB.y)*1000000F);
        if (Math.abs(aA-aB)<PConstants.PI/2f){ 
          angle += interpFactor*(aB-aA);
        }
        //else if (Math.abs(aA-aB)>3*PConstants.PI/2F){
        //  angle -= interpFactor*(2*PConstants.PI-(aB-aA));
        //}
        if (speed > 5){
          x = p.curvePoint(xAcp, xA, xB, xBcp, interpFactor);
          y = p.curvePoint(yAcp, yA, yB, yBcp, interpFactor);
          tx = p.curveTangent(xAcp, xA, xB, xBcp, interpFactor);
          ty = p.curveTangent(yAcp, yA, yB, yBcp, interpFactor);
          float ang = -PApplet.atan2(ty,tx);
          if (Math.abs(aA-ang) < PConstants.PI/2F){
            angle = ang;
          }
        }
        else {
          x = xA+(xB-xA)*interpFactor;
          y = yA+(yB-yA)*interpFactor;    
//          else if (Math.abs(aA-aB)>3*PConstants.PI/2F){
//            angle += interpFactor*(2*PConstants.PI-(aB-aA));
//          }

        }


        
        
//        p.stroke(0,0,0,255);
//        p.strokeWeight(2);
//        p.curve(xAcp, yAcp, xA, yA, xB, yB, xBcp, yBcp);
//        p.noStroke();
//        
        //VehDot v = new VehDot(id, "blank", x, y, angle, type);
        //ScreenPosition dotPos = v.marker.getScreenPosition(m);
        
        p.pushMatrix();
            p.translate(x, y);
            p.rotate(-(angle));
      
            if (type.equals("passenger")){ // Passenger car
                p.fill(255,255,255,255);
                p.scale(m.getZoom()/266000);
                p.rect(-5f,-2f, 10f, 4f);
            }
        else if (type.equals("delivery")){ // Delivery truck
                p.fill(0,255,255,255);
                p.scale(m.getZoom()/266000);
                p.rect(-6f,-2f, 12f, 4f);
            }
        else if (type.equals("trailer")){ // Tractor-trailer truck
                p.fill(0,255,255,255);
                p.scale(m.getZoom()/266000);
                p.rect(-7f,-2.5f, 14f, 5f);
            }
        else if (type.equals("rail")){ // Subway
                p.fill(255,155,0,255);
                p.scale(m.getZoom()/266000);
                p.rect(-40f,-6f, 80f, 12f);
            }
            else if (type.equals("BUS")){
                //Bus shape
                p.fill(255,255,0,255);
                p.scale(m.getZoom()/266000);
                p.rect(-8f,-3f, 24f, 6f);
                //Bus route display
                if (labelBuses == true) {
                  p.textAlign(PConstants.CENTER,PConstants.CENTER);
                  p.textSize(18);
                  p.fill(255,0,0,255);
                  p.rotate(angle);
                  //p.text(PApplet.str(angle),0,0);
                  p.text((id).split("_")[0],0,0);                  
                }
            }
            else if (type.equals("DEFAULT_VEHTYPE")){
                p.fill(255,255,255,255);
                p.scale(m.getZoom()/266000);
                p.rect(-5f,-2f, 10f, 4f);
            }
            else {
                p.fill(255,255,255,255);
              p.scale(m.getZoom()/266000);
                p.rect(-.5f,-1f,1f,2f);
            }
            p.popMatrix();
        
      }
    }
  }  

  
  private PApplet p;
}


