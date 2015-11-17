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
  
  PVector[] vertices;
  
  boolean active = true;
  
  boolean drawOutline;
  boolean drawFill;
  
  
  int    polyCorners; //  =  how many corners the polygon has (no repeats)
  float  polyX[]    ; //      =  horizontal coordinates of corners
  float  polyY[]    ; //      =  vertical coordinates of corners
  //float  x, y     ; //       =  point to be tested
  float minX, minY, maxX, maxY;
  
  // Graphics object to hold fill information
  PGraphics fill;
  
  //
  //  The following global arrays should be allocated before calling these functions:
  //
  float  constant[]; // = storage for precalculated constants (same size as polyX)
  float  multiple[]; // = storage for precalculated multipliers (same size as polyX)
  
  Obstacle (PVector[] vert) {
    
    vertices = new PVector[vert.length];
    polyCorners = vertices.length;
    polyX  = new float[polyCorners];
    polyY  = new float[polyCorners];
    constant = new float[polyCorners];
    multiple = new float[polyCorners];
    
    drawOutline = true;
    drawFill = false;
    
    for (int i=0; i<vert.length; i++) {
      vertices[i] = new PVector(vert[i].x, vert[i].y);
      polyX[i] = vert[i].x;
      polyY[i] = vert[i].y;
      
      //Determins max extents of polygone
      if (i==0) {
        minX = vert[i].x;
        minY = vert[i].y;
        maxX = vert[i].x;
        maxY = vert[i].y;
      } else {
        
        if (minX > vert[i].x) {
          minX = vert[i].x;
        } else if (maxX < vert[i].x) {
          maxX = vert[i].x;
        }
        
        if (minY > vert[i].y) {
          minY = vert[i].y;
        } else if (maxY < vert[i].y) {
          maxY = vert[i].y;
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
    
    precalc_values();
    
  }
  
  void precalc_values() {
  
    int   i, j=polyCorners-1 ;
  
    for(i=0; i<polyCorners; i++) {
      if(polyY[j]==polyY[i]) {
        constant[i]=polyX[i];
        multiple[i]=0; 
      } else {
        constant[i]=polyX[i]-(polyY[i]*polyX[j])/(polyY[j]-polyY[i])+(polyY[i]*polyX[i])/(polyY[j]-polyY[i]);
        multiple[i]=(polyX[j]-polyX[i])/(polyY[j]-polyY[i]); 
      }
      j=i; 
    }
  }
  
  boolean pointInPolygon(float x, float y) {
  
    int   i, j = polyCorners-1;
    boolean  oddNodes = false;
  
    for (i=0; i<polyCorners; i++) {
      if ((polyY[i]< y && polyY[j]>=y
      ||   polyY[j]< y && polyY[i]>=y)) {
        oddNodes^=(y*multiple[i]+constant[i]<x); 
      }
      j=i; 
    }
  
    return oddNodes; 
  
  }
  
  PVector normalOfEdge(float x, float y, float vX, float vY) {
    
    PVector[] vert = new PVector[2];
    PVector normal;
    float[] dist = new float[2];
    float dist_temp;
    int bigger;
    
    // populates with first two points
    vert[0] = new PVector(vertices[0].x,vertices[0].y);
    vert[1] = new PVector(vertices[1].x,vertices[1].y);
    dist[0] = abs(x-vertices[0].x) + abs(y-vertices[0].y);
    dist[1] = abs(x-vertices[1].x) + abs(y-vertices[1].y);
    
    if (dist[0] > dist[1]) {
      bigger = 0;
    } else {
      bigger = 1;
    }
    
    for (int i=2; i<polyCorners; i++) {
      dist_temp = abs(x-vertices[i].x) + abs(y-vertices[i].y);
      
      if (bigger == 1)
      
      if (dist_temp < dist[bigger]) {
        dist[bigger] = dist_temp;
        vert[bigger].x = vertices[i].x;
        vert[bigger].y = vertices[i].y;
        //println("vert0: " + vert[0].x + ", " + vert[0].y);
        //println("vert1: " + vert[1].x + ", " + vert[1].y);
      }
      
      if (dist[0] > dist[1]) {
        bigger = 0;
      } else {
        bigger = 1;
      }
    }
    
    normal = new PVector(vert[0].x-vert[1].x, vert[0].y-vert[1].y);
    
    
//    if ( (vX*vY < 0 && normal.x*normal.y > 0) || 
//         (vX*vY > 0 && normal.x*normal.y < 0)     ) {
//      normal.rotate(PI);
//    } else {
//      normal.rotate(-PI);
//    }
    
    return normal;
    
  }
  
  void display(color stroke, int alpha) {
    
    if (drawOutline) {
      // Draws Polygon Ouline
      for (int i=0; i<polyCorners; i++) {
        stroke(stroke, alpha);
        if (i == polyCorners-1) {
          line(vertices[i].x, vertices[i].y, vertices[0].x, vertices[0].y);
        } else {
          line(vertices[i].x, vertices[i].y, vertices[i+1].x, vertices[i+1].y);
        }
      }
    }
    
    if (drawFill) {
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
      
      image(fill, minX, minY);
    }
    
  }
  
}
    
  
  
