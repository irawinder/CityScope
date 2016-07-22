Table roadnetwork, railnetwork, pednetwork, bikenetwork, andorranet;

void initData(){
     roadnetwork = loadTable("data/miniroadnodes.csv", "header");
     railnetwork =loadTable("data/rails.csv", "header");
     pednetwork = loadTable("data/minipednodes.csv", "header");
     bikenetwork =loadTable("data/bikenodes.csv", "header");
     andorranet = loadTable("data/ANDnodes.csv", "header");
     println("data loaded");
}

float R = 6371000; //in meters
float longitude, latitude;
class Merc{
  void bounds(PVector Center, float seldimx, float seldimy){
          float angradx = seldimx/6371.0;
          float angrady = seldimy/6371.0;
          minlat = (Center.x*PI/180) - angradx;
          maxlat = (Center.x*PI/180) + angradx;
          minlat = minlat*180/PI; 
          maxlat = maxlat*180/PI; 
          
          //float latt = asin(sin(Center.x*PI/180)/cos(angrad));
          float deltalon = asin(sin(angrady)/cos(Center.x*PI/180));
          
          minlon = Center.y*PI/180-deltalon;
          maxlon = Center.y*PI/180+deltalon;
          
          minlon = minlon*180/PI;
          maxlon = maxlon*180/PI;
          println(minlon, maxlon, minlat, maxlat);
          
          aspect = seldimx/seldimy;
          
          areawidth = seldimx;
          areaheight = seldimy;
          
  }
  
}