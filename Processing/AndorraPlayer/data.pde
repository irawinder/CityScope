Table sampleOutput;
Table tripAdvisor;
Table frenchWifi;
Table OD_France;

void initData() {
  
  sampleOutput = loadTable("data/outputUpdate.csv", "header");
  tripAdvisor = loadTable("data/Tripadvisor_andorra_la_vella.csv", "header");
  frenchWifi = loadTable("data/network_edges_french.csv", "header");
}
