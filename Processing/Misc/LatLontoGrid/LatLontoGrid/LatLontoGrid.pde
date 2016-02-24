// Function to take Latitude Longitude (along with rotation grid h/w and grid size) 
// to return the index the point on the table grid.

//Azimuth in degrees, gridsize in km/stud.


//possible issue with y being positive while v needs to be negative
//possible issue with kmperLon although the geometry seems right


int[] LatLontoGrid(float lat, float lon, float centerLat, float centerLon, float azm, float gridsize, int gh, int gw)
{
  //Create the unit conversion ratios. Earth Radius = 6371km
  //I find the km per Longitude from the center and assume its constant over the region
  float kmperLon = cos((float)(Math.PI/180*centerLat))*6371/360;
  float kmperLat = 6371/360;
  
  //Convert from lat/lon to grid units (not yet rotated)
  float x = (lon - centerLon)*kmperLon/gridsize;
  float y = (lat - centerLat)*kmperLat/gridsize;
  
  //Rotate (Im rotating opposite direction because Im really supposed to rotate the coordinate system)
  x = -x*cos((float)Math.PI/180*(azm)) + y*sin((float)Math.PI/180*(azm));
  y = -x*sin((float)Math.PI/180*(azm)) - y*cos((float)Math.PI/180*(azm));
  
  //Translate from center of grid to top left corner
  x = x - gw/2;
  y = y + gh/2;
  // x and y are now on the grid, truncating to int will give us its location
  
  int[] xy;
  xy = new int[2];
  xy[0] = int(x);
  xy[1] = int(y);
  
  //println(xy[0], xy[1]);
  return xy;
}


