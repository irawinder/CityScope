boolean displayAgents = true;
ArrayList<Mellennial> mellennials;
ArrayList<MidCareer> midcareers;
ArrayList<Senior> seniors;

int cols = codeArray.length;
int rows = codeArray.length;
int numberOfAgents = 700;
int[][] myArray = new int[cols][rows];
int[][] myArray1 = new int[cols][rows];

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
float x_target_1 = 0; float y_target_1 = 0; float x_target1_1 = 0; float y_target1_1 = 0; float x_target2_1 = 0; float y_target2_1 = 0; float x_target3_1 = 0; float y_target3_1 = 0; float x_target4_1 = 0; float y_target4_1 = 0; float x_target5_1 = 0; float y_target5_1 = 0;
float x_target_3 = 0; float y_target_3 = 0; float x_target1_3 = 0; float y_target1_3 = 0; float x_target2_3 = 0; float y_target2_3 = 0; float x_target3_3 = 0; float y_target3_3 = 0; float x_target4_3 = 0; float y_target4_3 = 0; float x_target5_3 = 0; float y_target5_3 = 0;
float x_target_9 = 0; float y_target_9 = 0; float x_target1_9 = 0; float y_target1_9 = 0; float x_target2_9 = 0; float y_target2_9 = 0; float x_target3_9 = 0; float y_target3_9 = 0; float x_target4_9 = 0; float y_target4_9 = 0; float x_target5_9 = 0; float y_target5_9 = 0;
float x_target_10 = 0; float y_target_10 = 0; float x_target1_10 = 0; float y_target1_10 = 0; float x_target2_10 = 0; float y_target2_10 = 0; float x_target3_10 = 0; float y_target3_10 = 0; float x_target4_10 = 0; float y_target4_10 = 0; float x_target5_10 = 0; float y_target5_10 = 0;
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
float x_tar_0 = 0; float y_tar_0 = 0; float x_tar1_0 = 0; float y_tar1_0 = 0; float x_tar2_0 = 0; float y_tar2_0 = 0; float x_tar3_0 = 0; float y_tar3_0 = 0; float x_tar4_0 = 0; float y_tar4_0 = 0; float x_tar5_0 = 0; float y_tar5_0 = 0;
float x_tar_2 = 0; float y_tar_2 = 0; float x_tar1_2 = 0; float y_tar1_2 = 0; float x_tar2_2 = 0; float y_tar2_2 = 0; float x_tar3_2 = 0; float y_tar3_2 = 0; float x_tar4_2 = 0; float y_tar4_2 = 0; float x_tar5_2 = 0; float y_tar5_2 = 0;
float x_tar_8 = 0; float y_tar_8 = 0; float x_tar1_8 = 0; float y_tar1_8 = 0; float x_tar2_8 = 0; float y_tar2_8 = 0; float x_tar3_8 = 0; float y_tar3_8 = 0; float x_tar4_8 = 0; float y_tar4_8 = 0; float x_tar5_8 = 0; float y_tar5_8 = 0;
float x_tar_11 = 0; float y_tar_11 = 0; float x_tar1_11 = 0; float y_tar1_11 = 0; float x_tar2_11 = 0; float y_tar2_11 = 0; float x_tar3_11 = 0; float y_tar3_11 = 0; float x_tar4_11 = 0; float y_tar4_11 = 0; float x_tar5_11 = 0; float y_tar5_11 = 0;

void initializeAgents(){    
    mellennials = new ArrayList<Mellennial>();
    midcareers = new ArrayList<MidCareer>();
    seniors = new ArrayList<Senior>();
    for (int i = 0; i < numberOfAgents; i++) {
      mellennials.add(new Mellennial(random(width),random(height)));
      midcareers.add(new MidCareer(random(width),random(height)));
      seniors.add(new Senior(random(width),random(height)));
    }
}

void updateAgents(){
  
    int[] idFound = new int[361];
    int count = 0;
    int count2 = 0;
    int count3 = 0;
//<------counts for millennials ------------>    
    int foundCount = 0;
    int foundCount1 = 0;
    int foundCount2 = 0;
    int foundCount3 = 0;
//<------counts for midcareers ------------->    
    int foundCount_1 = 0;
    int foundCount1_1 = 0;
    int foundCount2_1 = 0;
    int foundCount3_1 = 0;
//<------counts for seniors ---------------->    
 
//<----------------------------------------->

    for(int i = 0; i <codeArray.length; i++){
      for (int j = 0; j <codeArray.length; j++){
        
           int type = codeArray[i][j][0];
           float y_location = i *( (4 * 16*LU_W) + gridGap);
           float x_location = j *( (4 * 16*LU_W) + gridGap);

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//                                 
//millennials  2-4-10-11
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//           
           
           if (type != -1){
             
               //midcareer andseniors 1 3 9 12
               
               
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
               if (type == 1){
                 foundCount++;
                 if (foundCount == 1){
                   idFound[foundCount] = type;
                   x_target_1 = x_location;
                   y_target_1 = y_location;
                 }
                 if (foundCount == 2){
                   x_target1_1 = x_location;
                   y_target1_1 = y_location;  
                 }
                 if (foundCount == 3){
                   x_target2_1 = x_location;
                   y_target2_1 = y_location;  
                 }
                 if (foundCount == 4){
                   x_target3_1 = x_location;
                   y_target3_1 = y_location;  
                 }
                 if (foundCount == 5){
                   x_target4_1 = x_location;
                   y_target4_1 = y_location;  
                 }
                 if (foundCount == 6){
                   x_target5_1 = x_location;
                   y_target5_1 = y_location;  
                 }
               }
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
               
               if (type == 3){
                 foundCount1++;
                 if (foundCount1 == 1){
                   idFound[foundCount1] = type;
                   x_target_3 = x_location;
                   y_target_3 = y_location;
                 }
                 if (foundCount1 == 2){
                   x_target1_3 = x_location;
                   y_target1_3 = y_location;  
                 }
                 if (foundCount1 == 3){
                   x_target2_3 = x_location;
                   y_target2_3 = y_location;  
                 }
                 if (foundCount1 == 4){
                   x_target3_3 = x_location;
                   y_target3_3 = y_location;  
                 }
                 if (foundCount1 == 5){
                   x_target4_3 = x_location;
                   y_target4_3 = y_location;  
                 }
                 if (foundCount1 == 6){
                   x_target5_3 = x_location;
                   y_target5_3 = y_location;  
                 }    
               }
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
               
               if (type == 9){
                 foundCount2++;
                 if (foundCount2 == 1){
                   idFound[foundCount2] = type;
                   x_target_9 = x_location;
                   y_target_9 = y_location;
                 }
                 if (foundCount2 == 2){
                   x_target1_9 = x_location;
                   y_target1_9 = y_location;  
                 }
                 if (foundCount2 == 3){
                   x_target2_9 = x_location;
                   y_target2_9 = y_location;  
                 }
                 if (foundCount2 == 4){
                   x_target3_9 = x_location;
                   y_target3_9 = y_location;  
                 }
                 if (foundCount2 == 5){
                   x_target4_9 = x_location;
                   y_target4_9 = y_location;  
                 }
                 if (foundCount2 == 6){
                   x_target5_9 = x_location;
                   y_target5_9 = y_location;  
                 }
               }
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 

               if (type == 10){
                 foundCount3++;
                 if (foundCount3 == 1){
                   idFound[foundCount3] = type;
                   x_target_10 = x_location;
                   y_target_10 = y_location;
                 }
                 if (foundCount3 == 2){
                   x_target1_10 = x_location;
                   y_target1_10 = y_location;  
                 }
                 if (foundCount3 == 3){
                   x_target2_10 = x_location;
                   y_target2_10 = y_location;  
                 }
                 if (foundCount3 == 4){
                   x_target3_10 = x_location;
                   y_target3_10 = y_location;  
                 }
                 if (foundCount3 == 5){
                   x_target4_10 = x_location;
                   y_target4_10 = y_location;  
                 }
                 if (foundCount3 == 6){
                   x_target5_10 = x_location;
                   y_target5_10 = y_location;  
                 }    
               }
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
               if (type == 0){
                 
                 foundCount_1++;
                 if (foundCount_1 == 1){
                   x_tar_0 = x_location;
                   y_tar_0 = y_location;
                 }
                 if (foundCount_1 == 2){
                   x_tar1_0 = x_location;
                   y_tar1_0 = y_location;  
                 }
                 if (foundCount_1 == 3){
                   x_tar2_0 = x_location;
                   y_tar2_0 = y_location;  
                   }
                 if (foundCount_1 == 4){
                   x_tar3_0 = x_location;
                   y_tar3_0 = y_location;  
                 }
                 if (foundCount_1 == 5){
                   x_tar4_0 = x_location;
                   y_tar4_0 = y_location;  
                 }
                 if (foundCount_1 == 6){
                   x_tar5_0 = x_location;
                   y_tar5_0 = y_location;  
                 }

               }
               
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
               //midcareer andseniors
               if (type == 2){
                 
                 foundCount1_1++;
                 if (foundCount1_1 == 1){
                   idFound[foundCount1_1] = type;
                   x_tar_2 = x_location;
                   y_tar_2 = y_location;
                 }
                 if (foundCount1_1 == 2){
                   x_tar1_2 = x_location;
                   y_tar1_2 = y_location;  
                 }
                 if (foundCount1_1 == 3){
                   x_tar2_2 = x_location;
                   y_tar2_2 = y_location;  
                   }
                 if (foundCount1_1 == 4){
                   x_tar3_2 = x_location;
                   y_tar3_2 = y_location;  
                 }
                 if (foundCount1_1 == 5){
                   x_tar4_2 = x_location;
                   y_tar4_2 = y_location;  
                 }
                 if (foundCount1_1 == 6){
                   x_tar5_2 = x_location;
                   y_tar5_2 = y_location;  
                 }
               }
               //midcareer andseniors
               if (type == 11){
                 foundCount3_1++;
                 if (foundCount3_1 == 1){
                   x_tar_11 = x_location;
                   y_tar_11 = y_location;
                 }
                 if (foundCount3_1 == 2){
                   x_tar1_11 = x_location;
                   y_tar1_11 = y_location;  
                 }
                 if (foundCount3_1 == 3){
                   x_tar2_11 = x_location;
                   y_tar2_11 = y_location;  
                 }
                 if (foundCount3_1 == 4){
                   x_tar3_11 = x_location;
                   y_tar3_11 = y_location;  
                 }
                 if (foundCount3_1 == 5){
                   x_tar4_11 = x_location;
                   y_tar4_11 = y_location;  
                 }
                 if (foundCount3_1 == 6){
                   x_tar5_11 = x_location;
                   y_tar5_11 = y_location;
                 }
               }
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
               //midcareer andseniors
               if (type == 8){
                 foundCount2_1++;
                 if (foundCount2_1 == 1){
                   x_tar_8 = x_location;
                   y_tar_8 = y_location;
                 }
                 if (foundCount2_1 == 2){
                   x_tar1_8 = x_location;
                   y_tar1_8 = y_location;  
                 }
                 if (foundCount2_1 == 3){
                   x_tar2_8 = x_location;
                   y_tar2_8 = y_location;  
                 }
                 if (foundCount2_1 == 4){
                   x_tar3_8 = x_location;
                   y_tar3_8 = y_location;  
                 }
                 if (foundCount2_1 == 5){
                   x_tar4_8 = x_location;
                   y_tar4_8 = y_location;  
                 }
                 if (foundCount2_1 == 6){
                   x_tar5_8 = x_location;
                   y_tar5_8 = y_location;  
                 }
               }
           }
      }   
    }
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//                   
    for (MidCareer m : midcareers){
      if(count2 <=40){
      m.applyBehaviors(midcareers);
      } else if (count2> 40 && count2 <=80){
      m.applyBehaviors1(midcareers);
      } else if (count2> 80 && count2 <=120){
      m.applyBehaviors2(midcareers);
      } else if (count2> 120 && count2 <=160){
      m.applyBehaviors3(midcareers);
      } else if (count2> 160 && count2 <=200){
      m.applyBehaviors4(midcareers);
      } else if (count2> 200 && count2 <=240){
      m.applyBehaviors5(midcareers);
      } else if (count2> 240 && count2 <=280){
      m.applyBehaviors6(midcareers);
      } else if (count2> 280 && count2 <=320){
      m.applyBehaviors7(midcareers);
      } else if (count2> 320 && count2 <=360){
      m.applyBehaviors8(midcareers);
      } else if (count2> 360 && count2 <=400){
      m.applyBehaviors9(midcareers);
      } else if (count2> 400 && count2 <=440){
      m.applyBehaviors10(midcareers);
      } else if (count2> 440 && count2 <=480){
      m.applyBehaviors11(midcareers);
      } else if (count2> 480 && count2 <=520){
      m.applyBehaviors12(midcareers);
      } else if (count2> 520 && count2 <=560){
      m.applyBehaviors13(midcareers);
      } else if (count2> 560 && count2 <=600){
      m.applyBehaviors14(midcareers);
      } else if (count2> 600 && count2 <=640){
      m.applyBehaviors15(midcareers);
      } else if (count2> 640 && count2 <=680){
      m.applyBehaviors16(midcareers);
      } else if (count2> 680 && count2 <=720){
      m.applyBehaviors17(midcareers);
      } else if (count2> 720 && count2 <=760){
      m.applyBehaviors18(midcareers);
      } else if (count2> 760 && count2 <=820){
      m.applyBehaviors19(midcareers);
      } else if (count2> 820 && count2 <=840){
      m.applyBehaviors20(midcareers);
      } else if (count2> 840 && count2 <=880){
      m.applyBehaviors21(midcareers);
      }else if (count2> 880 && count2 <=920){
      m.applyBehaviors22(midcareers);
      }else if (count2> 920 && count2 <=1000){
      m.applyBehaviors23(midcareers);
      }
      m.update();
      count2++; 
    }
    
    for (Mellennial v : mellennials){
      if(count <=40){
      v.applyBehaviors(mellennials);
      } else if (count> 40 && count <=80){
      v.applyBehaviors1(mellennials);
      } else if (count> 80 && count <=120){
      v.applyBehaviors2(mellennials);
      } else if (count> 120 && count <=160){
      v.applyBehaviors3(mellennials);
      } else if (count> 160 && count <=200){
      v.applyBehaviors4(mellennials);
      } else if (count> 200 && count <=240){
      v.applyBehaviors5(mellennials);
      } else if (count> 240 && count <=280){
      v.applyBehaviors6(mellennials);
      } else if (count> 280 && count <=320){
      v.applyBehaviors7(mellennials);
      } else if (count> 320 && count <=360){
      v.applyBehaviors8(mellennials);
      } else if (count> 360 && count <=400){
      v.applyBehaviors9(mellennials);
      } else if (count> 400 && count <=440){
      v.applyBehaviors10(mellennials);
      } else if (count> 440 && count <=480){
      v.applyBehaviors11(mellennials);
      } else if (count> 480 && count <=520){
      v.applyBehaviors12(mellennials);
      } else if (count> 520 && count <=560){
      v.applyBehaviors13(mellennials);
      } else if (count> 560 && count <=600){
      v.applyBehaviors14(mellennials);
      } else if (count> 600 && count <=640){
      v.applyBehaviors15(mellennials);
      } else if (count> 640 && count <=680){
      v.applyBehaviors16(mellennials);
      } else if (count> 680 && count <=720){
      v.applyBehaviors17(mellennials);
      } else if (count> 720 && count <=760){
      v.applyBehaviors18(mellennials);
      } else if (count> 760 && count <=820){
      v.applyBehaviors19(mellennials);
      } else if (count> 820 && count <=840){
      v.applyBehaviors20(mellennials);
      } else if (count> 840 && count <=880){
      v.applyBehaviors21(mellennials);
      }else if (count> 880 && count <=920){
      v.applyBehaviors22(mellennials);
      }else if (count> 920 && count <=1000){
      v.applyBehaviors23(mellennials);
      }
      v.update();
      count++;
    }

  for (Senior s : seniors){
      if(count3 <=40){
      s.applyBehaviors(seniors);
      } else if (count3> 40 && count3 <=80){
      s.applyBehaviors1(seniors);
      } else if (count3> 80 && count3 <=120){
      s.applyBehaviors2(seniors);
      } else if (count3> 120 && count3 <=160){
      s.applyBehaviors3(seniors);
      } else if (count3> 160 && count3 <=200){
      s.applyBehaviors4(seniors);
      } else if (count3> 200 && count3 <=240){
      s.applyBehaviors5(seniors);
      } else if (count3> 240 && count3 <=280){
      s.applyBehaviors6(seniors);
      } else if (count3> 280 && count3 <=320){
      s.applyBehaviors7(seniors);
      } else if (count3> 320 && count3 <=360){
      s.applyBehaviors8(seniors);
      } else if (count3> 360 && count3 <=400){
      s.applyBehaviors9(seniors);
      } else if (count3> 400 && count3 <=440){
      s.applyBehaviors10(seniors);
      } else if (count3> 440 && count3 <=480){
      s.applyBehaviors11(seniors);
      } else if (count3> 480 && count3 <=520){
      s.applyBehaviors12(seniors);
      } else if (count3> 520 && count3 <=560){
      s.applyBehaviors13(seniors);
      } else if (count3> 560 && count3 <=600){
      s.applyBehaviors14(seniors);
      } else if (count3> 600 && count3 <=640){
      s.applyBehaviors15(seniors);
      } else if (count3> 640 && count3 <=680){
      s.applyBehaviors16(seniors);
      } else if (count3> 680 && count3 <=720){
      s.applyBehaviors17(seniors);
      } else if (count3> 720 && count3 <=760){
      s.applyBehaviors18(seniors);
      } else if (count3> 760 && count3 <=820){
      s.applyBehaviors19(seniors);
      } else if (count3> 820 && count3 <=840){
      s.applyBehaviors20(seniors);
      } else if (count3> 840 && count3 <=880){
      s.applyBehaviors21(seniors);
      }else if (count3> 880 && count3 <=920){
      s.applyBehaviors22(seniors);
      }else if (count3> 920 && count3 <=1000){
      s.applyBehaviors23(seniors);
      }
      s.update();
      count3++;
    }
    
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//                   
}

public void drawAgents() {
  
  for (Mellennial v : mellennials){    
    plan.fill(#15f4ee);
    plan.stroke(0);
    plan.pushMatrix();
    plan.translate(v.location.x, v.location.y);
    plan.ellipse(0, 0, v.r, v.r);
    plan.popMatrix();
  }
  for (MidCareer m : midcareers){    
    plan.fill(#ff0000);
    plan.stroke(0);
    plan.pushMatrix();
    plan.translate(m.location.x, m.location.y);
    plan.ellipse(0, 0, m.r, m.r);
    plan.popMatrix();
  }
  for (Senior s : seniors){    
    plan.fill(#fedd00);
    plan.stroke(0);
    plan.pushMatrix();
    plan.translate(s.location.x, s.location.y);
    plan.ellipse(0, 0, s.r, s.r);
    plan.popMatrix();
  }
  
}

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
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
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//   
  void applyBehaviors(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target_1,y_target_1));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors1(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target1_1,y_target1_1));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors2(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target2_1,y_target2_1));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  } 
    void applyBehaviors3(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target3_1,y_target3_1));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors4(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target4_1,y_target4_1));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors5(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target5_1,y_target5_1));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//   
  void applyBehaviors6(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target_3,y_target_3));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors7(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target1_3,y_target1_3));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors8(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target2_3,y_target2_3));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  
    void applyBehaviors9(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target3_3,y_target3_3));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors10(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target4_3,y_target4_3));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors11(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target5_3,y_target5_3));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
  void applyBehaviors12(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target_9,y_target_9));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors13(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target1_9,y_target1_9));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors14(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target2_9,y_target2_9));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  
    void applyBehaviors15(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target3_9,y_target3_9));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors16(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target4_9,y_target4_9));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors17(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target5_9,y_target5_9));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  //---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
  void applyBehaviors18(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target_10,y_target_10));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors19(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target1_10,y_target1_10));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors20(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target2_10,y_target2_10));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  
    void applyBehaviors21(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target3_10,y_target3_10));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors22(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target4_10,y_target4_10));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors23(ArrayList<Mellennial> mellennials) {
     PVector separateForce = separate(mellennials);
     PVector seekForce = seek(new PVector(x_target5_10,y_target5_10));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
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
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
public class MidCareer {
    
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;
  float maxspeed;
  
  MidCareer(float x, float y) {
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
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//   
  void applyBehaviors(ArrayList<MidCareer> midcareers) {
     PVector separateForce = separate(midcareers);
     PVector seekForce = seek(new PVector(x_tar_0,y_tar_0));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors1(ArrayList<MidCareer> midcareers) {
     PVector separateForce = separate(midcareers);
     PVector seekForce = seek(new PVector(x_tar1_0,y_tar1_0));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors2(ArrayList<MidCareer> midcareers) {
     PVector separateForce = separate(midcareers);
     PVector seekForce = seek(new PVector(x_tar2_0,y_tar2_0));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors3(ArrayList<MidCareer> midcareers) {
     PVector separateForce = separate(midcareers);
     PVector seekForce = seek(new PVector(x_tar3_0,y_tar3_0));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors4(ArrayList<MidCareer> midcareers) {
     PVector separateForce = separate(midcareers);
     PVector seekForce = seek(new PVector(x_tar4_0,y_tar4_0));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors5(ArrayList<MidCareer> midcareers) {
     PVector separateForce = separate(midcareers);
     PVector seekForce = seek(new PVector(x_tar5_0,y_tar5_0));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//   
  void applyBehaviors6(ArrayList<MidCareer> midcareers) {
     PVector separateForce = separate(midcareers);
     PVector seekForce = seek(new PVector(x_tar_2,y_tar_2));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors7(ArrayList<MidCareer> midcareers) {
     PVector separateForce = separate(midcareers);
     PVector seekForce = seek(new PVector(x_tar1_2,y_tar1_2));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors8(ArrayList<MidCareer> midcareers) {
     PVector separateForce = separate(midcareers);
     PVector seekForce = seek(new PVector(x_tar2_2,y_tar2_2));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors9(ArrayList<MidCareer> midcareers) {
     PVector separateForce = separate(midcareers);
     PVector seekForce = seek(new PVector(x_tar3_2,y_tar3_2));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors10(ArrayList<MidCareer> midcareers) {
     PVector separateForce = separate(midcareers);
     PVector seekForce = seek(new PVector(x_tar4_2,y_tar4_2));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors11(ArrayList<MidCareer> midcareers) {
     PVector separateForce = separate(midcareers);
     PVector seekForce = seek(new PVector(x_tar5_2,y_tar5_2));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
  void applyBehaviors12(ArrayList<MidCareer> midcareers) {
     PVector separateForce = separate(midcareers);
     PVector seekForce = seek(new PVector(x_tar_8,y_tar_8));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors13(ArrayList<MidCareer> midcareers) {
     PVector separateForce = separate(midcareers);
     PVector seekForce = seek(new PVector(x_tar1_8,y_tar1_8));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors14(ArrayList<MidCareer> midcareers) {
     PVector separateForce = separate(midcareers);
     PVector seekForce = seek(new PVector(x_tar2_8,y_tar2_8));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors15(ArrayList<MidCareer> midcareers) {
     PVector separateForce = separate(midcareers);
     PVector seekForce = seek(new PVector(x_tar3_8,y_tar3_8));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors16(ArrayList<MidCareer> midcareers) {
     PVector separateForce = separate(midcareers);
     PVector seekForce = seek(new PVector(x_tar4_8,y_tar4_8));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors17(ArrayList<MidCareer> midcareers) {
     PVector separateForce = separate(midcareers);
     PVector seekForce = seek(new PVector(x_tar5_8,y_tar5_8));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//   
  void applyBehaviors18(ArrayList<MidCareer> midcareers) {
     PVector separateForce = separate(midcareers);
     PVector seekForce = seek(new PVector(x_tar_11,y_tar_11));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors19(ArrayList<MidCareer> midcareers) {
     PVector separateForce = separate(midcareers);
     PVector seekForce = seek(new PVector(x_tar1_11,y_tar1_11));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors20(ArrayList<MidCareer> midcareers) {
     PVector separateForce = separate(midcareers);
     PVector seekForce = seek(new PVector(x_tar2_11,y_tar2_11));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors21(ArrayList<MidCareer> midcareers) {
     PVector separateForce = separate(midcareers);
     PVector seekForce = seek(new PVector(x_tar3_11,y_tar3_11));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors22(ArrayList<MidCareer> midcareers) {
     PVector separateForce = separate(midcareers);
     PVector seekForce = seek(new PVector(x_tar4_11,y_tar4_11));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors23(ArrayList<MidCareer> midcareers) {
     PVector separateForce = separate(midcareers);
     PVector seekForce = seek(new PVector(x_tar5_11,y_tar5_11));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
  PVector seek(PVector target){
      PVector desired = PVector.sub(target,location);
      desired.normalize();
      desired.mult(maxspeed);
      PVector steer = PVector.sub(desired,velocity);
      steer.limit(maxforce);
      return steer; 
  }
  
  PVector separate(ArrayList<MidCareer> midcareers){
    float desiredseparation = r*1.5;
    PVector sum = new PVector();
    int count = 0;
    
    for(MidCareer other : midcareers) {
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
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

public class Senior { 
    
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;
  float maxspeed;
  
  Senior(float x, float y) {
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
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//   
  void applyBehaviors(ArrayList<Senior> seniors) {
     PVector separateForce = separate(seniors);
     PVector seekForce = seek(new PVector(x_tar_0,y_tar_0));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors1(ArrayList<Senior> seniors) {
     PVector separateForce = separate(seniors);
     PVector seekForce = seek(new PVector(x_tar1_0,y_tar1_0));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors2(ArrayList<Senior> seniors) {
     PVector separateForce = separate(seniors);
     PVector seekForce = seek(new PVector(x_tar2_0,y_tar2_0));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors3(ArrayList<Senior> seniors) {
     PVector separateForce = separate(seniors);
     PVector seekForce = seek(new PVector(x_tar3_0,y_tar3_0));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors4(ArrayList<Senior> seniors) {
     PVector separateForce = separate(seniors);
     PVector seekForce = seek(new PVector(x_tar4_0,y_tar4_0));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors5(ArrayList<Senior> seniors) {
     PVector separateForce = separate(seniors);
     PVector seekForce = seek(new PVector(x_tar5_0,y_tar5_0));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//   
  void applyBehaviors6(ArrayList<Senior> seniors) {
     PVector separateForce = separate(seniors);
     PVector seekForce = seek(new PVector(x_tar_2,y_tar_2));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors7(ArrayList<Senior> seniors) {
     PVector separateForce = separate(seniors);
     PVector seekForce = seek(new PVector(x_tar1_2,y_tar1_2));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors8(ArrayList<Senior> seniors) {
     PVector separateForce = separate(seniors);
     PVector seekForce = seek(new PVector(x_tar2_2,y_tar2_2));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors9(ArrayList<Senior> seniors) {
     PVector separateForce = separate(seniors);
     PVector seekForce = seek(new PVector(x_tar3_2,y_tar3_2));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors10(ArrayList<Senior> seniors) {
     PVector separateForce = separate(seniors);
     PVector seekForce = seek(new PVector(x_tar4_2,y_tar4_2));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors11(ArrayList<Senior> seniors) {
     PVector separateForce = separate(seniors);
     PVector seekForce = seek(new PVector(x_tar5_2,y_tar5_2));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
  void applyBehaviors12(ArrayList<Senior> seniors) {
     PVector separateForce = separate(seniors);
     PVector seekForce = seek(new PVector(x_tar_8,y_tar_8));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors13(ArrayList<Senior> seniors) {
     PVector separateForce = separate(seniors);
     PVector seekForce = seek(new PVector(x_tar1_8,y_tar1_8));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors14(ArrayList<Senior> seniors) {
     PVector separateForce = separate(seniors);
     PVector seekForce = seek(new PVector(x_tar2_8,y_tar2_8));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors15(ArrayList<Senior> seniors) {
     PVector separateForce = separate(seniors);
     PVector seekForce = seek(new PVector(x_tar3_8,y_tar3_8));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors16(ArrayList<Senior> seniors) {
     PVector separateForce = separate(seniors);
     PVector seekForce = seek(new PVector(x_tar4_8,y_tar4_8));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors17(ArrayList<Senior> seniors) {
     PVector separateForce = separate(seniors);
     PVector seekForce = seek(new PVector(x_tar5_8,y_tar5_8));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//   
  void applyBehaviors18(ArrayList<Senior> seniors) {
     PVector separateForce = separate(seniors);
     PVector seekForce = seek(new PVector(x_tar_11,y_tar_11));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors19(ArrayList<Senior> seniors) {
     PVector separateForce = separate(seniors);
     PVector seekForce = seek(new PVector(x_tar1_11,y_tar1_11));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors20(ArrayList<Senior> seniors) {
     PVector separateForce = separate(seniors);
     PVector seekForce = seek(new PVector(x_tar2_11,y_tar2_11));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors21(ArrayList<Senior> seniors) {
     PVector separateForce = separate(seniors);
     PVector seekForce = seek(new PVector(x_tar3_11,y_tar3_11));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors22(ArrayList<Senior> seniors) {
     PVector separateForce = separate(seniors);
     PVector seekForce = seek(new PVector(x_tar4_11,y_tar4_11));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  void applyBehaviors23(ArrayList<Senior> seniors) {
     PVector separateForce = separate(seniors);
     PVector seekForce = seek(new PVector(x_tar5_11,y_tar5_11));
     separateForce.mult(3);
     seekForce.mult(1);
     applyForce(separateForce);
     applyForce(seekForce);
  }
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
  PVector seek(PVector target){
      PVector desired = PVector.sub(target,location);
      desired.normalize();
      desired.mult(maxspeed);
      PVector steer = PVector.sub(desired,velocity);
      steer.limit(maxforce);
      return steer; 
  }
  
  PVector separate(ArrayList<Senior> seniors){
    float desiredseparation = r*1.5;
    PVector sum = new PVector();
    int count = 0;
    
    for(Senior other : seniors) {
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
