// Andorra PEV Simulation v0010 
// for MIT Media Lab, Changing Place Group, CityScope Project

// by Yan Zhang (Ryan) <ryanz@mit.edu>
// Dec.8th.2015


float stepLength = 0.2F; //for the road pts generated in rhino/gh; units: km

class Road {
  
 PVector[] roadPts;
 int ptNum;
 String roadPtFilePath;
 int directionType; // 0 = one way(start pt to end pt); 1 = two way 
  
 Road() {
   
 }
  
 // class functions
 void getData(String[] _roadLines, int _directionType) {
   directionType = _directionType;
   String[] lines = _roadLines;
   //println("there are " + lines.length + " lines");
   ptNum = lines.length;
   roadPts = new PVector[ptNum];
   for (int i = 0; i < ptNum; i++) {
     //println(lines[i]);
     String[] pieces = split(lines[i], ",");
     float x = float(pieces[0]);
     float y = float(pieces[1]);
     float z = float(pieces[2]);
     roadPts[i] = new PVector(x,y,z);
   }
 }
  
 PVector getPt(float _t) {
   float t = _t;
   int l = roadPts.length;
   if ( t < 0.0F || t > 1.0F ) {
     println("\"t\" out of range! \"t\" must be between 0.0F and 1.0F. Now t = " + t);
     return null;
   }else{
     int n = int((l-1)*t);
     return roadPts[n];
   }
 }
  
 PVector getNextPt(float _t) {
   float t = _t;
   int l = roadPts.length;
   if ( t < 0.0F || t > 1.0F ) {
     println("\"t\" out of range! \"t\" must be between 0.0F and 1.0F. Now t = " + t);
     return null;
   }else{
     int n = int((l-1)*t);
     return roadPts[n+1];
   }
 }
  
}//class Road