/* LatLontoGrid is a script that transforms a cloud of weighted latitude-longitude points 
 * into a discrete, pixelized aggregation data set.  Input is a TSV file
 * of weighted lat-lon and out put is a JSON.
 *
 *      ---------------> + U-Axis 
 *     |
 *     |
 *     |
 *     |
 *     |
 *     |
 *   + V-Axis
 * 
 * Mike Winder (mhwinder@gmail.com)
 * Ira Winder (jiw@mit.edu)
 * Write Date: January, 2015
 * 
 */

// length of one pixel [km]
float gridSize;

// Lat-Lon and rotation to center the grid
float centerLatitude;
float centerLongitude;
float azimuth; // 0 = North

// Filename of TSV file to grab weighted lat-lon points 
// for example, the fileName for data.tsv would simply be the string "data"; 
// this script add ".tsv" for you
String fileName;

// String that specifies which parameter to summarize as pixels
String valueMode = "totes";
  // "totes" for total crates delivered
  // "deliveries" essentially makes all weights set to 1, regardless of totes
  // "doorstep" will average the doorstep time for each grid
  // "source" will describes which store ID(s) serve that grid bucket
  // "stores" will place the store ID in any pixel that has a store


// The grid array of "buckets" that hold aggregated values
int grid[][];

// TSV to hold lat-lon points
Table dataInput;
// JSON to hold aggregated grid output
JSONArray dataOutput;

// Sets Default Paramters for Denver Area
void denverMode() {
  gridSize = 2; //km
  centerLatitude = 39.95;
  centerLongitude = -104.9903;
  azimuth =  0; // 0 = North
  fileName = "denver";
}

// Sets Default Paramters for San Jose Area
void sanjoseMode() {
  gridSize = 1; //km
  centerLatitude = 37.395237;
  centerLongitude = -121.979507;
  azimuth =  0; // 0 = North
  fileName = "sanjose";
}

// 
void pixelizeData(int gridU, int gridV) {
  
  // Name of CSV file to upload
  dataInput = loadTable("data/" + fileName + ".tsv");
  dataOutput = new JSONArray();
  
  // variables to temporary hold lat, lon, value, and grid buck for a single point
  float latitude;
  float longitude;
  int value; // One weighted value per JSON file (currently)
  int[] uv = new int[2]; // [0] is u, [1] is v
  
  //initializes the grid then fills it with zeros
  grid = new int[gridU][gridV];
  for(int i=0;i<gridU;i++) {
    for(int j=0;j<gridV;j++) {
      grid[i][j] = 0;
    }
  }
  
  //Dumps weighted lat-lon points into grid[][] buckets
  for(int i=1;i<dataInput.getRowCount();i++) //start 2 rows in because of header
  { 
    // Column Locations based on CTL data received Feb 2015
    
    latitude = dataInput.getFloat(i,8); //9th column is customer latitude
    longitude = dataInput.getFloat(i,9); //10th column is customer longitude
    
    value = 0;
    
    if (valueMode.equals("deliveries")) {
      value = 1;
    } else if (valueMode.equals("totes")) {
      value = dataInput.getInt(i,12); //13th column is the totes value
    } else if (valueMode.equals("doorstep")) {
      value = dataInput.getInt(i,13); //14th column is the totes value
    } else if (valueMode.equals("source")) {
      value = dataInput.getInt(i,0);        //1st column is the store ID
    } else if (valueMode.equals("stores")) {
      latitude = dataInput.getFloat(i,10);  //11th column is store latitude
      longitude = dataInput.getFloat(i,11); //12th column is store longitude
      value = dataInput.getInt(i,0);        //1st column is the store ID
    }
    
    // Fetch grid location of coordinate
    uv = LatLontoGrid(latitude, longitude, centerLatitude, centerLongitude, azimuth, gridSize, this.gridV, this.gridU);
    
    //Check if the location is inside the grid
    if((uv[0]>0) && (uv[1]>0) && (uv[0]<gridU) && (uv[1]<gridV))
    {
      grid[uv[0]][uv[1]] += value;
    } 
  }
  
  // Writes Grid to JSON File
  int counter = 0; // Counter used to keep track of JSONObject index
  JSONObject temp;
  for(int i=0;i<gridU;i++) {
    for(int j=0;j<gridV;j++) {
      temp = new JSONObject();
      temp.setInt("u", i);
      temp.setInt("v", j);
      temp.setInt("totes", grid[i][j]);
      dataOutput.setJSONObject(counter, temp);
      counter++;
    }
  }
  saveJSONArray(dataOutput, "data/" + fileName + "_totes.json");
}



/* Function to take Latitude Longitude (along with rotation grid h/w and grid size) 
 * and return the index of the point on a discrete grid.
 *
 * Azimuth in degrees, gridsize in km/stud.
 *
 * Mike Winder (mhwinder@gmail.com)
 * Ira Winder (jiw@mit.edu)
 * January, 2015
 * 
 */

int[] LatLontoGrid(float lat, float lon, float centerLat, float centerLon, float azm, float gridsize, int gh, int gw)
{
  //Create the unit conversion ratios. Earth Radius = 6371km
  //I find the km per Longitude from the center and assume its constant over the region
  float kmperLon = 2*PI*cos((float)(Math.PI/180.0*centerLat))*6371.0/360;
  float kmperLat = 2*PI*6371.0/360;
  
  //Convert from lat/lon to grid units (not yet rotated)
  float x = (lon - centerLon)*kmperLon/gridsize;
  float y = (lat - centerLat)*kmperLat/gridsize;
  
  //Rotate
  float xR, yR;
  float theta = (float)Math.PI/180*(azm+180);
  xR = + x*cos(theta) + y*sin(theta);
  yR = - x*sin(theta) + y*cos(theta);
  
  //Translate from center of grid to top left corner
  xR -= 0.5*gw;
  yR += 0.5*gh;
  // x and y are now on the grid, truncating to int will give us its location
  
  int[] xy;
  xy = new int[2];
  // Adjusts for negative latitude and longitudes
  if (centerLon < 0) {
    xy[0] = - int(xR);
  } else {
    xy[0] =   int(xR);
  }
  if (centerLat < 0) {
    xy[1] = - int(yR);
  } else {
    xy[1] =   int(yR);
  }
  
  //println(xy[0], xy[1]);
  return xy;
}
