boolean displayScoreWeb = true;

int webMode = 1; // 0=teal(static);  1 = average score fill; 2 = score cluster fill

PGraphics scoreWeb;

int live, work;

ArrayList<Float> scores;
ArrayList<String> scoreNames;

float avgScore;

int nWeb;

void initializeScoreWeb() {
  scoreWeb = createGraphics(1000, 1000);
}

void drawScoreWeb(int x, int y, int w, int h) {
  
  // Web center (X,Y);  Size (D); score names (sNames) and scores (s)
  generateScoreWeb(int(0.5*scoreWeb.width), int(0.5*scoreWeb.height), int(0.225*scoreWeb.height), scoreNames, scores); 
  
  image(scoreWeb, x, y, w, h);
}

void generateScoreWeb(int x, int y, int d, ArrayList<String> sNames, ArrayList<Float> s) { //Web center (X,Y);  Size (D); score names (sNames) and scores (s)
  
  float rot = 0.25*PI;
  nWeb = sNames.size();
  
  scoreWeb.beginDraw();
  scoreWeb.background(0);
  
  if (nWeb > 2) {
    
    //Draw Score Axes
    for (int i=0; i<nWeb; i++) {
      //Draw Score Axes
      scoreWeb.stroke(#999999);
      scoreWeb.line(x, y, d*cos(rot+i*2*PI/nWeb) + x, d*sin(rot+i*2*PI/nWeb) + y);
    }
    
    //Draw Labels
    scoreWeb.translate(x,y);
    scoreWeb.rotate(rot);
    for (int i=0; i<nWeb; i++) {
      //Draw Labels
      scoreWeb.fill(#666666);
      scoreWeb.textFont(font48, 48);
      
      if (PI/2 < (2*PI*i/nWeb+rot) && (2*PI*i/nWeb+rot) < 3*PI/2) { //Flips text upside down
        scoreWeb.rotate(PI);
        scoreWeb.textAlign(RIGHT);
        scoreWeb.text(sNames.get(i), - d - 48, 0.4*48);
        scoreWeb.textAlign(LEFT);
        scoreWeb.rotate(-PI);
      } else {
        scoreWeb.text(sNames.get(i), d+48, 0.4*48);
      }
      scoreWeb.rotate(2*PI/nWeb);
    }
    scoreWeb.rotate(-rot);
    scoreWeb.translate(-x,-y);
    
    //Draw Score Fills
    for (int i=0; i<nWeb; i++) {
      
      //Draw Score Fills
      if (webMode == 0) {
        scoreWeb.fill(#00FFFF);
      } else if (webMode == 1) {
        scoreWeb.fill(255*(1- (s.get(i)+s.get((i+1)%nWeb))/2 ), 255*(s.get(i)+s.get((i+1)%nWeb))/2, 0);
      } else if (webMode == 2) {
        scoreWeb.fill(255*(1-avgScore), 255*avgScore, 0);
      }
      scoreWeb.triangle(x, y, s.get(i)*d*cos(rot+i*2*PI/nWeb) + x, s.get(i)*d*sin(rot+i*2*PI/nWeb) + y, s.get((i+1)%nWeb)*d*cos(rot+(i+1)%nWeb*2*PI/nWeb) + x, s.get((i+1)%nWeb)*d*sin(rot+(i+1)%nWeb*2*PI/nWeb) + y);
    }
    
    for (int i=0; i<nWeb; i++) {
      //Draw Score Lines
      if (webMode == 0) {
        scoreWeb.stroke(#238586);
      } else if (webMode == 1) {
        scoreWeb.stroke(255*(1-s.get(i)+s.get((i+1)%nWeb))/2, 255*(s.get(i)+s.get((i+1)%nWeb))/2, 0);
      } else if (webMode == 2) {
        scoreWeb.stroke(255*(1-avgScore), 255*avgScore, 0);
      }
    
      scoreWeb.strokeWeight(4);
      scoreWeb.line(s.get(i)*d*cos(rot+i*2*PI/nWeb) + x, s.get(i)*d*sin(rot+i*2*PI/nWeb) + y, s.get((i+1)%nWeb)*d*cos(rot+(i+1)%nWeb*2*PI/nWeb) + x, s.get((i+1)%nWeb)*d*sin(rot+(i+1)%nWeb*2*PI/nWeb) + y);
    }
    
    for (int i=0; i<nWeb; i++) {
      //Draw Score Dots
      scoreWeb.strokeWeight(1);
      if (webMode == 0) {
        scoreWeb.fill(#238586);
      } else if (webMode == 1) {
        scoreWeb.fill(255*(1-s.get(i)), 255*s.get(i), 0);
      } else if (webMode == 2) {
        scoreWeb.fill(255*(1-s.get(i)), 255*s.get(i), 0);
      }
      
      scoreWeb.ellipse(s.get(i)*d*cos(rot+i*2*PI/nWeb) + x, s.get(i)*d*sin(rot+i*2*PI/nWeb) + y, 20, 20);
    }
    
    for (int i=0; i<nWeb; i++) {
      //Draw Score Numbers
      if (webMode == 0) {
        scoreWeb.fill(#CCCCCC);
      } else if (webMode == 1) {
        scoreWeb.fill(255*(1-s.get(i)), 255*s.get(i), 0);
      } else if (webMode == 2) {
        scoreWeb.fill(255*(1-s.get(i)), 255*s.get(i), 0);
      }
      scoreWeb.textFont(font48, 48);
      
      if (PI/2 < (2*PI*i/nWeb+rot) && (2*PI*i/nWeb+rot) < 3*PI/2) { //Flips text upside down
        scoreWeb.textAlign(RIGHT);
        scoreWeb.text(int(100*s.get(i)), 1.2*s.get(i)*d*cos(rot+i*2*PI/nWeb) + x, 1.2*s.get(i)*d*sin(rot+i*2*PI/nWeb) + y + 0.6*48);
        scoreWeb.textAlign(LEFT);
      } else {
        scoreWeb.text(int(100*s.get(i)), 1.2*s.get(i)*d*cos(rot+i*2*PI/nWeb) + x, 1.2*s.get(i)*d*sin(rot+i*2*PI/nWeb) + y + 0.6*48);
      }
    }
    
    scoreWeb.endDraw();
  }
}
