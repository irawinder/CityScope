boolean displayAgents = false;
ArrayList<Mellennial> mellennials;
int cols = codeArray.length;
int rows = codeArray.length;
int[][] myArray = new int[cols][rows];
int[][] myArray1 = new int[cols][rows];
float x_target = 0; float y_target = 0; float x_target1 = 0; float y_target1 = 0; float x_target2 = 0; float y_target2 = 0; float x_target3 = 0; float y_target3 = 0; float x_target4 = 0; float y_target4 = 0; float x_target5 = 0; float y_target5 = 0; float x_target6 = 0; float y_target6 = 0;


void initializeAgents(){
  
  
    mellennials = new ArrayList<Mellennial>();

    for (int i = 0; i < 1000; i++) {
      mellennials.add(new Mellennial(random(width),random(height)));
    }

}

int[] idFound = new int[361];
int foundCount = 0;
int foundCount1 = 0;
int foundCount2 = 0;
int foundCount3 = 0;

void updateAgents(){
    
    int count = 0;
    int foundCount = 0;
    int foundCount1 = 0;
    int foundCount2 = 0;
    int foundCount3 = 0;
    
    for(int i = 0; i <codeArray.length; i++){
      for (int j = 0; j <codeArray.length; j++){
        
           int type = codeArray[i][j][0];
           float y_location = i *( (4 * 15*LU_W) + gridGap);
           float x_location = j *( (4 * 15*LU_W) + gridGap);
           //millennials  2-4-10-11
           
           if (type != -1){
               if (type == 1){
                 foundCount++;
                 if (foundCount == 1){
                   idFound[foundCount] = type;
                   x_target = x_location;
                   y_target = y_location;
                   }
                   if (foundCount == 2){
                     x_target1 = x_location;
                     y_target1 = y_location;  
                   }
                   if (foundCount == 3){
                     x_target2 = x_location;
                     y_target2 = y_location;  
                   }
                   if (foundCount == 4){
                     x_target3 = x_location;
                     y_target3 = y_location;  
                   }
                   if (foundCount == 5){
                     x_target4 = x_location;
                     y_target4 = y_location;  
                   }
                   if (foundCount == 6){
                     x_target5 = x_location;
                     y_target5 = y_location;  
                   }
                   if (foundCount == 7){
                     x_target6 = x_location;
                     y_target6 = y_location;  
                   }
               }
               if (type == 3){
                 foundCount1++;
                 if (foundCount1 == 1){
                   idFound[foundCount1] = type;
                   x_target = x_location;
                   y_target = y_location;
                   }
                   
               }if (type == 9){
                 foundCount2++;
                 if (foundCount2 == 1){
                   idFound[foundCount2] = type;
                   x_target = x_location;
                   y_target = y_location;
                   }
                   
               }if (type == 10){
                 foundCount3++;
                 if (foundCount3 == 1){
                   idFound[foundCount3] = type;
                   x_target = x_location;
                   y_target = y_location;
                   }
               }
           }
      }   
    }
    for (Mellennial v : mellennials){
      if(count <150){
      v.applyBehaviors(mellennials);
      } else if (count> 150 && count <300){
      v.applyBehaviors1(mellennials);
      } else if (count> 300 && count <450){
      v.applyBehaviors2(mellennials);
      } else if (count> 450 && count <600){
      v.applyBehaviors3(mellennials);
      } else if (count> 600 && count <750){
      v.applyBehaviors4(mellennials);
      } else if (count> 750 && count <900){
      v.applyBehaviors5(mellennials);
      } else if (count> 900 && count <1000){
      v.applyBehaviors6(mellennials);
      } 
      v.update();
      count++;
    }
}

public void drawAgents() {
  
  for (Mellennial v : mellennials){    
    plan.fill(#FF0000);
    plan.stroke(0);
    plan.pushMatrix();
    plan.translate(v.location.x, v.location.y);
    plan.ellipse(0, 0, v.r, v.r);
    plan.popMatrix();
  }
  
}

public class Mellennial {
    
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;
  float maxspeed;
  
  Mellennial(float x, float y) {
    location = new PVector(x, y);
    r = 6 ;
    maxspeed = 6;
    maxforce = 0.2;
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
  }
  
  void applyForce(PVector force){
    acceleration.add(force);

  }
  
  void applyBehaviors(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target,y_target));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors1(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target1,y_target1));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors2(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target2,y_target2));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  
    void applyBehaviors3(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target3,y_target3));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors4(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target4,y_target4));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors5(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target5,y_target5));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
    void applyBehaviors6(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target6,y_target6));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }

  PVector seek(PVector target){
      PVector desired = PVector.sub(target,location);
      desired.normalize();
      desired.mult(maxspeed);
      PVector steer = PVector.sub(desired,velocity);
      steer.limit(maxforce);
      return steer; 
  }
  
  PVector separate(ArrayList<Mellennial> mellennials){
    float desiredseparation = r*1.5;
    PVector sum = new PVector();
    int count = 0;
    
    for(Mellennial other : mellennials) {
      float d = PVector.dist(location, other.location);
      
      if ((d > 0 ) && (d < desiredseparation)){
        
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(d);
        sum.add(diff);
        count++;
      }
    }
    if (count > 0){
      sum.div(count);
      sum.normalize();
      sum.mult(maxspeed);
      sum.sub(velocity);
      sum.limit(maxforce);
    }
   return sum;   
  }
  
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  }
  
}
