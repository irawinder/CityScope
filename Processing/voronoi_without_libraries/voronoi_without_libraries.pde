Tower[] towers;
 
void setup()
{
  size(1100,700);
   
  smooth();
  towers = new Tower[10];
  for(int i=0; i<towers.length; i++)
  {
    towers[i] = new Tower();
  }
}
 
void draw()
{
  drawRegions();
  stroke(0);
  drawTowers();
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
 
void drawTowers()
{
  for(int i=0; i<towers.length; i++)
  {
    Tower t = towers[i];
    fill(255, 100); 
    ellipse(t.x, t.y, 6, 6);
  }
}
 
 
class Tower
{
  float x, y;
  color c;
   
  Tower()
  {
    x = random(width);
    y = random(height);
    c = color(random(255), random(255), random(255));
  }
   

}

