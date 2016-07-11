PImage Map;
MercatorMap mercatorMap;

boolean initialized = false;
boolean corners = true;
boolean center = false;
boolean pixilizer = false;

float Top_lat, Bottom_lat, Right_lon, Left_lon;

//Values for canvas
float aspect = .666;
float areawidth, areaheight;

//center values
PVector Center, top_left_corner, bottom_right_corner, top_right_corner, bottom_left_corner;

//Needed Java classes
import java.util.Set;
import java.util.HashSet;

void setup() {
  
 
    Top_lat = 27.0202;
    Bottom_lat = 23.1533;
    Left_lon = -107.334; 
    Right_lon = -100.452;

  top_left_corner = new PVector(Top_lat, Left_lon);
  top_right_corner = new PVector(Top_lat, Right_lon);
  bottom_left_corner = new PVector(Bottom_lat, Left_lon);
  bottom_right_corner = new PVector(Bottom_lat, Right_lon);
  
  size(900, 600); 
      
  initData();
  smooth();
}

void draw() {
  
  if(!initialized){
    //background images
      background(0);
           //mercatorMap 
            mercatorMap = new MercatorMap(width, height, Top_lat, Bottom_lat, Left_lon, Right_lon);
            drawLines();
            println(frameRate);

        println("Initialized");
        initialized = true;
  }
  
}
