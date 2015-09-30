
/////////// Image Operations and distortions
/////////// code orignally by Mohammad K Hadhrawi
/////////// new and modified code by Carson Smuts
/////////// modified some more by Ira Winder
/////////// 2014

PImage  imgEOps, imgWOps;
PGraphics printerImageE, printerImageW;
PGraphics outputE, outputW;

int imageCapture_width, imageCapture_height, piece_height; //Global variables used in "Image_Proj"

void setupOps() {
  
//  printerImageW = createGraphics(crop.width, crop.height, P2D);
//  printerImageE = createGraphics(crop.width, crop.height, P2D);
//
//  outputE = createGraphics(crop.width, crop.height, P2D);
//  outputW = createGraphics(crop.width, crop.height, P2D);
//  
//  imageCapture_width = crop.width;
//  imageCapture_height = crop.height;

  printerImageW = createGraphics(crop.height, crop.width, P2D);
  printerImageE = createGraphics(crop.height, crop.width, P2D);

  outputE = createGraphics(crop.height, crop.width, P2D);
  outputW = createGraphics(crop.height, crop.width, P2D);
  
  imageCapture_width = crop.height;
  imageCapture_height = crop.width;
}


void imageOps() {

  //dimension ratio of each half to be projected (may be different than projector resolution)
  //0.5 is half and half no overlap, greater than 0.5 creates overlap
  float piece_ratio = 1000.0/2000; 
  
  piece_height = floor(crop.width*piece_ratio);
  int offset = crop.width-piece_height;



  //uses PImage as sketch image .... "PImage crop;"

  // Printer Image West
  printerImageW.beginDraw();
  printerImageW.background(0);
  printerImageW.blendMode(REPLACE);
  printerImageW.translate(0, printerImageW.height);
  printerImageW.rotate(radians(270));
  printerImageW.image(crop, offset, 0);

  printerImageW.blendMode(REPLACE);

  printerImageW.endDraw();
  imgWOps = printerImageW.get();


  // Printer Image East
  printerImageE.beginDraw();
  printerImageE.background(0);
  printerImageE.blendMode(REPLACE);
  printerImageE.translate(printerImageE.width, 0);
  printerImageE.rotate(radians(90));
  printerImageE.image(crop, -offset, 0);
  
  printerImageE.blendMode(REPLACE);
  
  printerImageE.endDraw();
  imgEOps = printerImageE.get();
}
