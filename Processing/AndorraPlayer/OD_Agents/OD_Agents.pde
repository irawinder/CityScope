boolean showSinks = false;
boolean showObstacles = false;

Swarm[] testSwarm;
Obstacle[] testWall;

PVector[] origin;
PVector[] destination;
float[] weight;

Path course1, course2;

PVector[] obPts;

void setup() {
  
  
  size(800, 800);

  reset();
  
}

void draw() {
  
  background(0);
  
  if (showSinks) {
    course1.display(#00FF00, 100);
    course2.display(#FF0000, 100);
  }
  
  if (showObstacles) {
    for (Obstacle o : testWall) {
      o.display(#0000FF, 100);
    }
  }
  
  for (Swarm s : testSwarm) {
    s.update();
    s.display();
  }
  
}

void reset() {
  
  int numSwarm = 20;
  
  origin = new PVector[numSwarm];
  destination = new PVector[numSwarm];
  weight = new float[numSwarm];
  
  for (int i=0; i<numSwarm; i++) {
    origin[i] = new PVector(random(width), random(height));
    destination[i] = new PVector(random(width), random(height));
    weight[i] = int(random(40));
  }
  
  // rate, life, origin, destination
  testSwarm = new Swarm[numSwarm];
  for (int i=0; i<numSwarm; i++) {
    testSwarm[i] = new Swarm(weight[i], origin[i], destination[i], numSwarm/(i+10.0), color(random(255), random(255), random(255)));
  }
  
  course1 = new Path(origin);
  course2 = new Path(destination);
  
  int u = 16;
  int v = 16;
  int l = 40;
  
  obPts = new PVector[4];
  for (int i=0; i<obPts.length; i++) {
    obPts[i] = new PVector(0,0);
  }
  
  testWall = new Obstacle[u*v];
  for (int i=0; i<u; i++) {
    for (int j=0; j<v; j++) {
      
      float x = float(width)*i/(u+1)+l/2.0;
      float y = float(height)*j/(v+1)+l/2.0;
      obPts[0].x = x;     obPts[0].y = y;
      obPts[1].x = x+l;   obPts[1].y = y;
      obPts[2].x = x+l;   obPts[2].y = y+l;
      obPts[3].x = x;     obPts[3].y = y+l;
      
      testWall[i*u + j] = new Obstacle(obPts);
    }
  }
  
//  for (int i=0; i < course1.origin.length; i++) {
//    println(i+1 + ": " + course1.origin[i].x + ", " + course1.origin[i].y);
//  }
}

void keyPressed() {
  
  switch (key) {
    case 'o':
      if (showObstacles) {
        showObstacles = false;
      } else {
        showObstacles = true;
      }
      break;
    case 'k':
      if (showSinks) {
        showSinks = false;
      } else {
        showSinks = true;
      }
      break;
    case 'r':
      reset();
      break;
  }
  
}
