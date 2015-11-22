class ObstacleCourse {
  
  ArrayList<Obstacle> course;
  int index;
  int numObstacles;
  
  ObstacleCourse() {
    index = 0;
    numObstacles = 0;
    course = new ArrayList<Obstacle>();
  }
  
  void nextIndex() {
    if (index == course.size()-1) {
      index = 0;
    } else {
      index++;
    }
  }
  
  void addVertex(PVector vert) {
    if (course.size() == 0) {
      addObstacle();
    }
    Obstacle o = course.get(index);
    o.addVertex(vert);
    course.set(index, o);
  }
  
  void removeVertex() {
    Obstacle o = course.get(index);
    o.removeVertex();
    course.set(index, o);
  }
  
  void addObstacle() {
    course.add(new Obstacle());
    numObstacles++;
    if (index == numObstacles-2) {
      index++;
    }
  }
  
  void removeObstacle() {
    if (numObstacles > 0) {
      course.remove(index);
      numObstacles--;
      if (index == numObstacles && index != 0) {
        index--;
      }
    }
  }
  
  boolean testForCollision(Agent v) {
    
    boolean collision = false;
    
    // Tests for Collision with Agent of known location and velocity
    for (int i=0; i<numObstacles; i++) {
      if (course.get(i).pointInPolygon(v.location.x, v.location.y) ) {
        collision = true;
        v.roll(course.get(i).normalOfEdge(v.location.x, v.location.y, v.velocity.x, v.velocity.y));
        break;
      }
    }
    
    return collision;
  }
  
  void display(color stroke, int alpha) {
    
    for (int i=0; i<course.size(); i++) {
      if (i == index) {
        strokeWeight(2);
        course.get(i).display(#FFFF00, alpha);
        strokeWeight(1);
      } else {
        course.get(i).display(stroke, alpha);
      }
    }
    
  }
  
}
