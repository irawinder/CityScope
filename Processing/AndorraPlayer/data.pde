boolean loadData = true;

Table sampleOutput;
Table tripAdvisor;
Table frenchWifi;
Table localTowers;
Table tourists_0;

Table network;
Table OD;

int dateIndex = 5;

String[] dates = { "20140602", 
                   "20140815",
                   "20141102",
                   "20141109",
                   "20141225",
                   "mtb",
                   "outputCirq",
                   "volta" };
                   
String[] containerNames = { "Andorra La Vella",
                            "St. Julia",
                            "Massana",
                            "Arans",
                            "Encamp",
                            "Soldeu",
                            "El Pas de la Casa" };
                      
PVector[] container_Locations = {new PVector(0.5*canvasWidth, 0.5*canvasHeight), 
                                 new PVector(0.5*marginWidthPix, 0.6*canvasHeight), 
                                 new PVector(1.5*marginWidthPix + topoWidthPix, 0.5*canvasHeight), 
                                 new PVector(1.5*marginWidthPix + topoWidthPix, 0.25*canvasHeight), 
                                 new PVector(0.9*canvasWidth, 1.5*marginWidthPix + topoHeightPix), 
                                 new PVector(0.7*canvasWidth, 1.5*marginWidthPix + topoHeightPix), 
                                 new PVector(0.5*canvasWidth, 1.5*marginWidthPix + topoHeightPix) };

void initData() {
  
  localTowers = loadTable("data/localTowers.tsv", "header");
  
  //sampleOutput = loadTable("data/outputUpdate.csv", "header");
  sampleOutput = new Table();
  tripAdvisor = loadTable("data/Tripadvisor_andorra_la_vella.csv", "header");
  //frenchWifi = new Table();
  frenchWifi = loadTable("data/network_edges_french.csv", "header");
  
  tourists_0 = loadTable("data/OD_1225/17_1225.csv", "header");
  
  network = loadTable("data/CDR_OD/" + dates[dateIndex] + "_network.tsv", "header");
  OD =      loadTable("data/CDR_OD/" + dates[dateIndex] + "_OD.tsv", "header");
  
  for (int i=tripAdvisor.getRowCount()-1; i >= 0; i--) {
    if (tripAdvisor.getFloat(i, "Lat") < lat2 || tripAdvisor.getFloat(i, "Lat") > lat1 ||
        tripAdvisor.getFloat(i, "Long") < lon1 || tripAdvisor.getFloat(i, "Long") > lon2) {
      tripAdvisor.removeRow(i);
    }
  }
}
