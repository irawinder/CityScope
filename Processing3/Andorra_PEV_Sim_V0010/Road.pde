// Andorra PEV Simulation v0010
// for MIT Media Lab, Changing Place Group, CityScope Project

// by Yan Zhang (Ryan) <ryanz@mit.edu>
// Dec.8th.2015


float stepLength = 0.2; //for the road pts generated in rhino/gh; units: km

class Road {

  PVector[] roadPts;
  int ptNum;
  String roadPtFilePath;
  //int directionType; // 0 = one way(start pt to end pt); 1 = two way 

  Road() {
  }

  // class functions
  void getData(String[] _roadLines) {
    //directionType = _directionType;
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
      roadPts[i] = new PVector(x, y, z);
    }
  }

  PVector getPt(float _t) {
    float t = _t;
    int l = roadPts.length;
    if ( t < 0.0 || t > 1.0 ) {
      println("\"t\" out of range! \"t\" must be between 0.0 and 1.0. Now t = " + t);
      return null;
    } else {
      int n = int((l-1)*t);
      return roadPts[n];
    }
  }

  //PVector getNextPt(float _t) {
  //  float t = _t;
  //  int l = roadPts.length;
  //  if ( t < 0.0 || t > 1.0 ) {
  //    println("\"t\" out of range! \"t\" must be between 0.0 and 1.0. Now t = " + t);
  //    return null;
  //  } else {
  //    int n = int((l-1)*t);
  //    return roadPts[n+1];
  //  }
  //}
  
  PVector getTangentVector(float _t) {
    float t = _t;
    int l = roadPts.length;
    if ( t < 0.0 || t > 1.0 ) {
      println("\"t\" out of range! \"t\" must be between 0.0 and 1.0. Now t = " + t);
      return null;
    } else if (t == 1.0) {
      int n = int((l-1)*t);
      PVector v1 = roadPts[n-1];
      PVector v2 = roadPts[n];
      PVector v3 = PVector.sub(v2, v1);
      v3.normalize();
      return  v3;
    } else {
      int n = int((l-1)*t);
      PVector v1 = roadPts[n];
      PVector v2 = roadPts[n+1];
      PVector v3 = PVector.sub(v2, v1);
      v3.normalize();
      return  v3;
    }
  }


  void drawRoad() {
    for (int i = 0; i < ptNum - 1; i ++) {
      //if (directionType == 0) {
      //  stroke(0, 255, 255); //one way = cyan
      //} else {
      //  stroke(0, 0, 255); //two way = blue
      //}
      stroke(0, 255, 255); //cyan
      strokeWeight(1.0); 
      line(roadPts[i].x, roadPts[i].y, roadPts[i+1].x, roadPts[i+1].y);
    }
  }
}//class Road