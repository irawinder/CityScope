/* Pixelizer is a script that transforms a cloud of weighted latitude-longitude data 
 * into a discrete, pixelized density of the weighted data.  Input is a TSV file
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

//Define the grid
float centerLatitude = 39.95;
float centerLongitude = -104.9903;
float azimuth =  0; //North
float gridSize = 0.250; //km
int gridV = 22*4; // Height of Lego Table
int gridU =  18*4; // Width of Lego Table

String fileName = "denver";

int grid[][];

int counter = 0;
Table dataInput;
JSONArray dataOutput;
JSONObject temp;

void pixelizeData() {
  // Name of CSV file to upload
  dataInput = loadTable("data/" + fileName + ".tsv");
  dataOutput = new JSONArray();
  
  float latitude;
  float longitude;
  int value; // One weighted value per JSON file (currently)
  
  int[] uv = new int[2]; // [0] is u, [1] is v
  initGrid(); //Creates the grid then fills it with zeros
  
  for(int i=2;i<dataInput.getRowCount();i++) //start 2 rows in because of header
  {
    latitude = dataInput.getFloat(i,8); //9th column is latitude
    longitude = dataInput.getFloat(i,9); //10th column is longitude
    value = dataInput.getInt(i,12); //13th column is the totes value
      
    uv = LatLontoGrid(latitude,longitude,centerLatitude,centerLongitude,azimuth,gridSize,gridV,gridU);
    
    //println(uv[0], uv[1], value);
    
    //Check if the location is inside the grid
    if((uv[0]>0) && (uv[1]>0) && (uv[0]<gridU) && (uv[1]<gridV))
    {
      grid[uv[0]][uv[1]] += value;
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
  xy[0] = - int(x);
  xy[1] =   int(y);
  
  //println(xy[0], xy[1]);
  return xy;
}
