boolean loadData = true;

Table sampleOutput;
Table tripAdvisor;
Table frenchWifi;
Table localTowers;
Table tourists_0;

void initData() {
  
  localTowers = loadTable("data/localTowers.tsv", "header");
  
  //sampleOutput = loadTable("data/outputUpdate.csv", "header");
  sampleOutput = new Table();
  tripAdvisor = loadTable("data/Tripadvisor_andorra_la_vella.csv", "header");
  //frenchWifi = new Table();
  frenchWifi = loadTable("data/network_edges_french.csv", "header");
  
  tourists_0 = loadTable("data/OD_1225/1_1225.csv", "header");
  
  for (int i=tripAdvisor.getRowCount()-1; i >= 0; i--) {
    if (tripAdvisor.getFloat(i, "Lat") < lat2 || tripAdvisor.getFloat(i, "Lat") > lat1 ||
        tripAdvisor.getFloat(i, "Long") < lon1 || tripAdvisor.getFloat(i, "Long") > lon2) {
      tripAdvisor.removeRow(i);
    }
  }
}
