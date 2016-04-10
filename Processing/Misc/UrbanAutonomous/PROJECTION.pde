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
//int projectorOffset = screenWidth;

boolean testProjectorOnMac = false;

// defines Keystone settings from xml file in parent folder
Keystone ks;

// defines various drawing surfaces, all pre-calibrated, to project
CornerPinSurface surface;
PGraphics offscreen;
PImage projector;

// New Application Window Parameters
PFrameI proj2D = null; // f defines window to open new applet in
projApplet applet; // applet acts as new set of setup() and draw() functions that operate in parallel

// Run Anything Needed to have Projection mapping work
void initializeProjection2D() {
  println("Projector Info: " + projectorWidth + ", " + projectorHeight + ", " + projectorOffset);
  //toggleProjection(getButtonIndex(buttonNames[21]));
}

public class PFrameI extends JFrame {
  public PFrameI() {
    setBounds(0, 0, projectorWidth, projectorHeight );
    setLocation(projectorOffset, 0);
    applet = new projApplet();
    setResizable(false);
    setUndecorated(true); 
    setAlwaysOnTop(true);
    add(applet);
    applet.init();
    show();
    setTitle("Projection2D");
  }
}

public void showProjection2D() {
  if (proj2D == null) {
    proj2D = new PFrameI();
  }
  proj2D.setVisible(true);
}

public void closeProjection2D() {
  proj2D.setVisible(false);
}

public void resetProjection2D() {
  initializeProjection2D();
  if (proj2D != null) {
    proj2D.dispose();
    proj2D = new PFrameI();
    if (displayProjection2D) {
      showProjection2D();
    } else {
      closeProjection2D();
    }
  }
}

public class projApplet extends PApplet {
  public void setup() {
    // Keystone will only work with P3D or OPENGL renderers, 
    // since it relies on texture mapping to deform
    size(projectorWidth, projectorHeight, P2D);
    
    ks = new Keystone(this);;
    
    reset();
  }
  
  public void reset() {
    surface = ks.createCornerPinSurface(TABLE_IMAGE_HEIGHT, TABLE_IMAGE_HEIGHT, 20);
    offscreen = createGraphics(TABLE_IMAGE_HEIGHT, TABLE_IMAGE_HEIGHT);
    
    try{
      ks.load();
    } catch(RuntimeException e){
      println("No Keystone.xml.  Save one first if you want to load one.");
    }
  }
  
  public void draw() {
    
    // Convert the mouse coordinate into surface coordinates
    // this will allow you to use mouse events inside the 
    // surface from your screen. 
    PVector surfaceMouse = surface.getTransformedMouse();
    
    // most likely, you'll want a black background to minimize
    // bleeding around your projection area
    background(0);
    
    // Draw the scene, offscreen
    renderCanvas(offscreen, 0);
    surface.render(offscreen);
  
  }
  
  void renderCanvas(PGraphics p, int x_offset) {
    // Draw the scene, offscreen
    p.beginDraw();
    p.clear();
    p.translate(x_offset, 0);
    p.image(projector, 0, 0);
    p.endDraw();
  }
  
  void keyPressed() {
    switch(key) {
      case 'c':
        // enter/leave calibration mode, where surfaces can be warped 
        // and moved
        ks.toggleCalibration();
        break;
  
      case 'l':
        // loads the saved layout
        ks.load();
        break;
  
      case 's':
        // saves the layout
        ks.save();
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
    testProjectorOnMac = !testProjectorOnMac;
    println("Test on Mac = " + testProjectorOnMac);
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


