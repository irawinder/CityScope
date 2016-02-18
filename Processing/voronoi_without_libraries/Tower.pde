class Tower
{
  float x, y;
  color c;
   
  Tower()
  {
    Table bigs = loadTable("data/bigs.csv", "header");
    for (int j=0;j<bigs.getRowCount();j++) {
    x = bigs.getFloat(j, "x");
    y = bigs.getFloat(j, "y");
    }
    
    c = color(random(255), random(255), random(255));
    
  }

}
