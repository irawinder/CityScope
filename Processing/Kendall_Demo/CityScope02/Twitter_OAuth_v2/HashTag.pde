///////////Streaming tap into Twitter database by Carson Smuts 2014 MIT Media Lab

String TWITTER_HASH_URL = "https://stream.twitter.com/1.1/statuses/filter.json";
String TWITTER_HOST2 = "stream.twitter.com";


//String query = "track=twitter";
String query = "track=cityscope";


String oauth_consumer_key = "WcEmTFUSM2IkfIU8zR4Gw";
String oauth_nonce = "0803ca605a2c57d1a104017f71e00688";
String oauth_signature_method = "HMAC-SHA1";
String oauth_timestamp = "";
String oauth_token = "362819517-Wu62xUiM2tQGwHBM64NTs7wkR7XN55CZ4Da8Kesh";
String oauth_version = "1.0";
String oauth_consumer_secret = "lNP361x4dy9iBYADZnno1yWDzAOEvQNH7yZ5ALMQk";
String oauth_token_secret = "FK5Dgr5y2YFQLIXAhVHjLumKoi44BfC8hy4tb1jyJU";


/*
String oauth_consumer_key = "8EtujG6xz1nKhQFnBICaw";
 String oauth_nonce = "";
 String oauth_signature_method = "HMAC-SHA1";
 String oauth_timestamp = "";
 String oauth_token = "362819517-Aw62F7lf1X1lBWwTPZR3oQb581yptIe0zj08svN4";
 String oauth_version = "1.0";
 
 String oauth_consumer_secret = "kS3LS4lS4ESkhmbL35t21tq6Nv0tk3bbbsaCpUfRcjc";
 String oauth_token_secret = "w4PrkS2BrdOqRrnWBWcuvYSTn8zGXLEoQwq82OaZkZ6s6";
 */

String oauth_signature = "";

BufferedReader hashTagBuffer;

HttpURLConnection connection;
boolean receivedData = false; 
boolean foundHashTag = false;
int hashTimer = 0;

int connectionTimer = 0;

String line;

import java.net.URLEncoder;
import java.security.SignatureException;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.sql.Timestamp;

import java.util.UUID; //for NOnce

//import org.apache.http.HttpEntity;
//import org.apache.http.HttpResponse;
//import org.apache.http.client.methods.HttpPost;
//import org.apache.http.impl.client.DefaultHttpClient;

import java.util.Date;
import java.text.SimpleDateFormat;


import processing.net.*;
import javax.xml.bind.DatatypeConverter;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import javax.net.ssl.HttpsURLConnection;




public static final String ENCODING = "UTF-8";

void startHashes() {

  println("trying to connect");

  //Twitter retrieval code Written By Carson Smuts
  generateSignature();

  String DST = "OAuth ";
  DST += "oauth_consumer_key=" + "\"" + percentEncode(oauth_consumer_key) + "\"";
  DST += ", ";
  DST += "oauth_nonce=" + "\"" + percentEncode(oauth_nonce) + "\"";
  DST += ", ";
  DST += "oauth_signature=" +  "\"" + percentEncode(oauth_signature) + "\"";
  DST += ", ";
  DST += "oauth_signature_method=" +  "\"" + percentEncode(oauth_signature_method) + "\"";
  DST += ", ";
  DST += "oauth_timestamp=" +  "\"" + percentEncode(oauth_timestamp) + "\"";
  DST += ", ";
  DST += "oauth_token=" +  "\"" + percentEncode(oauth_token) + "\"";
  DST += ", ";
  DST += "oauth_version=" +  "\"" + percentEncode(oauth_version) + "\"";

  //println(DST);

  //String DSTtemp = "OAuth oauth_consumer_key=\"WcEmTFUSM2IkfIU8zR4Gw\", oauth_nonce=\"8702c83b321650cb488b9d5bc289e4ab\", oauth_signature=\"slV3FK7eljmgICZjgro2it0bbW0%3D\", oauth_signature_method=\"HMAC-SHA1\", oauth_timestamp=\"1397424295\", oauth_token=\"362819517-Wu62xUiM2tQGwHBM64NTs7wkR7XN55CZ4Da8Kesh\", oauth_version=\"1.0\"";
  //println(DSTtemp);


  try {
    //System.setProperty("http.keepAlive", "true" );
    // Encode the query
    //String encodedQuery = URLEncoder.encode(query, "UTF-8");
    // This is the data that is going to be send to itcuties.com via POST request
    // 'e' parameter contains data to echo
    String postData = query;

    // Connect to google.com
    URL url = new URL(TWITTER_HASH_URL);
    connection = (HttpURLConnection) url.openConnection();
    connection.setDoOutput(true);
    //connection.setChunkedStreamingMode(0);

    connection.setRequestMethod("POST");
    connection.setRequestProperty("Authorization", DST);
    //connection.setRequestProperty("Connection", "Keep-Alive");
    //connection.setRequestProperty("Keep-Alive", "timeout=60000");
    connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
    connection.setRequestProperty("Host", "stream.twitter.com");
    connection.setRequestProperty("Content-Length", String.valueOf(postData.length()));


    // Write data
    OutputStream os = connection.getOutputStream();
    os.write(postData.getBytes());
    os.close();

    InputStream in = (InputStream) connection.getInputStream();

    // Read response
    hashTagBuffer = new BufferedReader(new InputStreamReader(in));
  }
  catch (Exception e) {
    //throw new IOException("Invalid endpoint URL specified.", e);
    // println(connection.getErrorStream());
    println(e.getMessage());
    startHashes();
  }
}

void updateHashes() {

  try {  
    if ( (line = hashTagBuffer.readLine()) != null) {
      println(line);
      line = line.toLowerCase();
      if (line.contains("cityscope")) {
        println("Found City Scope tweet");
        foundHashTag = true;
      }
    }
  }
  catch (Exception e) {
    //throw new IOException("Invalid endpoint URL specified.", e);
    // println(connection.getErrorStream());
    println(e.getMessage());
    startHashes();
  }
}









void generateSignature() {
  //https://dev.twitter.com/docs/auth/creating-signature

    ////////CREATE TIME STAMP//////////////
  Date date= new Date();
  oauth_timestamp = "" + date.getTime()/1000;
  //println(oauth_timestamp);
  //oauth_timestamp="1397424295";

  ///////GEN NOnce/////////
  //String uuid = UUID.randomUUID().toString();
  oauth_nonce = RandomAlphaNumericString(32);
  //oauth_nonce = "8702c83b321650cb488b9d5bc289e4ab";
  //println(oauth_nonce);


  /////////ENCODE STRING//////////////
  //String encQuery   = percentEncode(query);
  String encConsKey = percentEncode(oauth_consumer_key);
  String encOnce    = percentEncode(oauth_nonce);
  String encMeth    = percentEncode(oauth_signature_method);
  String encTStamp  = percentEncode(oauth_timestamp);
  String encToken   = percentEncode(oauth_token);
  String encVers    = percentEncode(oauth_version);

  String encodedStr = "";

  println(query);
  //println(percentEncode("_"));

  encodedStr += "oauth_consumer_key=" + encConsKey;
  encodedStr += "&oauth_nonce=" + encOnce;
  encodedStr += "&oauth_signature_method=" + encMeth;
  encodedStr += "&oauth_timestamp=" + encTStamp;
  encodedStr += "&oauth_token=" + encToken;
  encodedStr += "&oauth_version=" + encVers;
  encodedStr += "&" + query;

  //println(encodedStr);

  /////////CREATE BASE STRING//////////////

  String baseStr = "POST&";

  baseStr += percentEncode(TWITTER_HASH_URL);
  baseStr += "&";
  baseStr += percentEncode(encodedStr);

  //println("POST&https%3A%2F%2Fstream.twitter.com%2F1.1%2Fstatuses%2Ffilter.json&oauth_consumer_key%3DWcEmTFUSM2IkfIU8zR4Gw%26oauth_nonce%3Dba2ebac5149544f80da3853a17c7a112%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D1397421026%26oauth_token%3D362819517-Wu62xUiM2tQGwHBM64NTs7wkR7XN55CZ4Da8Kesh%26oauth_version%3D1.0%26track%3Dtwitter");
  //println(baseStr);

  /////////CREATE SIGNING KEY//////////////

  String signingKey = percentEncode(oauth_consumer_secret) + "&" + percentEncode(oauth_token_secret);

  // println(signingKey);


  /////////CREATE SIGNATURE//////////////
  try {
    // get an hmac_sha1 key from the raw key bytes
    SecretKeySpec theKey = new SecretKeySpec(signingKey.getBytes(), "HmacSHA1");

    // get an hmac_sha1 Mac instance and initialize with the signing key
    Mac mac = Mac.getInstance("HmacSHA1");
    mac.init(theKey);

    // compute the hmac on input data bytes
    byte[] rawHmac = mac.doFinal(baseStr.getBytes());

    // base64-encode the hmac
    String result = DatatypeConverter.printBase64Binary(rawHmac);

    println(result);
    oauth_signature =result;
  } 
  catch (Exception e) {
    //throw new SignatureException("Failed to generate HMAC : " + e.getMessage());
  }
}


public static String RandomAlphaNumericString(int size) {
  String chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
  String ret = "";
  int length = chars.length();
  for (int i = 0; i < size; i ++) {
    ret += chars.split("")[ (int) (Math.random() * (length - 1)) ];
  }
  return ret;
}




String percentEncode(String s) {
  ////http://oauth.googlecode.com/svn/code/java/core/commons/src/main/java/net/oauth/OAuth.java
  if (s == null) {
    return "";
  }
  try {
    return URLEncoder.encode(s, ENCODING)
      // OAuth encodes some characters differently:
      .replace("+", "%20").replace("*", "%2A")
        .replace("%7E", "~");
    // This could be done faster with more hand-crafted code.
  } 
  catch (UnsupportedEncodingException wow) {
    throw new RuntimeException(wow.getMessage(), wow);
  }
}


