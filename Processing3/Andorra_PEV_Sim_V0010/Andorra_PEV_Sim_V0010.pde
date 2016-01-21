// Andorra PEV Simulation v0010 //<>//
// for MIT Media Lab, Changing Place Group, CityScope Project

// by Yan Zhang (Ryan) <ryanz@mit.edu>
// Dec.8th.2015

// Log: 
// 160101 - road structure: all one way, two way = one way + reverse. 
//        - object structure: PEVs and Roads don't have ID or GUID in objects, 
//          pass or find the object directly!
// 160115 - update curve parameter speed t to absolute speed kmps according frameRate
// 160118 - add PEV speed control
//        - add PEV number control
// 160121 - change PEV states randomly


//import processing.opengl.*;
//import peasy.*;
//PeasyCam cam;
//PMatrix3D currCameraMatrix;
//PGraphics3D g3; 

PFont myFont;

PImage img_BG;
//PImage img_RD;
//PImage img_LEGEND;
//PImage img_TMP_PATH;

String roadPtFile;
//int tmpRoadID = int(random(0, 12)+0.5F);

float screenScale;  //1.0F(for normal res or OS UHD)  2.0F(for WIN UHD)
int totalPEVNum = 10;
int targetPEVNum;
int totalRoadNum;
float scaleMeterPerPixel = 2.15952; //meter per pixel in processing; meter per mm in rhino
float ScrollbarRatioPEVNum = 0.12;
float ScrollbarRatioPEVSpeed = 0.5;
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

  setupScrollbars();
  //colorMode(RGB,255,255,255,100);

  //smooth(); //smooth(); is slower than smooth(8);
  smooth(8); //2,3,4, or 8
  //noSmooth();
  //frameRate(60); //default frameRate is 60
  frameRate(10000); //never can be reach

  img_BG = loadImage("BG_ALL_75DPI.png");

  // add roads
  roadPtFile = "RD_CRV_PTS_151231.txt";
  roads = new Roads();
  roads.addRoadsByRoadPtFile(roadPtFile);

  // add PEVs
  PEVs = new PEVs();
  PEVs.initiate(totalPEVNum);
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

  // draw roads
  //roads.drawRoads();

  // run PEVs
  PEVs.run();

  // show frameRate
  //println(frameRate);
  textAlign(RIGHT);
  textSize(10*2/screenScale);
  fill(200);
  text("frameRate: "+str(int(frameRate)), 1620 - 50, 50);

  // draw scollbars
  drawScrollbars();
  targetPEVNum = int(ScrollbarRatioPEVNum*45+5); //5 to 50
  PEVs.changeToTargetNum(targetPEVNum);
  maxSpeedKPH = (ScrollbarRatioPEVSpeed*20+10)*10; //units: kph  10.0 to 50.0 kph
  maxSpeedMPS = maxSpeedKPH * 1000.0 / 60.0 / 60.0; //20.0 KPH = 5.55556 MPS
  maxSpeedPPS = maxSpeedMPS / scaleMeterPerPixel; 
  fill(255);
  noStroke();
  rect(260, 701, 35, 14);
  rect(260, 726, 35, 14);
  textAlign(LEFT);
  textSize(10);
  fill(200);
  //text("Score Filters: ",10,20);
  //text("Framerate: " + round(frameRate) + "\nDrag mouse to rotate camera\nPress SPACEBAR to show/hide labels on points\nPress ENTER to show/hide sliders and texts",10,100);
  text("mouseX: "+mouseX/screenScale+", mouseY: "+mouseY/screenScale, 10, 20);
  fill(0);
  text(targetPEVNum, 263, 712);
  text(int(maxSpeedKPH/10), 263, 736);

  // copy right
  textAlign(RIGHT);
  textSize(10);
  fill(100);
  text("Yan Zhang (Ryan) <ryanz@mit.edu>" + "\n" + 
    "MIT Media Lab, Changing Place Group" + "\n" +
    "December 2015", 1620 - 30, 825 - 50);
}