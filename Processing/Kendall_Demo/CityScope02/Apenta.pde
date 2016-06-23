boolean showHeat = false; //Initial heatmap state
boolean showData = true;

// Hue of Visualization for each layer
int[] t;

// Legend Color Parameters
int minhue = 0; //min hue
int maxhue = 360; //max hue

int minTextSize =   canvas_height/100;
PFont font1 = createFont("Arial Narrowc", 2.0*minTextSize);
PFont font2 = createFont("Arial Narrowc", 1.5*minTextSize);
PFont font3 = createFont("Arial Narrowc", 2.0*minTextSize+15);

int pentaSlide = 0; // tracker for slide location
int[][] pentaSlideShow = {
  {0, 0},  //Slide, Frequency of All
  //{0, 63}, //Slide, Frequency of Venture Capital
  //{0, 32}, //Slide, Frequency of Internet Cluster
  //{0, 5},  //Slide, Frequency of Bio
  //{0, 11}, //Slide, Frequency of Computer Software
  
  //{3, 0},  //Slide, EX of All
  //{3, 48}, //Slide, EX of Pharm. Cluster
  //{3, 45}, //Slide, EX of Oil and Energy Cluster
  //{3, 5},  //Slide, EX of Biotechnology Cluster
  //{3, 11}, //Slide, EX of Computer Software Cluster
  
  //{2, 0},  //Slide, Mindshare of All
  //{2, 15}, //Slide, Mindshare of Consumer Services
  //{2, 27},  //Slide, Mindshare of Higher Education
  //{2, 32}, //Slide, Mindshare of Internet
  //{2, 37},  //Slide, Mindshare of Marketing and Advertising
  
  {4, 0}  //Slide, Venture Capital
};

void setupPenta() {
  
  // assigns hue values to each data layer, evenly spaced between input values
  t = layerHues(numlayers, minhue, maxhue); 
  
  // Load CSV data of latitudes, longitudes, and weights: In the future would be preferable to link to online reference
  pentalytics = loadTable("Cambridge_Pentalytics.csv", "header");
  
  initializeData(); // create PVectors of Data Layers from CSV data
  initializeMaps(); // create heatmaps based on PVectors and Normalization Coeffecients
  initializeCloud(); // Create new WordCloud
}

void drawPenta() {
  
  if (showData) {
    
    setMercator();
    noStroke();
    
    if (showHeat) {
      drawAliasedHeatMap(heatmap[fieldindex][displayindex], max[fieldindex][displayindex], min[fieldindex][displayindex], t[displayindex], displayindex);
    } else {
      //display heatmap that is known to be empty of values, makes P2D applet layers work FOR SOME GOD-FORSAKEN REASON
      drawAliasedHeatMap(nullmap, 0, 0, 0, 0);
    }
    
    if (displayindex == 0) {
      for (int i=1; i<numlayers; i++) {
        drawNodes(coord[fieldindex][i], count[fieldindex][i], sum[fieldindex][0], t[i], displayindex, 14);
      }
    } else {
      drawNodes(coord[fieldindex][displayindex], count[fieldindex][displayindex], sum[fieldindex][0], t[displayindex], 0, 14);
    }
    
    unsetMercator();
    image(baseMaps.getBaseMapOverlay(), 0, 0);
    if (help == false) {
      if (displayindex == 0) {
        drawWordCloud(fieldindex);
      } else {
        drawLegend(clusters, displayindex, max[fieldindex][0], t[displayindex]);
      }
      drawDataInfo();
    }
  } else {
    
    if (help == false) {
      //display heatmap that is known to be empty of values, makes P2D applet layers work FOR SOME GOD-FORSAKEN REASON
      setMercator();
      drawAliasedHeatMap(nullmap, 0, 0, 0, 0);
      unsetMercator();
    }
  }
  
  if (help) {
    //display heatmap that is known to be empty of values, makes P2D applet layers work FOR SOME GOD-FORSAKEN REASON
    setMercator();
    drawAliasedHeatMap(nullmap, 0, 0, 0, 0);
    unsetMercator();
    
    translate(width-w_cloud, height-h_cloud-70);
    drawDirections();
    translate(-width+w_cloud, -height+h_cloud+70);
  }
}

private void drawLegend(String[] data, int index, float m, int t) { // Draws Data Layer Key
  String output;
  
  colorMode(HSB, 360, 2*m, 2*m, w_scaler*m); //Sets boundaries of ColorMode to be same as heatmap max values
  
  if (data[index] == null) {
    output="No Data";
  }
  else {
    output=data[index];
  }
  
  textAlign(RIGHT);
  
  fill(t, m, 2*m, w_scaler*m);
  textFont(font1);
  text(output, canvas_width-20, canvas_height-115); 
  
  fill(#FFFFFF);
  textSize(minTextSize);
  text("[" + (index+1) + " of " + (data.length) + " Industry Clusters]", canvas_width-20, canvas_height-100);
}

private void drawDataInfo() {
  textAlign(RIGHT);
  
  fill(#FFFFFF);
  textFont(font1);
  textSize(1.75*minTextSize);
  text("Industry " + field[fieldindex], canvas_width-20, canvas_height-30);
  textSize(minTextSize);
  text("*Source: ContextLabs Pentalytics", canvas_width-20, canvas_height-15);
  
  textFont(font3);
  textSize(minTextSize);
  //text("per sqKM", width-300, height-70);
  
  textSize(1.75*minTextSize);
  textAlign(LEFT);
  colorMode(HSB, 360, 1, 1, 1);
  if (displayindex == 0) {
    fill(0, 0, 1, 1);
  }
  else {
    fill(t[displayindex], .5, 1, 1);
  }
  text(ceil(sum[fieldindex][displayindex]/sq(.96)) + "* per sqKM", width-w_cloud-20, height-70);
}
  
int[] layerHues(int numlayers, float min, float max) { // For each layer, defines equidistant hue values
  int[] t_values = new int[numlayers];
  for (int i=0; i<numlayers; i++) {
    //t_values[i] = floor(minhue + ((float)i/numlayers)*(maxhue-minhue)); // Distributes hues equally
    t_values[i] = floor(random(min, max)); // Distributes hues randomly
    if (debug == true) {
      println("t_values[" + i + "] = " + t_values[i]);
    }
  }
  return t_values;
}


