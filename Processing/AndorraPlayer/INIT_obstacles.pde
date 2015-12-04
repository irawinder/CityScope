boolean showObstacles = false;
boolean editObstacles = false;
boolean testObstacles = false;

Obstacle[] testWall;
ObstacleCourse boundaries;

void initObstacles() {
  testObstacles(testObstacles);
  boundaries = new ObstacleCourse();
  
  boundaries.loadCourse("data/course.tsv");
  
  //boundaries.addObstacle();
  //boundaries.addVertex(new PVector(random(canvasWidth/2), random(canvasHeight/2)));
  //boundaries.addVertex(new PVector(random(canvasWidth/2, canvasWidth), random(canvasHeight/2)));
  //boundaries.addVertex(new PVector(random(canvasWidth/2, canvasWidth), random(canvasHeight/2, canvasHeight)));
  //boundaries.addVertex(new PVector(random(canvasWidth/2), random(canvasHeight/2, canvasHeight)));
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


