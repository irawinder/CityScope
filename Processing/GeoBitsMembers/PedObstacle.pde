//  The following class allows a user to define a polygon in 2D space.  
//  Key utility method of the class allows one to test whether or not a point lies inside or outside of the polygon
//
//  USAGE:
//  Call precalc_values() to initialize the constant[] and multiple[] arrays,
//  then call pointInPolygon(x, y) to determine if the point is in the polygon.
//
//  The function will return YES if the point x,y is inside the polygon, or
//  NO if it is not.  If the point is exactly on the edge of the polygon,
//  then the function may return YES or NO.
//
//  Note that division by zero is avoided because the division is protected
//  by the "if" clause which surrounds it.
  
class Obstacle {
  
  //PVector[] vertices;
  
  //vertices and of a polygon obstacles
  ArrayList<PVector> v;
  
  //lengths of side of a polygon obstacle
  ArrayList<Float> l;
  
  boolean active = true;
  
  boolean drawOutline;
  boolean drawFill;
  
  
  int polyCorners; //  =  how many corners the polygon has (no repeats)
  int index;
  float minX, minY, maxX, maxY;
  
  // Graphics object to hold fill information
  PGraphics fill;
  
  //
  //  The following global arrays should be allocated before calling these functions:
  //
  ArrayList<Float>  constant; // = storage for precalculated constants (same size as polyX)
  ArrayList<Float>  multiple; // = storage for precalculated multipliers (same size as polyX)
  
  Obstacle (PVector[] vert) {
    
    v = new ArrayList<PVector>();
    l = new ArrayList<Float>();
    
    constant = new ArrayList<Float>();
    multiple = new ArrayList<Float>();
    
    drawOutline = true;
    drawFill = false;
    
    polyCorners = vert.length;
    index = 0;
    
    for (int i=0; i<vert.length; i++) {
      v.add(new PVector(vert[i].x, vert[i].y));
    }
    
    if (polyCorners > 2) {
      fillGraphic(v);
    
      calc_lengths();
      precalc_values();
    }
    
  }
  
  Obstacle () {

    v = new ArrayList<PVector>();
    l = new ArrayList<Float>();
    
    constant = new ArrayList<Float>();
    multiple = new ArrayList<Float>();
    
    drawOutline = true;
    
    polyCorners = 0;
    index = 0;
      
    }
  
  void calc_lengths() {
    
    l.clear();
    
    // Calculates the length of each edge in pixels
    for (int i=0; i<v.size(); i++) {
      if (i < v.size()-1 ){
        l.add(sqrt( sq(v.get(i+1).x-v.get(i).x) + sq(v.get(i+1).y-v.get(i).y)));
      } else {
        l.add(sqrt( sq(v.get(0).x-v.get(i).x) + sq(v.get(0).y-v.get(i).y)));
      }
    }
  }
  
  void nextIndex() {
    index = afterIndex();
  }
  
  int priorIndex() {
    if (v.size() == 0) {
      return 0;
    } else if (index == 0) {
      return v.size()-1;
    } else {
      return index - 1;
    }
  }
  
  int afterIndex() {
    if (v.size() == 0) {
      return 0;
    } else if (index >= v.size()-1) {
      return 0;
    } else {
      return index + 1;
    }
  }
  
  void fillGraphic(ArrayList<PVector> v) {
    for (int i=0; i<v.size(); i++) {
      
      //Determins max extents of polygon
      if (i==0) {
        minX = v.get(i).x;
        minY = v.get(i).y;
        maxX = v.get(i).x;
        maxY = v.get(i).y;
      } else {
        
        if (minX > v.get(i).x) {
          minX = v.get(i).x;
        } else if (maxX < v.get(i).x) {
          maxX = v.get(i).x;
        }
        
        if (minY > v.get(i).y) {
          minY = v.get(i).y;
        } else if (maxY < v.get(i).y) {
          maxY = v.get(i).y;
        }
        
      }
      
    }

    // Creates the smallest possible rectilinear graphics object that holds the polygon
    if (maxX-minX > 0 && maxY-minY > 0) {
      fill = createGraphics(int(maxX-minX), int(maxY-minY));
      //println("Fill Size: " + fill.width + ", " + fill.height);
    } else {
      createGraphics(1,1);
      //println("object has no area");
    }
  }
  
  void precalc_values() {
  
    int   i, j=polyCorners-1 ;
  
    constant.clear();
    multiple.clear();
  
    for(i=0; i<polyCorners; i++) {
      if(v.get(j).y==v.get(i).y) {
        constant.add(v.get(i).x);
        multiple.add(0.0); 
      } else {
        constant.add(v.get(i).x-(v.get(i).y*v.get(j).x)/(v.get(j).y-v.get(i).y)+(v.get(i).y*v.get(i).x)/(v.get(j).y-v.get(i).y));
        multiple.add((v.get(j).x-v.get(i).x)/(v.get(j).y-v.get(i).y)); 
      }
      j=i; 
    }
  }

  
  boolean pointInPolygon(float x, float y) {
    
    if (polyCorners > 2) {
      int   i, j = polyCorners-1;
      boolean  oddNodes = false;
    
      for (i=0; i<polyCorners; i++) {
        if ((v.get(i).y< y && v.get(j).y>=y
        ||   v.get(j).y< y && v.get(i).y>=y)) {
          oddNodes^=(y*multiple.get(i)+constant.get(i)<x); 
        }
        j=i; 
      }
    
      return oddNodes; 
    } else {
      return false;
    }
  
  }
  
  // Outputs a vector normal to the closest obstacle edge segment relative to a givent point with velocity
  PVector normalOfEdge(float x, float y, float vX, float vY) {
    if (polyCorners > 2) {
      PVector normal;
      PVector tangent;
      
      //approx length into which we divide obstacle edges
      int segmentLength = 20;
      float minDist = Float.MAX_VALUE;
      int closestEdge = 0;
      float x_seg, y_seg;
      
      float d;
      float[] dist = new float[polyCorners];
      
      for (int i=0; i<polyCorners; i++) {
          
        float seg = l.get(i)/segmentLength;
        dist[i] = Float.MAX_VALUE;
        for (int j=0; j<seg; j++) {
          if (i < polyCorners-1) {
            x_seg = v.get(i).x + float(j)/seg*(v.get(i+1).x-v.get(i).x);
            y_seg = v.get(i).y + float(j)/seg*(v.get(i+1).y-v.get(i).y);
            //tableCanvas.ellipse(x_seg, y_seg, 10, 10);
          } else {
            x_seg = v.get(i).x + j/seg*(v.get(0).x-v.get(i).x);
            y_seg = v.get(i).y + j/seg*(v.get(0).y-v.get(i).y);
            //tableCanvas.ellipse(x_seg, y_seg, 10, 10);
          }
          d = sqrt( sq(x_seg-x) + sq(y_seg-y));
          if (dist[i] > d) {
            dist[i] = d;
          } 
        }
        
        // Sets 
        if (minDist > dist[i]) {
          minDist = dist[i];
          closestEdge = i;
        }
      }
      
      //tableCanvas.stroke(textColor);
      //tableCanvas.strokeWeight(4);
      
      if (closestEdge < polyCorners - 1) {
        tangent = new PVector(v.get(closestEdge+1).x - v.get(closestEdge).x, v.get(closestEdge+1).y - v.get(closestEdge).y);
        //tableCanvas.line(v.get(closestEdge+1).x, v.get(closestEdge+1).y, v.get(closestEdge).x, v.get(closestEdge).y);
      } else {
        tangent = new PVector(v.get(0).x - v.get(closestEdge).x, v.get(0).y - v.get(closestEdge).y);
        //tableCanvas.line(v.get(0).x, v.get(0).y, v.get(closestEdge).x, v.get(closestEdge).y);
      }

      
      return tangent;
    } else {
      return new PVector(0,0);
    }
    
  }
  
}

  
