/* 
Draws a voronoi diagram with points from a dummy spreadsheet 
Utilizes toxiclibs library to render voronoi and clip polygons off screen as needed 


TO DO 
-Be less dependent on library
-Enhance so it can work with real data and return regions
-Give regions IDs
-Arraylists with data and voronoi, etc
-Implement in Agent Demo 
*/

Table towers;
Table hotels;
int width = 1200;
int height = 900;

void setup() {
 Table towers = loadTable("data/towers.csv", "header");
 size(width, height);
 setupVoronoi(); 
 int pointNum = towers.getRowCount(); //number of total points
 background(255);
//gets points for voronoi  
   for (int i=0;i<pointNum;i++){
      float x = towers.getFloat(i, "x");//random(0,width);
      float y= towers.getFloat(i, "y");//random(0,height);
      voronoi.addPoint(new Vec2D(x,y));
  }
   drawVoronoi();
   drawData();
//going to have to get points here for stagnant data
}

