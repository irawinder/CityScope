//logics for showPoints and doClip
boolean showPoints = true;

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

void drawVoronoi() {
  stroke(#fff000);
  strokeWeight(3);
  noFill();
  //draw polygons...
  for (Polygon2D poly : voronoi.getRegions()){
  gfx.polygon2D(poly);
  }
  
}
