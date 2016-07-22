JSONObject nodes;
JSONArray nodevals;

Table Neighbors;
class Grid{
  int dimx, dimy, cellwidth;

  void export(int cellwidth){
    Neighbors = new Table();
    println("exporting nodes");
            nodevals = new JSONArray();

            for(int i = 0; i<SnapGrid.size(); i++){
                  nodes = new JSONObject();
                  nodes.setFloat("u", SnapGrid.get(i).x);
                  nodes.setFloat("v", SnapGrid.get(i).y);
                  nodes.setFloat("z", SnapGrid.get(i).z);
                  nodevals.setJSONObject(i, nodes);
                      }
             saveJSONArray(nodevals, "exports/nodes" + cellwidth + "_kilometers_.json"); 
             println("nodes exported");
    }
      
  }
