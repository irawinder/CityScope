
/////////// Twitter Kendal Square feeds v7b
/////////// code By Carson Smuts
/////////// 2014


/////////GLOBAL SETTINGS////////

boolean startHashStream  = true;

boolean sketchFullScreen() {
  return false;
} 
////////////////////////////////






import java.util.Date;
import java.text.SimpleDateFormat;


import processing.net.*;
import javax.xml.bind.DatatypeConverter;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import javax.net.ssl.HttpsURLConnection;

import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.ui.*;
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.providers.*;


// import UDP library
import hypermedia.net.*;
UDP udp;  // define the UDP object

UnfoldingMap map;


JSONObject globalJSON;
JSONArray savedJSON;

ArrayList<Node> nodes;

int last;
int randUserTimer;


//New York
//float lat = 40.775797;
//float lon = -73.957815;

//Boston-Kendall
float lat = 42.363917;
float lon = -71.084028;

//Cape Town
//float lat =-33.92367;
//float lon =18.433428;

//Defense Colony
//float lat = 12.975556;
//float lon = 77.640861;
boolean launching = true;

float scaleF = 23000;

int centerX;
int centerY;

boolean tweetSelected;

boolean cyleusers = true;
int selectedNode;
int selectedMsg;

boolean reset = false;
boolean startedDates = false;


boolean foundHashTag = false;
String hashString;
Msg hashMsg;
int hashTimer = 0;

boolean drawPaths = false;

void setupTwitter() {


  nodes = new ArrayList<Node>();  // Create an empty ArrayList
  savedJSON = new JSONArray();
  loadJSON();
  //getTweets();


  //Test Projection
  PVector testProj = mercatorMap.getScreenLocation(new PVector( 42.358922371673074, -71.07729187107644));
  println(testProj);

  getRandomUser();

  smooth();
  stroke(255);    
  frameRate(30);
  last=millis();
  centerX = width/2;
  centerY = height/2;

  udp = new UDP( this, 6100 );
  //udp.log( true );     // <-- printout the connection activity
  udp.listen( true );


  if (f==null)f = new PFrame(); //Creates a new window for controls

}

void drawTwitter() {

  setMercator();

  boolean showCorners = false;
  if (showCorners) {
    fill(255, 255, 255, 125);

    PVector p1 = mercatorMap.getScreenLocation(new PVector(42.360395930249723, -71.090762482750293));
    PVector p2 = mercatorMap.getScreenLocation(new PVector(42.368912156588415, -71.088776097501125));
    PVector p3 = mercatorMap.getScreenLocation(new PVector(42.367438402431446, -71.07729187107644));
    PVector p4 = mercatorMap.getScreenLocation(new PVector(42.358922371673074, -71.079279756061354));

    p1.x = p1.x - w_shift;
    p2.x = p2.x - w_shift;
    p3.x = p3.x - w_shift;
    p4.x = p4.x - w_shift;

    p1.y = p1.y - h_shift;
    p2.y = p2.y - h_shift;
    p3.y = p3.y - h_shift;
    p4.y = p4.y - h_shift;

    ellipse(p1.x, p1.y, 125, 125);
    ellipse(p2.x, p2.y, 125, 125);
    ellipse(p3.x, p3.y, 125, 125);
    ellipse(p4.x, p4.y, 125, 125);
  }

  fill(255);



  for (int i = 0 ; i < nodes.size() ; i++) {


    Node tempNode = nodes.get(i);
    //   println(tempNode.user);


    for (int j = 0 ; j< tempNode.messages.size() ; j++) {
      Msg tempMsg = tempNode.messages.get(j);

      /////////////////GET DATE AND LOOK FOR EARLIEST AND LATEST/////////////////
      //SimpleDateFormat example - Date with timezone information
      //DateFormat DATE_FORMAT = new DateFormat("yyyy-MM-dd'T'HH:mm  'GMT'Z '('z')'");

      String format ="yyyy-MM-dd'T' HH:mm  'GMT'Z '('z')'";
      String format2 ="EEEE";
      SimpleDateFormat sdf = new SimpleDateFormat(format);

      Date gmtDate = new Date(tempMsg.date);// use your date here
      Date localDate = new Date(gmtDate.getTime() - 3600 * 1000);
      long dateMilli = localDate.getTime();
      long msgDate = new Date(tempMsg.date).getTime()- 3600 * 1000;
      long cullStart =new Date(cullDateStart).getTime()- 3600 * 1000;
      long cullEnd =new Date(cullDateEnd).getTime()- 3600 * 1000;



      if (launching && msgDate<cullStart) {
        cullDateStart = tempMsg.date;
        date1 = tempMsg.date;
      }

      if (launching && msgDate>cullEnd) {
        cullDateEnd = tempMsg.date;
        date2 = tempMsg.date;
        println(tempMsg.date);
      }


      fill(tempMsg.msgColor);
      strokeWeight(1);
      stroke(255, 255, 255, 125);

      // ellipse (x, y, 8, 8);


      //////////////ONLY DRAW IF DATE IS BIGGER THAN THE CULL DATE/////////
      Date cullGmtDateEnd = new Date(cullDateEnd);
      Date cullDateEnd = new Date(cullGmtDateEnd.getTime() - 3600 * 1000);
      long cullMilliEnd = cullDateEnd.getTime();

      Date cullGmtDateStart = new Date(cullDateStart);
      Date cullDateStart = new Date(cullGmtDateStart.getTime() - 3600 * 1000);
      long cullMilliStart = cullDateStart.getTime();

      if (dateMilli < cullMilliEnd && dateMilli > cullMilliStart) {

        //  println(dateMilli);
        // println(cullMilli);

        ///////////////////////////////////////////
        ////////// DRAW Tweets Locations///////////
        ///////////////////////////////////////////


        if (tempNode.user.equals("Name Search") == true) {
          selectedNode = i;
        }


        PVector p1 = mercatorMap.getScreenLocation(new PVector(tempMsg.lon, tempMsg.lat));

        p1.x = p1.x - w_shift;
        p1.y = p1.y - h_shift;

        stroke(65, 170, 219, 0);
        fill(255, 255, 255, 10);
        ellipse(p1.x, p1.y, 150, 150);

        fill(65, 170, 219, 60);

        ellipse(p1.x, p1.y, 20, 20);
        ellipse(p1.x, p1.y, 20, 20);
        ellipse(p1.x, p1.y, 20, 20);
        ellipse(p1.x, p1.y, 45, 45);
        ellipse(p1.x, p1.y, 55, 55);
        ellipse(p1.x, p1.y, 65, 65);
        ellipse(p1.x, p1.y, 85, 85);

        if (j>0) {
          Msg tempMsg2 = tempNode.messages.get(j-1);
          PVector p2 = mercatorMap.getScreenLocation(new PVector(tempMsg2.lon, tempMsg2.lat));
          p2.x = p2.x - w_shift;
          p2.y = p2.y - h_shift;
          strokeWeight(13);
          // stroke(65, 170, 219, 230);
          stroke(255, 0, 0, 140);
          // line(p1.x, p1.y, p2.x, p2.y );
          // println(p1 + " " + p2);
        }
      }//////////END CULL DATE CHECK////////
    }//end messages

    startedDates = true;


    ///////////////////////////////////////////
    ////////// DRAW Tweet Paths////////////////
    ///////////////////////////////////////////
    if (drawPaths) {
      //////////////ONLY DRAW IF DATE IS BIGGER THAN THE CULL DATE/////////


      for (int j = 0 ; j< tempNode.polylines.size() ; j++) {

        Date gmtDate = new Date(tempNode.polydates.get(j));// use your date here
        Date localDate = new Date(gmtDate.getTime() - 3600 * 1000);
        long dateMilli = localDate.getTime();

        Date cullGmtDateEnd = new Date(cullDateEnd);
        Date cullDateEnd = new Date(cullGmtDateEnd.getTime() - 3600 * 1000);
        long cullMilliEnd = cullDateEnd.getTime();

        Date cullGmtDateStart = new Date(cullDateStart);
        Date cullDateStart = new Date(cullGmtDateStart.getTime() - 3600 * 1000);
        long cullMilliStart = cullDateStart.getTime();

        if (dateMilli < cullMilliEnd && dateMilli > cullMilliStart) {


          //println(tempNode.polylines);
          ArrayList<PVector> polyline =tempNode.polylines.get(j);
          if (polyline.size()>1) {
            for (int k = 0 ; k< polyline.size() ; k++) {
              PVector p1 = mercatorMap.getScreenLocation(polyline.get(k));

              if (k==0 || k==polyline.size()-1) {
                fill(244, 255, 0, 190);
                noStroke();
                ellipse(p1.x- w_shift, p1.y- h_shift, 20, 20);
              }

              if (k>0) {
                PVector p2 = mercatorMap.getScreenLocation(polyline.get(k-1));
                stroke(255, 0, 0, 140);
                //stroke(65, 170, 219, 180);
                strokeWeight(10);
                line(p1.x- w_shift, p1.y- h_shift, p2.x- w_shift, p2.y- h_shift );

                //ellipse(p1.x, p1.y, 20, 20);
                //println(p1.x + "," + p1.y);
              }//end if k
            }//end pointlist
          }
        }// end cull polylines
      }//end polylines
    }//end DrawPaths
  }//end Nodes

  ////////////////DRAW #CitySCOPE location///////////////



  unsetMercator();


  ///////////////////////IF #CITYSCOPE DRAW USER DOT//////////////////
  if (foundHashTag) {
    setPulse();
    fill(0, 0, 0, 80);
    rect(0, 0, width, height);
  }

  setMercator();

  if (foundHashTag) {


    PVector mediaLAB = mercatorMap.getScreenLocation(new PVector(42.360918, -71.087516 ));
    mediaLAB.x = mediaLAB.x - w_shift;
    mediaLAB.y = mediaLAB.y - h_shift;

    for (int i = 200 ; i>0; i--) {
      fill(255, 36, 153, (.25*(200-i)*sin));
      noStroke();
      ellipse(mediaLAB.x, mediaLAB.y, i, i);
    }
  }
  else {//draw random user location
    setPulse();
    Node tempNode = nodes.get(selectedNode);
    //Node tempNode = nodes.get(nodes.size()-1);
    Msg tempMsg = tempNode.messages.get(tempNode.messages.size()-1);

    PVector randUserP = mercatorMap.getScreenLocation(new PVector(tempMsg.lon, tempMsg.lat ));
    randUserP.x = randUserP.x - w_shift;
    randUserP.y = randUserP.y - h_shift;
    // println(randUserP);
    for (int i = 200 ; i>0; i--) {
      fill(255, 36, 153, (.25*(200-i)*sin));
      noStroke();
      ellipse(randUserP.x, randUserP.y, i, i);
    }

    for (int j = 0 ; j< tempNode.polylines.size() ; j++) {

      Date gmtDate = new Date(tempNode.polydates.get(j));// use your date here
      Date localDate = new Date(gmtDate.getTime() - 3600 * 1000);
      long dateMilli = localDate.getTime();

      Date cullGmtDateEnd = new Date(cullDateEnd);
      Date cullDateEnd = new Date(cullGmtDateEnd.getTime() - 3600 * 1000);
      long cullMilliEnd = cullDateEnd.getTime();

      Date cullGmtDateStart = new Date(cullDateStart);
      Date cullDateStart = new Date(cullGmtDateStart.getTime() - 3600 * 1000);
      long cullMilliStart = cullDateStart.getTime();

      if (dateMilli < cullMilliEnd && dateMilli > cullMilliStart) {


        //println(tempNode.polylines);
        ArrayList<PVector> polyline =tempNode.polylines.get(j);
        if (polyline.size()>1) {
          for (int k = 0 ; k< polyline.size() ; k++) {
            PVector p1 = mercatorMap.getScreenLocation(polyline.get(k));

            if (k==0 || k==polyline.size()-1) {
              fill(244, 255, 0, 190);
              noStroke();
              ellipse(p1.x- w_shift, p1.y- h_shift, 20, 20);
            }

            if (k>0) {
              PVector p2 = mercatorMap.getScreenLocation(polyline.get(k-1));
              stroke(255, 0, 0, 140);
              //stroke(65, 170, 219, 180);
              strokeWeight(10);
              line(p1.x- w_shift, p1.y- h_shift, p2.x- w_shift, p2.y- h_shift );

              //ellipse(p1.x, p1.y, 20, 20);
              //println(p1.x + "," + p1.y);
            }//end if k
          }//end pointlist
        }
      }// end cull polylines
    }//end polylines
  }

  unsetMercator();

  ////////////////////////////////////////////////////////////////////////
  ////////////////////////IF #CITYSCOPE DRAW USER info////////////////////
  ////////////////////////////////////////////////////////////////////////

  if (foundHashTag) {
    //println("#cityscope");
    //////////////DRAW HASH TAG//////////////

    Msg tempMsg = hashMsg;
    //println(tempMsg.date);

    translate(width - 325, height-150);
    fill(255, 255, 255);
    //username
    textSize(20);
    text("Twitter User: " + tempMsg.user, 0, 0); 
    //message
    textSize(10);
    text(tempMsg.msg, 0, 20, 315, 100);
    fill(65, 170, 219, 240);
    //user date
    textAlign(RIGHT);
    textSize(11);

    //SimpleDateFormat example - Date with timezone information
    //DateFormat DATE_FORMAT = new DateFormat("yyyy-MM-dd'T'HH:mm  'GMT'Z '('z')'");

    String format ="yyyy-MM-dd'T' HH:mm  'GMT'Z '('z')'";
    String format2 ="EEEE";
    SimpleDateFormat sdf = new SimpleDateFormat(format);

    Date gmtDate = new Date(tempMsg.date);// use your date here
    Date localDate = new Date(gmtDate.getTime() - 3600 * 1000);

    //SimpleDateFormat sdf = new SimpleDateFormat(format);

    String bostonDate =sdf.format(localDate);
    text(bostonDate, 310, 120);
    fill(255, 255, 255);

    //Lat lon
    textSize(11);
    text("lat: " + tempMsg.lon + "  lon: " +tempMsg.lat, 310, 135);

    translate(-(width - 325), -(height-150));
  }
  else {/////Print random user


    Node tempNode = nodes.get(selectedNode);
    //Node tempNode = nodes.get(nodes.size()-1);
    Msg tempMsg = tempNode.messages.get(tempNode.messages.size()-1);
    //println(tempMsg.date);


    translate(width - 325, height-150);

    //username
    textSize(20);

    fill(255, 36, 153, 255);
    text("Twitter User: " + tempMsg.user, 0, 0); 
    fill(255, 255, 255);
    //message
    textSize(10);
    text(tempMsg.msg, 0, 20, 315, 100);
    fill(65, 170, 219, 240);
    
    //user date
    textAlign(RIGHT);
    textSize(11);

    //SimpleDateFormat example - Date with timezone information
    //DateFormat DATE_FORMAT = new DateFormat("yyyy-MM-dd'T'HH:mm  'GMT'Z '('z')'");

    String format ="yyyy-MM-dd'T' HH:mm  'GMT'Z '('z')'";
    String format2 ="EEEE";
    SimpleDateFormat sdf = new SimpleDateFormat(format);

    Date gmtDate = new Date(tempMsg.date);// use your date here
    Date localDate = new Date(gmtDate.getTime() - 3600 * 1000);

    //SimpleDateFormat sdf = new SimpleDateFormat(format);

    String bostonDate =sdf.format(localDate);
    text(bostonDate, 310, 120);
    fill(255, 255, 255);

    //Lat lon
    textSize(11);
    text("lat: " + tempMsg.lon + "  lon: " +tempMsg.lat, 310, 135);

    translate(-(width - 325), -(height-150));
  }




  if ( tweetSelected ) {
    fill(255, 255, 255, 190);
    strokeWeight(0);
    rect(0, 0, 250, height);
  }

  if (  tweetSelected ) {
    Node tempNode = nodes.get(selectedNode);
    Msg tempMsg = tempNode.messages.get(selectedMsg);

    fill(111, 111, 111);
    textSize(32);
    text(tempMsg.user, 10, 30); 
    fill(0, 102, 153);
    textSize(12);
    text(tempMsg.msg, 10, 50, 180, 200);  // Text wraps within text box

    textSize(9);

    fill(125, 125, 125);
    text("lat: " + tempMsg.lon, 10, 230);
    text("lon: " +tempMsg.lat, 10, 240);
  }




  if (millis() - 30000 >= last) {
    println( "30 seconds" );
    last=millis();
    // getTweets();
    saveJSON();
  }


  if (millis() - 10000 >= randUserTimer) {
    //println( "10 seconds " );
    randUserTimer=millis();
    reset = true;
    if (cyleusers) {
      getRandomUser();
    }
  }


  if (millis() - 18000 >= hashTimer) {//////////////HASHTAG DELAY
    //println( "18 seconds" );
    foundHashTag = false;
  }


  launching = false;
  //noLoop();
}

void getRandomUser() {

  //GET RANDOM USER

  PVector randUserP;
  selectedNode = (int)random(0, nodes.size()-1);
  // println((int)random(0, nodes.size()-1));
  Node tempNode = nodes.get(selectedNode);
  Msg tempMsg = tempNode.messages.get(tempNode.messages.size()-1);
  randUserP = mercatorMap.getScreenLocation(new PVector(tempMsg.lon, tempMsg.lat ));
  randUserP.x = randUserP.x - w_shift;
  randUserP.y = randUserP.y - h_shift;
  while (randUserP.x<0 || randUserP.x>width || randUserP.y<0 || randUserP.y>height || tempNode.polylines.size ()==0 ) {
    selectedNode = (int)random(0, nodes.size()-1);
    // println((int)random(0, nodes.size()-1));
    tempNode = nodes.get(selectedNode);
    tempMsg = tempNode.messages.get(tempNode.messages.size()-1);
    randUserP = mercatorMap.getScreenLocation(new PVector(tempMsg.lon, tempMsg.lat ));
    randUserP.x = randUserP.x - w_shift;
    randUserP.y = randUserP.y - h_shift;
  }
}

void getTweets() {

  //Twitter retrieval code Written By Carson Smuts

    String consumerKey = "8EtujG6xz1nKhQFnBICaw";
  String consumerSecret = "kS3LS4lS4ESkhmbL35t21tq6Nv0tk3bbbsaCpUfRcjc";
  String consumerKeyAndSecret = consumerKey + ":" + consumerSecret;
  byte[] utf8 = null;
  try
  {
    utf8 = consumerKeyAndSecret.getBytes("UTF-8");
  } 
  catch (Exception e) {
  }
  String b64 = DatatypeConverter.printBase64Binary(utf8);
  println(b64);

  //////////////////////////////////////METHOD ONE//////////////////////////////////////

  String TWITTER_AUTH_URL = "https://api.twitter.com/oauth2/token";
  String TWITTER_HOST = "api.twitter.com";

  try {


    HttpsURLConnection connection = null;        
    URL url = new URL(TWITTER_AUTH_URL);
    connection = (HttpsURLConnection) url.openConnection();
    connection.setDoOutput(true);
    connection.setDoInput(true);
    connection.setRequestMethod("POST");
    connection.setRequestProperty("Host", TWITTER_HOST);
    connection.setRequestProperty("User-Agent", "TwitterGrassHopper");
    connection.setUseCaches(false);

    connection.setRequestProperty("Authorization", "Basic " + b64);
    connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
    connection.setRequestProperty("Content-Length", "29");
    connection.setUseCaches(false);

    writeRequest(connection, "grant_type=client_credentials");

    String TempS = readResponse(connection);

    println(TempS);
  }
  catch (Exception e) {
    //throw new IOException("Invalid endpoint URL specified.", e);
  }


  ///////////////////////////////////////METHOD ONE//////////////////////////////////////

  HttpsURLConnection connection2 = null;

  String TWITTER_Search = "https://api.twitter.com/1.1/search/tweets.json?geocode=";
  TWITTER_Search = TWITTER_Search + lat + "," + lon + "," + "1km&count=100";

  try {
    URL url = new URL(TWITTER_Search); 
    connection2 = (HttpsURLConnection) url.openConnection();           
    // connection2.setDoOutput(true);
    // connection2.setDoInput(true); 
    connection2.setRequestMethod("GET"); 
    connection2.setRequestProperty("Host", "api.twitter.com");
    connection2.setRequestProperty("User-Agent", "Your Program Name");
    connection2.setRequestProperty("Authorization", "Bearer " + "AAAAAAAAAAAAAAAAAAAAAFtJXAAAAAAAH4UYwEjmb2K1VZ6rFoGPrgjNSK4%3DEHkWbJuaxtFHXHnMLZYs41m5BVFBTEHzdabcXBC5r5TobFQ2EV");
    // connection2.setUseCaches(false);

    String TempS = readResponse(connection2);
    // println(TempS);
    globalJSON = JSONObject.parse(TempS);

    // println(globalJSON);

    json2Nodes();
  }
  catch (Exception e) {
    //throw new IOException("Invalid endpoint URL specified.", e);
  }
}



void json2Nodes() {

  //println(globalJSON);

  JSONArray statuses = globalJSON.getJSONArray("statuses");

  println(statuses.size());
  print("Node size");
  println(nodes.size() );

  for (int i = 0 ; i < statuses.size() ; i++) {
    boolean found = false;
    JSONObject tweet = statuses.getJSONObject(i); 
    JSONObject userDetails = tweet.getJSONObject("user");

    // println(i);

    if (!tweet.isNull("coordinates")) {
      JSONObject coord = tweet.getJSONObject("coordinates");
      JSONArray lonLat = coord.getJSONArray("coordinates");
      String status = tweet.getString("text");
      String created = tweet.getString("created_at");
      String userName = userDetails.getString("name");
      String msgID = tweet.getString("id_str");
      // println(lonLat.getFloat(0));


      //nodes.add(new Node(lonLat.getFloat(0), lonLat.getFloat(1), status, userName, created, "location"));  // Add a Node to the array
      Msg tempMsg = new Msg(lonLat.getFloat(0), lonLat.getFloat(1), status, userName, created, msgID, "location");

      if (nodes.size() == 0) {
        Node tempNode = new Node(userName, "location");
        tempNode.messages.add(tempMsg);
        nodes.add(tempNode);
        found = true;
      }
      else {

        for (int j = 0 ; j < nodes.size() ; j++) {

          Node tempNodeEx = nodes.get(j);
          boolean foundMsg = false;

          if (tempNodeEx.user.equals(userName) == true) {

            //  print("found existing User: ");
            //  println(userName);
            found = true;

            for (int k = 0 ; k < tempNodeEx.messages.size() ; k++) {

              Msg tempMsgEx =  tempNodeEx.messages.get(k);
              if (tempMsgEx.msgID.equals(msgID) == true) {
                foundMsg = true;
              }
            }
            if (!foundMsg) {

              tempNodeEx.messages.add(tempMsg);

              if (tempNodeEx.messages.size()>1) {
                delay(400);
                Msg tempMsgPrevious =  tempNodeEx.messages.get(tempNodeEx.messages.size()-2);  ///////////ADD SEGMENT TO POLYLINE LIST from PREVIOUS MSG TO CURRENT////////////
                getDirect(j, tempMsg.lon, tempMsg.lat, tempMsgPrevious.lon, tempMsgPrevious.lat, tempMsg.date); ////////////TWITTER SENDS IN REVERSED LON LAT to match XY////////////////
                println("call for poly");
              }
              println("New Msg for existing user");
            }
            else {
              //println("Msg Already exists");
            }
          }
        }
      }

      if (!found) {
        //  println("No dup");
        Node tempNode = new Node(userName, "location");
        tempNode.messages.add(tempMsg);
        nodes.add(tempNode);
      }
    }//End check for tweet Geo
  }
  println(nodes.size());
}



// Writes a request to a connection
private static boolean writeRequest(HttpsURLConnection connection, String textBody) {
  try {
    BufferedWriter wr = new BufferedWriter(new OutputStreamWriter(connection.getOutputStream()));
    wr.write(textBody);
    wr.flush();
    wr.close();
    println("write success");

    return true;
  }
  catch (IOException e) { 
    return false;
  }
}


// Reads a response for a given connection and returns it as a string.
private static String readResponse(HttpsURLConnection connection) {
  try {
    StringBuilder str = new StringBuilder();

    BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()));
    String line = "";
    while ( (line = br.readLine ()) != null) {
      str.append(line + System.getProperty("line.separator"));
    }

    println("read success");

    return str.toString();
  }
  catch (IOException e) {
    println(connection.getErrorStream());
    println(e.getMessage());

    return new String();
  }
}


void receive( byte[] data, String ip, int port ) {  // <-- extended handler

  // get the "real" message =
  // forget the ";\n" at the end <-- !!! only for a communication with Pd !!!
  data = subset(data, 0, data.length-2);
  String message = new String( data );

  parseHashes(message);
  foundHashTag = true;
  hashTimer = millis();

  println("RECEIVED MESSAGE");
}

void parseHashes(String responseString) {
  //http://json.parser.online.fr    My go to site for checking the parse layout

  //println(userDetails);
  try {
    JSONObject tweet = JSONObject.parse(responseString); 

    JSONObject userDetails = tweet.getJSONObject("user");

    //  if (!tweet.isNull("coordinates")) {

    try {
      JSONObject coord = tweet.getJSONObject("coordinates");
      JSONArray lonLat = coord.getJSONArray("coordinates");
      //println(lonLat);
    } 
    catch (Exception e) {
      //throw new SignatureException("Failed to generate HMAC : " + e.getMessage());
    }


    String status = tweet.getString("text");
    String created = tweet.getString("created_at");
    String userName = userDetails.getString("name");
    String msgID = tweet.getString("id_str");
    // println(lonLat.getFloat(0));

    // Msg tempMsg = new Msg(lonLat.getFloat(0), lonLat.getFloat(1), status, userName, created, msgID, "location");
    hashMsg = new Msg(0, 0, status, userName, created, msgID, "location");

    //  println("");

    //  println(hashMsg.user);
    // println("");

    // println(hashMsg.msg);
  } 
  catch (Exception e) { 
    //throw new SignatureException("Failed to generate HMAC : " + e.getMessage());
  }/////End try and Catch for "User"

  //}//End check for tweet Geo
}

