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
float gridSize = 2.0; // toggle to 2.0, 1.0, and 0.5
float maxGridSize = 2.0;

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
  
// String that specifies what parameter of population data to load
String popMode = "POP10";
  // "POP10" for population count from 2010 census
  // "HOUSING10" for housing unit count from 2010 census

// The grid array of "buckets" that hold aggregated values
int gridSum[][];

// The grid array of "buckets" that holds frequency values
int gridFreq[][];

// The grid array of "buckets" that holds store locations
int gridStore[][];

// The grid array of "buckets" that we display on screen
int gridSDisplay[][];

// TSV to hold lat-lon points
Table dataInput;
// JSON to hold aggregated grid output
JSONArray dataOutput;

// Sets Default Paramters for Denver Area
void denverMode() {
  centerLatitude = 39.95;
  centerLongitude = -104.9903;
  azimuth =  0; // 0 = North
  fileName = "denver";
}

// Sets Default Paramters for San Jose Area
void sanjoseMode() {
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
  
  // variables to temporary hold lat, lon, value, and grid buck for a single point; C for customer, S for store
  float latitudeC, longitudeC, latitudeS, longitudeS;
  int value; // One weighted value per JSON file (currently)
  int[] uv = new int[2]; // [0] is u, [1] is v
  
  //initializes the grid then fills it with zeros
  gridSum   = new int[gridU][gridV];
  gridFreq  = new int[gridU][gridV];
  gridStore = new int[gridU][gridV];
  for(int i=0;i<gridU;i++) {
    for(int j=0;j<gridV;j++) {
      gridSum[i][j] = 0;
      gridFreq[i][j] = 0;
      gridStore[i][j] = 0;
    }
  }
  
  //Dumps weighted lat-lon points into grid[][] buckets
  for(int i=1;i<dataInput.getRowCount();i++) //start 2 rows in because of header
  { 
    // Column Locations based on CTL data received Feb 2015
    
    latitudeC = dataInput.getFloat(i,8); //9th column is customer latitude
    longitudeC = dataInput.getFloat(i,9); //10th column is customer longitude
    latitudeS = dataInput.getFloat(i,10);  //11th column is store latitude
    longitudeS = dataInput.getFloat(i,11); //12th column is store longitude
    
    value = 0;
    
    if (valueMode.equals("deliveries")) {
      value = 1;
    } else if (valueMode.equals("totes")) {
      value = dataInput.getInt(i,12);       //13th column is the totes value
    } else if (valueMode.equals("doorstep")) {
      value = dataInput.getInt(i,13);       //14th column is the totes value
    } else if (valueMode.equals("source")) {
      value = dataInput.getInt(i,0);        //1st column is the store ID
    }
    
    // Fetch grid location of Customer coordinate
    uv = LatLontoGrid(latitudeC, longitudeC, centerLatitude, centerLongitude, azimuth, gridSize, this.gridV, this.gridU);
    //Check if the location is inside the grid
    if((uv[0]>0) && (uv[1]>0) && (uv[0]<gridU) && (uv[1]<gridV))
    {
      if(valueMode.equals("source")) {
        // in the case of stores, "value" is the store's integer ID
        gridSum[uv[0]][uv[1]] = value;
      } else {
        // In all other cases, the value is added into its grid bucket
        gridSum[uv[0]][uv[1]] += value;
      }
      
      // += 1 every time a value is deposited into a bucket of gridSum[][]
      gridFreq[uv[0]][uv[1]] += 1;
    } 
    
    // Fetch grid location of Store coordinate
    uv = LatLontoGrid(latitudeS, longitudeS, centerLatitude, centerLongitude, azimuth, gridSize, this.gridV, this.gridU);
    //Check if the location is inside the grid
    if((uv[0]>0) && (uv[1]>0) && (uv[0]<gridU) && (uv[1]<gridV))
    {
      // Presence of a store is designated as "1" (could become more diverse for sm/lg stores, lockers, etc)
      gridStore[uv[0]][uv[1]] = 1;
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
      
      // Performs a different summary calculation depending on the data type
      if (valueMode.equals("deliveries")) {
        // Sum of deliveries per grid
        temp.setInt(valueMode, gridSum[i][j]);
      } else if (valueMode.equals("totes")) {
        // Sum of Totes per grid
        temp.setInt(valueMode, gridSum[i][j]);
      } else if (valueMode.equals("doorstep")) {
        // Average Doorstep time per grid
        temp.setFloat(valueMode, int((float)gridSum[i][j]/gridFreq[i][j]));
      } else if (valueMode.equals("source")) {
        // Store Source at a particular Grid
        temp.setInt(valueMode, gridSum[i][j]);
      }
      
      // 0 or 1 describing whether a store is present
      temp.setInt("store", gridStore[i][j]);
      
      dataOutput.setJSONObject(counter, temp);
      counter++;
    }
  }
  saveJSONArray(dataOutput, "data/" + fileName + "_" + valueMode + ".json");
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
  
//  // Prints lat-lon of lower left corner to console
//  // Coordinates are needed for STL to match their coordinate system
//  println("Lat: " + (centerLat - (gridSize*gh/2)/kmperLat) );
//  println("Lon: " + (centerLon - (gridSize*gw/2)/kmperLon) );
  
  //println(xy[0], xy[1]);
  return xy;
}
