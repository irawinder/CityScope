//Converts a table with Lat/Lon/Value into a JSON density distribution on a grid.
//I decided to have one value per file so the program that uses them can load
//all the files in a folder. This will allow new data to be imported easily without
//modifying older data.


//Define the grid
float centerLatitude = ???;
float centerLongitude = ???;
float azimuth = 0; //North
float gridSize = .25; //km
int gridHeight = 64;
int gridWidth = 64;


Table dataInput;
JSONArray dataOutput;


void setup()
{
  
  dataInput = loadTable("table name here!!!");
  dataOutput = new JSONArray();
  
  float latitude;
  float longitude;
  float value;
  
  int u;  //u is x
  int v;  //v is y
  
  int i;
  for(i=0;i<dataInput.getColumnCount()
  {
    if(true)  //Use this to decide if the row should be read (filter out stores etc.)
    {
      latitude = dataInput.getFloat(0,i); //First column is latitude !!Check this!!
      longitude = dataInput.getFloat(1,i); //Second column is longitude !!Check this!!
      value = dataInput.getInt(???,i); //??? column is the value I want
      
      something = LatLontoGrid(latitude,longitude,centerLatitude,centerLongitude,azimuth,gridSize,gridHeight,gridWidth);
      
      //Do JSON stuff
    }
  }
  
  //Write JSON file
  
}
