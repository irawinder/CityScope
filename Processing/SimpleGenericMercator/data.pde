Table roadnetwork, roadattributes;

void initData(){
     roadnetwork = loadTable("data/miniroadnodes.csv", "header");
     //roadattributes = loadTable("data/roadattributes.csv", "header");
     println("data loaded");
}
