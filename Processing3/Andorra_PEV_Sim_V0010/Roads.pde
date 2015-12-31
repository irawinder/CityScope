class Roads {
  
  // variables in the class
  ArrayList<Road> roads; // An ArrayList for all the boids
  String[] roadPtFilePaths;
  
  Roads() {
    roads = new ArrayList<Road>(); // Initialize the ArrayList
  }
  
  void addRoadsByRoadPtFiles(String[] _roadPtFilePaths) {
    roadPtFilePaths = _roadPtFilePaths;
    for (String roadPtFilePath : roadPtFilePaths) {
      Road road = new Road(); 
      road.getData(roadPtFilePath);
      roads.add(road);
    }
  }
  
  void addRoad(Road road) {
    roads.add(road);
  }
  
}