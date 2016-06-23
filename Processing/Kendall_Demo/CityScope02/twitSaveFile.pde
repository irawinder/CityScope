

void saveJSON() {
  for (int i = 0 ; i < nodes.size() ; i++) {
    Node tempNode = nodes.get(i);
    JSONObject jsonNode = new JSONObject();
    //Set JSON values for node
    jsonNode.setString("user", tempNode.user);
    jsonNode.setString("location", tempNode.location);

    //save node messages
    JSONArray jsonMessages = new JSONArray();
    for (int j = 0 ; j< tempNode.messages.size() ; j++) {
      JSONObject jsonMsg = new JSONObject();
      Msg tempMsg = tempNode.messages.get(j);
      jsonMsg.setFloat("lat", tempMsg.lat);
      jsonMsg.setFloat("lon", tempMsg.lon);
      jsonMsg.setString("msg", tempMsg.msg);
      jsonMsg.setString("user", tempMsg.user);
      jsonMsg.setString("date", tempMsg.date);
      jsonMsg.setString("msgID", tempMsg.msgID);
      jsonMsg.setString("location", tempMsg.location);
      jsonMessages.setJSONObject(j, jsonMsg);
    }

    jsonNode.setJSONArray("messages", jsonMessages);

    //save node polylines
    JSONArray jsonPolylines = new JSONArray();

    for (int j = 0 ; j< tempNode.polylines.size() ; j++) {

      ArrayList<PVector> tempPolyline = tempNode.polylines.get(j); //get polyline

      JSONArray jsonPoints = new JSONArray();

      for (int k = 0 ; k< tempPolyline.size() ; k++) {
        JSONObject jsonVector = new JSONObject();
        PVector tempVec =  tempPolyline.get(k);
        jsonVector.setFloat("x", tempVec.x);
        jsonVector.setFloat("y", tempVec.y);
        jsonPoints.setJSONObject(k, jsonVector);
      }

      jsonPolylines.setJSONArray(j, jsonPoints);
    }

    jsonNode.setJSONArray("polylines", jsonPolylines);


    //save node polylines Dates
    JSONArray jsonPolylineDates = new JSONArray();
    for (int j = 0 ; j< tempNode.polydates.size() ; j++) {
      jsonPolylineDates.setString(j, tempNode.polydates.get(j));
    }

    println(jsonPolylineDates);

    jsonNode.setJSONArray("polylineDates", jsonPolylineDates);


    savedJSON.setJSONObject(i, jsonNode);
  }
  saveJSONArray(savedJSON, "savedNodes.json");

 // println( "Saving JSON" );
}


void loadJSON() {
  //LOAD Saved NODES FROM FILE
  savedJSON = loadJSONArray("savedNodes.json");
  println("Loaded JSON Objects: " + savedJSON.size());

  for (int i = 0 ; i < savedJSON.size() ; i++) {
    JSONObject jsonNode =savedJSON.getJSONObject(i);
    Node tempNode = new Node(jsonNode.getString("user"), jsonNode.getString("location"));

    //get Messages
    JSONArray jsonMessages = jsonNode.getJSONArray("messages");
    for (int j = 0 ; j < jsonMessages.size() ; j++) {
      JSONObject jsonMsg = jsonMessages.getJSONObject(j);
      Msg tempMsg = new Msg(jsonMsg.getFloat("lat"), jsonMsg.getFloat("lon"), jsonMsg.getString("msg"), jsonMsg.getString("user"), jsonMsg.getString("date"), jsonMsg.getString("msgID"), jsonMsg.getString("location"));
      tempNode.messages.add(tempMsg);
    }

    //get Polylines
    JSONArray jsonPolylines = jsonNode.getJSONArray("polylines");
    for (int j = 0 ; j < jsonPolylines.size() ; j++) {
      ArrayList<PVector> tempPolyline = new ArrayList<PVector>();
      JSONArray jsonPolyline = jsonPolylines.getJSONArray(j);
      for (int k = 0 ; k < jsonPolyline.size() ; k++) {
        JSONObject jsonVector = jsonPolyline.getJSONObject(k);
        PVector p = new PVector(jsonVector.getFloat("x"), jsonVector.getFloat("y"));
        tempPolyline.add(p);
      }
      tempNode.polylines.add(tempPolyline);
    }

    //get Polyline Dates
    JSONArray jsonPolydates = jsonNode.getJSONArray("polylineDates");
    for (int j = 0 ; j < jsonPolydates.size() ; j++) {
     tempNode.polydates.add(jsonPolydates.getString(j));
    }

    nodes.add(tempNode);
  }
}

