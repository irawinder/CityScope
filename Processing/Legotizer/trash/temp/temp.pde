Table building_heights, river_heights, RoadMap;

Table kendall;

  // 0 = Ground: Open
  // -1 = Ground: Street
  // -2 = Ground: Park
  // -3 = Water
  
void setup() {
  // Static Forms: 
  // 192x192 matrices that describe heights (LU) of Legotized Kendall Square Model 
  // (does not include/account for plastic grid spacers)  
  building_heights = loadTable("staticStructures/building_heights.tsv");
  river_heights = loadTable("staticStructures/river_heights.tsv");
  RoadMap = loadTable("staticStructures/RoadMap.tsv");
  
  kendall = loadTable("staticStructures/building_heights.tsv");
  
  println(kendall.getRowCount());
  println(kendall.getColumnCount());
  println(river_heights.getRowCount());
  println(river_heights.getColumnCount());
  
  
  for (int i=0; i < kendall.getRowCount(); i++) {
    for (int j=0; j < kendall.getColumnCount(); j++) {
      
      if (kendall.getInt(i,j) == 0) { // NoBuilding
        if (river_heights.getInt(i,j) == 0) { // Is River
          kendall.setInt(i,j,-3); //Changes River to mean '-3'
        } else if (RoadMap.getInt(i,j) == 0) { // Is Road
          kendall.setInt(i,j,-1); //Changes st to mean '-1'
        }
      
      } else {
        kendall.setInt(i,j,3*kendall.getInt(i,j)); //Multiplies Kendall heights by 3
      }
      

      
      //println(kendall.getInt(i,j));
      
    }
  }
  
  saveTable(kendall, "static_kendall.tsv");
}

void draw() {
}

