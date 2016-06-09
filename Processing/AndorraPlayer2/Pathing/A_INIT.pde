//------------- Initialize Pathfinding Objects

Pathfinder finderTopo, finderMargin;

// Pathfinder test and debugging Objects
Pathfinder finderTest;
PVector A, B;
ArrayList<PVector> testPath, testVisited;

void initPathfinder(PGraphics p, int res) {
  finderTopo = new Pathfinder(p.width, p.height, res, boundaries);
  finderMargin = new Pathfinder(p.width, p.height, res, container);
  
  initOD(p);
  initNetwork(p, 10, 0.55);
  initPath(finderTest, A, B);
  
  // Ensures that a valid path is always initialized upon start
  while (testPath.size() < 2) {
    println("Generating new origin-destination pair ...");
    initOD(p);
    initPath(finderTest, A, B);
  }
}

void initNetwork(PGraphics p, int res, float cullRatio) {
  finderTest = new Pathfinder(p.width, p.height, res, cullRatio);
}

void initPath(Pathfinder finder, PVector A, PVector B) {
  testPath = finder.findPath(A, B);
  testVisited = finder.getVisited();
}

void initOD(PGraphics p) {
  A = new PVector(random(1.0)*p.width, random(1.0)*p.height);
  B = new PVector(random(1.0)*p.width, random(1.0)*p.height);
}
