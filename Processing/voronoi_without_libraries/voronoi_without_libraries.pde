Tower[] towers;

PVector coord;
PVector location;

void setup()
{
  size(1100,700);
  smooth();
  
  towers = new Tower[9];
  for(int i=0; i<towers.length; i++)
  {
    towers[i] = new Tower();
  }
}
 
void draw()
{
  println(frameRate);
  drawRegions();
  drawTowers();
  drawData();
  //drawTowers2();
}
 
void drawRegions()
{
  loadPixels(); // must call before using pixels[]
  
  for(int x=0; x<width; x++)
  {
    for(int y=0; y<height; y++)
    {
      float minDist = width+height;
      int closest = 0;
      for(int i=0; i<towers.length; i++)
      {
        Tower t = towers[i];
        float d = dist(x,y, t.x, t.y);
        if (d<minDist)
        {
          closest = i;
          minDist = d;
        }
      }
     
      pixels[y*width+x] = towers[closest].c;
    }
  }
  updatePixels(); // must call after using pixels[]
}
 
 //dealing with not testing pixels
 //polygons instead of regions
 //piggyback off Obstacle code 
   //Obstacle --> polygon/regions 
 //no running every frame 
 
void drawTowers()
{
  for(int i=0; i<towers.length; i++)
  {
    Tower t = towers[i];
    fill(255, 100); 
    ellipse(t.x, t.y, 15, 15);
  }
}

void drawTowers2()
{
  Table bigs = loadTable("data/bigs.csv", "header");
    for (int j=0;j<bigs.getRowCount();j++) {
    location = (new PVector(bigs.getFloat(j, "x"), bigs.getFloat(j, "y")));
    fill(0);
    ellipse(location.x, location.y, 7, 7);
    }
}
 
void drawData()
{
Table hotels = loadTable("data/hotels.csv", "header");
    for (int j=0;j<hotels.getRowCount();j++) {
    coord = (new PVector(hotels.getFloat(j, "x"), hotels.getFloat(j, "y")));
    ellipse(coord.x, coord.y, 7, 7);
    }
}


