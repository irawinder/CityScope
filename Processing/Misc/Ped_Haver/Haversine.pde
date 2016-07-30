float R = 6371000; //in meters

float longitude, latitude;

  JSONArray thing;
  JSONObject vals;

float cell = Canvaswidth/areawidth;

//always from origin (upperleft), these are the radian values
//float lat1 = Upper_left.x * PI/180;
//float lon1 = Upper_left.y * PI/180;

//the arraylists this function will output
ArrayList<PVector> xy_amenities = new ArrayList<PVector>();
ArrayList<PVector> xy_amencenter = new ArrayList<PVector>();
ArrayList<PVector> xy_bus = new ArrayList<PVector>();
ArrayList<PVector> xy_peds = new ArrayList<PVector>();
ArrayList<PVector> xy_bridges = new ArrayList<PVector>();
ArrayList<PVector> xy_second = new ArrayList<PVector>();
ArrayList<PVector> crossings = new ArrayList<PVector>();

class Haver{
  void calc(String filename, String tag, ArrayList<PVector> name){
    float lat1 = Upper_left.x * PI/180;
    float lon1 = Upper_left.y * PI/180;
            Table values = loadTable(filename, "header");
     for(int i = 0; i<values.getRowCount(); i++){
                       //get longitude in radians
                          longitude = values.getFloat(i, "x") * PI/180;
                       //get latitude in radians      
                          latitude = values.getFloat(i, "y") * PI/180;
                     
                     //use the Haversine formula
                     float delta_lat = latitude-lat1;
                     float delta_lon = longitude-lon1;
                     
                     float a = sin(delta_lat/2)*sin(delta_lat/2) + cos(lat1)*cos(latitude)*(sin(delta_lon/2)*sin(delta_lon/2));
                     float c = 2*(atan2(sqrt(a), sqrt(1-a)));
                     float d = c*R;
                     float bearing = atan2(sin(delta_lon)*cos(latitude), cos(lat1)*sin(latitude) - sin(lat1)*cos(latitude)*cos(delta_lon));
                             
                             //convert to polar and put in array
                             PVector xy_coord = new PVector(cell*d*cos(radians(abs(90-degrees(bearing)))), cell*d*sin(radians(abs(90-degrees(bearing)))));

                             //determine what arraylist to put thing in
                             name.add(xy_coord);
                                               
                }
                  println("Haversine run on " + filename);
         
          
          
          
          //export data nodes for bus and amens
          
          thing = new JSONArray();
          if(name == xy_bus || name == xy_amenities){
          for(int i = 0; i<name.size(); i++){
              vals = new JSONObject();
              vals.setFloat("u", name.get(i).x);
              vals.setFloat("v", name.get(i).y);
              thing.setJSONObject(i, vals);
     
          }
           saveJSONArray(thing, "exports/" + tag + ".json"); 
                   println("haversine data exported");
          }
  }
  
 void left(PVector center){
   float dist = 2096.95;
   
   float lat = asin(sin(center.x)*cos(dist/R) + cos(center.x)*sin(dist/R)*cos(radians((-45+180)%360)));
   float lon = center.y + atan2(sin(radians((-45+180)%360))*sin(dist/R)*cos(center.x), cos(dist/R)-sin(center.x)*sin(lat));
   
   Upper_left = new PVector(lat, lon);
   
   println(lat, lon);
  }
  
      
}
