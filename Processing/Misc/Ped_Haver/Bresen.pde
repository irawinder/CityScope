/*
Bresenham Algorithm Demo 
  by Nina Lutz, nlutz@mit.edu               MIT Media Lab, Summer 2016
  Supervisor: Ira Winder, jiw@mit.edu       MIT Media Lab

NOTE: This code may still be condensed 
  
The bresenham algorithm is a classic algorithm used in early computer graphics. It renders a line on rasterized (gridded) space. 
The algorithm takes in a start and end point and finds all the points between them at the scale that the user sets. 

This implementation takes in a csv with a series of points. I arranged them into seperate lines, each with a unique id. 
If you want to use the code exactly, name your columns "shapeid" for the line id number, "x" for your x coordinate and "y" for your y coordinate

I chose to draw a grid of ellipses, becuase I use this alogirthm in a path finding network over pedestrian paths and ellipses are easier for visual confirmation, but you can use squares
*/

//lines should have an ID, I call it "shapeid" because this matches most GeoSpatial data structures from programs like QGIS 

//set a scale for your grid; this is the weight of each raster cell
float scale;
 
//global variables for rendering lines
PVector start, end;
float x, y, x1, x2, y1, y2, dx, dy, Steps, xInc, yInc;
ArrayList<PVector> Coordinates = new ArrayList<PVector>();
ArrayList<PVector> SnapGrid = new ArrayList<PVector>();

class bresenham{
  
void bresenham(String filename, ArrayList<PVector> xylist){
        background(0);
        Table network = loadTable(filename, "header");

  for(int i = 0; i<network.getRowCount()-1; i++){
       //initialize start and end points and put them into PVectors
        x1 = xylist.get(i).x;
        x2 = xylist.get(i+1).x;
        y1 = xylist.get(i).y;
        y2 = xylist.get(i+1).y;
        
        start = new PVector(x1, y1);
        end = new PVector(x2, y2);
        
        //these are what will be rendered between the start and end points, initialize at start
        x = start.x;
        y = start.y;
        
        //calculating the change in x and y across the line
        dx = abs(end.x - start.x);
        dy = abs(end.y - start.y);
        
        //number of steps needed, based on what change is biggest
        //depending on your need for accuracy, you can adjust this, the smaller the Steps number, the fewer points rendered
        if(dx > dy){
          Steps = dx;
        }
        else{
          Steps = dy;        
        }
          
        //x and y increments for the points in the line      
        float xInc = (dx)/(Steps);
        float yInc = (dy)/(Steps);
        
        //this is the code to render vertical and horizontal lines, which need to be handled differently at different resolution for my implementation
                if(x1 == x2 || y1 == y2){
                       if (y2 < y1 || x2 < x1) {
                          start = new PVector(x2, y2);
                          end = new PVector(x1, y1);
                        }
            
                        else{
                          start = new PVector(x1, y1);
                          end = new PVector(x2, y2);
                        }
        
                        //slopes of the lines
                        dx = abs(end.x - start.x);
                        dy = abs(end.y - start.y);
                      
                        //steps needed to render the lines
                        if (dx > dy) {
                          Steps = dx/4;
                        } else {
                          Steps = dy/4;
                        }
                      
                        //increments for the points on the line 
                         xInc =  dx/(Steps);
                         yInc = dy/(Steps);
                      
                        //sets a starting point
                        x = start.x;
                        y = start.y;  
                 }

        //focuses on finding coordinates of diagnol lines
          for(int v = 0; v< (int)Steps; v++){       
                //there are four main cases that need to be handled
                      if(end.x < start.x && end.y < start.y){
                           x = x - xInc;    y = y - yInc;
                                }
                      else if(end.y < start.y){
                           x = x + xInc;    y = y - yInc;
                                }  
                      else if(end.x < start.x){
                           x = x - xInc;    y = y + yInc;
                                }
                      else{ 
                           x = x + xInc;    y = y + yInc;
                             }
                             
                    //this add the values to the array if they're in different lines  
                    if(network.getInt(i, "shapeid") == network.getInt(i+1, "shapeid")){    
                        if(x <= max(x1, x2) && y<= max(y1, y2) && x >= min(x1, x2) && y >= min(y1, y2) 
                        && x >= 0 && x <= Canvaswidth && y >= 0 && y<= Canvasheight){
                          
                          if(filename == "data/pednetv2nodes.csv"){
                        Coordinates.add(new PVector(x, y, 0));
                          }
                          else{
                            Coordinates.add(new PVector(x, y, 1));
                            }
                        }
                    }           
              }
  }
   println(Coordinates.size() + " possible nodes on or tangent to line" + "   framerate: " + frameRate);
}

void clean(ArrayList list){
            HashSet set = new HashSet(list);
            list.clear();
            list.addAll(set);
            
            println(Coordinates.size() + " possible nodes after cleaning");
}
  
  void draw_grid(){
  //intialize grid variables, with U as x and V as y renderers
   int U = int(width/scale);
   int V = int(height/scale);
   //this is based off the scale int that is initialized at the top of this sketch 
   float SCALE = scale;
   println("rendering grid");
           
       //iterates through and draws the grid
        for (int i=0; i<U; i++) {
            for (int j=0; j<V; j++) {
                float a = (i*SCALE + scale);
                float b = (j*SCALE + scale);
                
                //this is where I chose to render the grid as ellipses
                stroke(50);
                noFill();
                strokeWeight(.5);
                ellipse(a, b, scale, scale);  

                //compare grid values to Coordinates and color the grid cells that correspond to the lines 
                 for(int k = 0; k<Coordinates.size()-1; k++){
                      if(abs(a - Coordinates.get(k).x) <= scale/2 && abs(b - Coordinates.get(k).y) <= scale/2){
                            strokeWeight(.5);
                            stroke(#FFE066);
                            ellipse(a, b, scale, scale);
                            SnapGrid.add(Coordinates.get(k));
                      }
                    }  
              }
            }

  }
  

  

}
