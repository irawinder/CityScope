int columnCount;
int scenarioID = 3;
float offset;
int delta;
int column;
float x_;
float y_;

int smText;
int lgText;

boolean debug = false;

void setupSummary() {
  
  columnCount = summary.getColumnCount() - 1;
  //offset = 0.3*columnCount*(screenH/25);
  offset = 0.25/columnCount*height;
  
  baseChange = new int[columnCount];
  
  smText = screenH/30;
  lgText = screenH/10;
    
}

void drawSummary() {
  
  // Refreshes (+/-) change flag on summary parameters
  // -1 is decresae from base; +1 is increase from base
  refreshChangeBools();
  
  fill(#FFFFFF);
  textSize(smText);
  textAlign(LEFT);
  
  if (debug) {
    
    for(int i=0; i<columnCount; i++) {
      
      if (i == 0) {
        fill(#FFF829);
      } else {
        fill(#FFFFFF);
      }
      
      if (i == 0 && invalid) {
        fill(#FF0000);
        text("INVALID", 0.01*width, float(i+1)/columnCount*height - offset);
        fill(#FFFFFF);
      } else {
        text(summary.getString(0, i+1), 0.01*width, float(i+1)/columnCount*height - offset);
      }
      
      text(summary.getString(scenarioID+1, i+1), 0.6*width, float(i+1)/columnCount*height - offset);
      if (i==0) {
        text("Change from Today", 0.75*width, float(i+1)/columnCount*height - offset);
      } else {
        
        delta = summary.getInt(scenarioID+1, i+1) - summary.getInt(0+1, i+1);
        
        fill(#333333);
        
        checkChange(i, 1);
        
        text(delta, 0.75*width, float(i+1)/columnCount*height - offset);
        fill(#FFFFFF);
      }
    }
    
    for(int i=0; i<summary.getRowCount(); i++) {
      //println(summary.getString(i, 0));
    }
  } else {
    
    // Sets Static Global Variables to a Demo of Choice
    switch (demoMode) {
      case 1:
        drawStreetSummary();
        break;
        
      case 2:
        drawNeighborhoodSummary();
        break;
    }
  }
}

void drawStreetSummary() {
  
  image(streetScore_template, 0, 0, width, height);

  
  //Print Bus Time
  
      column = 3;
      x_ = 0.0;
      y_ = 0.01;
      
      // via Bus
      textAlign(RIGHT);
      fill(#FFFFFF);
      textSize(smText);
        //text("via Bus:", (0.79+x_)*width, (0.10+y_)*height);
      
      //Sets color to green or red
      checkChange(column-1, -1);
          
      // Change in Time
      textSize(smText);
      textAlign(RIGHT);
      if (baseChange[column-1] == -1) {
        text( "(saved " + ( abs(summary.getInt(scenarioID+1, column) - summary.getInt(0+1, column)) ) + " min)", (0.81+x_)*width, (0.16+y_)*height);
      } else if (baseChange[column-1] == 1) {
        text( "(added " + ( summary.getInt(scenarioID+1, column) - summary.getInt(0+1, column) ) + " min)", (0.81+x_)*width, (0.16+y_)*height);
      }
      
      // Bus Time
      textAlign(RIGHT);
      textSize(lgText);
        text(summary.getString(scenarioID+1, column), (0.79+x_)*width, (0.27+y_)*height);
      
      fill(#FFFFFF);
    
  //Print Driving Time
      column = 2;
      x_ = 0.0;
      y_ = 0.50;
      
//      // via Car
//      textAlign(RIGHT);
//      fill(#FFFFFF);
//      textSize(smText);
//        text("via Car:", (0.64+x_)*width, (0.22+y_)*height);
      
      //Sets color to green or red
      checkChange(column-1, -1);
          
//      // Change in Time
//      textSize(smText);
//      textAlign(RIGHT);
//      if (baseChange[column-1] == -1) {
//        text( "(saved " + ( abs(summary.getInt(scenarioID+1, column) - summary.getInt(0+1, column)) ) + " min)", (0.64+x_)*width, (0.27+y_)*height);
//      } else if (baseChange[column-1] == 1) {
//        text( "(added " + ( summary.getInt(scenarioID+1, column) - summary.getInt(0+1, column) ) + " min)", (0.64+x_)*width, (0.27+y_)*height);
//      }
      
      // Bus Time
      textAlign(RIGHT);
      textSize(lgText);
        text(summary.getString(scenarioID+1, column), (0.79+x_)*width, (0.27+y_)*height);
      
      fill(#FFFFFF);
  
  //Print Bus Stop Waiting Time
      column = 4;
      x_ = -0.31;
      y_ = 0.13;
      
//      // via Bus
//      textAlign(RIGHT);
//      fill(#FFFFFF);
//      textSize(smText);
//        //text("via Bike:", (0.64+x_)*width, (0.22+y_)*height);
      
      //Sets color to green or red
      checkChange(column-1, -1);
          
//      // Change in Wait Time
//      textSize(smText);
//      textAlign(RIGHT);
//      if (baseChange[column-1] == -1) {
//        text( "(saved " + ( abs(summary.getInt(scenarioID+1, column) - summary.getInt(0+1, column)) ) + "sec)", (0.63+x_)*width, (0.27+y_)*height);
//      } else if (baseChange[column-1] == 1) {
//        text( "(added " + ( summary.getInt(scenarioID+1, column) - summary.getInt(0+1, column) ) + "sec)", (0.63+x_)*width, (0.27+y_)*height);
//      }
      
      // Bus Wait Time
      textAlign(RIGHT);
      textSize(lgText);
        text(summary.getString(scenarioID+1, column), (0.79+x_)*width, (0.27+y_)*height);
      
      fill(#FFFFFF);


  //Print Bike Trips
      column = 6;
      x_ = -0.50;
      y_ = 0.49;
      
//      // via Bus
//      textAlign(RIGHT);
//      fill(#FFFFFF);
//      textSize(smText);
//        text("via Bike:", (0.64+x_)*width, (0.22+y_)*height);
      
      //Sets color to green or red
      checkChange(column-1, 1);
          
//      // Change in Time
//      textSize(smText);
//      textAlign(RIGHT);
//      if (baseChange[column-1] == -1) {
//        text( "(removed " + ( abs(summary.getInt(scenarioID+1, column) - summary.getInt(0+1, column)) ) + ")", (0.64+x_)*width, (0.27+y_)*height);
//      } else if (baseChange[column-1] == 1) {
//        text( "(added " + ( summary.getInt(scenarioID+1, column) - summary.getInt(0+1, column) ) + ")", (0.64+x_)*width, (0.27+y_)*height);
//      }
      
      // Bus Time
      textAlign(RIGHT);
      textSize(lgText);
        text(summary.getString(scenarioID+1, column), (0.79+x_)*width, (0.27+y_)*height);
      
      fill(#FFFFFF);
      
  //Print Parking Spots
      column = 5;
      x_ = -0.64;
      y_ = -0.16;
      
//      // via Bus
//      textAlign(RIGHT);
//      fill(#FFFFFF);
//      textSize(smText);
//        //text("via Bike:", (0.64+x_)*width, (0.22+y_)*height);
      
      //Sets color to green or red
      checkChange(column-1, 1);
          
//      // Change in Time
//      textSize(smText);
//      textAlign(LEFT);
//      if (baseChange[column-1] == -1) {
//        text( "(removed " + ( abs(summary.getInt(scenarioID+1, column) - summary.getInt(0+1, column)) ) + ")", (0.66+x_)*width, (0.43+y_)*height);
//      } else if (baseChange[column-1] == 1) {
//        text( "(added " + ( summary.getInt(scenarioID+1, column) - summary.getInt(0+1, column) ) + ")", (0.66+x_)*width, (0.43+y_)*height);
//      }
      
      // Park Spots
      textAlign(RIGHT);
      textSize(lgText);
        text(summary.getString(scenarioID+1, column), (0.79+x_)*width, (0.27+y_)*height);
      
      fill(#FFFFFF);
  
}

void drawNeighborhoodSummary() {
  

  
}

void refreshChangeBools() {
  
  // Refreshes (+/-) change flag on summary parameters
  // -1 is decresae from base; +1 is increase from base
  for(int i=0; i<columnCount; i++) {
    baseChange[i] = 0;
    
    if ( summary.getFloat(scenarioID+1, i+1) > summary.getFloat(1, i+1) ) {
      baseChange[i] = 1;
    } else if ( summary.getFloat(scenarioID+1, i+1) < summary.getFloat(1, i+1) ) {
      baseChange[i] = -1;
    }
  }
  
}

void checkChange(int i, int flip) {
  
  if (baseChange[i] == 1*flip) {
    //fill(#FFFFFF);
    fill(#00FF00);
  } else if (baseChange[i] == -1*flip) {
    //fill(#FFFFFF);
    fill(#FF0000);
  }
        
}
