void drawLines(String filename, ArrayList<PVector> Coordinates, color c){ 
    Table values = loadTable(filename, "header");
    for(int i = 0; i<values.getRowCount()-1; i++){ 
         if(values.getInt(i, "shapeid") == values.getInt(i+1, "shapeid")){
                stroke(c);
                strokeWeight(1.5);
                line(Coordinates.get(i).x, Coordinates.get(i).y, Coordinates.get(i+1).x, (Coordinates.get(i+1).y));
            }      
               }
               
       println("lines drawn"); 
}


