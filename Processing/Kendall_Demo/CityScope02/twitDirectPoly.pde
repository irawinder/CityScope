
/////////// Google direction retrieval
/////////// code Written By Carson Smuts
/////////// 2014


void getDirect(int nodeIndex, float lat, float lon, float lat2, float lon2, String date) {


  ///////////////////////////////////////METHOD ONE//////////////////////////////////////

  HttpsURLConnection connection2 = null;

  String DIRECT_Search = "https://maps.googleapis.com/maps/api/directions/json?origin=";
  DIRECT_Search = DIRECT_Search + lat + "," + lon + "&destination=" + lat2 + "," + lon2 + "&sensor=true&mode=cycling";

  try {
    URL url = new URL(DIRECT_Search); 
    connection2 = (HttpsURLConnection) url.openConnection();           
    // connection2.setDoOutput(true);
    // connection2.setDoInput(true); 
    connection2.setRequestMethod("GET"); 
    connection2.setRequestProperty("Host", "maps.googleapis.com");
    connection2.setRequestProperty("User-Agent", "Your Program Name");


    String TempS = readResponse(connection2);
    // println(TempS);
    JSONObject directJSON = JSONObject.parse(TempS);
    JSONArray routes = directJSON.getJSONArray("routes");
    JSONObject theRoute = routes.getJSONObject(0);
    // println(directJSON);


    JSONObject poly = theRoute.getJSONObject("overview_polyline");
    String polyline = poly.getString("points");

    //println(tempPoly);

    Node tempNode = nodes.get(nodeIndex);

    //println(tempNode.polylines);

    ArrayList<PVector> tempPoly = decodePoly(polyline);
    tempNode.polylines.add(tempPoly);
    tempNode.polydates.add(date);
    
  }
  catch (Exception e) {
    //throw new IOException("Invalid endpoint URL specified.", e);
  }
}





//ArrayList<PVector> tempPoly = directToNode(nodeIndex, theRoute);
ArrayList<PVector> directToNode(int nodeIndex, JSONObject theRoute) {   //Old method of extracting individual steps

  ArrayList<PVector> poly = new ArrayList<PVector>();
  JSONArray legs = theRoute.getJSONArray("legs");
  JSONObject theLeg = legs.getJSONObject(0);
  JSONArray steps = theLeg.getJSONArray("steps");

  for (int i = 0 ; i < steps.size() ; i++) {
    JSONObject step = steps.getJSONObject(i);
    JSONObject start = step.getJSONObject("start_location");

    float startLat = start.getFloat("lat");
    float startLon = start.getFloat("lng");

    JSONObject end = step.getJSONObject("end_location");

    float endLat = end.getFloat("lat");
    float endLon = end.getFloat("lng");

    println(start);
    println(end);
    //PVector startp = new PVector( startLat, startLon);
    PVector endp = new PVector( endLat, endLon);

    poly.add(endp);
  }

  return poly;
}



/**
 * Converted by Carson Smuts from Method to decode polyline points
 * Courtesy : jeffreysambells.com/2010/05/27/decoding-polylines-from-google-maps-direction-api-with-java
 * */

ArrayList<PVector> decodePoly(String encoded) {
  ArrayList<PVector> poly = new ArrayList<PVector>();
  int index = 0;
  int len = encoded.length();
  int lat = 0;
  int lng = 0;

  while (index < len) {
    int b, shift = 0, result = 0;
    do {
      b = encoded.charAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } 
    while (b >= 0x20);
    int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    lat += dlat;

    shift = 0;
    result = 0;
    do {
      b = encoded.charAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } 
    while (b >= 0x20);
    int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    lng += dlng;

    PVector p = new PVector( (((float) lat / 1E5) ), (((float) lng / 1E5) ));
    poly.add(p);
  }

  return poly;
}

