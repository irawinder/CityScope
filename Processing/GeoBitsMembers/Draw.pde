PGraphics direction, popup, loading, agents;
//toggling booleans for displays
boolean showFrameRate = false;
boolean select = true;
boolean directions = false;
boolean showoutput = true;


//dimensions for box
int boxw = 350;
int boxh = int(boxw*(22.0/20.0));
int numcols = 18;
int numrows = 22;

void initGraphics(){
  //handler and graphics for road lines
  Selection = createGraphics(width, height);
  Canvas = createGraphics(width, height);
  Handler = createGraphics(width, height);
  
  direction = createGraphics(width, height);
  popup = createGraphics(width, height);
  loading = createGraphics(width, height);
  agents = createGraphics(width, height);
  projector = createGraphics(width, height);
}

//draws info
void draw_info() {
  textSize(20);
  fill(0);
  stroke(0);
  if (showFrameRate) {
    text("frameRate: " + frameRate, 20, 50);
    text("zoom level " + map.getZoomLevel(), 20, 80);
  }
  rect(0, 0, width, 30);
  fill(255);
  text("Nina Lutz. This demo is under development, please be patient. Press 'd' for instructions.", 20, 20);
}

//user directions
void draw_directions(PGraphics p) {
  p.beginDraw();
  p.noStroke();
  p.fill(255, 200);
  p.rect(10, 30, width/3+20, height/4+30, 5);
  p.textSize(12);
  p.fill(#ff0000);
  p.text("This is GeoBits. GeoBits is a developing geospatial sandbox.", 15, 50);
  p.text("Currently you can navigate the map, select a region,", 15, 70); 
  p.text("and export a geojson of all the features in this region.", 15, 90); 
  p.text("Zoom in until you are prompted to model.", 15, 110); 
  p.text("KEYS: ", 15, 140);
  p.text("d = toggle info", 15, 160);
  p.text("s = toggle selection box", 15, 180);
  p.text("p = export data", 15, 200);
  p.text("W = make box bigger, w = smaller", 15, 220);
  p.text("+/- = zoom in and out", 15, 240);
  p.endDraw();
}

void draw_loading(PGraphics p){
  p.beginDraw();
  p.fill(0);
  p.rect(0, 0, width, height);
  p.fill(255);
  p.textSize(25);
  p.textAlign(CENTER);
  p.text("Pulling Data...",width/2, height/2);
  p.endDraw();

}

//void draw_agents(PGraphics p){
//  p.beginDraw();
//  p.fill(0);
//  p.rect(0, 0, width, height);
//  p.fill(255);
//  p.textSize(25);
//  p.textAlign(CENTER);
//  p.text("Computing Agent Model...",width/2, height/2);
//  p.endDraw();
//
//}


void draw_popup(PGraphics p){
  p.beginDraw();
  p.noStroke();
  p.fill(255, 200);
  p.rect(width*2/3, 30, width/3, 70, 5);
  p.textSize(12);
  p.fill(#ff0000);
  p.text("Press 's' to toggle selection window, Press 'p' to export data", width*2/3 + 20, 50);
      if(pull){
        p.text("Press 'P' to render selection, 'A' to render canvas", width*2/3 + 20, 70);
      }
  p.endDraw();
}

//draw user selection box
void draw_selection() {
  noFill();
  strokeWeight(2);
  stroke(0);
  rect(mouseX, mouseY, boxw, boxh);
  fill(#00ff00);
  ellipse(mouseX, mouseY, 20, 20);
  fill(#ff0000);
  ellipse(mouseX + boxw, mouseY +boxh, 20, 20);
  fill(#0000ff);
  ellipse(mouseX, mouseY + boxh, 20, 20);
  fill(#ffff00);
  ellipse(mouseX + boxw, mouseY, 20, 20);
  
  strokeWeight(1);
  stroke(100);
  
  for(int i = 0; i<numcols+1; i++)
    line(int(i*boxw/numcols) + int(mouseX), mouseY, int(i*boxw/numcols) + int(mouseX), mouseY+boxh);
  
  for(int i = 0; i<numrows+1; i++)
    line(mouseX, int(i*boxh/numrows) + int(mouseY), mouseX + boxw, int(i*boxh/numrows) + int(mouseY));
   
}
