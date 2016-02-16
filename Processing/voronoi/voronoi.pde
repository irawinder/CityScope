/* 
Draws a voronoi diagram with points from a dummy spreadsheet 
Utilizes toxiclibs library to render voronoi and clip polygons off screen as needed 

Have...
ArrayList of Polygons
ArrayList of Towers


TO DO 
-Enhance so it can work with real data and return regions
-Implement in Agent Demo 
*/


Table towers;
;
int width = 1200;
int height = 900;
Vec2D tower;

void setup() {
 Table towers = loadTable("data/towers.csv", "header");
 size(width, height);
 setupVoronoi(); 
 println(frameRate);
 int num = towers.getRowCount(); //number of total points
 background(255);
//gets points for voronoi  
   for (int i=0;i<num;i++){
      float x = towers.getFloat(i, "x");//random(0,width);
      float y= towers.getFloat(i, "y");//random(0,height);
      tower = (new Vec2D(towers.getFloat(i, "x"), towers.getFloat(i, "y")));
      voronoi.addPoint(new Vec2D(x,y));
  }
   drawVoronoi();
   //drawData();
}
