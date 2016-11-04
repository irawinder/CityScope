class GridCell{
  float cellwidth, population;
  bbox bounds;
  ArrayList<PVector> Nodes;
      GridCell(float _cellwidth, float _pop, bbox _bounds){
          population = _pop;
          cellwidth = _cellwidth;
          bounds = _bounds;
      }
   
 void PopulateNodes(RoadNetwork network){
    for(int i = 0; i<network.Roads.size(); i++){
        network.Roads.get(i).bresenham();
        for(int j = 0; j<network.Roads.get(i).Brez.size(); j++){
          PVector coord = network.Roads.get(i).Brez.get(j);
          if(bounds.inbbox(coord) == true){
                Nodes.add(coord);
            }
        }
    }
 }
      
}

class Grid{
  bbox bounds;
  ArrayList<GridCell> cells;
  int w, h, numcells;
  String name;
  Grid(String _name, ArrayList<GridCell> _cells){
      name = _name;
      cells = _cells;
      numcells = numrows*numcols;
  }
  void generategrid(RoadNetwork network, int numrows, int numcols, PGraphics p){
      for(int i = 0; i<numcells; i++){
        PVector upperleft = mercatorMap.getScreenLocation(network.bounds.boxcorners().get(1));
        PVector bottomright = mercatorMap.getScreenLocation(network.bounds.boxcorners().get(3));
        
          bbox cellbb = new bbox(upperleft.x + (i)*boxw/numcols, upperleft.y + (i)*boxw/numcols, upperleft.x + (i+1)*boxw/numcols, upperleft.y + (i+1)*boxw/numcols);
          p.stroke(#0000ff);
          p.rect(upperleft.x + (i)*boxw/numcols, upperleft.y + (i)*boxw/numcols, upperleft.x + (i+1)*boxw/numcols, upperleft.y + (i+1)*boxw/numcols);
          
          GridCell cell = new GridCell(boxw/numcols, random(50), cellbb);
          
          //for(int i = 0; i<numcols+1; i++)
          //    line(int(i*boxw/numcols) + int(mouseX), mouseY, int(i*boxw/numcols) + int(mouseX), mouseY+boxh);
          //  
          //  for(int i = 0; i<numrows+1; i++)
          //    line(mouseX, int(i*boxh/numrows) + int(mouseY), mouseX + boxw, int(i*boxh/numrows) + int(mouseY));
      }
      //pull network
      //make grid cells with bounding box blehhhh
      //run populate nodes function
  }
  
  void drawgrid(){
        
    }
}
