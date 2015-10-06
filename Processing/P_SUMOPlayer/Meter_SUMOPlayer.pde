import processing.core.PApplet;
import processing.core.PConstants;
import processing.core.PImage;
import processing.data.*;

import java.util.List;
import java.io.InputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.io.File;
import java.lang.ClassLoader;
import java.io.DataInputStream;
import java.net.MalformedURLException;
import java.net.URL;

M_FcdXml[] M_fx; //load floating car data from SUMO
  
public void setupM_SUMO() {
  smooth();

  //Set up Unfolding basemap
  bm = new BaseMap(this);
  bm.setup(lat, lon, zoom);
  
  //Load pre-run scenario
  M_fx = new M_FcdXml[3];
  
  M_fx[0] = new M_FcdXml(this);
  M_fx[0].setup(tokens[0]);

  M_fx[1] = new M_FcdXml(this);
  M_fx[1].setup(tokens[1]);

  M_fx[2] = new M_FcdXml(this);
  M_fx[2].setup(tokens[2]);  

  frameRate(fr);
  M_fx[0].vehicleKeyframe(0);
  M_fx[1].vehicleKeyframe(0);
  M_fx[2].vehicleKeyframe(0);
}
  
public void drawM_SUMO() {
  
  //Draw pre-run simulation  
  if (rt == false){
    //If there are timesteps left,
    if (frame+2 < M_fx[tokenIndex].numFrames){
          //Interpolate positions depending on playback speed
          if((millis() - timer)/1000F >= 1F/playbackSpeed){
            frame++;
            M_fx[tokenIndex].vehicleKeyframe(frame);
            //PApplet.println((millis() - timer)/1000 + " : " + playbackSpeed);
            timer = millis();  
          }          
    }
    //Else, start from the beginning of the pre-run simulation
    else{
      frame=0;
    }
    
    //Draw the basemap
      
    //Draw the vehicles
    noStroke();
    M_fx[tokenIndex].drawVehicles((millis()-timer)/(1000F)*playbackSpeed);
  
//    //Draw the info window
//    fill(0);
//    rect(2, 6, 300, 50, 6);
//    textAlign(PConstants.LEFT,PConstants.BOTTOM);
//        textSize(24);
//        fill(255);
//    text("Sim. Playback: " + playbackSpeed + "x", 10, 40);
  
  }
  
  
//  //Draw the command legend
//  fill(0);
//  rect(width-202, height-156, 200, 150, 6);
//  fill(255);
//  text("Hotkeys",width-192,height-125);
//  textSize(12);
//  text("Faster: a",width-192,height-110);
//  text("Slower: z",width-192,height-95);
//  text("Outline basemap: 1",width-192,height-80);
//  text("Aerial basemap: 2",width-192,height-65);
//  text("Toggle realtime: r",width-192,height-50);
//  text("Record video: v",width-192,height-35);
  
  
  //pushMatrix();
  //scale((float) 0.75);
  //popMatrix();
}
