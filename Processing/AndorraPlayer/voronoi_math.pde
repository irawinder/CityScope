
//            origin_coord[i] = mercatorMap.getScreenLocation(new PVector(marc_rest.getFloat(w, "LAT"), marc_rest.getFloat(w, "LNG")));
//            destination_coord[i] = mercatorMap.getScreenLocation(new PVector(marc_rest.getFloat(w, "LAT"), marc_rest.getFloat(w, "LNG")));
//            
//            origin_coord[i] = new PVector(origin_coord[i].x + marginWidthPix, origin_coord[i].y + marginWidthPix);
//            destination_coord[i] = new PVector(destination_coord[i].x + marginWidthPix, destination_coord[i].y + marginWidthPix);
//
////----------compare between the origins and destinations with voronoi math          
//                  float first_dist_o = sqrt(pow(origin_coord[i].x-origin[i].x, 2) - pow(origin_coord[i].y-origin[i].y, 2));
//                  float second_dist_o = sqrt(pow(origin_coord[i].x-origin[i-1].x, 2) - pow(origin_coord[i].y-origin[i-1].y, 2));
//
//                  float first_dist_d = sqrt(pow(destination_coord[i].x-destination[i].x, 2) - pow(destination_coord[i].y-destination[i].y, 2));
//                  float second_dist_d = sqrt(pow(destination_coord[i].x-destination[i-1].x, 2) - pow(destination_coord[i].y-destination[i-1].y, 2));
//                
//                 if(first_dist_o < second_dist_o){
//                     origin[i] = origin_coord[i];
//                     println("voronoi origin");
//                           }
//
//                  if(first_dist_d < second_dist_d){
//                     destination[i] = destination_coord[i];
//                     println("voronoi destination");
//                           }
//                 
//                 
//                 else {
//                   if (network.getString(i, "NATION").equals("sp")) {
//                         if(marc_rest.getString(w, "LANGUAGES").equals("CA,ES,EN,RU") || marc_rest.getString(w, "LANGUAGES").equals("CA") 
//                          || marc_rest.getString(w, "LANGUAGES").equals("CA,ES,EN,PT") ||marc_rest.getString(w, "LANGUAGES").equals("CA,ES"))
//                          {
//                              destination_coord[i] = mercatorMap.getScreenLocation(new PVector(marc_rest.getFloat(w, "LAT"), marc_rest.getFloat(w, "LNG")));
//                              destination[i] = new PVector(destination_coord[i].x + marginWidthPix, destination_coord[i].y + marginWidthPix);
//                              println("disapears right place spanish", w, i);
//    
//                          }
//                              }
//                              
//                     if (network.getString(i, "NATION").equals("sp")) {
//                         if(marc_rest.getString(w, "LANGUAGES").equals("CA,ES,EN,RU") || marc_rest.getString(w, "LANGUAGES").equals("CA") 
//                          || marc_rest.getString(w, "LANGUAGES").equals("CA,ES,EN,PT") ||marc_rest.getString(w, "LANGUAGES").equals("CA,ES"))
//                          {
//                              origin_coord[i] = mercatorMap.getScreenLocation(new PVector(marc_rest.getFloat(w, "LAT"), marc_rest.getFloat(w, "LNG")));
//                              origin[i] = new PVector(origin_coord[i].x + marginWidthPix, origin_coord[i].y + marginWidthPix);
//                              println("appears right place spanish", w, i);
//    
//                          }
//                              }          
//                    if (network.getString(i, "NATION").equals("fr")) {
//                         if(marc_rest.getString(w, "LANGUAGES").equals("CA,ES,FR,EN") || marc_rest.getString(w, "LANGUAGES").equals("CA,ES,FR,EN,RU") 
//                          || marc_rest.getString(w, "LANGUAGES").equals("CA,ES,FR,PT"))
//                          {
//                              destination_coord[i] = mercatorMap.getScreenLocation(new PVector(marc_rest.getFloat(w, "LAT"), marc_rest.getFloat(w, "LNG")));
//                              destination[i] = new PVector(destination_coord[i].x + marginWidthPix, destination_coord[i].y + marginWidthPix);
//                              println("disapears right place french", w, i);
//    
//                          }
//                              }         
//                              
//                 }
//                 
//                      if (w == marc_rest.getRowCount()-1){
//                        w = 1;
//                        }
//                       w++;

//            for(int j=0; j<marc_rest.getRowCount(); j++){
//            origin_coord[j] = mercatorMap.getScreenLocation(new PVector(marc_rest.getFloat(j, "LAT"), marc_rest.getFloat(j, "LNG")));
//            destination_coord[j] = mercatorMap.getScreenLocation(new PVector(marc_rest.getFloat(j, "LAT"), marc_rest.getFloat(j, "LNG")));
//            
//            origin_coord[j] = new PVector(origin_coord[j].x + marginWidthPix, origin_coord[j].y + marginWidthPix);
//            destination_coord[j] = new PVector(destination_coord[j].x + marginWidthPix, destination_coord[j].y + marginWidthPix);
//            
//             minDistanceOrigin = pow((origin_coord[j].x - origin[1].x), 2)  +  pow((origin_coord[j].y - origin[1].y), 2);
//             minDistanceDestination = pow((destination_coord[j].x - destination[1].x), 2)  +  pow((destination_coord[j].y - destination[1].y), 2);
//             minIndexOrigin = 1;
//             minIndexDestination = 1;
//             
//             for(int i=2; i<numSwarm; i++){
//              if (network.getInt(i, "CON_O") == 0 && network.getInt(i, "CON_D") == 0) {  
//              float dist_o = pow((origin_coord[j].x - origin[i].x), 2)  +  pow((origin_coord[j].y - origin[i].y), 2);
//              float dist_d = pow((destination_coord[j].x - destination[i].x), 2)  +  pow((destination_coord[j].y - destination[i].y), 2);
//                              
//                             if (dist_o <= minDistanceOrigin)
//                             {
//                                 minDistanceOrigin = dist_o;
//                                 minIndexOrigin = i;
//                                 println("possible origin...", i, j);
//                            }
//                            
//                            if (dist_d <= minDistanceDestination)
//                             {
//                                 minDistanceDestination = dist_d;
//                                 minIndexDestination = i;
//                                 println("possible destination...", i, j);
//                            }
//                           
//                  } 
//                 }
//                 origin[minIndexOrigin] = origin_coord[j];
//                 destination[minIndexDestination] = destination_coord[j];
//               }
