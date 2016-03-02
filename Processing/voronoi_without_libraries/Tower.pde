
class Tower
{
  float x, y;
  color c;
   
  Tower ()
  {
     x = random(width); 

     y = random(height);
     
    c = color(random(255), random(255), random(255));
  }
}
