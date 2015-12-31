// Andorra PEV Simulation v0010  //<>//
// for MIT Media Lab, Changing Place Group, CityScope Project

// by Yan Zhang (Ryan) <ryanz@mit.edu>
// Dec.8th.2015


//import processing.opengl.*;
//import peasy.*;
//PeasyCam cam;
//PMatrix3D currCameraMatrix;
//PGraphics3D g3; 

PFont myFont;

PImage img_BG;
//PImage img_RD;
//PImage img_LEGEND;
//PImage img_TMP_PEV;
//PImage img_TMP_PATH;
PImage img_PEV_PSG;

String roadPtFile;
//int tmpRoadID = int(random(0, 12));

Roads roads;
PEVs PEVs; 


void setup() {

  //size(2160, 1100); 
  size(1620, 825);

  //smooth();
  smooth(8); //2,3,4, or 8
  frameRate(60);

  //img_BG = loadImage("BG_300DPI.png");
  //img_RD = loadImage("RD_300DPI-01.png");
  //img_LEGEND = loadImage("LEGEND_300DPI.png");
  //img_TMP_PEV = loadImage("TMP_PEVS_300DPI-01.png");
  img_BG = loadImage("BG_ALL_75DPI.png");
  //img_TMP_PEV = loadImage("TMP_PEVS_75DPI-01.png");
  //img_TMP_PATH = loadImage("TMP_START_END_PATH_75DPI-01.png");
  img_PEV_PSG = loadImage("PEV_PSG_300DPI.png");
  
  // add roads
  roadPtFile = "RD_CRV_PTS_151231.txt";
  roads = new Roads();
  roads.addRoadsByRoadPtFile(roadPtFile);
  
  // add PEVs
  int maxPEVNum = 5;
  PEVs = new PEVs();
  PEVs.initiateRandom(maxPEVNum);
}

void draw() {

  background(255);

  //println(frameRate);

  imageMode(CORNER);

  image(img_BG, 0, 0, width, height);
  //image(img_TMP_PEV, 0, 0, width, height);
  //image(img_TMP_PATH, 0, 0, width, height);
  //image(img_RD, 0, 0, width, height);
  //image(img_LEGEND, 0, 0, width, height);
  //image(img_TMP_PEV, 0, 0, width, height);

  //// test draw a pt on a road
  //float speed = 0.5F; //whole run per second;
  //float t = sin(((frameCount / 60.0F * speed) - 0.5F) * PI) / 2.0F + 0.5F;
  //if (t == 0) {
  //  tmpRoadID = int(random(0, 12));
  //}
  //Road tmpRoad = roads.roads.get(tmpRoadID);
  //PVector tmpPt = tmpRoad.getPt(t);
  //stroke(255, 0, 0); 
  //strokeWeight(14.0F); 
  //point(tmpPt.x, tmpPt.y);
  ////println("t = "+t+", x = "+tmpPt.x+", y = "+tmpPt.y);
  
  // run PEVs
  PEVs.run();
  
}