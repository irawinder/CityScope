void drawLines(String filename, color c){ 
  println("rendering lines: ", filename); 
    Table values = loadTable(filename, "header");
    for(int i = 0; i<values.getRowCount()-1; i++){ 
         if(values.getInt(i, "shapeid") == values.getInt(i+1, "shapeid")){
                stroke(c);
                strokeWeight(1);
                PVector Start = mercatorMap.getScreenLocation(new PVector(values.getFloat(i, "y"), values.getFloat(i, "x")));
                PVector End = mercatorMap.getScreenLocation(new PVector(values.getFloat(i+1, "y"), values.getFloat(i+1, "x")));
                line(Start.x, Start.y, End.x, End.y);
            }      
               }    
       println("lines drawn: ", filename); 
}

void drawCurrentSelection(){
    top_left_corner = map.getScreenLocation(new PVector(minlat, maxlon)) ;
    bottom_right_corner =   map.getScreenLocation(new PVector(maxlat, minlon)) ;
    top_right_corner=   map.getScreenLocation(new PVector(maxlat, maxlon)) ;
    bottom_left_corner =   map.getScreenLocation(new PVector(minlat, minlon)) ;
    stroke(#ff0000);
    strokeWeight(2);
    line(top_left_corner.x, top_left_corner.y, bottom_left_corner.x, bottom_left_corner.y);
    line(top_left_corner.x, top_left_corner.y, top_right_corner.x, top_right_corner.y);
    line(bottom_left_corner.x, bottom_left_corner.y, bottom_right_corner.x, bottom_right_corner.y);
    line(top_right_corner.x, top_right_corner.y, bottom_right_corner.x, bottom_right_corner.y);
}
