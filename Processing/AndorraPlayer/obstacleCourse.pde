boolean mainCourse = true;

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
  
  void nextVert() {
    Obstacle o = course.get(index);
    o.nextIndex();
    course.set(index, o);
  }
  
  void addVertex(PVector vert) {
    if (course.size() == 0) {
      addObstacle();
    }
    Obstacle o = course.get(index);
    o.addVertex(vert);
    course.set(index, o);
  }
  
  void nudgeVertex(int x, int y) {
    Obstacle o = course.get(index);
    o.nudgeVertex(x, y);
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
        // Applies unique forcevector if collision detected....not so great
        //v.roll(course.get(i).normalOfEdge(v.location.x, v.location.y, v.velocity.x, v.velocity.y));
        break;
      }
    }
    
    return collision;
  }
  
  boolean testForCollision(PVector v) {
    
    boolean collision = false;
    
    // Tests for Collision with Agent of known location and velocity
    for (int i=0; i<numObstacles; i++) {
      if (course.get(i).pointInPolygon(v.x, v.y) ) {
        collision = true;
        break;
      }
    }
    
    return collision;
  }
  
  void display(color stroke, int alpha) {
    for (int i=0; i<course.size(); i++) {
      if (i == index && editObstacles) {
        tableCanvas.strokeWeight(2);
        course.get(i).display(#FFFF00, alpha, true);
        tableCanvas.strokeWeight(1);
      } else {
        course.get(i).display(stroke, alpha, false);
      }
    }
  }
  
  void saveCourse(String filename) {
    Table courseTSV = new Table();
    courseTSV.addColumn("obstacle");
    courseTSV.addColumn("vertX");
    courseTSV.addColumn("vertY");
  
    for (int i=0; i<course.size(); i++) {
      for (int j=0; j<course.get(i).polyCorners; j++) {
        TableRow newRow = courseTSV.addRow();
        newRow.setInt("obstacle", i);
        newRow.setFloat("vertX", (1920.0/projectorWidth)*course.get(i).v.get(j).x);
        newRow.setFloat("vertY", (1920.0/projectorWidth)*course.get(i).v.get(j).y);
      }
    }
    
    saveTable(courseTSV, filename);
    
    println("ObstacleCourse data saved to '" + filename + "'");
    
  }
  
  // filename = "data/course.tsv"
  void loadCourse(String filename) {
    
    Table courseTSV;
    
    try {
      courseTSV = loadTable(filename, "header");
      println("Obstacle Course Loaded from " + filename);
    } catch(RuntimeException e){
      courseTSV = new Table();
      println(filename + " incomplete file");
    }
      
    int obstacle;
    
    if (courseTSV.getRowCount() > 0) {
      
      while (numObstacles > 0) {
        removeObstacle();
      }
      
      obstacle = -1;
      
      for (int i=0; i<courseTSV.getRowCount(); i++) {
        if (obstacle != courseTSV.getInt(i, "obstacle")) {
          obstacle = courseTSV.getInt(i, "obstacle");
          addObstacle();
        }
        //addVertex(new PVector(courseTSV.getFloat(i, "vertX"), courseTSV.getFloat(i, "vertY")));
        //addVertex(new PVector((projectorWidth/1000.0)*courseTSV.getFloat(i, "vertX"), (projectorWidth/1000.0)*courseTSV.getFloat(i, "vertY")));
        addVertex(new PVector((projectorWidth/1920.0)*courseTSV.getFloat(i, "vertX"), (projectorWidth/1920.0)*courseTSV.getFloat(i, "vertY")));
      }
      
    }
  }
}
