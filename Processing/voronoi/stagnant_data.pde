void drawData(){ 
    Table hotels = loadTable("data/hotels.csv", "header");
    for (int i=0;i<hotels.getRowCount();i++) {
    float lat = hotels.getFloat(i, "x");
    float lon = hotels.getFloat(i, "y");
    ellipse(lat, lon, 7, 7);
    fill(0);
  }
}
