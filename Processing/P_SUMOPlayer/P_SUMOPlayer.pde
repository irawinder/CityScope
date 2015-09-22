/** SumoPlayer
 *  Displays fcdoutput from Sumo traffic simulations, plus GTFS-RT transit locations, in the Processing Environment
 */
/**
 * @author ansons
 *
 */

/*

package com.ansonstewart.sumoplayer;

*/
//Import libraries
import processing.core.PApplet;
import processing.core.PConstants;
import processing.data.*;
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

/*

import com.google.protobuf.*;
import com.ansonstewart.sumoplayer.Fcd;
import com.ansonstewart.sumoplayer.Fcd.*;
import com.ansonstewart.sumoplayer.GtfsRt;
import com.ansonstewart.sumoplayer.GtfsRt.*;
import com.ansonstewart.sumoplayer.BaseMap;
import com.google.transit.realtime.GtfsRealtime;
import com.google.transit.realtime.GtfsRealtime.*;

*/

import java.util.List;
import java.io.InputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.io.File;
import java.lang.ClassLoader;
import java.io.DataInputStream;
import java.net.MalformedURLException;
import java.net.URL;

/*
@SuppressWarnings("unused")
public class SumoPlayer extends PApplet {
   
*/

private static final long serialVersionUID = 1L;

BaseMap bm;
FcdXml fx; //load floating car data from SUMO
//GtfsRt gr; //load GTFS real-time data
int timer, animationTimer; 
int frame;
float playbackSpeed = 1; 
int fr = 25; //fps
boolean labelBuses, rt = false;
int rtStep = 0;
String tokenVector = "000011";

public void setup() {
  //Screen size
  size(1920,1080,P2D);
    smooth();
  
  //Set up Unfolding basemap
    bm = new BaseMap(this);
    bm.setup();
  
  //Load pre-run scenario
    fx = new FcdXml(this);
    fx.setup(tokenVector);
    
/*
  //Load real-time MBTA vehicle locations  
    gr = new GtfsRt(this);
    gr.setup();
    timer = -100000;
    //For real-time MBTA vehicle locations, load two consecutive 30-second snapshots
    frameRate(fr);
    fx.vehicleKeyframe(0);
*/

}

public void draw() {

//Draw pre-run simulation  
if (rt == false){
  //If there are timesteps left,
  if (frame+2 < fx.numFrames){
        //Interpolate positions depending on playback speed
        if((millis() - timer)/1000F >= 1F/playbackSpeed){
          frame++;
          fx.vehicleKeyframe(frame);
          //PApplet.println((millis() - timer)/1000 + " : " + playbackSpeed);
          timer = millis();  
        }          
  }
  //Else, start from the beginning of the pre-run simulation
  else{
    frame=0;
  }
  
  //Draw the basemap
  bm.currentMap.draw();
    
  //Draw the vehicles
  noStroke();
  fx.drawVehicles(bm.currentMap, (millis()-timer)/(1000F)*playbackSpeed, labelBuses);

  //Draw the info window
  fill(0);
  rect(2, 6, 300, 50, 6);
  textAlign(PConstants.LEFT,PConstants.BOTTOM);
      textSize(24);
      fill(255);
  text("Sim. Playback: " + playbackSpeed + "x", 10, 40);

}

////For real-time vehicle locations
//if (rt==true){
//
////Draw the unfolding map basemap
//bm.currentMap.draw();
//  
//  //If less than thirty seconds have elapsed since the last position update,
//  if(millis() - timer >=30000){    
//    rtStep++;
//    gr.read();
//    gr.printTimestamp();
//    if(rtStep >= 2){
//      gr.vehicleKeyframe(rtStep);
//    }
//    timer = millis();
//  }
//  //If multiple position updates have been loaded
//  if(rtStep >= 2){
//    //PApplet.println(rtStep);
//    gr.drawVehicles(bm.currentMap, (millis()-timer)/30000f, labelBuses);
//    //PApplet.println((millis()-timer)/30000f);
//  }
//  
//  //Draw the info window
//  fill(0);
//  rect(2, 6, 300, 50, 6);
//  textAlign(PConstants.LEFT,PConstants.BOTTOM);
//      textSize(24);
//      fill(255);
//  text("Realtime Data", 10, 40);
//}

//Draw the command legend
fill(0);
rect(width-202, height-156, 200, 150, 6);
fill(255);
text("Hotkeys",width-192,height-125);
textSize(12);
text("Faster: a",width-192,height-110);
text("Slower: z",width-192,height-95);
text("Outline basemap: 1",width-192,height-80);
text("Aerial basemap: 2",width-192,height-65);
text("Toggle realtime: r",width-192,height-50);
text("Record video: v",width-192,height-35);
}

public void keyPressed(){
      
  //Frame information to console log
    if (key == 'i') {
      println("z: " + bm.currentMap.getZoom()/266144);
      println(frame);
      println("m: " + millis());
      println("t: " + timer);
      println(labelBuses);
      }
    
  //Switch to Stamen plain basemap
      if (key == '1') {
        bm.currentMap = bm.map1;
        labelBuses = true;
      }
      
    //Switch to aerial basemap  
      if (key == '2') {
        bm.currentMap = bm.map2;
        labelBuses = false;
      }
      
    //Switch which pre-run simulation is playing  
      if (key =='t'){
        if (tokenVector == "000011"){
          tokenVector = "000012";
        }
        else{
          tokenVector = "000011";
        };
        fx.setup(tokenVector);  
      }
      
    //Pause
      if (key =='w'){
        noLoop();
      }
      
    //Start  
      if (key =='s'){
        loop();
      }
    
    //Save video frames
      if (key =='v'){
      saveFrame("vid_####.jpg");
    }
      
    //Speed up playback
      if (key =='a'){
        if (playbackSpeed < 30){
          playbackSpeed ++;
        };
      }
      
    //Slow down playback
      if (key =='z'){
        if (playbackSpeed > 0){
          playbackSpeed --;
        };
      }
      
    //Toggle realtime vehicle locations
      if (key =='r'){
        if (rt == false){
          timer = -100000;
          rt = true;
        }
        else{
          rt = false;
          bm.currentMap.zoomAndPanTo(16, new Location(42.329544, -71.083984));
        };
      }
}
  
/*
  public static void main(String _args[]) {
    PApplet.main(new String[] {"--present", "--hide-stop", "--bgcolor=#000000", com.ansonstewart.sumoplayer.SumoPlayer.class.getName() }); //
  }
}
*/

