/*
Version 1: 7/6/16

Nina Lutz, MIT Media Lab, Summer 2016, nlutz@mit.edu
Supervisor: Ira Winder, MIT Media Lab, jiw@mit.edu 

This script renders layers of shapefile data by drawing out the linestrings (or polygons) from a lat lon to an xy grid

The aspect ratio here is 22.0(width units): 18.0 (length units) but this is fairly arbitrary. This aspect ratio is the usual aspect ratio for a CityScope Pixilized Grid. 

This is Singapore shapefile data, but it can work with any. 

This uses the Haversine formula to project lat lon coordinates to an XY Cartesian grid. 


/////BUGS 

1. Please note there is a bug in the Haversine calculation going from Center. It goes perfectly from left corner though. 
2. There are also ghost lines from the shape file on the perimeter. I may need to add another filter.


////To Do 
1. Clean code and think about how classes are constructed
*/


//This is the center point to render calculations from
PVector Central = new PVector(1.34718, 103.72825);
PVector Upper_left;

//new haversine object
Haver hav = new Haver();

//intialization boolean such that large draw functions only run once
boolean initialized = false;

 int Canvaswidth = 800; 
 float Canvasheight = Canvaswidth*(22.0/18.0);
 
 float areawidth = 2880;
 
 void setup(){
        size(Canvaswidth, int(Canvasheight), P3D);
        initData();
        
        //finds left corner given a center point
        hav.left(Central);
      
        //runs haversine calculation on any csv file to get xy coords from lat lon
        //calculation takes in a csv of lat lon points associated and exports an array list of xy coordinates
        //I added a tag attribute in case you need to diferentiate datasets with different rules  
        hav.calc("data/pednet.csv", "peds", xy_peds);
        hav.calc("data/overhead.csv", "bridges", xy_bridges);
        hav.calc("data/second.csv", "second", xy_second);
        hav.calc("data/crossings.csv", "crossings", crossings);
        hav.calc("data/road.csv", "roads", xy_roads);
        hav.calc("data/cover.csv", "covered", xy_covered);
        
 }
 

void draw(){
    //these only run once
    if (!initialized) {
        background(0);
        //comment and uncomment which layers you want
        //chose spreadsheet, xy arraylist, and color
        drawLines("data/overhead.csv", xy_bridges, #ff00ff);
        drawLines("data/second.csv", xy_second, #ffff00); 
        drawLines("data/road.csv", xy_roads, #0000ff);
        drawLines("data/crossings.csv", crossings, #ffffff);
        drawLines("data/cover.csv", xy_covered, #00ff00);
        drawLines("data/pednet.csv", xy_peds, #ff0000);
        
        //saves the png of the screen
            save("lines.png");
        
        println("Initialized");      
        initialized = true;
    }
    
    //put functions here to run every time
    text("Nina Lutz, MIT Media Lab", 20, height-20);
}
