
boolean load_non_essential_data = true;

//Raster Graphics for basemaps of model

   // Base satelite image for model
   PImage topo;

// Objects for converting Latitude-Longitude to Canvas Coordinates
   
    // corner locations for topographic model (latitude and longitude)
    PVector UpperLeft = new PVector(42.505086, 1.509961);
    PVector UpperRight = new PVector(42.517066, 1.544024);
    PVector LowerRight = new PVector(42.508161, 1.549798);
    PVector LowerLeft = new PVector(42.496164, 1.515728);
    
    //Amount of degrees rectangular canvas is rotated from horizontal latitude axis
    float rotation = 25.5000; //degrees
    float lat1 = 42.517066; // Uppermost Latitude on canvas
    float lat2 = 42.496164; // Lowermost Latitude on canvas
    float lon1 = 1.509961; // Leftmost Longitude on canvas
    float lon2 = 1.549798; // Rightmost Longitude on canvas
     
    MercatorMap mercatorMap; // rectangular projection environment to convert latitude and longitude into pixel locations on the canvas

// Tables of CDR and other point-based data

  int dataMode = 2;
  // dataMode = 2 for Andorra CDR Network (circa Dec 2015)
  // dataMode = 1 for random network
  // dataMode = 0 for empty network and Pathfinder Test OD
  
  // Sample Geolocated Data
  Table tripAdvisor;
  Table frenchWifi;
  Table localTowers;
  Table restaurants;
  Table attractions;
  Table amenities; 
  Table wifi; 
  Table marc_rest;
  Table values;
  Table antenna; 
  Table yup;

  
  // OD Matrix Information
  Table network;
  Table OD;
  Table towers;
  int dateIndex = 6; // Initial date index    
  String[] dates = { "20140602", 
                     "20140815",
                     "20141102",
                     "20141109",
                     "20141225",
                     "mtb",
                     "cirq",
                     "volta" };
  
  // for dataMode = 3:
  int hourIndex = 71;
  int maxHour = 23;
  int maxFlow = 0; // For a given date and hour, defines upper bound for flow between any two points based on data
  Table summary;
  String date = "no data";

// Names and locations of areas outside of table to be represented on margins
          
  // Names of 7 Hamlets in Andorra         
  String[] container_Names = {"Andorra La Vella",
                              "St. Julia",
                              "Massana",
                              "Ordino",
                              "Encamp",
                              "Canillo",
                              "El Pas de la Casa" };

  float offset = -.2; // Amount that Hamlets markers are offset from center of margin   
  PVector[] container_Locations = {new PVector(topoWidthPix+0.5*marginWidthPix, topoHeightPix+0.5*marginWidthPix), 
                                   new PVector((0.5-offset)*marginWidthPix, topoHeightPix + 0.5*marginWidthPix), 
                                   new PVector((1.5+offset)*marginWidthPix + topoWidthPix, 0.45*canvasHeight), 
                                   new PVector((1.5+offset)*marginWidthPix + topoWidthPix, 0.20*canvasHeight), 
                                   new PVector(0.80*canvasWidth, (1.5+offset)*marginWidthPix + topoHeightPix), 
                                   new PVector(0.65*canvasWidth, (1.5+offset)*marginWidthPix + topoHeightPix), 
                                   new PVector(0.50*canvasWidth, (1.5+offset)*marginWidthPix + topoHeightPix) };
  
void initData() {
  
  println("Loading Data ...");
  
  if (dataMode == 2) {
    load_non_essential_data = true;
    showTopo = true;
  } else {
    load_non_essential_data = false;
    showTopo = false;
  }
  println("Load Non-Essential Data = " + load_non_essential_data);
  
  // Creates projection environment to convert latitude and longitude into pixel locations on the canvas
  mercatorMap = new MercatorMap(topoWidthPix, topoHeightPix, lat1, lat2, lon1, lon2, rotation);
  
  // Used as sample data set
  localTowers = loadTable("data/cell.csv", "header");
  frenchWifi = loadTable("data/network_edges_french.csv", "header");
  values = loadTable("data/values.csv", "header");
  antenna = loadTable("data/antenna.csv", "header");
  
  // loads baseimage for topographic model
  topo = loadImage("crop.png");
  
  if (load_non_essential_data) {
    
    network = loadTable("data/CDR_OD/" + dates[dateIndex] + "_network.tsv", "header");
    OD =      loadTable("data/CDR_OD/" + dates[dateIndex] + "_OD.tsv", "header");
    
    wifi = loadTable("data/wifi_user.csv");
    
    localTowers = loadTable("data/cell.csv", "header");
    amenities = loadTable("data/attractions.csv", "header");


    for (int i=amenities.getRowCount() - 1; i >= 0; i--) {
     if (amenities.getFloat(i, "Lat") < lat2 || amenities.getFloat(i, "Lat") > lat1 ||
          amenities.getFloat(i, "Long") < lon1 || amenities.getFloat(i, "Long") > lon2) {
        amenities.removeRow(i);
      }
    }
    
    yup = loadTable("data/amens.csv", "header");
    for (int i=yup.getRowCount() - 1; i >= 0; i--) {
     if (yup.getFloat(i, "Lat") < lat2 || yup.getFloat(i, "Lat") > lat1 ||
          yup.getFloat(i, "Lon") < lon1 || yup.getFloat(i, "Lon") > lon2) {
        yup.removeRow(i);
      }
    }
    
  marc_rest = loadTable("data/restaurants.tsv", "header");
  for (int i=marc_rest.getRowCount() - 1; i >= 0; i--) {
     if (marc_rest.getFloat(i, "LAT") < lat2 || marc_rest.getFloat(i, "LAT") > lat1 ||
          marc_rest.getFloat(i, "LNG") < lon1 || marc_rest.getFloat(i, "LNG") > lon2) {
        marc_rest.removeRow(i);
      }
    }
    
  antenna = loadTable("data/antenna.csv", "header");
  for (int i=antenna.getRowCount() - 1; i >= 0; i--) {
     if (antenna.getFloat(i, "Latitude") < lat2 || antenna.getFloat(i, "Latitude") > lat1 ||
          antenna.getFloat(i, "Longitude") < lon1 || antenna.getFloat(i, "Longitude") > lon2) {
        antenna.removeRow(i);
      }
    }
  

   restaurants = loadTable("data/restaurants.csv", "header");
   for (int i=restaurants.getRowCount() - 1; i >= 0; i--) {
     if (restaurants.getFloat(i, "Lat") < lat2 || restaurants.getFloat(i, "Lat") > lat1 ||
          restaurants.getFloat(i, "Long") < lon1 || restaurants.getFloat(i, "Long") > lon2) {
        restaurants.removeRow(i);
      }
    }
    
   attractions = loadTable("data/attractions.csv", "header");
   for (int i=attractions.getRowCount() - 1; i >= 0; i--) {
     if (attractions.getFloat(i, "Lat") < lat2 || attractions.getFloat(i, "Lat") > lat1 ||
          attractions.getFloat(i, "Long") < lon1 || attractions.getFloat(i, "Long") > lon2) {
        attractions.removeRow(i);
      }
    }
    
    tripAdvisor = loadTable("data/Tripadvisor_andorra_la_vella.csv", "header");
    for (int i=tripAdvisor.getRowCount()-1; i >= 0; i--) {
      if (tripAdvisor.getFloat(i, "Lat") < lat2 || tripAdvisor.getFloat(i, "Lat") > lat1 ||
          tripAdvisor.getFloat(i, "Long") < lon1 || tripAdvisor.getFloat(i, "Long") > lon2) {
        tripAdvisor.removeRow(i);
      }
    }

  } else { // Initializes empty objects to prevent null pointer error
    network = new Table();
    OD = new Table();
    wifi = new Table();
    tripAdvisor = new Table();
    restaurants = new Table();
    attractions = new Table();
    amenities = new Table();
    marc_rest = new Table();
    antenna = new Table();
  }
  
  println("Data loaded.");
}
  
