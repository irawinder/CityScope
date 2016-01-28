//import toxiclibs library 
import toxi.geom.*;
import toxi.geom.mesh2d.*;
import toxi.util.*;
import toxi.util.datatypes.*;
import toxi.processing.*;

//logics for showPoints and doClip
boolean showPoints = true;
//boolean doClip;

// helper class for rendering
ToxiclibsSupport gfx;

// empty voronoi mesh container
Voronoi voronoi = new Voronoi();

// optional polygon clipper
//PolygonClipper2D clip;

void setupVoronoi() {
  smooth();
  gfx = new ToxiclibsSupport(this);
}

int j = 0;
void drawVoronoi() {
  //rect(0,0,width,height);
  stroke(100);
  strokeWeight(2);
  noFill();
  // draw polygons, clip them if needed...
  for (Polygon2D poly : voronoi.getRegions()) {
    /*if (doClip) {
     gfx.polygon2D(clip.clipPolygon(poly));
    } 
    else {
      gfx.polygon2D(poly);
    }
    */
    gfx.polygon2D(poly);
  }
  
  
int i = 0;
  // draw original points added to voronoi
  if (showPoints) {
    noStroke();
    for (Vec2D towers : voronoi.getSites()) {
      i++;
      ellipse(towers.x, towers.y, 20, 20);
      fill(i*80, i*20, i*5);
    }
  }


Table hotels = loadTable("data/hotels.csv", "header");
    for (int j=0;j<hotels.getRowCount();j++) {
    coord = (new Vec2D(hotels.getFloat(j, "x"), hotels.getFloat(j, "y")));
    ellipse(coord.x, coord.y, 7, 7);
    for (Polygon2D poly : voronoi.getRegions()) {
    /*if (doClip) {
     gfx.polygon2D(clip.clipPolygon(poly));
    } 
    else {
      gfx.polygon2D(poly);
    }
    */
    if((poly.containsPoint(coord) == true)){
      fill(80, 0, 255); 
    }
      }
    }

}

