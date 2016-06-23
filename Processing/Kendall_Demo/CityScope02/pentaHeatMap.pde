/**
  *  Scripts for creating HeatMap Visualizations
  * (c) 2014 Ira Winder, jamesira.com
  *
  */

// Arrays to hold heatmap "pixel" values
float[][][][] heatmap;

float[][] nullmap;

// sigma value of gaussian curve, in pixels
float sigma; 

float S = 0.1; //sigma modifier, represents fraction of screen pixel width

// HeatMap Resolution (u,v)
int lowres_width = 100;
int lowres_height = 100;

// Ratio of (u,v) to (width,height) of canvas
float w_scaler = lg_width/lowres_width;
float h_scaler = lg_height/lowres_height;

int t_var = 240; //hue variation between highest and lowest heat values for each data type

// global maximum pixel value for each data layer's heatmap
float[][] max;
float[][] min;

//create heatmaps based on PVectors and Normalization Coeffecients
void initializeMaps() {
  
  // global maximum pixel value for each data layer's heatmap
  max = new float[numfields][numlayers];
  min = new float[numfields][numlayers];
   
  sigma = S*width; //Sigma value proportial to canvas width
  heatmap = new float[numfields][numlayers][lowres_width][lowres_height];
  nullmap = new float[lowres_width][lowres_height];

  // Creates normalized HeatMaps
  for (int g = 0; g<numfields; g++) {
    for (int h = 0; h<numlayers; h++) {
      max[g][h] = 0;
      min[g][h] = 1000000000;
      for (int i=0; i<lowres_width; i++) {
        for (int j=0; j<lowres_height; j++) {
          heatmap[g][h][i][j] = 0; 
          for (int k=0; k<count[g][h]; k++) {
            // 2D Guassian Distribution: f(x, y) = weight/ (2*pi*sigma^2) * e^( -(x^2 + y^2)/(2*sigma) )
            heatmap[g][h][i][j] += coord[g][h][k].z* 1/(2.0*PI*sq(sigma))*exp( -(sq(coord[g][h][k].x-i*w_scaler + w_scaler/2)+sq(coord[g][h][k].y-j*h_scaler + h_scaler/2))/(1. * sq(sigma)));
          }
          if (g==0 && h ==0) {
            //println("heatmap[0][0][" + i + "][" + j + "] = " + heatmap[0][0][i][j]);
          }
          heatmap[g][h][i][j] *= (2*PI*sigma)/sqrt(2*PI);  //normalizes values according to integral:f(x,y)| -/+ infinity = weight*sqrt(2*PI)/ (2*PI*sigma)
          heatmap[g][h][i][j] *= 10000;  //makes number big enough to be non-zero
          if (heatmap[g][h][i][j] > max[g][h]) {
            max[g][h] = heatmap[g][h][i][j];        // max value set to max normalized value
          }
          if (heatmap[g][h][i][j] < min[g][h]) {
            min[g][h] = heatmap[g][h][i][j];        // max value set to max normalized value
          }
        }
      }
    }
  }
  
  //Subtracts min value from all heat maps
  for (int g = 0; g<numfields; g++) {
    for (int h = 0; h<numlayers; h++) {
      max[g][h] -= min[g][h];
      for (int i=0; i<lowres_width; i++) {
        for (int j=0; j<lowres_height; j++) {
          heatmap[g][h][i][j] -= min[g][h];
        }
      }
    }
  }

  if (debug == true) {
    for (int j=0; j<numfields; j++) {
      for (int i=0; i<numlayers; i++) {
        println("sum[" + j + "][" + i + "] = " + sum[j][i]);
      }
      for (int i=0; i<numlayers; i++) {
        println("max[" + j + "][" + i + "] = " + max[j][i]);
      }
    }
  }
}

private void drawHeatMap(float[][] map, float max, float min, int t, int index) { // More Smooth, but slower
  colorMode(HSB, 360, 2*max, 2*max, w_scaler*max); //Sets boundaries of ColorMode to be same as heatmap max values
  for (int i=0; i<lowres_width; i++) {
    for (int j=0; j<lowres_height; j++) {   
      for (int d = floor(w_scaler); d>0; d--) { // For each "pixel," draws concentric circles, fading to transparency
        fill(t+t_var*map[i][j]/max, map[i][j]+max, map[i][j]+max, (w_scaler-d)*map[i][j]*sin);
        ellipse(floor(i*w_scaler + w_scaler/2)- w_shift, floor(j*h_scaler + h_scaler/2)- h_shift, d*2*PI, d*2*PI);
      }
    }
  }
}

private void drawAliasedHeatMap(float[][] map, float max, float min, int t, int index) { // Less Smooth, but faster
  colorMode(HSB, 360, sqrt(sqrt(5/4*max)), sqrt(sqrt(5/4*max)), sqrt(sqrt(5/4*max)) ); //Sets boundaries of ColorMode to be same as heatmap max values 
  for (int i=0; i<lowres_width; i++) {
    for (int j=0; j<lowres_height; j++) {
      fill(((t + t_var) - t_var*map[i][j]/max)%360, sqrt(sqrt(max/4+map[i][j])), sqrt(sqrt(max/4+map[i][j])), sqrt(sqrt(max/4+map[i][j]))*sin);
      rect(floor(i*w_scaler)- w_shift, floor(j*h_scaler)- h_shift, w_scaler, h_scaler);
    }
  }
}
