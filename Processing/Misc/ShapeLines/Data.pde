Table pednetwork, roadnetwork, bridges, intersections, secondstory, coveredlinks;

void initData(){
      pednetwork = loadTable("data/pednet.csv", "header");
      roadnetwork = loadTable("data/road.csv", "header");
      bridges = loadTable("data/overhead.csv", "header");
      intersections = loadTable("data/crossings.csv", "header");
      secondstory = loadTable("data/second.csv", "header");
      coveredlinks = loadTable("data/cover.csv", "header");

      
      println("data loaded");
}

/* 
Data Notes: 

These csvs are obtained from QGIS, an OpenSource GeoSpatial data renderer 

Steps to get them: 
1. Open Shapefile in QGIS 
2. Make sure to install MMQGIS PlugIn 
3. Use MMQGIS menu to export geometry and attribute spreadsheets
    This saves the lat, lon coordinates of the seperate shapes and has a dictionary of shapeid indexes to correlate the geometries and attributes 
    PLEASE NOTE THEY ARE INVERTED; lon is x, lat is y 
    
*/ 
