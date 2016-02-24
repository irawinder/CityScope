//Converts a table with Lat/Lon/Value into a JSON density distribution on a grid.
//I decided to have one value per file so the program that uses them can load
//all the files in a folder. This will allow new data to be imported easily without
//modifying older data.

//I used JSONConverter as a guide to make this.


//Define the grid
float centerLatitude = 39.7392;
float centerLongitude = 104.9903;
float azimuth = 0; //North
float gridSize = 1; //km
int gridHeight = 64;
int gridWidth = 64;

int grid[][];

int counter = 0;
Table dataInput;
JSONArray dataOutput;
JSONObject temp;

void setup()
{
  
  dataInput = loadTable("Data.csv");
  dataOutput = new JSONArray();
  
  float latitude;
  float longitude;
  float value;
  
  int[] uv;
  uv = new int[2]; // [0] is u, [1] is v
  initGrid(); //Creates the grid then fills it with zeros
  
  int i;
  //for(i=3;i<dataInput.getRowCount();i++) //start 3 rows in because of header
  for(i=3;i<10;i++)
  {
    latitude = dataInput.getFloat(i,8); //9th column is latitude
    longitude = dataInput.getFloat(i,9); //10th column is longitude
    value = dataInput.getInt(i,12); //13th column is the totes value
      
    //println(value);
    //println(latitude, longitude, value);
    
    //It doesn't seem to find the first many rows
    //It often gets 0 values for totes which makes no sense
    //Could be my csv inputs but I really don't know what loadTable() does.
      
    uv = LatLontoGrid(latitude,longitude,centerLatitude,centerLongitude,azimuth,gridSize,gridHeight,gridWidth);
    
    println(uv[0], uv[1], value);
    
    //Check if the location is inside the grid
    if((uv[0]>0) && (uv[1]>0) && (uv[0]<gridWidth) && (uv[1]<gridHeight))
    {
      grid[uv[0]][uv[1]] += value;
    }
  }
  
  //Write JSON file
  writeGrid();
}

void initGrid()
{
  grid = new int[gridWidth][gridHeight];
  int i,j;
  for(i=0;i<gridWidth;i++)
  {
    for(j=0;j<gridWidth;j++)
    {
      grid[i][j] = 0;
    }
  }
}

void writeGrid()
{
  grid = new int[gridWidth][gridHeight];
  int i,j;
  for(i=0;i<gridWidth;i++)
  {
    for(j=0;j<gridWidth;j++)
    {
      temp = new JSONObject();
      temp.setInt("u", i);
      temp.setInt("v", j);
      temp.setInt("totes", grid[i][j]);
      writeObject();
    }
  }
  saveJSONArray(dataOutput, "totes.json");
}

//Stolen from JSONConverter
void writeObject() 
{
  dataOutput.setJSONObject(counter, temp);
  counter++;
}


