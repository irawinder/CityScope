// Andorra PEV Simulation v0010 
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
PImage img_TMP_PATH;
PImage img_PEV_PSG;

String[] roadPtFilePaths;

Roads roads; 


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
  img_TMP_PATH = loadImage("TMP_START_END_PATH_75DPI-01.png");
  img_PEV_PSG = loadImage("PEV_PSG_300DPI.png");
  
  String[] roadPtFilePaths = {"RD_CRV_PTS_NORTH_01.txt", "RD_CRV_PTS_SOUTH_01.txt"};
  roads = new Roads();
  roads.addRoadsByRoadPtFiles(roadPtFilePaths); //<>//
  
}

void draw() {
  
  background(255);
  
  imageMode(CORNER);

  image(img_BG, 0, 0, width, height);
  //image(img_TMP_PEV, 0, 0, width, height);
  image(img_TMP_PATH, 0, 0, width, height);
  //image(img_RD, 0, 0, width, height);
  //image(img_LEGEND, 0, 0, width, height);
  //image(img_TMP_PEV, 0, 0, width, height);
 
  //noFill();
  //stroke(0);
 
  ////curve that I want an object/sprite to move down
  //bezier(800, 0,1000,10,900,450,700,682);
 
 
  //float t =  (frameCount/100.0)%1;
  //float x = bezierPoint(800, 1000, 900, 700, t);
  //float y = bezierPoint( 0, 10, 450, 682, t);
 
  //fill(255,0,0);
  //ellipse(x, y, 35, 35);
  
  //stroke(255,0,0); 
  //strokeWeight(14.0); 
  //try {
  //  line = reader.readLine();
  //} catch (IOException e) {
  //  e.printStackTrace();
  //  line = null;
  //}
  //if (line == null) {
  //  // Stop reading because of an error or file is empty
  //  noLoop();  
  //} else {
  //  String[] pieces = split(line, ",");
  //  float x = float(pieces[0]);
  //  float y = float(pieces[1]);
  //  println("x = " + x + ", y = " + y);
  //  //point(x, y);
  //  pushMatrix();
  //  translate(x, y);
  //  rotate(-PI*160/180);
  //  image(img_PEV_PSG, -64/2/4, -33/2/4, 64/4, 33/4);
  //  popMatrix();
  //}
  
  //// test draw a pt on a road
  float speed = 0.1F; //whole run per second;
  float t = sin(((frameCount / 60.0F * speed) - 0.5F) * PI) / 2.0F + 0.5F;
  Road tmpRoad = roads.roads.get(0);
  PVector tmpPt = tmpRoad.getPt(t);
  stroke(255,0,0); 
  strokeWeight(14.0F); 
  point(tmpPt.x, tmpPt.y);
  println("t = "+t+", x = "+tmpPt.x+", y = "+tmpPt.y);
  
  
  //println(frameRate);
 
}