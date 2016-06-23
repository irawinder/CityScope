/**
  *  Script for Importing Image Basemaps to CityScope
  * (c) 2014 Ira Winder, jamesira.com
  *
  */

String[][] basemap_filenames = { //Add more String names to add more basemaps
  {"Sat_1280_1280.png",       "Google Satellite"},
  //{"Googlebw_1280_1280.png",  "Google Maps"},
  {"Google_1280_1280.png",    "Google Maps"},
  {"L_EnergyLines.jpg",       "Energy Demand Field"},
  {"L_Mobility.png",          "Mobility Systems"},
  {"L_Solar.png",             "Solar Insolation"},
  {"L_WindStudy.png",         "WindFlow Analysis"},
  {"L_DemoGrid.png",          "Data Medley"},
  {"mapBW.jpg",               "Steets"}
};
  
String overlay_filename = "Googlebw_1280_1280_alpha.png";

public class BaseMaps {
  /* String array of filenames of basemaps with descriptions, already cropped to Kendall Square model area */
  protected String[][] filenames;
  /* String of basemap overlay filename, typically png with pixels desired to stay opaque, such as street, and all else transparent */
  protected String overlay_filename;
  /* Canvas Dimensions */
  protected int w, h;
  
  private PImage[] basemap;
  private PImage basemap_overlay;

  //Initial Basemap to Display
  private int baseindex = 0;
  
  //Constructor
  public BaseMaps(String[][] filenames, String overlay_filename, int w, int h) {
    this.filenames = filenames;
    this.overlay_filename = overlay_filename;
    this.w = w;
    this.h = h;
    
    this.basemap = new PImage[filenames.length];
    for (int i = 0; i < filenames.length; i++) {
      this.basemap[i] = loadImage(filenames[i][0]);
      this.basemap[i].resize(w, h);
    }
    
    //Streats overlay only
    this.basemap_overlay = loadImage(overlay_filename);
    this.basemap_overlay.resize(w, h);
  }
  
  public int numBaseMaps() {
    return basemap.length;
  }
  
  public int getIndex() {
    return baseindex;
  }
  
  public PImage getBaseMap() {
    return basemap[baseindex];
  }
  
  public PImage getIndexedBaseMap(int index) {
    if (index >= 0 && index <= (numBaseMaps()-1)) {
      return basemap[index];
    } else {
      println("Baseindex out of bounds");
      return basemap[baseindex];
    }
  }
  
  public String getBaseMapName() {
    return filenames[baseindex][1];
  }
  
  public String getIndexedBaseMapName(int index) {
    if (index >= 0 && index <= (numBaseMaps()-1)) {
      return filenames[index][1];
    } else {
      println("Baseindex out of bounds");
      return filenames[baseindex][1];
    }
  }
  
  public PImage getBaseMapOverlay() {
    return basemap_overlay;
  }
  
  public void nextBaseMap() {
    if (baseindex < numBaseMaps()-1) {
      baseindex++;
    } else {
      baseindex = 0;
    }
  }
  
  public void lastBaseMap() {
    if (baseindex > 0) {
      baseindex--;
    } else {
      baseindex = numBaseMaps()-1;
    }
  }
  
  public void setBaseMap(int index) {
    if (index >= 0 && index <= (numBaseMaps()-1)) {
      baseindex = index;
    }
  }
}


