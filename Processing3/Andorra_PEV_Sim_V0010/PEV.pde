// Andorra PEV Simulation v0010 
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
  PVector locationNextPt;
  float speed; //current speed; units: kph

  PEV(int _id, int _roadID, float _t) {
    id = _id;
    roadID = _roadID;
    t = _t;
    status = 0;
    locationPt = roads.roads.get(roadID).getPt(t);
    speed = 0.0F;
  }

  void run() {
    getDirection();
    render();
  }

  void getDirection() {
    Road road = roads.roads.get(roadID);
    //float speed = 0.5F; //whole run per second;
    //float t = sin(((frameCount / 60.0F * speed) - 0.5F) * PI) / 2.0F + 0.5F;
    //if (t == 0) {
    // tmpRoadID = int(random(0, 12));
    //}
    locationPt = road.getPt(t);
    locationNextPt = road.getNextPt(t);
  }

  void render() {
    
    img_PEV_PSG
  }
}