//void CDRNetwork() {
//
//  int numSwarm;
//  color col;
//
//  numSwarm = network.getRowCount();
//
//
//
//  origin = new PVector[numSwarm];
//  int[] origin_zone = new int[numSwarm];
//  int[] destination_zone = new int[numSwarm];
//  tower_coord = new PVector[numSwarm];
//  val = new PVector[numSwarm];
//  rest_coord = new PVector[numSwarm];
//  destination = new PVector[numSwarm];
//  hotel_coord = new PVector[numSwarm];
//  attraction_coord = new PVector[numSwarm];
//  weight = new float[numSwarm];
//  swarmHorde.clearHorde();
//  dist_origins = new PVector[numSwarm];
//
//  int w = 1;
//  boolean external = false;
//
//  PVector v_tower1 = new PVector(1112, 217, 0);
//  PVector v_tower2 = new PVector(793, 232, 0);
//  PVector v_tower3 = new PVector(470, 92, 0);
//  PVector v_tower4 = new PVector(963, 342, 0);
//  PVector v_tower5 = new PVector(377, 123, 0);
//  PVector v_tower6 = new PVector(601, 517, 0);
//  PVector v_tower7 = new PVector(544, 319, 0);
//  PVector v_tower8 = new PVector(806, 41, 0);
//  PVector v_tower9 = new PVector(259, 112, 0);
//  PVector v_tower10 = new PVector(515, 68, 0);
//  PVector v_tower11 = new PVector(520, 10, 0);
//  PVector v_tower12 = new PVector(1400, 518, 0);
//
//  ArrayList<PVector> tower_1 = new ArrayList<PVector>();
//  ArrayList<PVector> tower_2 = new ArrayList<PVector>();
//  ArrayList<PVector> tower_3 = new ArrayList<PVector>();
//  ArrayList<PVector> tower_4 = new ArrayList<PVector>();
//  ArrayList<PVector> tower_5 = new ArrayList<PVector>();
//  ArrayList<PVector> tower_6 = new ArrayList<PVector>();
//  ArrayList<PVector> tower_7 = new ArrayList<PVector>();
//  ArrayList<PVector> tower_8 = new ArrayList<PVector>();
//  ArrayList<PVector> tower_9 = new ArrayList<PVector>();
//  ArrayList<PVector> tower_10 = new ArrayList<PVector>();
//  ArrayList<PVector> tower_11 = new ArrayList<PVector>();
//  ArrayList<PVector> tower_12 = new ArrayList<PVector>();
//  ArrayList<PVector> umbrella = new ArrayList<PVector>();
//  ArrayList<PVector> french_speaking_amenities = new ArrayList<PVector>();
//  ArrayList<PVector> spanish_speaking_amenities = new ArrayList<PVector>();
//  ArrayList<PVector> tower_values = new ArrayList<PVector>();
//  
//for (int i=0; i<localTowers.getRowCount(); i++) { // iterates through each row      
//    val[i] = mercatorMap.getScreenLocation(new PVector(localTowers.getFloat(i, "Lat"), localTowers.getFloat(i, "Lon")));
//    tower_values.add(val[i]);
//  }  
//
//for (int i=0; i<numSwarm; i++) {
/////////////////////////////////////////////////////////////////////////////////////////voronoi for hotels
//                          for (int z=0; z<tripAdvisor.getRowCount (); z++) {
//                            hotel_coord[z] = mercatorMap.getScreenLocation(new PVector(tripAdvisor.getFloat(z, "Lat"), tripAdvisor.getFloat(z, "Long")));
//                            hotel_coord[z] = new PVector(hotel_coord[z].x + marginWidthPix, hotel_coord[z].y + marginWidthPix);
//            
//                              PVector minDistanceHotel =  PVector.sub(v_tower1, hotel_coord[z]);
//                              int towerIndex = 0;
//                      
//                              for (int d=0; d<values.getRowCount (); d++) {
//                                tower_coord[d] = new PVector(values.getFloat(d, "x"), values.getFloat(d, "y"));
//                      
//                                PVector dist = PVector.sub(tower_coord[d], hotel_coord[z]);
//                      
//                                if (abs(dist.mag()) <= abs(minDistanceHotel.mag()))
//                                {
//                                  minDistanceHotel = dist;
//                                  towerIndex = d;
//                                }
//                              }
//                                  
//                              if(hotel_coord[z].y > 130){
//                                      if (towerIndex == 0) {
//                                        tower_1.add(hotel_coord[z]);
//                                      }
//                                      if (towerIndex  == 1) {
//                                        tower_2.add(hotel_coord[z]);
//                                      }
//                                      if (towerIndex  == 2) {
//                                        tower_3.add(hotel_coord[z]);
//                                      }
//                                      if (towerIndex  == 3) {
//                                        tower_4.add(hotel_coord[z]);
//                                      }
//                                      if (towerIndex  == 4) {
//                                        tower_5.add(hotel_coord[z]);
//                                      }
//                                      if (towerIndex == 5) {
//                                        tower_6.add(hotel_coord[z]);
//                                      }
//                                      if (towerIndex == 6) {
//                                        tower_7.add(hotel_coord[z]);
//                                      }
//                                      if (towerIndex == 7) {
//                                        tower_8.add(hotel_coord[z]);
//                                      }                     
//                                      if (towerIndex  == 8) {
//                                        tower_9.add(hotel_coord[z]);
//                                      }
//                                      if (towerIndex == 9) {
//                                        tower_10.add(hotel_coord[z]);
//                                      }
//                                      if (towerIndex == 10) {
//                                        tower_11.add(hotel_coord[z]);
//                                      }
//                                       if (towerIndex == 11) {
//                                        tower_12.add(hotel_coord[z]);
//                                      }
//                                      if (towerIndex == 10 || towerIndex == 9) {
//                                        umbrella.add(hotel_coord[z]);
//                                      }
//                                      
//                            }                           
//                          }
//////////////////////////////////////////////////////////////voronoi for attracitons
//                      for (int c=0; c<amenities.getRowCount (); c++) {
//                        attraction_coord[c] = mercatorMap.getScreenLocation(new PVector(amenities.getFloat(c, "Lat"), amenities.getFloat(c, "Long")));
//                        attraction_coord[c] = new PVector(attraction_coord[c].x + marginWidthPix, attraction_coord[c].y + marginWidthPix);
//                          PVector minDistanceAttractions =  PVector.sub(v_tower1, attraction_coord[c]);
//                          int towerIndex = 0;
//                  
//                          for (int d=0; d<values.getRowCount (); d++) {
//                                    tower_coord[d] = new PVector(values.getFloat(d, "x"), values.getFloat(d, "y"));
//                          
//                          
//                                    PVector dist = PVector.sub(tower_coord[d], attraction_coord[c]);
//                          
//                                    if (abs(dist.mag()) <= abs(minDistanceAttractions.mag()))
//                                    {
//                                      minDistanceAttractions = dist;
//                                      towerIndex = d;
//                                    }
//                                  }
//                                        if (attraction_coord[c].y > 130) {
//                                        if (towerIndex == 0) {
//                                          tower_1.add(attraction_coord[c]);
//                                        }
//                                        if (towerIndex  == 1) {
//                                          tower_2.add(attraction_coord[c]);
//                                        }
//                                        if (towerIndex  == 2) {
//                                          tower_3.add(attraction_coord[c]);
//                                        }
//                                        if (towerIndex  == 3) {
//                                          tower_4.add(attraction_coord[c]);
//                                        }
//                                        if (towerIndex  == 4) {
//                                          tower_5.add(attraction_coord[c]);
//                                        }
//                                        if (towerIndex == 5) {
//                                          tower_6.add(attraction_coord[c]);
//                                        }
//                                        if (towerIndex == 6) {
//                                          tower_7.add(attraction_coord[c]);
//                                        }
//                                        if (towerIndex == 7) {
//                                          tower_8.add(attraction_coord[c]);
//                                        }                     
//                                        if (towerIndex  == 8) {
//                                          tower_9.add(attraction_coord[c]);
//                                        }
//                                        if (towerIndex == 9) {
//                                          tower_10.add(attraction_coord[c]);
//                                        }
//                                        if (towerIndex == 10) {
//                                          tower_11.add(attraction_coord[c]);
//                                        }
//                                        if (towerIndex == 11) {
//                                          tower_12.add(attraction_coord[c]);
//                                        }
//                                        if (towerIndex == 10 || towerIndex == 9) {
//                                          umbrella.add(attraction_coord[c]);
//                                        } 
//                                      }
//                      }
//                      
////////REST////////////////////////////////////////////////voronoi Restaurants                                       
//                   for(int j = 0; j<marc_rest.getRowCount(); j++){
//                           rest_coord[j] = mercatorMap.getScreenLocation(new PVector(marc_rest.getFloat(j, "LAT"), marc_rest.getFloat(j, "LNG")));           
//                           rest_coord[j] = new PVector(rest_coord[j].x + marginWidthPix, rest_coord[j].y + marginWidthPix);
//                           PVector minDistanceRest =  PVector.sub(v_tower1, rest_coord[j]);
//            
//                          int towerIndex = 0;
//                  
//                          for (int d=0; d<values.getRowCount (); d++) {
//                            tower_coord[d] = new PVector(values.getFloat(d, "x"), values.getFloat(d, "y"));
//                  
//                  
//                            PVector dist = PVector.sub(tower_coord[d], rest_coord[j]);
//                  
//                            if (abs(dist.mag()) <= abs(minDistanceRest.mag()))
//                            {
//                              minDistanceRest = dist;
//                              towerIndex = d;
//                            }
//                          }
//                                      if(rest_coord[j].y>130){
//                                      if (towerIndex == 0) {
//                                        tower_1.add(rest_coord[j]);
//                                        tower_12.add(rest_coord[j]);
//                                      }
//                                      if (towerIndex  == 1) {
//                                        tower_2.add(rest_coord[j]);
//                                      }
//                                      if (towerIndex  == 2) {
//                                        tower_3.add(rest_coord[j]);
//                                      }
//                                      if (towerIndex  == 3) {
//                                        tower_4.add(rest_coord[j]);
//                                      }
//                                      if (towerIndex  == 4) {
//                                        tower_5.add(rest_coord[j]);
//                                      }
//                                      if (towerIndex == 5) {
//                                        tower_6.add(rest_coord[j]);
//                                      }
//                                      if (towerIndex == 6) {
//                                        tower_7.add(rest_coord[j]);
//                                      }
//                                      if (towerIndex == 7) {
//                                        tower_8.add(rest_coord[j]);
//                                      }                     
//                                      if (towerIndex  == 8) {
//                                        tower_9.add(rest_coord[j]);
//                                      }
//                                      if (towerIndex == 9) {
//                                        tower_10.add(rest_coord[j]);
//                                      }
//                                      if (towerIndex == 10) {
//                                        tower_11.add(rest_coord[j]);
//                                      }
//                              
//                                      if (towerIndex == 11) {
//                                        tower_12.add(rest_coord[j]);
//                                      }
//                              
//                                      if (towerIndex == 10 || towerIndex == 9) {
//                                          umbrella.add(rest_coord[j]);
//                                        }
//                                      }
//////////////////////////////out of reach special children; tower 6 and tower 8                                                        
//                 PVector v34 = PVector.sub(v_tower6, rest_coord[j]);
//                    float r = v34.mag();
//                    if (abs(r) <= 400 && rest_coord[j].y > 400) {
//                      tower_6.add(rest_coord[j]);
//                    }      
//            
//                    PVector v40 = PVector.sub(v_tower8, rest_coord[j]);
//                    float b = v40.mag();
//                    if (abs(r) <= 300 && rest_coord[j].y > 130 && rest_coord[j].x > 720 ) {
//                      tower_8.add(rest_coord[j]);
//                    }             
//           } 
//       
////////////////////////////////////////////////////////ACTUAL STUFFS                
//  if (network.getInt(i, "CON_O") == 0 && network.getInt(i, "CON_D") == 0) {  
//                destination[i] = mercatorMap.getScreenLocation(new PVector(network.getFloat(i, "LAT_D"), network.getFloat(i, "LON_D")));
//                origin[i] = mercatorMap.getScreenLocation(new PVector(network.getFloat(i, "LAT_O"), network.getFloat(i, "LON_O"))); 
//                              PVector dist_dest_1 = PVector.sub(v_tower1, destination[i]); PVector dist_origin_1 = PVector.sub(v_tower1, origin[i]);
//                              PVector dist_origin_2 = PVector.sub(v_tower2, origin[i]); PVector dist_dest_2 = PVector.sub(v_tower2, destination[i]);
//                              PVector dist_origin_3 = PVector.sub(v_tower3, origin[i]); PVector dist_dest_3 = PVector.sub(v_tower3, destination[i]);
//                              PVector dist_origin_4 = PVector.sub(v_tower4, origin[i]); PVector dist_dest_4 = PVector.sub(v_tower4, destination[i]); 
//                              PVector dist_origin_5 = PVector.sub(v_tower5, origin[i]); PVector dist_dest_5 = PVector.sub(v_tower5, destination[i]);
//                              PVector dist_origin_6 = PVector.sub(v_tower6, origin[i]); PVector dist_dest_6 = PVector.sub(v_tower6, destination[i]);
//                              PVector dist_origin_7 = PVector.sub(v_tower7, origin[i]); PVector dist_dest_7 = PVector.sub(v_tower7, destination[i]);
//                              PVector dist_origin_8 = PVector.sub(v_tower8, origin[i]); PVector dist_dest_8 = PVector.sub(v_tower8, destination[i]);
//                              PVector dist_origin_9 = PVector.sub(v_tower9, origin[i]); PVector dist_dest_9 = PVector.sub(v_tower9, destination[i]);
//                              PVector dist_origin_10 = PVector.sub(v_tower10, origin[i]); PVector dist_dest_10 = PVector.sub(v_tower10, destination[i]);
//                              PVector dist_origin_11 = PVector.sub(v_tower11, origin[i]); PVector dist_dest_11 = PVector.sub(v_tower11, destination[i]);
//                              PVector dist_origin_12 = PVector.sub(v_tower12, origin[i]); PVector dist_dest_12 = PVector.sub(v_tower12, destination[i]);
//      //assigning the towers
//              if (dist_origin_1.mag() <= 5) {
//                if (tower_1.size() >= 1) {
//                  int h = int(random(0, tower_1.size()));
//                  origin[i] = tower_1.get(h);
//                  origin_zone[i] = 1;
//                      }
//                    }
//
//                  if (dist_dest_1.mag() <= 5) {
//                    if (tower_1.size() >= 1) {
//                      int h = int(random(0, tower_1.size()));
//                      destination[i] = tower_1.get(h);
//                      destination_zone[i] = 1;
//                    }
//                  }
//          
//                  if (dist_origin_2.mag() <= 5) {
//                    if (tower_2.size() >= 1) {
//                      int h = int(random(0, tower_2.size()));
//                      origin[i] = tower_2.get(h);
//                      origin_zone[i] = 2;
//                    }
//                  }
//          
//                  if (dist_dest_2.mag() <= 5) {
//                    if (tower_2.size() >= 1) {
//                      int h = int(random(0, tower_2.size()));
//                      destination[i] = tower_2.get(h);
//                      destination_zone[i] = 2;
//                    }
//                  }
//          
//                  if (dist_origin_3.mag() <= 5) {
//                      int h = int(random(0, tower_3.size()));
//                      origin[i] = tower_3.get(h);
//                      origin_zone[i] = 3;
//                  }
//          
//                  if (dist_dest_3.mag() <= 5) {
//                      int h = int(random(0, tower_3.size()));
//                      destination[i] = tower_3.get(h);
//                      destination_zone[i] = 3;
//                  }                        
//          
//                  if (dist_origin_4.mag() <= 5) {
//                    if (tower_4.size() >= 1) {
//                      int h = int(random(0, tower_4.size()));
//                      if (dates[dateIndex] == "cirq" && !(network.getString(i, "NATION").equals("sp"))) {
//                       origin[i] = tower_4.get(h);
//                       origin_zone[i] = 4;
//                        }
//                       if(dates[dateIndex] != "cirq"){
//                       origin[i] = tower_4.get(h);
//                       origin_zone[i] = 4;
//                       }
//                    }
//                  }
//          
//                  if (dist_dest_4.mag()<= 5) {
//                    if (tower_4.size() >= 1) {
//                      int h = int(random(0, tower_4.size()));
//                        if ((network.getString(i, "NATION").equals("fr"))) {
//                       destination[i] = tower_4.get(h);
//                       destination_zone[i] = 4;
//                        }
//                    }
//                  }
//          
//          
//                  if (dist_origin_5.mag()<= 5) {
//                    if (tower_5.size() >= 1) {
//                      int h = int(random(0, tower_5.size()));
//                      origin[i] = tower_5.get(h);
//                      origin_zone[i] = 5;
//                    }
//                  }
//          
//                  if (dist_dest_5.mag()<= 5) {
//                    if (tower_5.size() >= 1) {
//                      int h = int(random(0, tower_5.size()));
//                      destination[i] =  tower_5.get(h);
//                      destination_zone[i] = 5;
//                    }
//                  }
//          
//                  if (dist_origin_6.mag() <= 5) {
//                    if (tower_6.size() >= 1) {
//                      int h = int(random(0, tower_6.size()));
//                      origin[i] = tower_6.get(h);
//                      origin_zone[i] = 6;
//                    }
//                  }
//          
//                  if (dist_dest_6.mag()<= 5) {
//                    if (tower_6.size() >= 1) {
//                      int h = int(random(0, tower_6.size()));
//                      destination[i] = tower_6.get(h);
//                      destination_zone[i] = 6;
//                    }
//                  }
//          
//                  if (dist_origin_7.mag() <= 50) {
//                      int h = int(random(0, tower_7.size()));
//                      origin[i] = tower_7.get(h);
//                      origin_zone[i] = 7;
//                  }
//          
//                  if (dist_dest_7.mag() <= 50) {
//                      int h = int(random(0, tower_7.size()));
//                      destination[i] =  tower_7.get(h);
//                      destination_zone[i] = 7;
//                  }
//          
//                  if (dist_origin_8.mag() <= 5) {
//                    if (tower_8.size() >= 1) {
//                      int h = int(random(0, tower_8.size()));
//                      origin[i] = tower_8.get(h);
//                      origin_zone[i] = 8;
//                    }
//                  }
//          
//                  if (dist_dest_8.mag() <= 5) {
//                    if (tower_8.size() >= 1) {
//                      int h = int(random(0, tower_8.size()));
//                      destination[i] = tower_8.get(h);
//                      destination_zone[i] = 8;
//                    }
//                  }
//          
//                  if (dist_origin_9.mag() <= 5) {
//                    if (tower_9.size() >= 1) {
//                      int h = int(random(0, tower_9.size()));
//                      origin[i] = tower_9.get(h);
//                      origin_zone[i] = 9;
//                    }
//                  }
//          
//                  if (dist_dest_9.mag() <= 5) {
//                    if (tower_9.size() >= 1) {
//                      int h = int(random(0, tower_9.size()));
//                      destination[i] = tower_9.get(h);
//                      destination_zone[i] = 9;
//                    }
//                  }
//          
//            
//                  if (dist_origin_10.mag() <= 5) {
//                    if (tower_10.size() >= 1) {
//                      int h = int(random(0, umbrella.size()));
//                      origin[i] = umbrella.get(h);
//                      origin_zone[i] = 10;
//                    }
//                  }
//          
//                  if (dist_dest_10.mag() <= 5) {
//                    if (tower_10.size() >= 1) {
//                      int h = int(random(0, umbrella.size()));
//                      destination[i] = umbrella.get(h);
//                      destination_zone[i] = 10;
//                    }
//                  }
//          
//                  if (dist_origin_11.mag()  <= 5) {
//                    if (umbrella.size() >= 1) {
//                      int h = int(random(0, umbrella.size()));
//                      origin[i] = umbrella.get(h);
//                      origin_zone[i] = 11;
//                    }
//                  }
//          
//                  if (dist_dest_11.mag() <= 5) {
//                    if (umbrella.size() >= 1) {
//                      int h = int(random(0, umbrella.size()));
//                      destination[i] = umbrella.get(h);
//                      destination_zone[i] = 11;
//                    }
//                  }       
//          
//                  if (dist_origin_12.mag()  <= 50) {
//                      int h = int(random(0, tower_12.size()));
//                      origin[i] = tower_12.get(h);
//                      origin_zone[i] = 12;
//                  }
//          
//                  if (dist_dest_12.mag() <= 50) {
//                      int h = int(random(0, tower_12.size()));
//                      destination[i] = tower_12.get(h);
//                      destination_zone[i] = 12;
//                  }
//         ///////LANGUAGE HEURISTICS 
//         for(int j = 0; j<marc_rest.getRowCount(); j++){
//                                if (network.getString(i, "NATION").equals("sp")) {
//                                if(marc_rest.getString(j, "LANGUAGES").equals("CA,ES,EN,RU") || marc_rest.getString(j, "LANGUAGES").equals("CA") 
//                                || marc_rest.getString(j, "LANGUAGES").equals("CA,ES,EN,PT") ||marc_rest.getString(j, "LANGUAGES").equals("CA,ES") || marc_rest.getString(j, "LANGUAGES").equals("CA, ES, FR, EN, PT"))
//                                {
//                                  rest_coord[i] = mercatorMap.getScreenLocation(new PVector(marc_rest.getFloat(j, "LAT"), marc_rest.getFloat(j, "LNG")));
//                                  rest_coord[i] = new PVector(rest_coord[i].x + marginWidthPix, rest_coord[i].y + marginWidthPix);
//                                  if(rest_coord[i].y > 140){
//                                  spanish_speaking_amenities.add(rest_coord[i]);
//                                  int c = int(random(0, spanish_speaking_amenities.size()));
//                                  PVector doop = PVector.sub(origin[i], spanish_speaking_amenities.get(c));
//                                  PVector derp = PVector.sub(origin[i], destination[i]);
//                                  PVector moop = PVector.sub(destination[i], spanish_speaking_amenities.get(c));
//                                      if(abs(doop.mag())<= abs(derp.mag())){
//                                      destination[i] = spanish_speaking_amenities.get(c);
//                                        } 
//                                    }
//                                  }
//                                  }
//                      
//                              if (network.getString(i, "NATION").equals("fr")) {
//                                if (marc_rest.getString(j, "LANGUAGES").equals("CA,ES,FR,EN") || marc_rest.getString(j, "LANGUAGES").equals("CA,ES,FR,EN,RU") 
//                                  || marc_rest.getString(j, "LANGUAGES").equals("CA,ES,FR,PT"))
//                                {
//                                  rest_coord[i] = mercatorMap.getScreenLocation(new PVector(marc_rest.getFloat(j, "LAT"), marc_rest.getFloat(j, "LNG")));
//                                  rest_coord[i] = new PVector(rest_coord[i].x + marginWidthPix, rest_coord[i].y + marginWidthPix);
//                                  if(rest_coord[i].y > 140){
//                                  french_speaking_amenities.add(rest_coord[i]);
//                                  int c = int(random(0, french_speaking_amenities.size()));
//                                  PVector doop = PVector.sub(origin[i], french_speaking_amenities.get(c));
//                                  PVector derp = PVector.sub(origin[i], destination[i]);
//                                      if(doop.mag()<= derp.mag()){
//                                      destination[i] = french_speaking_amenities.get(c);
//                                        }
//                                    }
//                                  }
//                                }
//         }
//    }
//  } //end of the huge for loop to create the Container 0 OD matrix 
//
//
//  for (int i=0; i<numSwarm; i++) {
//    if (network.getInt(i, "CON_O") != 0 || network.getInt(i, "CON_D") != 0) {
//      origin[i] = container_Locations[network.getInt(i, "CON_O")];
//      destination[i] = container_Locations[network.getInt(i, "CON_D")];
//      external = true;
//    }
//
//
//
//    if (network.getString(i, "NATION").equals("sp")) {
//      col = spanish;
//      weight[i] = 10;
//    } else if (network.getString(i, "NATION").equals("fr")) {
//      col = french;
//      weight[i] = 10;
//    } else {
//      col = other;
//      weight[i] = 10;
//    }
//
//
//    // delay, origin, destination, speed, color
//    swarmHorde.addSwarm(weight[i], origin[i], destination[i], 1, col, origin_zone[i], destination_zone[i]);
//    // swarmHorde.addSwarm(weight[i], origin[i], destination[i], 1, col, origin_zone, destination_zone);
//    
//    // Makes sure that agents 'staying put' eventually die
//    // also that they don't blead into the margin or topo
//    swarmHorde.getSwarm(i).temperStandingAgents(external);
//  }
//
//  //Sets maximum range for hourly data
//  maxHour = 0;
//  for (int i=0; i<OD.getRowCount (); i++) {
//    if (OD.getInt(i, "HOUR") > maxHour) {
//      maxHour = OD.getInt(i, "HOUR");
//    }
//  }
//
//  for (int i=0; i<maxHour+1; i++) {
//    summary.addRow();
//    summary.setInt(i, "HOUR", i);
//    summary.setInt(i, "TOTAL", 0);
//    summary.setInt(i, "SPANISH", 0);
//    summary.setInt(i, "FRENCH", 0);
//    summary.setInt(i, "OTHER", 0);
//  }
//
//  for (int i=0; i<OD.getRowCount (); i++) {
//    String country = network.getString(OD.getInt(i, "EDGE_ID"), "NATION");
//    if ( country.equals("sp") ) {
//      summary.setInt(OD.getInt(i, "HOUR"), "SPANISH", summary.getInt(OD.getInt(i, "HOUR"), "SPANISH") + OD.getInt(i, "AMOUNT"));
//    } else if ( country.equals("fr") ) {
//      summary.setInt(OD.getInt(i, "HOUR"), "FRENCH", summary.getInt(OD.getInt(i, "HOUR"), "FRENCH") + OD.getInt(i, "AMOUNT"));
//    } else if ( country.equals("other") ) {
//      summary.setInt(OD.getInt(i, "HOUR"), "OTHER", summary.getInt(OD.getInt(i, "HOUR"), "OTHER") + OD.getInt(i, "AMOUNT"));
//    }
//    summary.setInt(OD.getInt(i, "HOUR"), "TOTAL", summary.getInt(OD.getInt(i, "HOUR"), "TOTAL") + OD.getInt(i, "AMOUNT"));
//  }
//
//  for (int i=0; i<summary.getRowCount (); i++) {
//    if ( summary.getInt(i, "TOTAL") > maxFlow ) {
//      maxFlow = summary.getInt(i, "TOTAL");
//    }
//  }
//
//  // Sets to rates at specific hour ...
//  setSwarmFlow(hourIndex);
//}
