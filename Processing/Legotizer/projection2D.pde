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

// For any given setup, please update these dimensions, in pixels
//
// Example TSV Format:
//
//  width   height  offset
//  1920    1080    1280

import javax.swing.JFrame;
import deadpixel.keystone.*;

// Visualization may show 2D projection visualization, or not
boolean displayProjection2D = false;

// defines Keystone settings from xml file in parent folder
Keystone ks;

// defines various drawing surfaces, all pre-calibrated, to project
CornerPinSurface[] surface;
PGraphics offscreen;

// New Application Window Parameters
PFrame proj2D = null; // f defines window to open new applet in
projApplet s; // s acts as new set of setup() and draw() functions that operate in parallel

public class PFrame extends JFrame {
  public PFrame() {
    setBounds(0, 0, projectorWidth, projectorHeight );
    setLocation(projectorOffset, 0);
    s = new projApplet();
    setResizable(false);
    setUndecorated(true); 
    setAlwaysOnTop(true);
    add(s);
    s.init();
    show();
    setTitle("Projection2D");
  }
}


String projectorPath = "projector.tsv";
Table projector;
int projectorWidth, projectorHeight, projectorOffset; 

void initializeProjection2D() {
  projector = loadTable(legotizer_data + demoPrefix + demos[vizMode] + projectorPath, "header");
  projectorWidth  = projector.getInt(0, "width");   // Projector Width in Pixels
  projectorHeight = projector.getInt(0, "height");  // Projector Height in Pixels
  projectorOffset = projector.getInt(0, "offset");  // If multiple screens stacked horizontally, 'offset' specifies number of, pixels to the right before projector screen begins
  
  loadProjectorLocation();
  
  println("Projector Info: " + projectorWidth + ", " + projectorHeight + ", " + projectorOffset);
}

void loadProjectorLocation(){
  //Projector location (relative to table grid origin)
  projU  = projector.getInt(0, "U"); // Projector U Location (4LU units)
  projV = projector.getInt(0, "V");  // Projector V Location (4LU units)
  projH = projector.getInt(0, "H");  // Projector Height (4LU units)
}

void saveProjectorLocation(){
  projector.setInt(0, "U", (int)projU);  // Projector U Location (4LU units)
  projector.setInt(0, "V", (int)projV);  // Projector V Location (4LU units)
  projector.setInt(0, "H", (int)projH);  // Projector Height (4LU units)
  
  saveTable(projector, legotizer_data + demoPrefix + demos[vizMode] + "projector.tsv");
}

public void showProjection2D() {
  if (proj2D == null) {
    proj2D = new PFrame();
  }
  proj2D.setVisible(true);
}

public void closeProjection2D() {
  proj2D.setVisible(false);
}

public void resetProjection2D() {
  if (proj2D != null) {
    proj2D.dispose();
    proj2D = new PFrame();
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
    
    ks = new Keystone(this);
    surface = new CornerPinSurface[1];
    surface[0] = ks.createCornerPinSurface(plan.width, plan.height, 20);
    
    // We need an offscreen buffer to draw the surface we
    // want projected
    // note that we're matching the resolution of the
    // CornerPinSurface.
    // (The offscreen buffer can be P2D or P3D)
    offscreen = createGraphics(plan.width, plan.height);
    
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
    PVector surfaceMouse = surface[0].getTransformedMouse();
    
    // Draw the scene, offscreen
    offscreen.beginDraw();
    offscreen.background(#0000FF);
    //offscreen.blendMode(MULTIPLY);
    offscreen.fill(0, 255, 0);
    offscreen.ellipse(surfaceMouse.x, surfaceMouse.y, 75, 75);
    offscreen.image(planImage, 0, 0);
    offscreen.endDraw();
  
    // most likely, you'll want a black background to minimize
    // bleeding around your projection area
    background(0);
   
    // render the scene, transformed using the corner pin surface
    surface[0].render(offscreen);
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


