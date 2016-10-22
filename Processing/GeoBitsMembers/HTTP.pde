/* 

Set of classes responsible for reading data from OSM, Mapzen, and Overpass APIs

GetRequest is based off code by Chris Allick and Daniel Shiffman

*/

String output, file, link, export, linegrab, progress;
JSONObject geostuff;

//bbox Bounds;

ArrayList<String>files = new ArrayList<String>();
String mapling;
ArrayList<PVector>PullBox = new ArrayList<PVector>();

 JSONArray masterexport = new JSONArray();
 JSONObject exportjson;
 bbox Bounds, SelBounds;

public void PullMap(int amount, float w, float h){
   pulling = true;
   println("requesting map data...");
    
   for(int i = 0; i<amount; i++){
   link = "http://vector.mapzen.com/osm/all/" + MapTiles(width, height, 0 , 0).get(i) +".json?api_key=vector-tiles-i5Sxwwo";
   Bounds = new bbox(map.getLocation(0, height).x, map.getLocation(0, height).y, map.getLocation(width, 0).x, map.getLocation(width, 0).y);
       canvas = new RoadNetwork("Canvas", Bounds);
   SelBounds = new bbox(SelectionBox().get(1).x, SelectionBox().get(0).y, SelectionBox().get(0).x, SelectionBox().get(1).y);
       selection = new RoadNetwork("Selection", SelBounds);
   places = new ODPOIs("Places");
   GetRequest get = new GetRequest(link);
   println("data requested...");
   get.send();
   output = get.getContent();
try{
   masterexport.setJSONObject(i, parseJSONObject(output)); 
}
  catch(Exception e){}
   println(int(float(i)/amount*100) + "% DONE");
   }
   try{
   saveJSONArray(masterexport, "exports/map" + map.getLocation(0, 0) + "_" + map.getLocation(width, height)+".json");
   mapling = "exports/map" + map.getLocation(0, 0) + "_" + map.getLocation(width, height)+".json";
   }
   catch(Exception e){
   }

}

public void PullOSM(){
//   String APIbox = SelectionBox().get(0).y + ","+ SelectionBox().get(1).x +","+ SelectionBox().get(1).y + "," +SelectionBox().get(0).x;
   String APIbox = map.getLocation(0, height).y + "," + map.getLocation(0, height).x + "," + map.getLocation(width, 0).y + "," + map.getLocation(width, 0).x;
//   println(SelectionBox().get(0).y + ","+ SelectionBox().get(1).x +","+ SelectionBox().get(1).y + "," +SelectionBox().get(0).x, "Sel box");
//   println(map.getLocation(0, height).x, map.getLocation(0, height).y, map.getLocation(width, 0).x, map.getLocation(width, 0).y, "Map box");
   link = "http://api.openstreetmap.org/api/0.6/map?bbox=" + APIbox;
   println(link);
  GetRequest get = new GetRequest(link);
   println("data requested...");
   get.send();
   output = get.getContent();
   String[] test = split(output, "fhajksdhfjajksdkfoiijhedjifkm"); //just gets into a text array without splitting because that char string won't exist
   saveStrings( "exports/" + "OSM"+ map.getLocation(0, 0) + "_" + map.getLocation(width, height)+ ".xml", test);
   println("DONE: OSM Raw Data Pulled");
}

//XML xml; 
public void PullWidths(){
  int numwidths = 0;
  JSONArray mapjson = loadJSONArray(mapling);
  XML[] widthtag;
  xml = loadXML("exports/" + "OSM"+ map.getLocation(0, 0) + "_" + map.getLocation(width, height)+ ".xml");
  XML[] children = xml.getChildren("way");
  for(int i = 0; i<children.length; i++){
      widthtag = children[i].getChildren("tag"); 
  for(int j = 0; j<widthtag.length; j++){
    try{
//      if(widthtag[j].getString("k").equals("lanes")){
//          for(int m = 0; m<MapTiles(width, height, 0, 0).size(); m++){ //iterates over all the tiles
//          JSONObject JSONM = mapjson.getJSONObject(m); 
//          JSONObject JSON = JSONM.getJSONObject("roads");
//          JSONArray JSONlines = JSON.getJSONArray("features");
//              for(int d = 0; d<JSONlines.size(); d++){
//              JSONObject properties = JSON.getJSONArray("features").getJSONObject(d).getJSONObject("properties");
//              String kind = properties.getString("highway");
//              if(kind.equals("residential") || kind.equals("secondary")){
//                  properties.setInt("speed", 40);
//              }
//               if(kind.equals("trunk")){
//                  properties.setInt("speed", 65);
//              }
//              int OSMid = JSON.getJSONArray("features").getJSONObject(d).getJSONObject("properties").getInt("id");
//              if(children[i].getInt("id") == OSMid){
//                numwidths+=1;
//                properties.setFloat("lanes", float(widthtag[j].getString("v")));
//              }
//              }
//      }
//      }
   if(widthtag[j].getString("k").equals("width")){
          for(int m = 0; m<MapTiles(width, height, 0, 0).size(); m++){ //iterates over all the tiles
          JSONObject JSONM = mapjson.getJSONObject(m); 
          JSONObject JSON = JSONM.getJSONObject("roads");
          JSONArray JSONlines = JSON.getJSONArray("features");
              for(int d = 0; d<JSONlines.size(); d++){
              JSONObject properties = JSON.getJSONArray("features").getJSONObject(d).getJSONObject("properties");
              properties.setInt("width", int(widthtag[j].getString("v")));
              }
      }
      }
        }
          catch( Exception e ){}
      }
  }
  saveJSONArray(mapjson, "exports/widths"+ map.getLocation(0, 0) + "_" + map.getLocation(width, height) + ".json");
  println("DONE: Width property extracted " + numwidths + " widths (in meters) of ways available.");
}

XML xml; 
//public void PullPOIs(){
//  println("pulling POIS");
//  XML[] widthtag;
//  xml = loadXML("exports/" + "OSM"+ map.getLocation(0, 0) + "_" + map.getLocation(width, height)+ ".xml");
//  XML[] children = xml.getChildren("node");
//  println(children.length);
//  for(int i = 0; i<children.length; i++){
//    float lat = float(children[i].getString("lat"));
//    float lon = float(children[i].getString("lon"));
//       if(i < children.length){
//         float prevlat = float(children[i+1].getString("lat"));
//         float prevlon = float(children[i+1].getString("lon"));
//             if(prevlat != lat && prevlon != lon){
//                 PVector loc = new PVector(lat, lon);
//                 POI poi = new POI(loc, 12, 0, "test", "stuff");
//                 POIs.add(poi);
//             }
//       }
//}
//    println("POIs generated: ", POIs.size());
//}

//imports the needed Java classes that Processing doesn't have natively, as we want to avoid using the net library and just do a basic HTTP request 
import java.util.Iterator;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

public class GetRequest
{
  String url;
  String content;
  HttpResponse response;
      ArrayList<BasicNameValuePair> headerPairs;

  
  public GetRequest(String url) 
  {
    this.url = url;
            headerPairs = new ArrayList<BasicNameValuePair>();

  }

  public void send() 
  {
    try {
      DefaultHttpClient httpClient = new DefaultHttpClient();

      HttpGet httpGet = new HttpGet(url);

                      Iterator<BasicNameValuePair> headerIterator = headerPairs.iterator();
                      while (headerIterator.hasNext()) {
                          BasicNameValuePair headerPair = headerIterator.next();
                          httpGet.addHeader(headerPair.getName(),headerPair.getValue());
                      }
  

      response = httpClient.execute( httpGet );
      HttpEntity entity = response.getEntity();
      this.content = EntityUtils.toString(response.getEntity());
      
      if( entity != null ) EntityUtils.consume(entity);
      httpClient.getConnectionManager().shutdown();
      
    } catch( Exception e ) { 
      e.printStackTrace(); 
    }
  }
  
  /* Getters
  _____________________________________________________________ */
  
  public String getContent()
  {
    return this.content;
  }

}

