class POI{
  public String name, kind;
  public int id, total, totalin;
  public PVector location;
//  ArrayList<Edge> edgeout = new ArrayList<Edge>();
//  ArrayList<Edge> edgein = new ArrayList<Edge>();
//  
  POI(PVector _location, int _id, int _total, String _name, String _kind){
        location = _location;
        id = _id;
        total = _total;
        name = _name;
        kind = _kind;
    }
}

class ODPOIs{
   public ArrayList<POI>POIs = new ArrayList<POI>(); 
   public String name;
   
   ODPOIs(String _name){
     name = _name;
   }
   
public void PullPOIs(){
  println("pulling POIS");
  XML[] widthtag;
  if(!demo){
  xml = loadXML("exports/" + "OSM"+ map.getLocation(0, 0) + "_" + map.getLocation(width, height)+ ".xml");
  }
  
  if(demo){
   xml = loadXML("data/OSM(42.363, -71.068)_(42.357, -71.053).xml");
  }
  XML[] children = xml.getChildren("node");
  println(children.length);
  for(int i = 0; i<children.length; i++){
    XML[] tag = children[i].getChildren("tag"); 
    for(int j = 0; j < tag.length; j++){
        if(tag[j].getString("k").equals("amenity") || tag[j].getString("k").equals("building") || tag[j].getString("k").equals("poi")){
            float lat = float(children[i].getString("lat"));
            float lon = float(children[i].getString("lon"));
                     PVector loc = new PVector(lat, lon);
                     POI poi = new POI(loc, 12, 0, "test", "stuff");
                     POIs.add(poi);
        }
    } 
}
    println("POIs generated: ", POIs.size());
}   
  
public void generate_POIs(){
//    println("Generating POIs...");
//    JSONArray input = loadJSONArray(mapling);
//    try{
//    for(int m = 0; m<MapTiles(width, height, 0, 0).size(); m++){
//        JSONObject JSONM = input.getJSONObject(m); 
//        JSONObject JSON = JSONM.getJSONObject("pois");
//        JSONArray JSONlines = JSON.getJSONArray("features");
//              for(int i=0; i<JSONlines.size(); i++) {
//                String kind = JSON.getJSONArray("features").getJSONObject(i).getJSONObject("properties").getString("kind");
//                int OSMid = JSON.getJSONArray("features").getJSONObject(i).getJSONObject("properties").getInt("id");
//                String name = JSON.getJSONArray("features").getJSONObject(i).getJSONObject("properties").getString("name");
//                 JSONArray POI_coord = JSON.getJSONArray("features").getJSONObject(i).getJSONObject("geometry").getJSONArray("coordinates");
//                 PVector loc = new PVector(POI_coord.getFloat(1), POI_coord.getFloat(0));
//                  POI poi = new POI(loc, OSMid, 0, name, kind);
//                  POIs.add(poi);
//              }
//              
//            }
//    }
//            
//            catch(Exception e){
//            } 
//        println("POIs generated: ", POIs.size());

 }
 
}
    
