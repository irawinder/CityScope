/**
  *  Scripts for CityScope WordCloud
  * (c) 2014 Ira Winder, jamesira.com
  *
  */

import wordcram.*; //Library for creating word clouds

// Parameters for generating word cloud
WordCram[] cloud;
Word[][] cloudArray = new Word[numfields][numlayers-1];
PGraphics[] cloudBuffer = new PGraphics[numfields];

int w_cloud = floor(canvas_width*(425.0/1280)); // Numbers Specific to Kendall Square Map, such to project in river
int h_cloud = floor(canvas_height*(200.0/1280)); // Numbers Specific to Kendall Square Map, such to project in river

void initializeCloud() {  
  
  // Sets weights and colors of Cluster Word Cloud
  colorMode(HSB, 360, 255, 255); //Sets boundaries of ColorMode to be same as heatmap max values
  for (int i=0; i<numfields; i++) {
    if (debug == true ) { println("--- BEGIN cloudArray[" + i + "] ---"); }
    for (int j=0; j<numlayers-1; j++) {
      if (sum[i][j+1] == 0) {
        cloudArray[i][j] = new Word("", 0);
      }
      else {
        cloudArray[i][j] = new Word(clusters[j+1], sum[i][j+1]);
      }
      cloudArray[i][j].setColor(color(t[j+1], 255.0/2, 255, 122.5*(1 + log(sum[i][j+1])/log(sum[i][0]))));
      if (debug == true ) { println(cloudArray[i][j].toString()); }
    }
    if (debug == true ) { println("--- END cloudArray[" + i + "] ---"); }
  }
  
  //Creates Clouds
  cloud = new WordCram[numfields];
  for (int i=0; i<numfields; i++) {
    cloudBuffer[i] = createGraphics(w_cloud, h_cloud, JAVA2D);
    cloudBuffer[i].clear();
    cloud[i] = new WordCram(this)
      .angledAt(radians(180))
      .fromWords(cloudArray[i])
      .withCustomCanvas(cloudBuffer[i])
      .sizedByWeight(minTextSize, 2*minTextSize)
      .withPlacer(Placers.upperLeft());
  }
  
  for (int i=0; i<numfields; i++) {
    cloudBuffer[i].beginDraw();
    cloudBuffer[i].textAlign(CENTER);
    cloudBuffer[i].textFont(createFont("sans", 20));
    cloudBuffer[i].translate(w_cloud, h_cloud);
    cloudBuffer[i].rotate(radians(180));
    cloud[i].drawAll();  
    cloudBuffer[i].endDraw();
  }
}

private void drawWordCloud(int index) {
  image(cloudBuffer[index], width-w_cloud-20, height-h_cloud-80);
}
