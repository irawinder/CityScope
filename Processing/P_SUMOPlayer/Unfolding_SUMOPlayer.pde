/** SumoPlayer
 *  Displays fcdoutput from Sumo traffic simulations, plus GTFS-RT transit locations, in the Processing Environment
 */
/**
 * @author ansons
 *
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

BaseMap bm;
U_FcdXml U_fx; //load floating car data from SUMO

public void setupU_SUMO() {
  smooth();
  
  //Set up Unfolding basemap
    bm = new BaseMap(this);
    bm.setup(lat, lon, zoom);
  
  //Load pre-run scenario
    U_fx = new U_FcdXml(this);
    U_fx.setup(tokens[tokenIndex]);
    
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

public void drawU_SUMO() {
  //Draw pre-run simulation  
  if (rt == false){
    //If there are timesteps left,
    if (frame+2 < U_fx.numFrames){
          //Interpolate positions depending on playback speed
          if((millis() - timer)/1000F >= 1F/playbackSpeed){
            frame++;
            U_fx.vehicleKeyframe(frame);
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
      U_fx.drawVehicles(bm.currentMap, (millis()-timer)/(1000F)*playbackSpeed, labelBuses);
    
    
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
