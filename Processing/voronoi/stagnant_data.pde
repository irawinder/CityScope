Vec2D coord; 

void drawData(){ 
    Table hotels = loadTable("data/hotels.csv", "header");
    for (int j=0;j<hotels.getRowCount();j++) {
    coord = (new Vec2D(hotels.getFloat(j, "x"), hotels.getFloat(j, "y")));
    ellipse(coord.x, coord.y, 7, 7);
    fill(0);
    for (Polygon2D poly : voronoi.getRegions()) {
    /*if (doClip) {
     gfx.polygon2D(clip.clipPolygon(poly));
    } 
    else {
      gfx.polygon2D(poly);
    }
    */
    
    if(poly.containsPoint(coord) == true){
    fill(255, 0, 0);
    }
    }
  }
}

