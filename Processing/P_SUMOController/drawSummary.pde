int columnCount;
int scenarioID = 1;
float offset;
int delta;

void setupSummary() {
  
  columnCount = summary.getColumnCount() - 1;
  //offset = 0.3*columnCount*(screenH/25);
  offset = 0.25/columnCount*height;
  
}

void drawSummary() {
  
  fill(#FFFFFF);
  textSize(screenH/25);
  textAlign(LEFT);

  
  for(int i=0; i<columnCount; i++) {
    
    if (i == 0) {
      fill(#FFF829);
    } else {
      fill(#FFFFFF);
    }
    text(summary.getString(0, i+1), 0.1*width, float(i+1)/columnCount*height - offset);
    
    text(summary.getString(scenarioID+1, i+1), 0.4*width, float(i+1)/columnCount*height - offset);
    if (i==0) {
      text("Change from Today", 0.7*width, float(i+1)/columnCount*height - offset);
    } else {
      
      delta = summary.getInt(scenarioID+1, i+1) - summary.getInt(0+1, i+1);
      
      fill(#333333);
      
      if (delta > 0) {
        fill(#FFFFFF);
      } else if (delta < 0) {
        fill(#FFFFFF);
      }
      
      text(delta, 0.7*width, float(i+1)/columnCount*height - offset);
      fill(#FFFFFF);
    }
  }
  
  for(int i=0; i<summary.getRowCount(); i++) {
    //println(summary.getString(i, 0));
  }

}
