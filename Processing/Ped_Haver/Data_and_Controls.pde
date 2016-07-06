////////////////
/// CONTROLS 
///////////////
boolean showPOI = true;
boolean showGrid = true;
boolean showlines = true;
boolean showFrameRate = false;

void keyPressed() {
     //draws lines
      if (key=='l') {
         showlines = toggle(showlines);
      }
      //draws POI
      else if(key=='p') {
         showPOI = toggle(showPOI);
      }   
      else if(key == 'g'){
         showGrid = toggle(showGrid);
      }
      else if(key == 'f'){
        showFrameRate = toggle(showFrameRate);
      }

}

boolean toggle(boolean bool) {
      if (bool) {
        return false;
      } else {
        return true;
      }
}


////////////////////////
//DATA LOAD 
///////////////////////
PImage img;
Table amenities; 
Table ped_nodes;
Table bus_stops;
Table bridges;
Table second;
Table sec;
Table Intersect;

void initData(){
      amenities = loadTable("data/temp-nodes.csv", "header");
      ped_nodes = loadTable("data/pednetv2nodes.csv", "header");
      bus_stops = loadTable("data/EZ-nodes.csv", "header");
      bridges = loadTable("data/bridges_links.csv", "header");
      second = loadTable("data/2ndmerc.csv", "header");
      sec = loadTable("data/sec.csv", "header");
      img = loadImage("map.jpg");
      Intersect = loadTable("data/crossings.csv", "header");
      
      println("data loaded");
}
