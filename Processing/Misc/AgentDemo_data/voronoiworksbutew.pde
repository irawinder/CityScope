//HUGE UGLY VORONOI MATH THAT DOES THING 
//if(showVoronoi == true)
//{
////  for(int l = 0; l<3; l++){
////      float x = random(10, p.width-10);
////      float y = random(10, p.height-10);
////      if(
////      (((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))) && 
////      ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <= ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
////      &&
////      ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <= ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
////      &&
////      ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <=  ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
////      &&
////      ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <= ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
////      &&
////      ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <=  ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
////      &&
////     ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
////      &&
////      ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <= ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
////      &&
////      ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <=((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
////      &&
////      ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <=  ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
////      &&
////      ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <= ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
////      &&
////      ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <= ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
////      &&
////      ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <= ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
////      &&
////      ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <=  ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
////      &&
////      ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0])) <=((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15]))
////      )
////      {
////      origin[i*(numNodes-1)+j] = new PVector(x, y);
////      works = true;
//////      towergeneration = false;
////      }
////      
////      
////     else{
////        if(i>1 && works == true){
////        origin[i*(numNodes-1)+j] = origin[(i-1)*(numNodes-1)+(j-1)];
////        }
////       if(i>1 && works == false){
////        origin[i*(numNodes-1)+j] = origin[(i-1)*(numNodes-1)+(j-1)];
////        }
////        else if(i>10 && works == false){
////          origin[i*(numNodes-1)+j] = origin[(i-2)*(numNodes-1)+(j-2)];
////        }
////        else{
////          origin[i*(numNodes-1)+j] = new PVector(towers_x[0], towers_y[0]); //in real life, this would be to an ammenity in the polygon
////          towergeneration = true;
//////          println(i, j);
////        }
////          
////       }
////}
////    for(int l = 0; l<3; l++){
////      float x = random(10, p.width-10);
////      float y = random(10, p.height-10);
////      if( (((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) 
////      && 
////     ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
////      &&
////     ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1])) <= ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
////      &&
////       ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1])) <= ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
////      &&
////       ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1])) <=((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
////      &&
////       ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1])) <=((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
////      &&
////       ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1])) <=((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
////      &&
////       ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1])) <=((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
////      &&
////       ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1])) <=((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
////      &&
////        ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1])) <=((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
////      &&
////       ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1])) <=((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
////      &&
////        ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1])) <=((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
////      &&
////        ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1])) <=((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
////      &&
////       ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1])) <=((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
////      &&
////       ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1])) <=((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15]))
////      && h<10)
////      {
////      origin1[i*(numNodes-1)+j] = new PVector(x, y);
////      works = true;
////      }
////      
//////      else{
//////        if(i>1 && works == true){
//////        origin1[i*(numNodes-1)+j] = origin1[(i-1)*(numNodes-1)+(j-1)];
//////        }
//////        else if(i>1 && works == false){
//////        origin1[i*(numNodes-1)+j] = origin1[(i-1)*(numNodes-1)+(j-1)];
//////        }
//////        else if(i>10 && works == false){
//////          origin1[i*(numNodes-1)+j] = origin1[(i-2)*(numNodes-1)+(j-2)];
//////        }
//////        else{
//////          origin1[i*(numNodes-1)+j] = new PVector(towers_x[1], towers_y[1]); //in real life, this would be to an ammenity in the polygon
//////          towergeneration = true;
//////          println(i, j);
//////        }
//////          
//////      }
////       
////  }
//  
////  for(int l = 0; l<3; l++){
////      float x = random(10, p.width-10);
////      float y = random(10, p.height-10);
////      if( 
////      (((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) && 
////      ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <=  ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
////      &&
////      ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <= ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
////      &&
////      ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <=  ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
////      &&
////      ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <=  ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
////      &&
////      ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <=  ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
////      &&
////     ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
////      &&
////      ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <=  ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
////      &&
////      ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <= ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
////      &&
////      ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <=  ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
////      &&
////      ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <=  ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
////      &&
////      ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <= ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
////      &&
////      ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <= ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
////      &&
////      ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <=  ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
////      &&
////      ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2])) <= ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15]))
////      )
////      {
////      origin2[i*(numNodes-1)+j] = new PVector(x, y);
////      works = true;
////      }
////      
////      else{
////        if(i>1 && works == true){
////        origin2[i*(numNodes-1)+j] = origin2[(i-1)*(numNodes-1)+(j-1)];
////        }
////        else if(i>1 && works == false){
////        origin2[i*(numNodes-1)+j] = origin2[(i-1)*(numNodes-1)+(j-1)];
////        }
////        else if(i>10 && works == false){
////          origin2[i*(numNodes-1)+j] = origin2[(i-2)*(numNodes-1)+(j-2)];
////        }
////        else{
////          origin2[i*(numNodes-1)+j] = new PVector(towers_x[2], towers_y[2]); //in real life, this would be to an ammenity in the polygon
////          towergeneration = true;
////        }
////          
////      }
////}
//// for(int l = 0; l<3; l++){
////      float x = random(10, p.width-10);
////      float y = random(10, p.height-10);
////      if( (((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) && 
////      ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
////      &&
////      ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <= ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
////      &&
////      ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <= ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
////      &&
////      ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <= ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
////      &&
////      ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <= ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
////      &&
////      ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
////      &&
////      ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <= ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
////      &&
////      ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <=((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
////      &&
////     ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <= ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
////      &&
////      ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <= ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
////      &&
////      ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <=((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
////      &&
////      ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <=((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
////      &&
////      ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <= ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
////      &&
////      ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3])) <=((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])))
////      {
////      origin3[i*(numNodes-1)+j] = new PVector(x, y);
////      works = true;
////      }
////      
////       else{
////        if(i>1 && works == true){
////        origin3[i*(numNodes-1)+j] = origin3[(i-1)*(numNodes-1)+(j-1)];
////        }
////        else if(i>1 && works == false){
////        origin3[i*(numNodes-1)+j] = origin3[(i-1)*(numNodes-1)+(j-1)];
////        }
////        else if(i>10 && works == false){
////          origin3[i*(numNodes-1)+j] = origin3[(i-2)*(numNodes-1)+(j-2)];
////        }
////        else{
////          origin3[i*(numNodes-1)+j] = new PVector(towers_x[3], towers_y[3]); //in real life, this would be to an ammenity in the polygon
////          towergeneration = true;
////        }
////          
////      }
////       
////  }
//  
//   for(int l = 0; l<3; l++){
//      float x = random(10, p.width-10);
//      float y = random(10, p.height-10);
//      if( (((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) && 
//      ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
//      &&
//      ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <= ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
//      &&
//      ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <= ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
//      &&
//      ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <= ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
//      &&
//      ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <= ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
//      &&
//      (((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
//      &&
//      ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <= ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
//      &&
//      ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <=((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
//      &&
//     ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <= ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
//      &&
//      ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <=((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
//      &&
//      ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <=((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
//      &&
//      ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <=((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
//      &&
//      ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <= ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
//      &&
//      ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4])) <= ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15]))))
//      {
//      origin4[i*(numNodes-1)+j] = new PVector(x, y);
//      works = true;
//      }
//      
//     else{
//        if(i>1 && works == true){
//        origin4[i*(numNodes-1)+j] = origin4[(i-1)*(numNodes-1)+(j-1)];
//        }
//        else if(i>1 && works == false){
//        origin4[i*(numNodes-1)+j] = origin4[(i-1)*(numNodes-1)+(j-1)];
//        }
//        else if(i>10 && works == false){
//          origin4[i*(numNodes-1)+j] = origin4[(i-2)*(numNodes-1)+(j-2)];
//        }
//        else{
//          origin4[i*(numNodes-1)+j] = new PVector(towers_x[4], towers_y[4]); //in real life, this would be to an ammenity in the polygon
//          towergeneration = true;
//        }
//          
//      }
//       
//  }
//  
//   for(int l = 0; l<3; l++){
//      float x = random(10, p.width-10);
//      float y = random(10, p.height-10);
//      if( (((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) && 
//      ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
//      &&
//      ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <= ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
//      &&
//      ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <= ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
//      &&
//      ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <= ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
//      &&
//      ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <= ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
//      &&
//      ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
//      &&
//      ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <= ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
//      &&
//      ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <=((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
//      &&
//     ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <= ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
//      &&
//      ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <= ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
//      &&
//      ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <=((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
//      &&
//      ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <=((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
//      &&
//      ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <= ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
//      &&
//      ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5])) <= ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])))
//      {
//      origin5[i*(numNodes-1)+j] = new PVector(x, y);
//      works = true;
//      }
//      
//       else{
//        if(i>1 && works == true){
//        origin5[i*(numNodes-1)+j] = origin5[(i-1)*(numNodes-1)+(j-1)];
//        }
//        else if(i>1 && works == false){
//        origin5[i*(numNodes-1)+j] = origin5[(i-1)*(numNodes-1)+(j-1)];
//        }
//        else if(i>10 && works == false){
//          origin5[i*(numNodes-1)+j] = origin5[(i-2)*(numNodes-1)+(j-2)];
//        }
//        else{
//          origin5[i*(numNodes-1)+j] = new PVector(towers_x[5], towers_y[5]); //in real life, this would be to an ammenity in the polygon
//          towergeneration = true;
//        }
//          
//      }
//  }
//
// for(int l = 0; l<3; l++){
//      float x = random(10, p.width-10);
//      float y = random(10, p.height-10);
//      if( (((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) && 
//      ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
//      &&
//      ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
//      &&
//      ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
//      &&
//      ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
//      &&
//     ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
//      &&
//      ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
//      &&
//      ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
//      &&
//      ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <=((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
//      &&
//     ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
//      &&
//      ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
//      &&
//      ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
//      &&
//      ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
//      &&
//      ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
//      &&
//      ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6])) <= ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])))
//      {
//      origin6[i*(numNodes-1)+j] = new PVector(x, y);
//      works = true;
//      }
//      
//      else{
//        if(i>1 && works == true){
//        origin6[i*(numNodes-1)+j] = origin6[(i-1)*(numNodes-1)+(j-1)];
//        }
//        else if(i>1 && works == false){
//        origin6[i*(numNodes-1)+j] = origin6[(i-1)*(numNodes-1)+(j-1)];
//        }
//        else if(i>10 && works == false){
//          origin6[i*(numNodes-1)+j] = origin6[(i-2)*(numNodes-1)+(j-2)];
//        }
//        else{
//          origin6[i*(numNodes-1)+j] = new PVector(towers_x[6], towers_y[6]); //in real life, this would be to an ammenity in the polygon
//          towergeneration = true;
//        }
//          
//      }
//       
//  }
//
//      for(int l = 0; l<3; l++){
//      float x = random(10, p.width-10);
//      float y = random(10, p.height-10);
//      if( (((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) && 
//      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
//      &&
//      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
//      &&
//      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
//      &&
//      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
//      &&
//      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
//      &&
//      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
//      &&
//      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
//      &&
//      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <=((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
//      &&
//      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
//      &&
//      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
//      &&
//      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
//      &&
//      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
//      &&
//      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
//      &&
//      ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7])) <= ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])))
//      {
//      origin7[i*(numNodes-1)+j] = new PVector(x, y);
//      works = true;
//      }
//      
//      else{
//        if(i>1 && works == true){
//        origin7[i*(numNodes-1)+j] = origin7[(i-1)*(numNodes-1)+(j-1)];
//        }
//        else if(i>1 && works == false){
//        origin7[i*(numNodes-1)+j] = origin7[(i-1)*(numNodes-1)+(j-1)];
//        }
//        else if(i>10 && works == false){
//          origin7[i*(numNodes-1)+j] = origin7[(i-2)*(numNodes-1)+(j-2)];
//        }
//        else{
//          origin7[i*(numNodes-1)+j] = new PVector(towers_x[7], towers_y[7]); //in real life, this would be to an ammenity in the polygon
//          towergeneration = true;
//        }
//          
//      }
//       
//  }
//  
//     for(int l = 0; l<3; l++){
//      float x = random(10, p.width-10);
//      float y = random(10, p.height-10);
//      if( (((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) && 
//      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
//      &&
//      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <=((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
//      &&
//      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <= ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
//      &&
//      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <= ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
//      &&
//      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <= ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
//      &&
//      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
//      &&
//      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <= ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
//      &&
//      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <= ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
//      &&
//      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <= ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
//      &&
//      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <=((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
//      &&
//      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <= ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
//      &&
//      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <= ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
//      &&
//      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <= ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
//      &&
//      ((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8])) <= ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])))
//      {
//      origin8[i*(numNodes-1)+j] = new PVector(x, y);
//      works = true;
//      }
//      
//       else{
//        if(i>1 && works == true){
//        origin8[i*(numNodes-1)+j] = origin8[(i-1)*(numNodes-1)+(j-1)];
//        }
//        else if(i>1 && works == false){
//        origin8[i*(numNodes-1)+j] = origin8[(i-1)*(numNodes-1)+(j-1)];
//        }
//        else if(i>10 && works == false){
//          origin8[i*(numNodes-1)+j] = origin8[(i-2)*(numNodes-1)+(j-2)];
//        }
//        else{
//          origin8[i*(numNodes-1)+j] = new PVector(towers_x[8], towers_y[8]); //in real life, this would be to an ammenity in the polygon
//          towergeneration = true;
//        }
//          
//      }
//       
//  }
//  
//  for(int l = 0; l<3; l++){
//      float x = random(10, p.width-10);
//      float y = random(10, p.height-10);
//      if( (((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) && 
//      ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
//      &&
//      ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <=((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
//      &&
//      ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <= ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
//      &&
//     ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <= ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
//      &&
//     ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <= ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
//      &&
//      ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
//      &&
//      ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <= ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
//      &&
//      ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <=((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
//      &&
//      ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <= ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
//      &&
//      ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <=((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
//      &&
//      ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <= ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
//      &&
//      ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <= ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
//      &&
//      ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <= ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
//      &&
//      ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9])) <= ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])))
//      {
//      origin9[i*(numNodes-1)+j] = new PVector(x, y);
//      works = true;
//      }
//      
//     else{
//        if(i>1 && works == true){
//        origin9[i*(numNodes-1)+j] = origin9[(i-1)*(numNodes-1)+(j-1)];
//        }
//        else if(i>1 && works == false){
//        origin9[i*(numNodes-1)+j] = origin9[(i-1)*(numNodes-1)+(j-1)];
//        }
//        else if(i>15 && works == false){
//          origin9[i*(numNodes-1)+j] = origin9[(i-2)*(numNodes-1)+(j-2)];
//        }
//         else{
//          origin9[i*(numNodes-1)+j] = new PVector (towers_x[9], towers_y[9]); //in real life, this would be to an ammenity in the polygon
//          towergeneration = true;
//        }
//          
//      }
//       
//  }
//  
//  for(int l = 0; l<3; l++){
//      float x = random(10, p.width-10);
//      float y = random(10, p.height-10);
//      if( (((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) && 
//      ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
//      &&
//      ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <=((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
//      &&
//      ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <= ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
//      &&
//     ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <= ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
//      &&
//     ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <= ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
//      &&
//      ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
//      &&
//      ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <= ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
//      &&
//      ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <=((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
//      &&
//      ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <= ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
//      &&
//      ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <=((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
//      &&
//      ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <=((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
//      &&
//      ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <=((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
//      &&
//      ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <=((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
//      &&
//      ((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10])) <=((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])))
//      {
//      origin10[i*(numNodes-1)+j] = new PVector(x, y);
//      works = true;
//      }
//      
//       else{
//        if(i>1 && works == true){
//        origin10[i*(numNodes-1)+j] = origin10[(i-1)*(numNodes-1)+(j-1)];
//        }
//        else if(i>1 && works == false){
//        origin10[i*(numNodes-1)+j] = origin10[(i-1)*(numNodes-1)+(j-1)];
//        }
//        else if(i>10 && works == false){
//          origin10[i*(numNodes-1)+j] = origin10[(i-2)*(numNodes-1)+(j-2)];
//        }
//        else{
//          origin10[i*(numNodes-1)+j] = new PVector(towers_x[10], towers_y[10]); //in real life, this would be to an ammenity in the polygon
//          towergeneration = true;
//        }
//          
//      }
//       
//  }
//
//  for(int l = 0; l<3; l++){
//      float x = random(10, p.width-10);
//      float y = random(10, p.height-10);
//      if( (((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) && 
//     ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
//      &&
//      ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <=((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
//      &&
//      ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <= ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
//      &&
//     ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <= ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
//      &&
//     ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <= ((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
//      &&
//      ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
//      &&
//      ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <= ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
//      &&
//     ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <=((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
//      &&
//      ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <= ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
//      &&
//      ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <=((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
//      &&
//      ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <=((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
//      &&
//      ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <=((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
//      &&
//      ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <=((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
//      &&
//      ((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11])) <=((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])))
//      {
//      origin11[i*(numNodes-1)+j] = new PVector(x, y);
//      works = true;
//      towergeneration = false;
//      }
//      
//      else{
//          origin11[i*(numNodes-1)+j] = new PVector(towers_x[11], towers_y[11]); //in real life, this would be to an ammenity in the polygon
//          towergeneration = true;
//          
//      }
//       
//  }
//  
//  
//    for(int l = 0; l<3; l++){
//      float x = random(10, p.width-10);
//      float y = random(10, p.height-10);
//      if( (((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) && 
//     ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
//      &&
//      ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <=((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
//      &&
//      ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <= ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
//      &&
//     ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <= ((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
//      &&
//     ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <=((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
//      &&
//     ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
//      &&
//      ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <= ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
//      &&
//     ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <=((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
//      &&
//      ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <= ((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
//      &&
//      ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <=((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
//      &&
//      ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <=((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
//      &&
//      ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <=((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
//      &&
//      ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <=((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
//      &&
//      ((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12])) <= ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])))
//      {
//      origin12[i*(numNodes-1)+j] = new PVector(x, y);
//      works = true;
//      }
//      
//      else{
//        if(i>1 && works == true){
//        origin12[i*(numNodes-1)+j] = origin12[(i-1)*(numNodes-1)+(j-1)];
//        }
//        else if(i>1 && works == false){
//        origin12[i*(numNodes-1)+j] = origin12[(i-1)*(numNodes-1)+(j-1)];
//        }
//        else if(i>10 && works == false){
//          origin12[i*(numNodes-1)+j] = origin12[(i-2)*(numNodes-1)+(j-2)];
//        }
//        else{
//          origin12[i*(numNodes-1)+j] = new PVector(towers_x[12], towers_y[12]); //in real life, this would be to an ammenity in the polygon
//          towergeneration = true;
//        }
//          
//      }
//       
//  }
//  
//    for(int l = 0; l<3; l++){
//      float x = random(10, p.width-10);
//      float y = random(10, p.height-10);
//      if( (((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) 
//      && 
//     ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
//      &&
//     ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <=((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
//      &&
//      ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <= ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
//      &&
//     ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <=((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
//      &&
//     ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <=((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
//      &&
//     ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
//      &&
//      ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <= ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
//      &&
//     ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <=((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
//      &&
//      ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <=((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
//      &&
//     ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <=((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
//      &&
//      ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <=((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
//      &&
//      ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <=((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
//      &&
//      ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <=((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14]))
//      &&
//      ((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13])) <= ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])))
//      {
//      origin13[i*(numNodes-1)+j] = new PVector(x, y);
//      //what if I just made an array with 15 working points?
//      works = true;
//      }
//      
//   else{
//     //and called a random index of them here
//        if(i>1 && works == true){
//        origin13[i*(numNodes-1)+j] = origin13[(i-1)*(numNodes-1)+(j-1)];
//        }
//        else if(i>1 && works == false){
//        origin13[i*(numNodes-1)+j] = origin13[(i-1)*(numNodes-1)+(j-1)];
//        }
//        else if(i>10 && works == false){
//          origin13[i*(numNodes-1)+j] = origin13[(i-2)*(numNodes-1)+(j-2)];
//        }
//        else{
//          origin13[i*(numNodes-1)+j] = new PVector(towers_x[13], towers_y[13]); //in real life, this would be to an ammenity in the polygon
//          towergeneration = true;
//        }
//          
//      }
//  }
//  int n = 0;
//    for(int l = 0; l<3; l++){
//      float x = random(10, p.width-10);
//      float y = random(10, p.height-10);
//      if( (((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) 
//      && 
//     ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
//      &&
//     ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <=((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
//      &&
//      ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <= ((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
//      &&
//     ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <=((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
//      &&
//     ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <=((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
//      &&
//     ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
//      &&
//      ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <= ((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
//      &&
//     ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <=((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
//      &&
//      ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <=((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
//      &&
//     ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <=((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
//      &&
//      ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <=((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
//      &&
//      ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <=((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
//      &&
//      ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <=((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
//      &&
//      ((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])) <= ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])))
//      {
//      origin14[i*(numNodes-1)+j] = new PVector(x, y);
//      works = true;
//      }
//      
//      
//      else{
//        if(i>1 && works == true){
//        origin14[i*(numNodes-1)+j] = origin14[(i-1)*(numNodes-1)+(j-1)];
//        }
//        else if(i>1 && works == false){
//        origin14[i*(numNodes-1)+j] = origin14[(i-1)*(numNodes-1)+(j-1)];
//        }
//        else if(i>10 && works == false){
//          origin14[i*(numNodes-1)+j] = origin14[(i-2)*(numNodes-1)+(j-2)];
//        }
//        else{
//          origin14[i*(numNodes-1)+j] = new PVector(towers_x[14], towers_y[14]); //in real life, this would be to an ammenity in the polygon
//          towergeneration = true;
//        }
//          
//      }
//       
//  }
//  
//for(int l = 0; l<3; l++){
//      float x = random(10, p.width-10);
//      float y = random(10, p.height-10);
//      if( (((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <= ((x  - towers_x[0]) * (x - towers_x[0])) +  ((y  - towers_y[0]) * (y  - towers_y[0]))) 
//      && 
//     ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <= ((x  - towers_x[2]) * (x - towers_x[2])) +  ((y  - towers_y[2]) * (y  - towers_y[2]))
//      &&
//     ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <=((x  - towers_x[3]) * (x - towers_x[3])) +  ((y  - towers_y[3]) * (y  - towers_y[3]))
//      &&
//      ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <=((x  - towers_x[4]) * (x - towers_x[4])) +  ((y  - towers_y[4]) * (y  - towers_y[4]))
//      &&
//     ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <=((x  - towers_x[5]) * (x - towers_x[5])) +  ((y  - towers_y[5]) * (y  - towers_y[5]))
//      &&
//     ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <=((x  - towers_x[6]) * (x - towers_x[6])) +  ((y  - towers_y[6]) * (y  - towers_y[6]))
//      &&
//     ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <= ((x  - towers_x[1]) * (x - towers_x[1])) +  ((y  - towers_y[1]) * (y  - towers_y[1]))
//      &&
//      ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <=((x  - towers_x[7]) * (x - towers_x[7])) +  ((y  - towers_y[7]) * (y  - towers_y[7]))
//      &&
//     ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <=((x  - towers_x[8]) * (x - towers_x[8])) +  ((y  - towers_y[8]) * (y  - towers_y[8]))
//      &&
//      ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <=((x  - towers_x[9]) * (x - towers_x[9])) +  ((y  - towers_y[9]) * (y  - towers_y[9]))
//      &&
//     ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <=((x  - towers_x[10]) * (x - towers_x[10])) +  ((y  - towers_y[10]) * (y  - towers_y[10]))
//      &&
//      ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <=((x  - towers_x[11]) * (x - towers_x[11])) +  ((y  - towers_y[11]) * (y  - towers_y[11]))
//      &&
//     ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <=((x  - towers_x[12]) * (x - towers_x[12])) +  ((y  - towers_y[12]) * (y  - towers_y[12]))
//      &&
//      ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <=((x  - towers_x[13]) * (x - towers_x[13])) +  ((y  - towers_y[13]) * (y  - towers_y[13]))
//      &&
//      ((x  - towers_x[15]) * (x - towers_x[15])) +  ((y  - towers_y[15]) * (y  - towers_y[15])) <=((x  - towers_x[14]) * (x - towers_x[14])) +  ((y  - towers_y[14]) * (y  - towers_y[14])))
//      {
//      origin15[i*(numNodes-1)+j] = new PVector(x, y);
//      works = true;
//      }
//      
//       else{
//        if(i>1 && works == true){
//        origin15[i*(numNodes-1)+j] = origin15[(i-1)*(numNodes-1)+(j-1)];
//        }
//        else if(i>1 && works == false){
//        origin15[i*(numNodes-1)+j] = origin15[(i-1)*(numNodes-1)+(j-1)];
//        }
//        else if(i>10 && works == false){
//          origin15[i*(numNodes-1)+j] = origin15[(i-2)*(numNodes-1)+(j-2)];
//        }
//        else{
//          origin15[i*(numNodes-1)+j] = new PVector(towers_x[15], towers_y[15]); //in real life, this would be to an ammenity in the polygon
//          towergeneration = true;
//        }
//          
//      }
//
//  
// }
//
//      
//    }
