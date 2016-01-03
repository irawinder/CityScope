// Andorra PEV Simulation v0010
// for MIT Media Lab, Changing Place Group, CityScope Project

// by Yan Zhang (Ryan) <ryanz@mit.edu>
// Dec.8th.2015


class PEVs {

  ArrayList<PEV> PEVs;
  //int currentPEVID;

  PEVs() {
    PEVs = new ArrayList<PEV>();
    //currentPEVID = 0;
  }

  void initiateRandom(int _totalPEVNum) {
    int totalPEVNum = _totalPEVNum;
    for (int i = 0; i < totalPEVNum; i ++) {
      int tmpRoadID = int(random(0.0, 12.0)+0.5);
      Road tmpRoad = roads.roads.get(tmpRoadID);
      float t = random(0.0, 0.75);
      //PEV tmpPEV = new PEV(currentPEVID, tmpRoadID, t);
      PEV tmpPEV = new PEV(tmpRoad, t);
      PEVs.add(tmpPEV);
      //currentPEVID ++;
    }
  }

  void run() {
    for (PEV PEV : PEVs) {
      PEV.run();
    }
  }

  void addPEV(PEV _PEV) {
    PEVs.add(_PEV);
  }
}