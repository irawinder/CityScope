// Function to take Latitude Longitude (along with rotation grid h/w and grid size) 
// to return the index the point on the table grid.

//Azimuth in degrees, gridsize in km/stud.

//int untill I know how to return two variables, there is likely a point object I can return
int LatLontoGrid(float lat, float lon, float centerLat, float centerLon, float azm, float gridsize, int gh, int gw)
{
  //Create the unit conversion ratios. Earth Radius = 6371km
  float kmperLon = cos(getRadians(centerLat))*6371/360;
  float kmperLat = 6371/360;
  
  //Convert from lat/lon to grid units (not yet rotated)
  float x = (lon - centerLon)*kmperLon/gridsize;
  float y = (lat - centerLat)*kmperLat/gridsize;
  
  //Rotate (Im rotating opposite direction because Im really supposed to rotate the coordinate system)
  x = -x*cos(getRadians(azm)) + y*sin(getRadians(azm));
  y = -x*sin(getRadians(azm)) - y*cos(getRadians(azm));
  
  //Translate from center of grid to top left corner (I hope thats the starting spot)
  x = x - gw/2;
  y = y + gh/2;
  // x and y are now on the grid, truncating to int will give us its location
  
  //Return value here with some 2 int object 
}


