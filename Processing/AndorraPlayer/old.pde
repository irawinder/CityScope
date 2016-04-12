// if (network.getInt(i, "CON_O") == 0 && network.getInt(i, "CON_D") == 0) {
//        destination[i] = mercatorMap.getScreenLocation(new PVector(network.getFloat(i, "LAT_D"), network.getFloat(i, "LON_D")));
//        origin[i] = mercatorMap.getScreenLocation(new PVector(network.getFloat(i, "LAT_O"), network.getFloat(i, "LON_O")));
//         for(int j = 0; j<184; j++){ 
//                 int c = int(random(0,184));
//                 PVector sub = stufftodo.get(c);
//                 if(abs(origin[i].x- sub.x) <= 30){
//                   origin[i] = new PVector(sub.x, sub.y);
//                 }
//         }
//                 
////               int c = int(random(0,184));
////               PVector sub = stufftodo.get(c);
////               if(origin[i] != destination[i]){
////                   if((abs(sub.y - origin[i].y) <= 50)){
////                     origin[i] = new PVector(sub.x, sub.y);
////                   }
////               }
//                   
////                  if(
////                  ((sub.x  - localTowers.getFloat(0, "Lat") * (sub.x  - localTowers.getFloat(0, "Lat"))) +  ((sub.y  - localTowers.getFloat(0, "Lon")) * (sub.y  - localTowers.getFloat(0, "Lon")))) 
////                     <= ((sub.x  - localTowers.getFloat(2, "Lat")) * (sub.x - localTowers.getFloat(2, "Lat")) +  ((sub.y  - localTowers.getFloat(2, "Lon")) * (sub.y  - localTowers.getFloat(2, "Lon")))) 
////                  && 
////                  ((sub.x  - localTowers.getFloat(0, "Lat") * (sub.x  - localTowers.getFloat(0, "Lat"))) +  ((sub.y  - localTowers.getFloat(0, "Lon")) * (sub.y  - localTowers.getFloat(0, "Lon")))) 
////                     <= ((sub.x  - localTowers.getFloat(6, "Lat")) * (sub.x - localTowers.getFloat(6, "Lat")) +  ((sub.y  - localTowers.getFloat(6, "Lon")) * (sub.y  - localTowers.getFloat(6, "Lon"))))
////                  &&
////                  ((sub.x  - localTowers.getFloat(0, "Lat") * (sub.x  - localTowers.getFloat(0, "Lat"))) +  ((sub.y  - localTowers.getFloat(0, "Lon")) * (sub.y  - localTowers.getFloat(0, "Lon")))) 
////                    <= ((sub.x  - localTowers.getFloat(3, "Lat")) * (sub.x - localTowers.getFloat(3, "Lat")) +  ((sub.y  - localTowers.getFloat(3, "Lon")) * (sub.y  - localTowers.getFloat(3, "Lon"))))
////                  &&
////                  ((sub.x  - localTowers.getFloat(0, "Lat") * (sub.x  - localTowers.getFloat(0, "Lat"))) +  ((sub.y  - localTowers.getFloat(0, "Lon")) * (sub.y  - localTowers.getFloat(0, "Lon")))) 
////                   <= ((sub.x  - localTowers.getFloat(4, "Lat")) * (sub.x - localTowers.getFloat(4, "Lat")) +  ((sub.y  - localTowers.getFloat(4, "Lon")) * (sub.y  - localTowers.getFloat(4, "Lon"))))
////                  &&
////                  ((sub.x  - localTowers.getFloat(0, "Lat") * (sub.x  - localTowers.getFloat(0, "Lat"))) +  ((sub.y  - localTowers.getFloat(0, "Lon")) * (sub.y  - localTowers.getFloat(0, "Lon")))) 
////                    <= ((sub.x  - localTowers.getFloat(5, "Lat")) * (sub.x - localTowers.getFloat(5, "Lat")) +  ((sub.y  - localTowers.getFloat(5, "Lon")) * (sub.y  - localTowers.getFloat(5, "Lon"))))
////                  &&
////                  ((sub.x  - localTowers.getFloat(0, "Lat") * (sub.x  - localTowers.getFloat(0, "Lat"))) +  ((sub.y  - localTowers.getFloat(0, "Lon")) * (sub.y  - localTowers.getFloat(0, "Lon")))) 
////                    <= ((sub.x  - localTowers.getFloat(7, "Lat")) * (sub.x - localTowers.getFloat(7, "Lat")) +  ((sub.y  - localTowers.getFloat(7, "Lon")) * (sub.y  - localTowers.getFloat(7, "Lon"))))
////                  &&
////                  ((sub.x  - localTowers.getFloat(0, "Lat") * (sub.x  - localTowers.getFloat(0, "Lat"))) +  ((sub.y  - localTowers.getFloat(0, "Lon")) * (sub.y  - localTowers.getFloat(0, "Lon")))) 
////                    <= ((sub.x  - localTowers.getFloat(1, "Lat")) * (sub.x - localTowers.getFloat(1, "Lat")) +  ((sub.y  - localTowers.getFloat(1, "Lon")) * (sub.y  - localTowers.getFloat(1, "Lon"))))
////                  &&
////                  ((sub.x  - localTowers.getFloat(0, "Lat") * (sub.x  - localTowers.getFloat(0, "Lat"))) +  ((sub.y  - localTowers.getFloat(0, "Lon")) * (sub.y  - localTowers.getFloat(0, "Lon")))) 
////                    <= ((sub.x  - localTowers.getFloat(8, "Lat")) * (sub.x - localTowers.getFloat(8, "Lat")) +  ((sub.y  - localTowers.getFloat(8, "Lon")) * (sub.y  - localTowers.getFloat(8, "Lon"))))
////                  &&
////                  ((sub.x  - localTowers.getFloat(0, "Lat") * (sub.x  - localTowers.getFloat(0, "Lat"))) +  ((sub.y  - localTowers.getFloat(0, "Lon")) * (sub.y  - localTowers.getFloat(0, "Lon")))) 
////                    <= ((sub.x  - localTowers.getFloat(9, "Lat")) * (sub.x - localTowers.getFloat(9, "Lat")) +  ((sub.y  - localTowers.getFloat(9, "Lon")) * (sub.y  - localTowers.getFloat(9, "Lon"))))
////                  &&
////                  ((sub.x  - localTowers.getFloat(0, "Lat") * (sub.x  - localTowers.getFloat(0, "Lat"))) +  ((sub.y  - localTowers.getFloat(0, "Lon")) * (sub.y  - localTowers.getFloat(0, "Lon")))) 
////                    <= ((sub.x  - localTowers.getFloat(10, "Lat")) * (sub.x - localTowers.getFloat(10, "Lat")) +  ((sub.y  - localTowers.getFloat(10, "Lon")) * (sub.y  - localTowers.getFloat(10, "Lon"))))
////                  &&
////                  ((sub.x  - localTowers.getFloat(0, "Lat") * (sub.x  - localTowers.getFloat(0, "Lat"))) +  ((sub.y  - localTowers.getFloat(0, "Lon")) * (sub.y  - localTowers.getFloat(0, "Lon")))) 
////                    <=((sub.x  - localTowers.getFloat(11, "Lat")) * (sub.x - localTowers.getFloat(11, "Lat")) +  ((sub.y  - localTowers.getFloat(11, "Lon")) * (sub.y  - localTowers.getFloat(11, "Lon"))))
////                  &&
////                  ((sub.x  - localTowers.getFloat(0, "Lat") * (sub.x  - localTowers.getFloat(0, "Lat"))) +  ((sub.y  - localTowers.getFloat(0, "Lon")) * (sub.y  - localTowers.getFloat(0, "Lon")))) 
////                    <= ((sub.x  - localTowers.getFloat(12, "Lat")) * (sub.x - localTowers.getFloat(12, "Lat")) +  ((sub.y  - localTowers.getFloat(12, "Lon")) * (sub.y  - localTowers.getFloat(12, "Lon"))))
////                  &&
////                  ((sub.x  - localTowers.getFloat(0, "Lat") * (sub.x  - localTowers.getFloat(0, "Lat"))) +  ((sub.y  - localTowers.getFloat(0, "Lon")) * (sub.y  - localTowers.getFloat(0, "Lon")))) 
////                    <=((sub.x  - localTowers.getFloat(13, "Lat")) * (sub.x - localTowers.getFloat(13, "Lat")) +  ((sub.y  - localTowers.getFloat(13, "Lon")) * (sub.y  - localTowers.getFloat(13, "Lon"))))
////                    )         
////                    { 
////                      origin[i] = new PVector(sub.x, sub.y);
////                    }  
////                else{
////                 origin[i] = mercatorMap.getScreenLocation(new PVector(network.getFloat(i, "LAT_O"), network.getFloat(i, "LON_O")));
////                }
////}
//    
//  }
////  
//  
//    // If edge crosses table area
//    else {
//      origin[i] = container_Locations[network.getInt(i, "CON_O")];
//      destination[i] = container_Locations[network.getInt(i, "CON_D")];
//      external = true;
//    }
//  
