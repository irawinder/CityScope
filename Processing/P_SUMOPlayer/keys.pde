public void keyPressed(){
      
  //Frame information to console log
    if (key == 'i') {
      println("z: " + bm.currentMap.getZoom()/266144);
      println(frame);
      println("m: " + millis());
      println("t: " + timer);
      println(labelBuses);
      }
    
  //Switch to Stamen plain basemap
      if (key == '1') {
        bm.currentMap = bm.map1;
        labelBuses = true;
      }
      
    //Switch to aerial basemap  
      if (key == '2') {
        bm.currentMap = bm.map2;
        labelBuses = false;
      }
      
    //Switch which pre-run simulation is playing  
      if (key =='t'){
        if (tokenVector == "000011"){
          tokenVector = "000012";
        }
        else{
          tokenVector = "000011";
        };
        fx.setup(tokenVector);  
      }
      
    //Pause
      if (key =='w'){
        noLoop();
      }
      
    //Start  
      if (key =='s'){
        loop();
      }
    
    //Save video frames
      if (key =='v'){
      saveFrame("vid_####.jpg");
    }
      
    //Speed up playback
      if (key =='a'){
        if (playbackSpeed < 30){
          playbackSpeed ++;
        };
      }
      
    //Slow down playback
      if (key =='z'){
        if (playbackSpeed > 0){
          playbackSpeed --;
        };
      }
      
      
//    //Toggle realtime vehicle locations
//      if (key =='r'){
//        if (rt == false){
//          timer = -100000;
//          rt = true;
//        }
//        else{
//          rt = false;
//          bm.currentMap.zoomAndPanTo(16, new Location(42.329544, -71.083984));
//        };
//      }
      
     
  switch(key) {
    
    // Prints Zoom Level
    case 'l':
      println("zoom: " + bm.currentMap.getZoomLevel());
      break;
    
    // Recalculates Scale
    case 'k':
      setScale();
      break;
    
    // Prints Latitude and Longitude of Map Center to Console  
    case 'c':
      println("center: " + bm.currentMap.getCenter().getLat() + ", " + bm.currentMap.getCenter().getLon());
      break;
      
    // Resets Map Position to Default
    case 'r':
      bm.resetMap(lat,lon,zoom);
      break;
  }
}
  
/*
  public static void main(String _args[]) {
    PApplet.main(new String[] {"--present", "--hide-stop", "--bgcolor=#000000", com.ansonstewart.sumoplayer.SumoPlayer.class.getName() }); //
  }
}
*/
