/*
Lots of conversion functions
*/

//Converts the users' selection box to a lat lon bounding box, returns an array of the corners and center
//left, bottom, right, top

public class bbox{
  public float minlon, minlat, maxlon, maxlat, w;
  FloatList bounds = new FloatList();
  
  bbox(float _minlon, float _minlat, float _maxlon, float _maxlat){
      minlon = _minlon;
      minlat = _minlat;
      maxlon = _maxlon;
      maxlat = _maxlat;
      
      w = mercatorMap.Haversine(new PVector(minlat, minlon), new PVector(minlat, maxlon));
   bounds.append(minlon);
   bounds.append(minlat);
   bounds.append(maxlon);
   bounds.append(maxlat);
  }
  
  public boolean inbbox(PVector point){
      boolean inbox;
      if(point.x > minlon && point.x < maxlon && point.y < maxlat && point.y > minlat){
          inbox = true;
      }
      else{
        inbox = false;
      }
      return inbox;
  }
  
  public void printbox(){
    println(minlon, minlat, maxlon, maxlat);
}

  public ArrayList<PVector> boxcorners(){
    ArrayList<PVector> corners = new ArrayList<PVector>();
      corners.add(new PVector(minlon, minlat));
      corners.add(new PVector(maxlon, minlat));
      corners.add(new PVector (maxlon, maxlat));
      corners.add(new PVector (minlon, maxlat));
      return corners;
  }

}

public ArrayList<PVector> SelectionBox() {
      ArrayList<PVector> box = new ArrayList<PVector>();
         float a = mouseX;
         float b = mouseY;
         float c = mouseX + boxw;
         float d = mouseY + boxh;
         PVector topleft = map.getLocation(a, b);
         PVector bottomright = map.getLocation(c, d);
         PVector topright = map.getLocation(c, b);
         PVector bottomleft = map.getLocation(a, d);
         PVector center = map.getLocation(mouseX + boxw/2, mouseY + boxh/2);
         box.add(topleft);
         box.add(bottomright);
         box.add(topright);
         box.add(bottomleft);
         box.add(center);
      return box;
};


public ArrayList<PVector> CanvasBox() {
      ArrayList<PVector> canvas = new ArrayList<PVector>();
         float a = 0;
         float b = 0;
         float c = width;
         float d = height;
         PVector topleft = map.getLocation(a, b);
         PVector bottomright = map.getLocation(c, d);
         canvas.add(topleft);
         canvas.add(bottomright);
      return canvas;
};

//this function gets the tile coordinates given the lat and lon of the center, as well as the zoom
//returns a string for utilization in the HTTP request link
//I actually want to return all the tiles in the current view, but only smartmesh one, but that calculation happens in the Bresenham with the bounding box
//remember that each tile is 256x256 pixels
 public static String getTileNumber(double lat, double lon, int zoom) {
   int xtile = (int)Math.floor( (lon + 180) / 360 * (1<<zoom) ) ;
   int ytile = (int)Math.floor( (1 - Math.log(Math.tan(Math.toRadians(lat)) + 1 / Math.cos(Math.toRadians(lat))) / Math.PI) / 2 * (1<<zoom) ) ;
    if (xtile < 0)
     xtile=0;
    if (xtile >= (1<<zoom))
     xtile=((1<<zoom)-1);
    if (ytile < 0)
     ytile=0;
    if (ytile >= (1<<zoom))
     ytile=((1<<zoom)-1);
    return("" + zoom + "/" + xtile + "/" + ytile);
   }
   
 public ArrayList<String> MapTiles(float w, float h, int offsetx, int offsety){
     int numcols = int(w/256) + 1;
     int numrows = int(h/256) + 2;
     int numcells = numcols*numrows;
     ArrayList<String>Tiles = new ArrayList<String>();
     ArrayList<PVector> Coords = new ArrayList<PVector>();
     
       for(int k = offsety-1; k<numrows+2; k++){
         for(int j = offsetx-1; j<numcols+1; j++){
             PVector coord = new PVector(j*256 + 128 + offsetx, k*256 + 128 + offsety);
             Coords.add(map.getLocation(coord.x, coord.y));
         }
     }

    for(int i = 0; i<numcells; i++){
        Tiles.add(getTileNumber(Coords.get(i).x, Coords.get(i).y, map.getZoomLevel()));
    }
    
    return Tiles;
 }  
