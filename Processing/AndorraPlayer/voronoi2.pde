//voronoi by Nina Lutz 

PVector[] rest_coord, amen_coord, destination_travel, origin_travel;

void Voronoi() {
  int numSwarm;
  boolean external = false;
  color col;
  numSwarm = network.getRowCount();
  origin = new PVector[numSwarm];
  destination = new PVector[numSwarm];
  int[] origin_zone = new int[numSwarm];
  int[] destination_zone = new int[numSwarm];
  
  val = new PVector[numSwarm];
  rest_coord = new PVector[numSwarm];
  amen_coord = new PVector[numSwarm];
  weight = new float[numSwarm];
  swarmHorde.clearHorde();
  origin_travel = new PVector[numSwarm];
  destination_travel = new PVector[numSwarm];
  ArrayList<PVector> french_speaking_amenities = new ArrayList<PVector>();
  ArrayList<PVector> spanish_speaking_amenities = new ArrayList<PVector>();
  ArrayList<PVector> tower_values = new ArrayList<PVector>();

  ArrayList<PVector> tower_1 = new ArrayList<PVector>();
  ArrayList<PVector> tower_2 = new ArrayList<PVector>();
  ArrayList<PVector> tower_3 = new ArrayList<PVector>();
  ArrayList<PVector> tower_4 = new ArrayList<PVector>();
  ArrayList<PVector> tower_5 = new ArrayList<PVector>();
  ArrayList<PVector> tower_6 = new ArrayList<PVector>();
  ArrayList<PVector> tower_7 = new ArrayList<PVector>();
  ArrayList<PVector> tower_8 = new ArrayList<PVector>();
  ArrayList<PVector> tower_9 = new ArrayList<PVector>();
  ArrayList<PVector> tower_10 = new ArrayList<PVector>();
  ArrayList<PVector> tower_11 = new ArrayList<PVector>();
  ArrayList<PVector> tower_0 = new ArrayList<PVector>();
  ArrayList<ArrayList<PVector>> test = new ArrayList<ArrayList<PVector>>();
  
for (int i=0; i<localTowers.getRowCount(); i++) { // iterates through each row      
    val[i] = mercatorMap.getScreenLocation(new PVector(localTowers.getFloat(i, "Lat"), localTowers.getFloat(i, "Lon")));
    if(val[i].x >= 0 && val[i].y >= 0){
    tower_values.add(val[i]);
    }
  }


for (int i=0; i<numSwarm; i++) {
                          for(int t =0; t<yup.getRowCount(); t++){
                            amen_coord[t] = mercatorMap.getScreenLocation(new PVector(yup.getFloat(t, "Lat"), yup.getFloat(t, "Lon")));
                            amen_coord[t] = new PVector(amen_coord[t].x + marginWidthPix, amen_coord[t].y + marginWidthPix);
                            
                            PVector minDistance =  PVector.sub(tower_values.get(0), amen_coord[t]);
                              int towerIndex = 0;
                      
                              for (int d=0; d<tower_values.size(); d++) {
                             
                                PVector dist = PVector.sub(tower_values.get(d), amen_coord[t]);
                      
                                if (abs(dist.mag()) <= abs(minDistance.mag()))
                                {
                                  minDistance = dist;
                                  towerIndex = d;
                                }
                              }
                              
                              if(amen_coord[t].y > tower_values.get(4).y){
                                  if (towerIndex == 0) {
                                        tower_0.add(amen_coord[t]);
                                        tower_3.add(amen_coord[t]);
                                      }
                                  if (towerIndex == 1) {
                                        tower_1.add(amen_coord[t]);
                                        tower_9.add(amen_coord[t]);
                                        tower_5.add(amen_coord[t]);
                                      }    
                                   if (towerIndex == 2) {
                                        tower_2.add(amen_coord[t]);
                                      }
                                  if (towerIndex == 4) {
                                        tower_4.add(amen_coord[t]);
                                        tower_5.add(amen_coord[t]);
                                      }  
                                  if (towerIndex == 5) {
                                        tower_5.add(amen_coord[t]);
                                        tower_9.add(amen_coord[t]);
                                      }
                                  if (towerIndex == 6) {
                                        tower_6.add(amen_coord[t]);
                                        //tower_3.add(amen_coord[t]);
                                      }  
                                  if (towerIndex == 8) {
                                        tower_8.add(amen_coord[t]);
                                        tower_9.add(amen_coord[t]);
                                      }
                                  if (towerIndex == 9) {
                                        tower_9.add(amen_coord[t]);
                                      }      
                                 if (towerIndex == 10) {
                                        tower_10.add(amen_coord[t]);
                                        tower_7.add(amen_coord[t]);
                                      }  
                                 if (towerIndex == 11) {
                                        tower_11.add(amen_coord[t]);
                                      }                                         
                              }
                            
           } 
//       
//////////////////////////////////////////////////////ACTUAL STUFFS                
  if (network.getInt(i, "CON_O") == 0 && network.getInt(i, "CON_D") == 0) {  
                destination[i] = mercatorMap.getScreenLocation(new PVector(network.getFloat(i, "LAT_D"), network.getFloat(i, "LON_D")));
                origin[i] = mercatorMap.getScreenLocation(new PVector(network.getFloat(i, "LAT_O"), network.getFloat(i, "LON_O")));            
                 for(int p = 0; p<tower_values.size(); p++){
                 origin_travel[i] = PVector.sub(tower_values.get(p), origin[i]);
                 destination_travel[i] = PVector.sub(tower_values.get(p), destination[i]);
                 
                     if(p == 0){
                         if(origin_travel[i].mag() <= 5){
                           int h = int(random(0, tower_0.size()));
                           origin[i] = tower_0.get(h);
                           origin_zone[i] = 0;
                         }
                         if(destination_travel[i].mag() <= 5){
                           int h = int(random(0, tower_0.size()));
                           destination[i] = tower_0.get(h);
                           destination_zone[i] = 0;
                         }
                     }                 
                 
                     if(p == 1){
                         if(origin_travel[i].mag() <= 5){
                           int h = int(random(0, tower_1.size()));
                           origin[i] = tower_1.get(h);
                           origin_zone[i] = 1;
                         }
                         if(destination_travel[i].mag() <= 5){
                           int h = int(random(0, tower_1.size()));
                           destination[i] = tower_1.get(h);
                           destination_zone[i] = 1;
                         }
                     }
                    if(p == 2){
                         if(origin_travel[i].mag() <= 5){
                           int h = int(random(0, tower_2.size()));
                           origin[i] = tower_2.get(h);
                           origin_zone[i] = 2;
                         }
                         if(destination_travel[i].mag() <= 5){
                           int h = int(random(0, tower_2.size()));
                           destination[i] = tower_2.get(h);
                           destination_zone[i] = 2;
                         }
                     }
                   if(p == 3){
                         if(origin_travel[i].mag() <= 5){
                           int h = int(random(0, tower_3.size()));
                           origin[i] = tower_3.get(h);
                           origin_zone[i] = 3;
                         }
                         if(destination_travel[i].mag() <= 5){
                           int h = int(random(0, tower_3.size()));
                           destination[i] = tower_3.get(h);
                           destination_zone[i] = 3;
                         }
                     }
                   if(p == 4){
                         if(origin_travel[i].mag() <= 5){
                           int h = int(random(0, tower_4.size()));
                           origin[i] = tower_4.get(h);
                           origin_zone[i] = 4;
                         }
                         if(destination_travel[i].mag() <= 5){
                           int h = int(random(0, tower_4.size()));
                           destination[i] = tower_4.get(h);
                           destination_zone[i] = 4;
                         }
                     } 
                  if(p == 5){
                         if(origin_travel[i].mag() <= 5){
                           int h = int(random(0, tower_5.size()));
                           origin[i] = tower_5.get(h);
                           origin_zone[i] = 5;
                         }
                         if(destination_travel[i].mag() <= 5){
                           int h = int(random(0, tower_5.size()));
                           destination[i] = tower_5.get(h);
                           destination_zone[i] = 5;
                         }
                     }    
                  if(p == 6){
                         if(origin_travel[i].mag() <= 5){
                           int h = int(random(0, tower_6.size()));
                           origin[i] = tower_6.get(h);
                           origin_zone[i] = 6;
                         }
                         if(destination_travel[i].mag() <= 5){
                           int h = int(random(0, tower_6.size()));
                           destination[i] = tower_6.get(h);
                           destination_zone[i] = 6;
                         }
                     }              
                  if(p == 8){
                         if(origin_travel[i].mag() <= 5){
                           int h = int(random(0, tower_8.size()));
                           origin[i] = tower_8.get(h);
                           origin_zone[i] = 8;
                         }
                         if(destination_travel[i].mag() <= 5){
                           int h = int(random(0, tower_8.size()));
                           destination[i] = tower_8.get(h);
                           destination_zone[i] = 8;
                         }
                     }    
                  if(p == 9){
                         if(origin_travel[i].mag() <= 5){
                           int h = int(random(0, tower_9.size()));
                           origin[i] = tower_9.get(h);
                           origin_zone[i] = 9;
                         }
                         if(destination_travel[i].mag() <= 5){
                           int h = int(random(0, tower_9.size()));
                           destination[i] = tower_9.get(h);
                           destination_zone[i] = 9;
                         }
                     }     
                  if(p == 10 || p == 7){
                         if(origin_travel[i].mag() <= 5){
                           int h = int(random(0, tower_10.size()));
                           origin[i] = tower_10.get(h);
                           origin_zone[i] = 10;
                         }
                         if(destination_travel[i].mag() <= 5){
                           int h = int(random(0, tower_10.size()));
                           destination[i] = tower_10.get(h);
                           destination_zone[i] = 10;
                         }
                     }     
                  if(p == 11){
                         if(origin_travel[i].mag() <= 5){
                           int h = int(random(0, tower_11.size()));
                           origin[i] = tower_11.get(h);
                           origin_zone[i] = 11;
                         }
                         if(destination_travel[i].mag() <= 5){
                           int h = int(random(0, tower_11.size()));
                           destination[i] = tower_11.get(h);
                           destination_zone[i] = 11;
                         }
                     }     
                     
                 }            
                            
         ///////LANGUAGE HEURISTICS 
         for(int j = 0; j<marc_rest.getRowCount(); j++){
                                if (network.getString(i, "NATION").equals("sp")) {
                                if(marc_rest.getString(j, "LANGUAGES").equals("CA,ES,EN,RU") || marc_rest.getString(j, "LANGUAGES").equals("CA") 
                                || marc_rest.getString(j, "LANGUAGES").equals("CA,ES,EN,PT") ||marc_rest.getString(j, "LANGUAGES").equals("CA,ES") || marc_rest.getString(j, "LANGUAGES").equals("CA, ES, FR, EN, PT"))
                                {
                                  rest_coord[i] = mercatorMap.getScreenLocation(new PVector(marc_rest.getFloat(j, "LAT"), marc_rest.getFloat(j, "LNG")));
                                  rest_coord[i] = new PVector(rest_coord[i].x + marginWidthPix, rest_coord[i].y + marginWidthPix);
                                  if(rest_coord[i].y >  tower_values.get(4).y){
                                  spanish_speaking_amenities.add(rest_coord[i]);
                                  int c = int(random(0, spanish_speaking_amenities.size()));
                                  PVector doop = PVector.sub(origin[i], spanish_speaking_amenities.get(c));
                                  PVector derp = PVector.sub(origin[i], destination[i]);
                                  PVector moop = PVector.sub(destination[i], spanish_speaking_amenities.get(c));
                                      if(abs(doop.mag())<= abs(derp.mag())){
                                      destination[i] = spanish_speaking_amenities.get(c);
                                        } 
                                    }
                                  }
                                  }
                              if (network.getString(i, "NATION").equals("fr")) {
                                if (marc_rest.getString(j, "LANGUAGES").equals("CA,ES,FR,EN") || marc_rest.getString(j, "LANGUAGES").equals("CA,ES,FR,EN,RU") 
                                  || marc_rest.getString(j, "LANGUAGES").equals("CA,ES,FR,PT"))
                                {
                                  rest_coord[i] = mercatorMap.getScreenLocation(new PVector(marc_rest.getFloat(j, "LAT"), marc_rest.getFloat(j, "LNG")));
                                  rest_coord[i] = new PVector(rest_coord[i].x + marginWidthPix, rest_coord[i].y + marginWidthPix);
                                  if(rest_coord[i].y > tower_values.get(4).y){
                                  french_speaking_amenities.add(rest_coord[i]);
                                  int c = int(random(0, french_speaking_amenities.size()));
                                  PVector doop = PVector.sub(origin[i], french_speaking_amenities.get(c));
                                  PVector derp = PVector.sub(origin[i], destination[i]);
                                      if(doop.mag()<= derp.mag()){
                                      destination[i] = french_speaking_amenities.get(c);
                                        }
                                    }
                                  }
                                }
         }
    }
  } 


  for (int i=0; i<numSwarm; i++) {
    if (network.getInt(i, "CON_O") != 0 || network.getInt(i, "CON_D") != 0) {
      origin[i] = container_Locations[network.getInt(i, "CON_O")];
      destination[i] = container_Locations[network.getInt(i, "CON_D")];
      external = true;
    }



    if (network.getString(i, "NATION").equals("sp")) {
      col = spanish;
      weight[i] = 10;
    } else if (network.getString(i, "NATION").equals("fr")) {
      col = french;
      weight[i] = 10;
    } else {
      col = other;
      weight[i] = 10;
    }


    // delay, origin, destination, speed, color
    swarmHorde.addSwarm(weight[i], origin[i], destination[i], 1, col, origin_zone[i], destination_zone[i]);
    // swarmHorde.addSwarm(weight[i], origin[i], destination[i], 1, col, origin_zone, destination_zone);
    
    // Makes sure that agents 'staying put' eventually die
    // also that they don't blead into the margin or topo
    swarmHorde.getSwarm(i).temperStandingAgents(external);
  }

  //Sets maximum range for hourly data
  maxHour = 0;
  for (int i=0; i<OD.getRowCount (); i++) {
    if (OD.getInt(i, "HOUR") > maxHour) {
      maxHour = OD.getInt(i, "HOUR");
    }
  }

  for (int i=0; i<maxHour+1; i++) {
    summary.addRow();
    summary.setInt(i, "HOUR", i);
    summary.setInt(i, "TOTAL", 0);
    summary.setInt(i, "SPANISH", 0);
    summary.setInt(i, "FRENCH", 0);
    summary.setInt(i, "OTHER", 0);
  }

  for (int i=0; i<OD.getRowCount (); i++) {
    String country = network.getString(OD.getInt(i, "EDGE_ID"), "NATION");
    if ( country.equals("sp") ) {
      summary.setInt(OD.getInt(i, "HOUR"), "SPANISH", summary.getInt(OD.getInt(i, "HOUR"), "SPANISH") + OD.getInt(i, "AMOUNT"));
    } else if ( country.equals("fr") ) {
      summary.setInt(OD.getInt(i, "HOUR"), "FRENCH", summary.getInt(OD.getInt(i, "HOUR"), "FRENCH") + OD.getInt(i, "AMOUNT"));
    } else if ( country.equals("other") ) {
      summary.setInt(OD.getInt(i, "HOUR"), "OTHER", summary.getInt(OD.getInt(i, "HOUR"), "OTHER") + OD.getInt(i, "AMOUNT"));
    }
    summary.setInt(OD.getInt(i, "HOUR"), "TOTAL", summary.getInt(OD.getInt(i, "HOUR"), "TOTAL") + OD.getInt(i, "AMOUNT"));
  }

  for (int i=0; i<summary.getRowCount (); i++) {
    if ( summary.getInt(i, "TOTAL") > maxFlow ) {
      maxFlow = summary.getInt(i, "TOTAL");
    }
  }

  // Sets to rates at specific hour ...
  setSwarmFlow(hourIndex);
  
}
