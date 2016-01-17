//import toxiclibs library 
import toxi.geom.*;
import toxi.geom.mesh2d.*;
import toxi.util.*;
import toxi.util.datatypes.*;
import toxi.processing.*;

//logics for showPoints and doClip
boolean showPoints = true;
boolean doClip;

// helper class for rendering
ToxiclibsSupport gfx;

// empty voronoi mesh container
Voronoi voronoi = new Voronoi();

// optional polygon clipper
PolygonClipper2D clip;

void setupVoronoi() {
  smooth();
  gfx = new ToxiclibsSupport(this);
}
 
void drawVoronoi() {
  //rect(0,0,width,height);
  stroke(100);
  strokeWeight(2);
  noFill();
  // draw polygons, clip them if needed...
  for (Polygon2D poly : voronoi.getRegions()) {
    if (doClip) {
     gfx.polygon2D(clip.clipPolygon(poly));
    } 
    else {
      gfx.polygon2D(poly);
    }
  }

  // draw original points added to voronoi
  if (showPoints) {
    noStroke();
    for (Vec2D c : voronoi.getSites()) {
      ellipse(c.x, c.y, 20, 20);
      fill(random(255), random(255), random(255));
    }

  }

}
