PImage Map, world;
MercatorMap mercatorMap, map;

boolean initialized = false;
boolean gridshow = true;
boolean lines = true;

//what area to show/render/do
boolean andorra = true;
boolean mex = false;
boolean cali = false;

float maxlat, minlat, minlon, maxlon, xlen, ylen, areawidth, areaheight, aspect;
int bx, by;

//center values
PVector top_left_corner, bottom_right_corner, top_right_corner, bottom_left_corner, Center;

//Haversine and bresenham
Merc hav = new Merc();
bresenham brez = new bresenham();
Grid grid = new Grid();

//Needed Java classes
import java.util.Set;
import java.util.HashSet;

void setup() {

  size(1400, 800);
  //fullScreen(2);
  smooth();

  // Loading exported image
  world = loadImage("test.jpg");
}

void draw() {
  if (!initialized) {
    if (cali) {
      Center = new PVector(35.02, -120.48);
      xlen = 1;
      ylen = 2;
    }
    if (mex) {
      Center = new PVector(24.31, -102.55);
      xlen = 1000;
      ylen = 1500;
    }
    if(andorra){
      Center = new PVector(42.5, 1.52);
      xlen = 2.3;
      ylen = 3.5;
    }

    hav.bounds(Center, xlen, ylen);  

    initData();
    background(0);
      mercatorMap = new MercatorMap(width, height, maxlat, minlat, minlon, maxlon, 0);

    
    if (andorra) {
      brez.generate("data/ANDnodes.csv");
      brez.clean(Coordinates);
      if (lines) {
        drawLines("data/ANDnodes.csv", #36E362);
      }
      if (gridshow) {
        brez.draw_grid();
      }
    }
    
    if (mex) {
      brez.generate("data/miniroadnodes.csv");
      brez.generate("data/rails.csv");
      brez.clean(Coordinates);
      if (lines) {
        drawLines("data/miniroadnodes.csv", #36E362);
        drawLines("data/rails.csv", #1878CC);
      }
      if (gridshow) {
        brez.draw_grid();
      }
    }
    if (cali) {
      if (lines) {
        drawLines("data/minipednodes.csv", #AD48E3);
        drawLines("data/bikenodes.csv", #D9310F);
      }
      brez.generate("data/minipednodes.csv");
      brez.generate("data/bikenodes.csv");
      brez.clean(Coordinates);
      if (gridshow) {
        brez.draw_grid();
      }
    }

    //translate and place thumbnail over thing
    translate(0, height-250);
    image(world, 0, 0, 450, 300);
    map = new MercatorMap(450, 300, 80, -80, -180, 180, 0);
    drawCurrentSelection();
    
    grid.export(int((scale*1000/width)*areawidth));

    println("Initialized");
    initialized = true;
  }
}
