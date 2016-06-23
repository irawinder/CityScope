
/////////// Image Operations and distortions
/////////// code orignally by Mohammad K Hadhrawi
/////////// new and modified code by Carson Smuts
/////////// modified some more by Ira Winder
/////////// 2014



//import com.sun.awt.AWTUtilities;
//import  java.awt.GraphicsDevice.*; // PC only
//import java.awt.Frame;
import javax.swing.JFrame;
import deadpixel.keystone.*;
import processing.video.*;

// defines various drawing surfaces, all pre-calibrated, to project
CornerPinSurface surface1;
CornerPinSurface surface2;

PGraphics buffer1; 
PGraphics buffer2; 

// defines Keystone settings from xml file in parent folder
Keystone ks1;  
Keystone ks2;  


PFrame1 proj1Frame;
PFrame2 proj2Frame;

proj1Applet proj1A;
proj2Applet proj2A;

int projector_width = 1280;
int projector_height = 800;


void setup_ImageProj() {


  // Window # 1
  PFrame1 proj1Frame = new PFrame1();
  proj1Frame.setTitle("Window #1");
  proj1Frame.setLocation(2560, 0);

  // Window # 2
  PFrame2 proj2Frame = new PFrame2();
  proj2Frame.setTitle("Window #2");
  proj2Frame.setLocation(3840, 0);
}



public class PFrame1 extends JFrame {
  public PFrame1() {
    setBounds(0, 0, projector_width, projector_height);
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
    ks1.load("keystone_1.xml");
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
    ks2.load("keystone_2.xml");
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
    }
  }
}

