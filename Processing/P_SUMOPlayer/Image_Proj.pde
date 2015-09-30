
/////////// Image Operations and distortions
/////////// code orignally by Mohammad K Hadhrawi
/////////// new and modified code by Carson Smuts
/////////// modified some more by Ira Winder
/////////// 2014

//
// This is a script that allows one to open a new canvas for the purpose 
// of simple 2D projection mapping, such as on a flat table surface
//
// Right now, only appears to work in windows...
//
// To use this example in the real world, you need a projector
// and a surface you want to project your Processing sketch onto.
//
// Simply press the 'c' key and drag the corners of the 
// CornerPinSurface so that they
// match the physical surface's corners. The result will be an
// undistorted projection, regardless of projector position or 
// orientation.
//
// You can also create more than one Surface object, and project
// onto multiple flat surfaces using a single projector.
//
// This extra flexbility can comes at the sacrifice of more or 
// less pixel resolution, depending on your projector and how
// many surfaces you want to map. 
//

import javax.swing.JFrame;
import deadpixel.keystone.*;

// Visualization may show 2D projection visualization, or not
boolean displayProjection2D = false;

// Defines various drawing surfaces, all pre-calibrated, to project
CornerPinSurface surface1;
CornerPinSurface surface2;
PGraphics buffer1; 
PGraphics buffer2; 

// Defines Keystone settings from xml file in parent folder
Keystone ks1;  
Keystone ks2;  

// Application Window Parameters

  // Projector 1
  PFrame1 proj1Frame = null;
  proj1Applet proj1A;
  
  //Projector 2
  PFrame2 proj2Frame = null;
  proj2Applet proj2A;

int projector_width;
int projector_height;
int screenWidth;

public class PFrame1 extends JFrame {
  public PFrame1() {
    setBounds(0, 0, projector_width, projector_height);
    setLocation(screenWidth, 0);
    proj1A = new proj1Applet();
    setResizable(false);
    setUndecorated(true); 
    setAlwaysOnTop(true);
    add(proj1A); 
    proj1A.init(); 
    show();
    setTitle("Window #1");
  }
}

public class PFrame2 extends JFrame {
  public PFrame2() {
    setBounds(0, 0, projector_width, projector_height);
    setLocation(screenWidth + projector_width, 0);
    proj2A = new proj2Applet();
    setResizable(false);
    setUndecorated(true); 
    setAlwaysOnTop(true);
    add(proj2A); 
    proj2A.init(); 
    show();
    setTitle("Window #2");
  }
}

public class proj1Applet extends PApplet {
  public void setup() {
    size(projector_width, projector_height, P2D);
    // set up and open Keystone window with xml file
    ks1 = new Keystone(this);  
    buffer1 = createGraphics(imageCapture_width, piece_height);
    // creates the projection surfaces, to be manipulated in draw()
    surface1 = ks1.createCornerPinSurface(400, 400, 20);
    try{
      ks1.load("keystone_1.xml");
    } catch(RuntimeException e){
      println("keystone_1.xml not found");
    }
  }
  public void draw() {
    background(0);
    //image(imgEOps, 0, 0);
    buffer1.beginDraw();
    buffer1.background(#FFFFFF);
    buffer1.blendMode(MULTIPLY);
    buffer1.image(imgWOps, 0, 0);
    buffer1.endDraw();
    surface1.render(buffer1, 0, 0, imageCapture_width, piece_height);
  }

  void keyPressed() {
    switch(key) {
    case 'c':
      // enter/leave calibration mode, where surfaces can be warped 
      // and moved
      ks1.toggleCalibration();
      break;

    case 'l':
      // loads the saved layout
      ks1.load("keystone_1.xml");
      break;

    case 's':
      // saves the layout
      ks1.save("keystone_1.xml");
      break;
      
    case '`': 
      if (displayProjection2D) {
        displayProjection2D = false;
        closeProjection2D();
      } else {
        displayProjection2D = true;
        showProjection2D();
      }
      break;
      
    }
  }
}

public class proj2Applet extends PApplet {
  public void setup() {
    size(projector_width, projector_height, P2D);
   // set up and open Keystone window with xml file
    ks2 = new Keystone(this);  
    buffer2 = createGraphics(imageCapture_width, piece_height);
    // creates the projection surfaces, to be manipulated in draw()
    surface2 = ks2.createCornerPinSurface(400, 400, 20);
    try{
      ks2.load("keystone_2.xml");
    } catch(RuntimeException e){
      println("keystone_2.xml not found");
    }
  }
  public void draw() {
    background(0);
    //image(imgEOps, 0, 0);
    buffer2.beginDraw();
    buffer2.background(#FFFFFF);
    buffer2.blendMode(MULTIPLY);
    buffer2.image(imgEOps, 0, 0);
    buffer2.endDraw();
    surface2.render(buffer2, 0, 0, imageCapture_width, piece_height);
  }

  void keyPressed() {
    switch(key) {
    case 'c':
      // enter/leave calibration mode, where surfaces can be warped 
      // and moved
      ks2.toggleCalibration();
      break;

    case 'l':
      // loads the saved layout
      ks2.load("keystone_2.xml");
      break;

    case 's':
      // saves the layout
      ks2.save("keystone_2.xml");
      break;
      
    case '`': 
      if (displayProjection2D) {
        displayProjection2D = false;
        closeProjection2D();
      } else {
        displayProjection2D = true;
        showProjection2D();
      }
      break;
      
    }
  }
}

void toggle2DProjection() {
  if (System.getProperty("os.name").substring(0,3).equals("Mac")) {
    println("Projection Mapping Currently not Supported for MacOS");
  } else {
    if (displayProjection2D) {
      displayProjection2D = false;
      closeProjection2D();
    } else {
      displayProjection2D = true;
      showProjection2D();
    }
  }
}

public void showProjection2D() {
  
  if (proj1Frame == null) {
    proj1Frame = new PFrame1();
  }
  proj1Frame.setVisible(true);
  
  if (proj2Frame == null) {
    proj2Frame = new PFrame2();
  }
  proj2Frame.setVisible(true);
  
}

public void closeProjection2D() {
  proj1Frame.setVisible(false);
  proj2Frame.setVisible(false);
}

