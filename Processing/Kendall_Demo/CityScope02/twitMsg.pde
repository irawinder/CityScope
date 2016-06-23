class Msg 
{
  float lat;
  float lon ; 
  String msg;
  String user;
  String date; 
  String msgID;
  String location;
  color msgColor;
  boolean active;
 
 
  Msg(float yposQ, float xposQ, String msgQ, String userQ, String dateQ, String msgIDQ, String locationQ) {
    lat = yposQ;
    lon = xposQ;
    msg = msgQ;
    user = userQ;
    date = dateQ;
    msgID = msgIDQ;
    location = locationQ;
    
    msgColor =  color(65, 170, 219, 200);
    active = false;
  }
  
}
