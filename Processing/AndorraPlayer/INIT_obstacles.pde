boolean showObstacles = false;
boolean editObstacles = false;
boolean testObstacles = false;

Obstacle[] testWall;
ObstacleCourse boundaries;
ObstacleCourse container;

void initObstacles() {
  testObstacles(testObstacles);
  boundaries = new ObstacleCourse();
  container = new ObstacleCourse();
  
  // Obstacles for agents generates within Andorra le Vella
  boundaries.loadCourse("data/course.tsv");
  
  // Obstacles for agents generated outside of Andorra le Vella (i.e. margins of table)
  //container.loadCourse("data/container.tsv");
  container.loadCourse("data/course.tsv");
  
//  container.addObstacle();
//  container.addVertex(new PVector(0.75*marginWidthPix, 0.75*marginWidthPix));
//  container.addVertex(new PVector(1.25*marginWidthPix + topoWidthPix, 0.75*marginWidthPix));
//  container.addVertex(new PVector(1.25*marginWidthPix + topoWidthPix, 1.25*marginWidthPix + topoHeightPix));
//  container.addVertex(new PVector(0.75*marginWidthPix, 1.25*marginWidthPix + topoHeightPix));
}

void testObstacles(boolean place) {
  if (place) {
    setObstacleGrid(32, 16);
  } else {
    setObstacleGrid(0, 0);
  }
}

void setObstacleGrid(int u, int v) {
  
  float w = 0.75*float(canvasWidth)/(u+1);
  float h = 0.75*float(canvasHeight)/(v+1);
  
  obPts = new PVector[4];
  for (int i=0; i<obPts.length; i++) {
    obPts[i] = new PVector(0,0);
  }
  
  testWall = new Obstacle[u*v];
  for (int i=0; i<u; i++) {
    for (int j=0; j<v; j++) {
      
      float x = float(canvasWidth)*i/(u+1)+w/2.0;
      float y = float(canvasHeight)*j/(v+1)+h/2.0;
      obPts[0].x = x;     obPts[0].y = y;
      obPts[1].x = x+w;   obPts[1].y = y;
      obPts[2].x = x+w;   obPts[2].y = y+h;
      obPts[3].x = x;     obPts[3].y = y+h;
      
      testWall[i*v + j] = new Obstacle(obPts);
      //testWall[i*v + j].addVertex(new PVector(x+w/2, y+h/2));
      //testWall[i*v + j].removeVertex();
      
    }
  }
}


