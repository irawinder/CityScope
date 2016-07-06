JSONObject nodes;
JSONArray nodevals;

Table Neighbors;
class Grid{
  int dimx, dimy, cellwidth;
  
  void render(int cellwidth, int dimx, int dimy){
       scale = Canvaswidth/dimx;
  }


  void export(int cellwidth, int dimx, int dimy){
    Neighbors = new Table();
    Neighbors.addColumn("Node index");
    Neighbors.addColumn("Neighbor index");
    println("exporting nodes");
            nodevals = new JSONArray();

            for(int i = 0; i<SnapGrid.size(); i++){
                 
                  nodes = new JSONObject();
                  nodes.setFloat("u", SnapGrid.get(i).x);
                  nodes.setFloat("v", SnapGrid.get(i).y);
                  nodes.setFloat("z", SnapGrid.get(i).z);
                          for(int j = 0; j<crossings.size(); j++){
                            if(abs(crossings.get(j).x - SnapGrid.get(i).x) <= cellwidth && abs(crossings.get(j).y - SnapGrid.get(i).y) <= cellwidth){
                              nodes.setString("crossing", "true");
                            }
                            else if(abs(crossings.get(j).x - SnapGrid.get(i).x) > cellwidth && abs(crossings.get(j).y - SnapGrid.get(i).y) > cellwidth){
                              nodes.setString("crossing", "false");
                            }   
                            
                          }
                  
                
                  for(int k = 0; k<SnapGrid.size(); k++){
                      float dist = sqrt(sq(SnapGrid.get(i).x - SnapGrid.get(k).x) + sq(SnapGrid.get(i).y - SnapGrid.get(k).y));
                      if(dist <2*scale && dist !=0){
                        TableRow newRow = Neighbors.addRow();
                        newRow.setFloat("Neighbor index", float(k));
                        newRow.setFloat("Node index", float(i));
                      }
                      
                  }

                  nodevals.setJSONObject(i, nodes);
                      }
             saveJSONArray(nodevals, "exports/nodes" + cellwidth + "_meters_" + dimx + "_by_" + dimy + ".json"); 
             saveTable(Neighbors, "exports/neighbors" + cellwidth + ".csv");
             println("nodes exported");
    }
      
  }
