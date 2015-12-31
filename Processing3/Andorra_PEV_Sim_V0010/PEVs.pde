// Andorra PEV Simulation v0010 
// for MIT Media Lab, Changing Place Group, CityScope Project

// by Yan Zhang (Ryan) <ryanz@mit.edu>
// Dec.8th.2015


class PEVs {

  ArrayList<PEV> PEVs;
  int currentPEVID;

  PEVs() {
    PEVs = new ArrayList<PEV>();
    currentPEVID = 0;
  }
  
  void initiateRandom(int _maxPEVNum){
    int maxPEVNum = _maxPEVNum;
    for (int i = 0; i < maxPEVNum; i ++) {
      int tmpRoadID = int(random(0.0F, 12.0F));
      float t = random(0.0F, 1.0F);
      PEV tmpPEV = new PEV(currentPEVID, tmpRoadID, t);
      PEVs.add(tmpPEV);
      currentPEVID ++;
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