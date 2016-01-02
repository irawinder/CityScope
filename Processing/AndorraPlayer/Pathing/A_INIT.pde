//------------- Initialize Pathfinding Objects

Pathfinder finderTopo, finderMargin;

// Pathfinder test and debugging Objects
Pathfinder finderTest;
PVector A, B;
ArrayList<PVector> testPath;

void initPathfinder(PGraphics p, int res) {
  finderTopo = new Pathfinder(p.width, p.height, res, boundaries);
  finderMargin = new Pathfinder(p.width, p.height, res, container);
  
  finderTest = new Pathfinder(p.width, p.height, res, 0.5);
  pathTest(p, finderTest);
}

void pathTest(PGraphics p, Pathfinder finder) {
  A = new PVector(random(1.0)*p.width, random(1.0)*p.height);
  B = new PVector(random(1.0)*p.width, random(1.0)*p.height);
  testPath = finder.findPath(A, B);
}
