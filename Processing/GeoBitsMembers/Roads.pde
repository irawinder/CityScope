PGraphics Canvas, Handler, Selection;

import java.util.Set;
import java.util.HashSet;

public class Road{
  public String name, kind;
  public int OSMid; 
  public PVector start, end, org, dest;
  public ArrayList<PVector>Brez = new ArrayList<PVector>();
  public ArrayList<PVector>SnapGrid = new ArrayList<PVector>();
  public float dx, dy, Steps, xInc, yInc, inc, x1, x2, y1, y2, x, y;
  
  Road(PVector _start, PVector _end, int _id){
    start = _start;
    end = _end;
    OSMid = _id;
  }
  
  public void bresenham(){
//      println("running brez");
      int inc = 1;
      PVector starting = mercatorMap.getScreenLocation(new PVector(start.x, start.y));
      PVector ending = mercatorMap.getScreenLocation(new PVector(end.x, end.y));
      
        x1 = starting.x;
        x2 = ending.x;
        y1 = starting.y;
        y2 = ending.y;
        
        org = new PVector(x1, y1);
        dest = new PVector(x2, y2);
        
        
     //these are what will be rendered between the start and end points, initialize at start
        x = org.x;
        y = org.y;
        
        //calculating the change in x and y across the line
        dx = abs(dest.x - org.x);
        dy = abs(dest.y - org.y);
        
        //number of steps needed, based on what change is biggest
        //depending on your need for accuracy, you can adjust this, the smaller the Steps number, the fewer points rendered
        if(dx > dy){
          Steps = dx/1.75;
        }
        else{
          Steps = dy/1.75;        
        }
        
         //x and y increments for the points in the line      
        float xInc = (dx)/(Steps);
        float yInc = (dy)/(Steps);
        
        //this is the code to render vertical and horizontal lines, which need to be handled differently at different resolution for my implementation
                if(x1 == x2 || y1 == y2){
                       if (y2 < y1 || x2 < x1) {
                          org = new PVector(x2, y2);
                          dest = new PVector(x1, y1);
                        }
            
                        else{
                          org = new PVector(x1, y1);
                          dest = new PVector(x2, y2);
                        }
        
                        //slopes of the lines
                        dx = abs(dest.x - org.x);
                        dy = abs(dest.y - org.y);
                      
                        //steps needed to render the lines
                        if (dx > dy) {
                          Steps = dx*inc;
                        } else {
                          Steps = dy*inc;
                        }
                      
                        //increments for the points on the line 
                         xInc =  dx/(Steps);
                         yInc = dy/(Steps);
                      
                        //sets a starting point
                        x = org.x;
                        y = org.y;  
                 }
                 
          for(int v = 0; v< (int)Steps; v++){       
                //there are four main cases that need to be handled
                      if(dest.x < org.x && dest.y < org.y){
                           x = x - xInc;    y = y - yInc;
                                }
                      else if(dest.y < org.y){
                           x = x + xInc;    y = y - yInc;
                                }  
                      else if(dest.x < org.x){
                           x = x - xInc;    y = y + yInc;
                                }
                      else{ 
                           x = x + xInc;    y = y + yInc;
                             }
  
                        if(x <= max(x1, x2) && y<= max(y1, y2) && x >= min(x1, x2) && y >= min(y1, y2) 
                        && x >= 0 && x <= width && y >= 0 && y<= height){
                            PVector coord = mercatorMap.getGeo(new PVector(int(x), int(y), 0));
                            //Brez.add(new PVector(int(x), int(y), 0));
//                            if(v%4 == 0){
                            Brez.add(coord);
                            //}
                        }
              }
            HashSet set = new HashSet(Brez);
            Brez.clear();
            Brez.addAll(set);
        
}
 
}

public class RoadNetwork{
  public ArrayList<Road>Roads = new ArrayList<Road>();
  public int size, capacity, normcap;
  public String name;
  public bbox bounds;
  
  RoadNetwork(String _name, bbox _Bounds){
      name = _name;
      bounds = _Bounds;
      size = Roads.size();
  }
  
   void GenerateNetwork(int genratio){
     Roads.clear();
      
      JSONArray input = loadJSONArray(mapling);
      
      for(int m = 0; m<genratio; m++){
        try{
          JSONObject JSONM = input.getJSONObject(m); 
          JSONObject JSON = JSONM.getJSONObject("roads");
          JSONArray JSONlines = JSON.getJSONArray("features");
//              try{
                for(int i=0; i<JSONlines.size(); i++) {
                  String type = JSON.getJSONArray("features").getJSONObject(i).getJSONObject("geometry").getString("type");
                  int OSMid = JSON.getJSONArray("features").getJSONObject(i).getJSONObject("properties").getInt("id");
  
                if(type.equals("LineString")){
                 JSONArray linestring = JSON.getJSONArray("features").getJSONObject(i).getJSONObject("geometry").getJSONArray("coordinates");
                   for(int j = 0; j<linestring.size(); j++){
                     if(j<linestring.size()-1){
                        PVector start = new PVector(linestring.getJSONArray(j).getFloat(1), linestring.getJSONArray(j).getFloat(0));
                        PVector end = new PVector(linestring.getJSONArray(j+1).getFloat(1), linestring.getJSONArray(j+1).getFloat(0));
                        if(bounds.inbbox(start) == true || bounds.inbbox(end) == true){ 
                        Road road = new Road(start, end, OSMid);
                        Roads.add(road);
                           }
                   }
                   }
            }
             if(type.equals("MultiLineString")){
                   JSONArray multi = JSON.getJSONArray("features").getJSONObject(i).getJSONObject("geometry").getJSONArray("coordinates");
                           for(int k = 0; k<multi.size(); k++){
                               JSONArray substring = multi.getJSONArray(k);
                                    for(int d = 0; d<substring.size(); d++){
                                           float lat = substring.getJSONArray(d).getFloat(1);
                                           float lon = substring.getJSONArray(d).getFloat(0);
                                            if(d<substring.size()-1){
                                                  PVector start = new PVector(substring.getJSONArray(d).getFloat(1), substring.getJSONArray(d).getFloat(0));
                                                  PVector end = new PVector(substring.getJSONArray(d+1).getFloat(1), substring.getJSONArray(d+1).getFloat(0));
                                               if(bounds.inbbox(start) == true || bounds.inbbox(end) == true){
                                                  Road road = new Road(start, end, OSMid);
                                                  Roads.add(road);
                                               }
                                            }
                                    }
                           }
                   }
                    }
            }
            catch(Exception e){
            }
                }
              println("Nodes: ", Roads.size());
              println("Bounding Box: ");
              bounds.printbox();
      }
      
  

  void drawRoads(PGraphics p, color c){
    println("Drawing roads...");
         p.beginDraw();
     for(int j = 0; j<bounds.boxcorners().size(); j++){
            PVector coord2;
            PVector coord = mercatorMap.getScreenLocation(bounds.boxcorners().get(j));
            if(j<bounds.boxcorners().size()-1){
            coord2 = mercatorMap.getScreenLocation(bounds.boxcorners().get(j+1));
            }
            else{
              coord2 = mercatorMap.getScreenLocation(bounds.boxcorners().get(0));
            }
            p.stroke(0);
            p.fill(#0000ff);
            p.ellipse(mercatorMap.getScreenLocation(bounds.boxcorners().get(0)).x, mercatorMap.getScreenLocation(bounds.boxcorners().get(0)).y, 10, 10); 
            p.fill(#00ff00);
            p.ellipse(mercatorMap.getScreenLocation(bounds.boxcorners().get(1)).x, mercatorMap.getScreenLocation(bounds.boxcorners().get(1)).y, 10, 10);
            p.fill(#ffff00);
             p.ellipse(mercatorMap.getScreenLocation(bounds.boxcorners().get(2)).x, mercatorMap.getScreenLocation(bounds.boxcorners().get(2)).y, 10, 10);
             p.fill(#ff0000);
             p.ellipse(mercatorMap.getScreenLocation(bounds.boxcorners().get(3)).x, mercatorMap.getScreenLocation(bounds.boxcorners().get(3)).y, 10, 10);
            p.line(coord.x, coord.y, coord2.x, coord2.y);
        }
        p.stroke(0);
          for(int i = 0; i<numcols+1; i++){
                float ww = abs(mercatorMap.getScreenLocation(bounds.boxcorners().get(3)).x - mercatorMap.getScreenLocation(bounds.boxcorners().get(0)).x);
                float hh = abs(mercatorMap.getScreenLocation(bounds.boxcorners().get(2)).y - mercatorMap.getScreenLocation(bounds.boxcorners().get(0)).y);
          }
  
      for(int i = 0; i<Roads.size(); i++){
        p.strokeWeight(1);
        PVector start = mercatorMap.getScreenLocation(new PVector(Roads.get(i).start.x, Roads.get(i).start.y));
        PVector end = mercatorMap.getScreenLocation(new PVector(Roads.get(i).end.x, Roads.get(i).end.y));
        if(showid){
            for(int j = 0; j<Roads.get(i).Brez.size(); j++){
               PVector coord = mercatorMap.getScreenLocation(new PVector(Roads.get(i).Brez.get(j).x, Roads.get(i).Brez.get(j).y));
                p.noFill();
                p.stroke(#ff0000);
                PVector nextcoord = new PVector(0, 0);
                if(j < Roads.get(i).Brez.size()-1){
                 nextcoord = mercatorMap.getScreenLocation(new PVector(Roads.get(i).Brez.get(j+1).x, Roads.get(i).Brez.get(j+1).y));
                }
                  if(abs(nextcoord.x - coord.x) > 5 || abs(nextcoord.y - coord.y) > 5){
                    p.ellipse(coord.x, coord.y, 5, 5);
                  }
            }
            p.stroke(0);
            p.ellipse(start.x, start.y, 3, 3);
        }
        p.stroke(c);
        p.line(start.x, start.y, end.x, end.y);  
      }
   p.endDraw(); 
   println("DONE: Roads Drawn", millis());
}
  
}

ArrayList<PVector> BresenhamMaster = new ArrayList<PVector>();

void test_Bresen(){
  for(int i = 0; i<canvas.Roads.size(); i++){
        for(int j = 0; j<canvas.Roads.get(i).Brez.size(); j++){
             BresenhamMaster.add(canvas.Roads.get(i).Brez.get(j));
        }
  }
  println("Brez", BresenhamMaster.size());
}
