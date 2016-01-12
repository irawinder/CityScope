//import library mesh by 
import megamu.mesh.*;

Table towers; 
int tower_amount;

void initData(){
towers = loadTable("data/towers.csv", "header");
tower_amount = towers.getRowCount();
}

void setup(){ 
size(1200 , 800);
smooth();
}

void draw(){
background(255);
float[][] points = new float [tower_amount][2]; // [point] [0 for x, 1 for y]
for(int i = 0; i<tower_amount; i++){ 
  points[i][0] = towers.getFloat(i, "x");
  points[i][1] = towers.getFloat(i, "y");
}
/*
points[0][1] = 150;
points[0][0] = 120; 
points[0][1] = 150; 
points[1][0] = 150; 
points[1][1] = 700;
points[2][0] = 320;
points[2][1] = 113;
points[3][0] = width/2; 
points[3][1] = height/2;
*/

Voronoi Andorra = new Voronoi(points);
MPolygon[] Regions = Andorra.getRegions();

for(int i=0; i<Regions.length; i++)
{
  float[][] regionCoordinates = Regions[i].getCoords();
  fill(0, 250, 0);
  Regions[i].draw(this);
}

float[][] Edges = Andorra.getEdges();

for(int i=0; i<Edges.length; i++)
{
  float startX = Edges[i][0];
  float startY = Edges[i][1];
  float endX = Edges[i][2];
  float endY = Edges[i][tower_amount];
  line(startX, startY, endX, endY);
}
}


