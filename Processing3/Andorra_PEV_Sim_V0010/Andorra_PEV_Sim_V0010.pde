// Andorra PEV Simulation v0010 //<>// //<>//
// for MIT Media Lab, Changing Place Group, CityScope Project

// by Yan Zhang (Ryan) <ryanz@mit.edu>
// Dec.8th.2015

// Log: 
// 160101 - road structure: all one way, two way = one way + reverse. 
//        - object structure: PEVs and Roads don't have ID or GUID in objects, 
//          pass or find the object directly!


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
//int tmpRoadID = int(random(0, 12)+0.5F);

float screenScale;  //1.0F(for normal res or OS UHD)  2.0F(for WIN UHD)
int totalPEVNum = 10;
int totalRoadNum;

Roads roads;
PEVs PEVs; 


void setup() {

  //size(1620, 825); //image original; screenScale = 1.0(for normal res or OS UHD)
  //size(3240, 1650); //screenScale = 2.0(for WIN UHD)
  //size(800, 408); //screenScale is about 0.5
  size(2400, 1222); //screenScale is about 1.5
  //fullScreen();
  screenScale = width / 1620.0; //fit everything with screen size
  scale(screenScale);
  println("width = "+width);
  println("screenScale = "+screenScale);

  //smooth(); //smooth(); is slower than smooth(8);
  smooth(8); //2,3,4, or 8
  //noSmooth();
  //frameRate(60); //default frameRate is 60
  frameRate(10000); //never can be reach

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
  PEVs = new PEVs();
  PEVs.initiateRandom(totalPEVNum);
}

void draw() {

  scale(screenScale);
  background(255);

  imageMode(CORNER);

  image(img_BG, 0, 0, 1620, 825);
  //image(img_TMP_PEV, 0, 0, width, height);
  //image(img_TMP_PATH, 0, 0, width, height);
  //image(img_RD, 0, 0, width, height);
  //image(img_LEGEND, 0, 0, width, height);
  //image(img_TMP_PEV, 0, 0, width, height);

  //// test draw a pt on a road
  //float speed = 0.5F; //whole run per second;
  //float t = sin(((frameCount / 60.0F * speed) - 0.5F) * PI) / 2.0F + 0.5F;
  //if (t == 0) {
  //  tmpRoadID = int(random(0, 12)+0.5F);
  //}
  //Road tmpRoad = roads.roads.get(tmpRoadID);
  //PVector tmpPt = tmpRoad.getPt(t);
  //stroke(255, 0, 0); 
  //strokeWeight(14.0F); 
  //point(tmpPt.x, tmpPt.y);
  ////println("t = "+t+", x = "+tmpPt.x+", y = "+tmpPt.y);

  // draw roads
  //roads.drawRoads();

  // run PEVs
  PEVs.run();

  // show frameRate
  //println(frameRate);
  textAlign(RIGHT);
  textSize(10*2/screenScale);
  fill(100, 100, 100);
  text("frameRate: "+str(int(frameRate)), 1620 - 50, 50);

  // copy right
  textAlign(RIGHT);
  textSize(10);
  fill(100, 100, 100);
  text("Yan Zhang (Ryan) <ryanz@mit.edu>" + "\n" + 
    "MIT Media Lab, Changing Place Group" + "\n" +
    "December 2015", 1620 - 30, 825 - 50);
}