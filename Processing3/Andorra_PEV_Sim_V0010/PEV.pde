// Andorra PEV Simulation v0010  //<>//
// for MIT Media Lab, Changing Place Group, CityScope Project

// by Yan Zhang (Ryan) <ryanz@mit.edu>
// Dec.8th.2015


float maxSpeed = 30.0F; //units: kph


class PEV {

  int id; //PEV agent id
  int status; //0 - empty; 1 - psg; 2 - pkg; 3 - psg & pkg
  int roadID; //the road the PEV is currently on
  float t; //t location of the current road;
  PVector locationPt; //location coordination on the canvas
  PVector locationTangent;
  float rotation; //rotation in radius on the canvas
  float speed; //current speed; units: kph

  PEV(int _id, int _roadID, float _t) {
    id = _id;
    roadID = _roadID;
    t = _t;
    status = 0;
    locationPt = roads.roads.get(roadID).getPt(t);
    speed = 0.01F;
  }

  void run() {
    move();
    getDirection();
    render();
  }

  void getDirection() {
    // get rotation
    Road road = roads.roads.get(roadID);
    locationPt = road.getPt(t);
    locationTangent = road.getTangentVector(t);
    rotation = PVector.angleBetween(new PVector(1.0F, 0.0F, 0.0F), locationTangent);
    if (locationTangent.y < 0) {
      rotation = -rotation;
    }

    //// drawn tangent
    //stroke(255, 255, 255);
    //strokeWeight(0.5F);
    //PVector v1 = locationTangent.setMag(50);
    //PVector v2 = PVector.sub(locationPt,v1);
    //PVector v3 = locationTangent.setMag(100);
    //PVector v4 = PVector.add(locationPt,v3);
    //line(v2.x, v2.y, v4.x, v4.y);

    //println("locationPt: " + locationPt);
    //println("locationNextPt: " + locationNextPt);
    //println("subPVector: " + subPVector);
    //println("rotation: " + rotation);
  }

  void render() {
    pushMatrix();
    translate(locationPt.x, locationPt.y);
    rotate(rotation);

    // draw direction line
    stroke(0, 255, 0); 
    strokeWeight(0.5F); 
    line(0.0F, 0.0F, 25.0F, 0.0F);

    // draw PEV img
    scale(0.3F);
    translate(-img_PEV_PSG.width/2, -img_PEV_PSG.height/2);
    image(img_PEV_PSG, 0, 0);
    popMatrix();
  }

  void move() {
    if (t + speed > 1.0F) {
      speed = -speed;
    } else if (t + speed < 0.0F) {
      speed = -speed;
    }
    t = t + speed;
  }
}