//  Globals which should be set before calling these functions:
//
//int    polyCorners; //  =  how many corners the polygon has (no repeats)
//float  polyX[]    ; //      =  horizontal coordinates of corners
//float  polyY[]    ; //      =  vertical coordinates of corners
//float  x, y       ; //       =  point to be tested
//
//  The following global arrays should be allocated before calling these functions:
//
//float  constant[]; // = storage for precalculated constants (same size as polyX)
//float  multiple[]; // = storage for precalculated multipliers (same size as polyX)
//
//  (Globals are used in this example for purposes of speed.  Change as
//  desired.)
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
  
  
  int    polyCorners; //  =  how many corners the polygon has (no repeats)
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
      println("object has no area");
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
  
  void addVertex(PVector vert) {
    polyCorners++;
    if(index == v.size()-1) {
      v.add(vert);
    } else {
      v.add(afterIndex(), vert);
    }
    index = afterIndex();
    if (polyCorners > 2) {
      calc_lengths();
      precalc_values();
    }
  }
  
  void nudgeVertex(int x, int y) {
   PVector vert = v.get(index);
   vert.x += x;
   vert.y += y;
   
   v.set(index, vert);
  }
  
  void removeVertex(){
    if (polyCorners > 0) {
      polyCorners--;
      v.remove(index);
      index = priorIndex();
      if (polyCorners > 2) {
        calc_lengths();
        precalc_values();
      }
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
  
  PVector normalOfEdge(float x, float y, float vX, float vY) {
    if (polyCorners > 2) {
      PVector normal;
      PVector tangent;
      
      //approx length into which we divide obstacle edges
      int segmentLength = 20;
      float minDist = canvasWidth + canvasHeight;
      int closestEdge = 0;
      float x_seg, y_seg;
      
      float d;
      float[] dist = new float[polyCorners];
      
      for (int i=0; i<polyCorners; i++) {
          
        float seg = l.get(i)/segmentLength;
        dist[i] = canvasWidth + canvasHeight;
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
      
      tableCanvas.stroke(#FFFFFF);
      tableCanvas.strokeWeight(4);
      
      if (closestEdge < polyCorners - 1) {
        tangent = new PVector(v.get(closestEdge+1).x - v.get(closestEdge).x, v.get(closestEdge+1).y - v.get(closestEdge).y);
        //tableCanvas.line(v.get(closestEdge+1).x, v.get(closestEdge+1).y, v.get(closestEdge).x, v.get(closestEdge).y);
      } else {
        tangent = new PVector(v.get(0).x - v.get(closestEdge).x, v.get(0).y - v.get(closestEdge).y);
        //tableCanvas.line(v.get(0).x, v.get(0).y, v.get(closestEdge).x, v.get(closestEdge).y);
      }
      
  //    normal = new PVector(tangent.x, tangent.y);
  //    
  //    if ( (vX*vY < 0 && tangent.x*tangent.y > 0) || 
  //         (vX*vY > 0 && tangent.x*tangent.y < 0)     ) {
  //      normal.rotate(-PI/2);
  //    } else {
  //      normal.rotate(PI/2);
  //    }
  //    
  //    
  //    normal.mult(0.5);
  //    
  //    tangent.add(normal);
      
      return tangent;
    } else {
      return new PVector(0,0);
    }
    
  }
  
  void display(color stroke, int alpha, boolean editing) {
    
    if (drawOutline && polyCorners > 1) {
      // Draws Polygon Ouline
      for (int i=0; i<polyCorners; i++) {
        tableCanvas.stroke(stroke, alpha);
        if (i == polyCorners-1) {
          tableCanvas.line(v.get(i).x, v.get(i).y, v.get(0).x, v.get(0).y);
        } else {
          tableCanvas.line(v.get(i).x, v.get(i).y, v.get(i+1).x, v.get(i+1).y);
        }
      }
    }
    
    if (editing) {
      if (editObstacles && polyCorners > 0) {
        tableCanvas.stroke(#00FF00, alpha);
        tableCanvas.ellipse(v.get(index).x, v.get(index).y, 30, 30);
      } if (editObstacles && polyCorners > 1) {
        tableCanvas.line(v.get(index).x, v.get(index).y, v.get(afterIndex()).x, v.get(afterIndex()).y);
        tableCanvas.noStroke();
        tableCanvas.fill(stroke, alpha);
        tableCanvas.ellipse(v.get(afterIndex()).x, v.get(afterIndex()).y, 30/2, 30/2);
      }
    }
    
    if (drawFill && polyCorners > 1) {
      // Draws Polygon fill
      fill.beginDraw();
      
      for (int j=0; j<fill.width; j++) {
        for (int k=0; k<fill.height; k++) {
          if (pointInPolygon(j + minX, k + minY)) {
            fill.set(j, k, #333333);
          }
        }
      }
      fill.endDraw();
      
      tableCanvas.image(fill, minX, minY);
    }
    
  }
  
}
    
  
  
