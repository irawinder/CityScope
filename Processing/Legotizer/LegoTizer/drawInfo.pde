String[] name = {
  "CityScope: Kendall",
  "CitySchema: Riyadh",
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
  
  textFont(font24, 24);
  fill(#CCCCCC);
  textAlign(LEFT);
  
  if (vizMode == 1) { //Riaydh Mode
    
    translate(10, height-60);
    if (colorMode == 0) {
      text("View Mode: Land Use", 0, 0);
    } else if (colorMode == 1) {
      text("View Mode: Form", 0, 0);
    } else if (colorMode == 2) {
      text("View Mode: " + heatMapName + " Heatmap", 0, 0);
    }
    translate(-10, -height+60);
    
    textFont(font24, 24);
    fill(residentialColor);
    text("Residents added: " + live + " ppl", 10, height-150);
    fill(officeColor);
    text("Jobs added: " + work + " ppl", 10, height-120);
    
  } else {
    
    translate(10, height-60);
    if (colorMode == 0) {
      text("View Mode: Land Use", 0, 0);
    } else if (colorMode == 1) {
      text("View Mode: Form", 0, 0);
    } else if (colorMode == 2) {
      text("View Mode: " + heatMapName + " Heatmap", 0, 0);
    }
    translate(-10, -height+60);
  }
}

void loading(String item) {
  background(0);
  textFont(font12);
  textAlign(CENTER);
  fill(#FFFFFF);
  text("Loading " + item + "...", width/2, height/2);
  text("Ira Winder, MIT Media Lab", width/2, height/2 + 20);
}
