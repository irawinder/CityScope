/**
  *  Scripts for CityScope Node Pulses
  * (c) 2014 Ira Winder, jamesira.com
  *
  */
  
// Node Pulse Parameters
float pulse_max = 500.0; //Changes magnitude of Largest Pulse
float pulse_min = 100.0; //Changes magnitude of Smallest Pulse
float pulse_def = 200.0; //Size of Pulse when all weights same

// Amount of pixels to "jiggle" data
int coord_jiggle = 20;

private void drawNodes(PVector[] c, int cnt, float s, int t, int index, int d) {
  float alpha;
  float max_alpha = pulse_max;
  float min_alpha = pulse_min;
  float diam;
  float max_diam;
  float min_diam;
  
  if (showHeat == false) {
    for (int k=0; k<cnt; k++) { 
      
      diam = sqrt(sqrt(4*c[k].z/PI));
      min_diam = sqrt(sqrt(4*min_weight[fieldindex][index]/PI));
      max_diam = sqrt(sqrt(4*max_weight[fieldindex][index]/PI));
      
      if (min_diam == max_diam) {
        alpha = pulse_def;
      } else {
        alpha = min_alpha + (max_alpha-min_alpha)/(max_diam-min_diam)*(diam);
      }

      colorMode(HSB, 360, 1, 1, (int)alpha); //Sets boundaries of ColorMode to be same as heatmap max values
      
      for (int i = (int)alpha; i>0; i-=(alpha/8)) { // For each "pixel," draws concentric circles, fading to transparency
        fill(t, 1, 1, .25*((int)alpha-i)*sin);
        ellipse(c[k].x- w_shift, c[k].y- h_shift, i, i);
      }
    }
  }
  
  colorMode(HSB, 360, 1, 1, 1); //Sets boundaries of ColorMode to be same as heatmap max values
  
  fill(t, .5, 1, 1);
  for (int k=0; k<cnt; k++) {
    ellipse(c[k].x- w_shift, c[k].y- h_shift, d, d);
  }

  if (debug == true) {
    //Draws Node Values
    fill(#FFFFFF);
    for (int k=0; k<cnt; k++) {
      text(floor(c[k].z), c[k].x- w_shift + 20, c[k].y- h_shift);
    }
  }
}
