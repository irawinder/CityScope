import deadpixel.keystone.*;

PImage special_agents, special_roads, things;

/* GeoBits 
 
 GeoBits is a system for exploring and rendering GeoSpatial data a global scale in a variety of coordinate systems
 For more info, visit https://changingplaces.github.io/GeoBits/
 
 This code is the essence of under construction...it's a hot mess
 
 Author: Nina Lutz, nlutz@mit.edu`
 
 Supervisor: Ira Winder, jiw@mit.edu
 
 Write datege: 8/13/16 
 Last Updated: 11/2/16
 */
boolean agentstriggered, initagents, initialized, lines, notenoughdata;
boolean bw, demo = true;
MercatorMap mercatorMap;
BufferedReader reader;
int current, zoom;

RoadNetwork canvas, selection, handler;
ODPOIs places;

void setup() {

  size(1366, 768, P3D);
  
  initCanvas();
  renderTableCanvas();
  initGraphics();
  
  map = new UnfoldingMap(this, new OpenStreetMap.OpenStreetMapProvider());
  MapUtils.createDefaultEventDispatcher(this, map);
  Location Boston = new Location(42.359676, -71.060636);
  
  if(demo){
  map.zoomAndPanTo(Boston, 17);
  pulling = true;
  }
  
  smooth();
  
}

void draw() {
  background(0);

  if (!pulling) {
    map.draw();
  }


  if (pull) {
    //Sets up Bounding Boxes for current model's map
      MapArch();
    
    //Use HTTP requests to get data    
    if(!demo){
      PullMap(MapTiles(width, height, 0, 0).size(), width, height);
      PullOSM();
      println("PullMap() ran");
    }
    
    //Or load the pre-processed demo set in Boston
    if(demo){
    mapling = "data/map(42.363, -71.068)_(42.357, -71.053).json";
    }
    
    //Organize POIs
    places.PullPOIs();
    println("Pull POIs ran");
    
    //Pulling seperate information if needed
    if (Yasushi) {
      PullOSM();
      PullWidths();
    }
    
    //Generates networks
    selection.GenerateNetwork(MapTiles(width, height, 0, 0).size());
    canvas.GenerateNetwork(MapTiles(width, height, 0, 0).size());
    println("Networks generated");
    
    println("DONE: Data Acquired");
    
    pulling = false;
    pull = false;
     
    //sets up for agentnetwork if there is enough info 
    AgentNetworkModel(); 
  }

  mercatorMap = new MercatorMap(1366, 768, CanvasBox().get(0).x, CanvasBox().get(1).x, CanvasBox().get(0).y, CanvasBox().get(1).y, 0);

  if (lines) {
    image(Handler, 0, 0);
  }

  if (directions) {
    image(direction, 0, 0);
  }

  if (select && !pulling) {
    draw_selection();
  }


  draw_info();
  
  if(notenoughdata){
     image(notenough, 0, 0); 
  }

  if (pulling) {
    image(loading, 0, 0);
    pull = true;
  }


  if (agentstriggered) {  
    if (initialized) {
      mainDraw();
    } else if (!initialized) {
      initContent(tableCanvas);
      initialized = true;
      initagents = false;
    } else {
      mainDraw();
    }
  }
  
  if(initialized && pullprojection){
  things = get(int(mercatorMap.getScreenLocation(selection.bounds.boxcorners().get(1)).x), int(mercatorMap.getScreenLocation(selection.bounds.boxcorners().get(1)).y), boxh, boxw+90);
  }

  
}

void mouseDragged() {
    demo = false;
    initialized = false;
    agentstriggered = false;
    lines = false;
  if(notenoughdata){
    notenoughdata = false;
  }
}


void renderTableCanvas() {
  image(tableCanvas, 0, 0, tableCanvas.width, tableCanvas.height);
}  
void mainDraw() {
  // Draw Functions Located here should exclusively be drawn onto 'tableCanvas',
  // a PGraphics set up to hold all information that will eventually be 
  // projection-mapped onto a big giant table:
  drawTableCanvas(tableCanvas);

  // Renders the finished tableCanvas onto main canvas as a projection map or screen
  renderTableCanvas();
}
