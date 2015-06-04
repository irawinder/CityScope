Table kendall;

  // 0 = Ground: Open
  // -1 = Ground: Street
  // -2 = Ground: Park
  // -3 = Water
  
void setup() {
  // Static Forms: 
  // 192x192 matrices that describe heights (LU) of Legotized Kendall Square Model 
  // (does not include/account for plastic grid spacers)  
  kendall = loadTable("staticStructures/staticStructures.tsv");
  
  for (int i=0; i < kendall.getRowCount(); i++) {
    for (int j=0; j < kendall.getColumnCount(); j++) {
      
      if (kendall.getInt(i,j) > 0) { // Has Building
        kendall.setInt(i, j, kendall.getInt(i,j)/3);
      }
      

      
      //println(kendall.getInt(i,j));
      
    }
  }
  
  saveTable(kendall, "staticStructures.tsv");
}

void draw() {
}

