/*EDGE Class

Every edge has a speed, thickness, color, type, origin, destination, id, and an origin and destination id

Therefore each edge knows what towers it goes between 

This code sets the increment as universal, but it can be set differently for different edges 

To draw the line animations, you have to consider the four cases of lines and draw accordingly

There is a "pause" function in here that just draws stagnant lines 
*/

public class Edge {
    //speed of animation
    private float increment;
    private PVector origin, destination;
    private color language; 
    int amount, type, origin_id, destination_id, id;
    
    //constructor
          Edge(PVector _origin, PVector _destination, float _increment, int _amount, color _language, int _type, int _oi, int _di, int _id){
              increment = _increment; 
              origin = _origin;
              destination = _destination;
              amount = _amount; 
              language = _language; 
              type = _type;
              origin_id = _oi;
              destination_id = _di;
              id = _id;
          }
    
    //draw lines
    public void pauseEdge(){
      stroke(language, 250);
      fill(language, 250);
      strokeWeight(amount);
        line(origin.x, origin.y, destination.x, destination.y);
            if(origin.x == destination.x && origin.y == destination.y){
               fill(language, 200);
               ellipse(origin.x, origin.y, amount, amount);
             }
      }
        
    public void drawEdge(){
        float x = origin.x; 
        float y = origin.y;
        float xspeed = abs(destination.x-origin.x)*increment;
        float yspeed = abs(destination.y-origin.y)*increment;
        
     //there are 4 cases of lines and need to cover all 4 to preserve the orientation of going from origin to destination 
     //case 1: line moving down and right
      if(origin.x <= destination.x && origin.y <= destination.y){ //<>//
            if(x+(millis()-initialTime)*xspeed < destination.x && y+(millis()-initialTime)*yspeed < destination.y){
                  line(x,y,x+(millis()-initialTime)*xspeed, y + (millis()-initialTime)*yspeed); //<>//
                  duration = int(millis()-initialTime); 
               }
            else if(!needLoop){
                  line(origin.x, origin.y, destination.x, destination.y);
                      if(millis() > initialTime+duration + delay){
                          needLoop = !needLoop;
                          }
                 }   
      }
      
      //case 2: line moving up and right
      if(origin.x <= destination.x && origin.y >= destination.y){
            if(x+(millis()-initialTime)*xspeed < destination.x && y+(millis()-initialTime)*yspeed > destination.y){
                  line(x,y,x+(millis()-initialTime)*xspeed, y - (millis()-initialTime)*yspeed);
                  duration = int(millis()-initialTime);
                }
            else if(!needLoop){
                  line(origin.x, origin.y, destination.x, destination.y);
                      if(millis() > initialTime+duration + delay){
                          needLoop = !needLoop;
                          }
                  }
      }
      
      //case 3: line moving left and up
      if(origin.x >= destination.x && origin.y >= destination.y){
          if(x-(millis()-initialTime)*xspeed > destination.x && y+(millis()-initialTime)*yspeed > destination.y){
                line(x,y,x-(millis()-initialTime)*xspeed, y - (millis()-initialTime)*yspeed);
                duration = int(millis()-initialTime);
               }
          else if(!needLoop){
              line(origin.x, origin.y, destination.x, destination.y);
                  if(millis() > initialTime+duration + delay){
                      needLoop = !needLoop;
                  }
            }
      }
      
      //case 4: line moving left and down
      if(origin.x >= destination.x && origin.y <= destination.y){
          if(x-(millis()-initialTime)*xspeed > destination.x && y+(millis()-initialTime)*yspeed < destination.y){
                line(x,y,x-(millis()-initialTime)*xspeed, y + (millis()-initialTime)*yspeed);
                duration = int(millis()-initialTime);
                }
          else if(!needLoop){
              line(origin.x, origin.y, destination.x, destination.y);
                    if(millis() > initialTime+duration + delay){
                        needLoop = !needLoop;
                    }
              }
        }
        
      if(origin.x == destination.x && origin.y == destination.y){
         ellipse(origin.x, origin.y, amount, amount);
       }
      
  }

    
}