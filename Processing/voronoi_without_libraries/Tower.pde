PVector locations;

class Tower
{
  float x, y;
  color c;
   
  Tower ()
  {
    Table bigs = loadTable("data/bigs.csv", "header");
     for (int j=0;j<bigs.getRowCount();j++) {
       locations = (new PVector(bigs.getFloat(j, "x"), bigs.getFloat(j, "y")));
     }
     
     for(int i = 0; i<9; i++){
     x = random(width); 
     }
     
     for(int k = 0; k<9; k++){
     y = random(height);
     }
     
    c = color(random(255), random(255), random(255));
  }
}
