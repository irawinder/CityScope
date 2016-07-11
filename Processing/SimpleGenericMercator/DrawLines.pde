void drawLines(){
  println("lines rendering");
      for(int i = 0; i<roadnetwork.getRowCount()-1; i++){ 
         if(roadnetwork.getInt(i, "shapeid") == roadnetwork.getInt(i+1, "shapeid")){
                stroke(#00ffff);
                strokeWeight(.5);
                PVector Start = mercatorMap.getScreenLocation(new PVector(roadnetwork.getFloat(i, "y"), roadnetwork.getFloat(i, "x")));
                PVector End = mercatorMap.getScreenLocation(new PVector(roadnetwork.getFloat(i+1, "y"), roadnetwork.getFloat(i+1, "x")));
                line(Start.x, Start.y, End.x, End.y);
            }      
               }
               
  println("lines drawn");
}
