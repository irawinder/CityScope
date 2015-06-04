String[] name = {
  "CityScope: Kendall",
  "CityScope: Riyadh",
  "CityScope: Flinders",
  "CityScope: Kendall2",
  "CityScope: Toronto"
};

void drawInfo() {
  
  textFont(font24, 24);
  fill(#999999);
  textAlign(RIGHT);
  text(name[vizMode], width - 15, 24+10);
  
  textFont(font12);
  textAlign(LEFT);
  text("Press 'h' key for help and advanced functions", 10, height-10);
  text(help[1], 10, height-10-13);
  text(help[0], 10, height-10-2*13);
  
  // Draws Graphic to show user simulation is in progress
  if (drawNodes && nodeMode == 1 && simCounter > 0) {
    
    String simString = "Simulation in Progress";;
    if (simCounter % 4 == 2) {
      simString += ".";
    } else if (simCounter % 4 == 1) {
      simString += "..";
    } else if (simCounter % 4 == 0) {
      simString += "...";
    }
    
    textAlign(CENTER);
    textFont(font24,24);
    fill(#333333);
    text(simString, width/2, 50);
    
  }
  
  textFont(font48, 36);
  fill(#CCCCCC);
  textAlign(LEFT);
  
  translate(width/8, 3*height/4);
  
  if (colorMode == 0) {
    text("Land Use", 0, 0);
  } else if (colorMode == 1) {
    text("Form", 0, 0);
  } else if (colorMode == 2) {
    text(heatMapName + " Heatmap", 0, 0);
  }
  
  translate(-width/8, -3*height/4);
  
  textAlign(RIGHT);
  textFont(font24, 24);
  
  translate(width-60, 100);
  
  fill(residentialColor);
  text("Live Population", 0, 40);
  fill(#CCCCCC);
  text(live + " ppl", 0, 70);
  fill(officeColor);
  text("Work Population", 0, 120);
  fill(#CCCCCC);
  text(work + " ppl", 0, 150);
  
  translate(-(width-60), -100);
}

void loading(String item) {
  background(0);
  textFont(font12);
  textAlign(CENTER);
  fill(#FFFFFF);
  text("Loading " + item + "...", width/2, height/2);
  text("Ira Winder, MIT Media Lab", width/2, height/2 + 20);
}
