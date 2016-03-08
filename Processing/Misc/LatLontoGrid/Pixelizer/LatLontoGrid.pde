/* Pixelizer is a script that transforms a cloud of weighted latitude-longitude points 
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
 * Ira Winder (jiw@mit.edu)
 * Mike Winder (mhwinder@gmail.com)
 * Write Date: January, 2015
 * 
 */

int gridV = 22*4; // Height of Lego Table
int gridU =  18*4; // Width of Lego Table

float gridSize;
float centerLatitude;
float centerLongitude;
float azimuth; //North
String fileName;

int grid[][];

int counter = 0;
Table dataInput;
JSONArray dataOutput;
JSONObject temp;

void denverMode() {
  //Define the grid
  gridSize = 2; //km
  
  centerLatitude = 39.95;
  centerLongitude = -104.9903;
  azimuth =  0; //North
  
  fileName = "denver";
}

void sanjoseMode() {
  //Define the grid
  gridSize = 1; //km

  centerLatitude = 37.395237;
  centerLongitude = -121.979507;
  azimuth =  0; //North
  
  fileName = "sanjose";  
}

void pixelizeData() {
  // Name of CSV file to upload
  dataInput = loadTable("data/" + fileName + ".tsv");
  dataOutput = new JSONArray();
  
  float latitude;
  float longitude;
  int value; // One weighted value per JSON file (currently)
  
  int[] uv = new int[2]; // [0] is u, [1] is v
  initGrid(); //Creates the grid then fills it with zeros
  
  for(int i=1;i<dataInput.getRowCount();i++) //start 2 rows in because of header
  { 
    // Column Locations based on CTL data received Feb 2015
    latitude = dataInput.getFloat(i,8); //9th column is latitude
    longitude = dataInput.getFloat(i,9); //10th column is longitude
    value = dataInput.getInt(i,12); //13th column is the totes value
    
    // Fetch grid location of coordinate
    uv = LatLontoGrid(latitude,longitude,centerLatitude,centerLongitude,azimuth,gridSize,gridV,gridU);
    
    //Check if the location is inside the grid
    if((uv[0]>0) && (uv[1]>0) && (uv[0]<gridU) && (uv[1]<gridV))
    {
      grid[uv[0]][uv[1]] += value;
      //grid[uv[0]][uv[1]] += 1;
    } 
  }
  
  //Write JSON file
  writeGrid();
}

// Initialized Grid totes to '0'
void initGrid()
{
  grid = new int[gridU][gridV];

  for(int i=0;i<gridU;i++)
  {
    for(int j=0;j<gridV;j++)
    {
      grid[i][j] = 0;
    }
  }
}

// Writes Grid to JSON File
void writeGrid()
{
  for(int i=0;i<gridU;i++)
  {
    for(int j=0;j<gridV;j++)
    {
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
 * // possible issue with y being positive while v needs to be negative
 * // possible issue with kmperLon although the geometry seems right
 * // issue with azimuth != 0
 *
 * Mike Winder (mhwinder@gmail.com)
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
