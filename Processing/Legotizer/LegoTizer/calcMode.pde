// Needs to be reformatted for use in Legotizer

// total values for residential, academic/institutional, office, and retail amounts
float tot_res, tot_ins, tot_off, tot_ret;

void calcStats() {
  tot_res = 0;
  tot_ins = 0;
  tot_off = 0;
  tot_ret = 0;
  
  for (int i = 0; i<UMax; i++) {
    for (int j = 0; j<VMax; j++) {
      if (siteInfo.getInt(i,j) == 1) { //is site
        if (codeArray[i][j][0] != -1) { //has peice
          
          tot_res += structures1x1.getInt(codeArray[i][j][0], 4);
          tot_off += structures1x1.getInt(codeArray[i][j][0], 5);
          tot_ret += structures1x1.getInt(codeArray[i][j][0], 6);
          tot_ins += structures1x1.getInt(codeArray[i][j][0], 7);
        }
      }
    }
  }
}

void drawStats() {
  camera();
  perspective();
  
  //fill(0);
  //rect(0,0,1920,100);
  
  fill(#FFFFFF);
  textSize(30);
  text("MIT / Kendall Square", 80, 80);
  
  fill(#882222);
  textSize(30);
  text("MIT Media Lab", 100, 470);
  
  if ((tot_ins + tot_res + tot_ret + tot_off)*100 > 110700) {
    fill(#FF0000);
    textSize(60);
    text("You've built too much!!!", 80, 200);
  }
  
  fill(#FFFFFF);
  
  translate(1650, 80);
  textSize(30);
  text("Residential", 0, 0);
  text("Retail", 0, 40);
  text("Office", 0, 80);
  text("Academic", 0, 120);
  
  translate(-50,-20);
  fill(#FFFF00); //yellow residential
  rect(0,0,30,30);
  fill(#ff00ff); //purple retail
  rect(0,40,30,30);
  fill(#FF0000); //red office
  rect(0,80,30,30);
  fill(#0000ff); //blue mit
  rect(0,120,30,30);
  
  fill(#FFFFFF);
  translate(-460, 20);
  textSize(30);
  text("Residential GFA: " + tot_res*100 + " sqm", 0, 0);
  text("Retail GFA: " + tot_ret*100 + " sqm", 0, 40);
  text("Office GFA: " + tot_off*100 + " sqm", 0, 80);
  text("Academic GFA: " + tot_ins*100 + " sqm", 0, 120);
  
  text("Total GFA: " + (tot_ins + tot_res + tot_ret + tot_off)*100 + "sqm", 0, 160);
  
}
