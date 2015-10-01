float Xmax = 0;
float Ymax = 0;

float Xmin = 250;
float Ymin = 250;

public class M_FcdXml {
  //Make Processing functions available
  M_FcdXml(PApplet _p){
    p = _p;
  }
  
  LinkedHashMap<Integer,HashMap<String, VehDot>> dots;
  XML xml;
  int[] frameIndex;
  XML[] timeSteps;
  int numFrames;
  HashMap<String, VehDot> v1, v2;

  
  void setup(String tokenVector){
    xml = p.loadXML(tokenVector+".xml");
    timeSteps = xml.getChildren("timestep");
    numFrames = timeSteps.length;
    dots = new LinkedHashMap<Integer,HashMap<String, VehDot>>(); //overall hashmap, for timesteps and vehicle id/marker hashmap
    for (int i = 0; i < numFrames; i++) {
      dots.put(i, new HashMap<String,VehDot>());
      
      //build dots for markers
      XML[] vehDotsXml = timeSteps[i].getChildren("vehicle");
      int numVehDots = vehDotsXml.length;
        
      for (int j = 0; j < numVehDots; j++){
          String id = vehDotsXml[j].getString("id");
          Float y = vehDotsXml[j].getFloat("y");
          Float x = vehDotsXml[j].getFloat("x");
          Float angle = vehDotsXml[j].getFloat("angle");
          Float speed = vehDotsXml[j].getFloat("speed");
          String type = vehDotsXml[j].getString("type");
          dots.get(i).put(id,new VehDot("blank",x,y,angle,speed,type));
        }
        
      //build dots for pedestrians (which lack type field)
        XML[] perDotsXml = timeSteps[i].getChildren("person");
        int numPerDots = perDotsXml.length;
        for (int j = 0; j < numPerDots; j++){
          String id = perDotsXml[j].getString("id");
          Float y = perDotsXml[j].getFloat("y");
          Float x = perDotsXml[j].getFloat("x");
          Float speed = perDotsXml[j].getFloat("speed");
          Float angle = perDotsXml[j].getFloat("angle");
          dots.get(i).put(id,new VehDot("blank",x,y,angle,speed,"person"));
          }
      }
      
    PApplet.println(numFrames + " frames (" +numFrames/60 + " minutes) loaded.");
  }
  
  void vehicleKeyframe(int i){
    v1 = dots.get(i);
    v2 = dots.get(i+1);
  }
  
  void drawVehicles(float interpFactor){
    //p.background(0);
    for (String key: v2.keySet()){
      if (v1.containsKey(key)){
        
        VehDot vA = v1.get(key);
        VehDot vB = v2.get(key);
        float xA = vA.x;
        float yA = vA.y;
        float xB = vB.x;
        float yB = vB.y;
        
        String type = vB.type;
        float aA = PApplet.radians(vA.angle);
        float aB = PApplet.radians(vB.angle);
        
        float x, y;
        float angle = aA;
        //PApplet.println(vA.x + " " + vA.y);
        //PApplet.println(PApplet.dist(vA.x, vA.y, vB.x, vB.y)*1000000F);
        if (Math.abs(aA-aB)<PConstants.PI/2f){ 
          angle += interpFactor*(aB-aA);
        }

          x = xA+(xB-xA)*interpFactor;
          y = yA+(yB-yA)*interpFactor;    
//          else if (Math.abs(aA-aB)>3*PConstants.PI/2F){
//            angle += interpFactor*(2*PConstants.PI-(aB-aA));
//          }




        
        
//        p.stroke(0,0,0,255);
//        p.strokeWeight(2);
//        p.curve(xAcp, yAcp, xA, yA, xB, yB, xBcp, yBcp);
//        p.noStroke();
//        
        //VehDot v = new VehDot(id, "blank", x, y, angle, type);
        //ScreenPosition dotPos = v.marker.getScreenPosition(m);
        
        p.pushMatrix();
        p.scale(4);
        //p.translate(144, 48);
        //p.rotate(3F*PConstants.PI/2F);
        p.translate(x, y);
        
//        if(x > Xmax) { Xmax = x; }
//        if(y > Ymax) { Ymax = y; }
//        if(x < Xmin) { Xmin = x; }
//        if(y < Ymin) { Ymin = y; }
        
        p.rotate(-(angle));
  
        if (type.equals("passenger") || type.equals("custom1") ){ // Passenger car
            p.fill(255,255,255,255);
            p.scale((float) 0.5);
            p.rect(-5f,-2f, 10f, 4f);
        }
        else if (type.equals("bicycle")){ // Delivery truck
                p.fill(0,255,255,255);
                p.scale((float) 0.5);
                p.rect(-3f,-1f, 6f, 2f);
            }
        else if (type.equals("trailer")){ // Tractor-trailer truck
                p.fill(0,255,255,255);
                p.scale((float) 0.5);
                p.rect(-7f,-2.5f, 14f, 5f);
            }
        else if (type.equals("rail")){ // Subway
                p.fill(255,155,0,255);
                p.scale((float) 0.5);
                p.rect(-40f,-6f, 80f, 12f);
            }
            else if (type.equals("bus/flexible")){
                //Bus shape
                p.fill(255,255,0,255);
                p.scale((float) 0.5);
                p.rect(-8f,-3f, 24f, 6f);
                //Bus route display

            }
            else if (type.equals("DEFAULT_VEHTYPE")){
                p.fill(255,255,255,255);
                p.scale((float) 0.5);
                p.rect(-5f,-2f, 10f, 4f);
            }
            else {
                p.fill(255,255,255,255);
              p.scale((float) 0.5);
                p.rect(-.5f,-1f,1f,2f);
            }
            p.popMatrix();
        
      }
    }
  }  

  
  private PApplet p;
}

