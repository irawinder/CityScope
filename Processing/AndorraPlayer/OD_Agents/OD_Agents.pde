boolean showSinks = false;
boolean showObstacles = false;

Swarm[] testSwarm;
Obstacle[] testWall;

PVector[] origin;
PVector[] destination;
float[] weight;

// points for defining sample obstacles;
PVector[] points;

Path course1, course2;

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
  origin = new PVector[8];
  origin[0] = new PVector(random(width), random(height));
  origin[1] = new PVector(random(width), random(height));
  origin[2] = new PVector(random(width), random(height));
  origin[3] = new PVector(random(width), random(height));
  origin[4] = new PVector(random(width), random(height));
  origin[5] = new PVector(random(width), random(height));
  origin[6] = new PVector(random(width), random(height));
  origin[7] = new PVector(random(width), random(height));
  
  destination = new PVector[8];
  destination[0] = new PVector(random(width), random(height));
  destination[1] = new PVector(random(width), random(height));
  destination[2] = new PVector(random(width), random(height));
  destination[3] = new PVector(random(width), random(height));
  destination[4] = new PVector(random(width), random(height));
  destination[5] = new PVector(random(width), random(height));
  destination[6] = new PVector(random(width), random(height));
  destination[7] = new PVector(random(width), random(height));
  
  weight = new float[8];
  weight[0] = int(random(40));
  weight[1] = int(random(40));
  weight[2] = int(random(40));
  weight[3] = int(random(40));
  weight[4] = int(random(40));
  weight[5] = int(random(40));
  weight[6] = int(random(40));
  weight[7] = int(random(40));
  
  // rate, life, origin, destination
  testSwarm = new Swarm[8];
  for (int i=0; i<testSwarm.length; i++) {
    testSwarm[i] = new Swarm(weight[i], origin[i], destination[i], 2, color(random(255), random(255), random(255)));
  }
  
  course1 = new Path(origin);
  course2 = new Path(destination);
  
  points = new PVector[5];
  points[0] = new PVector(300, 300);
  points[1] = new PVector(350, 300);
  points[2] = new PVector(350, 380);
  points[3] = new PVector(325, 350);
  points[4] = new PVector(300, 350);
  
  testWall = new Obstacle[4];
  PVector shift;
  for (int i=0; i<testWall.length; i++) {
    testWall[i] = new Obstacle(points);
    shift = new PVector(random(-400, 400), random(-400, 400));
    for (int j=0; j<points.length; j++) {
      points[j].add(shift);
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
