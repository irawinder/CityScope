import javax.swing.JFrame;
import deadpixel.keystone.*;

int projectorWidth = 1920;
int projectorHeight = 1080;
int projectorOffset = 1500;

int screenWidth = 1882;
int screenHeight = 1058;

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
PFrame proj2D = null; // f defines window to open new applet in
projApplet applet; // applet acts as new set of setup() and draw() functions that operate in parallel

// Run Anything Needed to have Projection mapping work
void initializeProjection2D() {
  println("Projector Info: " + projectorWidth + ", " + projectorHeight + ", " + projectorOffset);
  loadProjectorLocation();
}


public class PFrame extends JFrame {
  public PFrame() {
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
    proj2D = new PFrame();
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
    
    ks = new Keystone(this);;
    
    reset();
  }
  
  public void reset() {
    surface = ks.createCornerPinSurface(1000, 1000, 20);
    offscreen = createGraphics(1000, 1000);
    
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
    renderCanvas(offscreen);
    surface.render(offscreen);
  
  }
  
  void renderCanvas(PGraphics p) {
    // Draw the scene, offscreen
    p.beginDraw();
    p.clear();
    p.fill(#ff0000);
    p.ellipse(20, 20, 100, 100);
//    p.image(margin, 0, 0);
//    p.image(projector, margin.width, 0);
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


// These default values are overridden by projector.txt
float projU;
float projV;
float projH;
Table projectorLocation;

void loadProjectorLocation() {
  projectorLocation = loadTable("settings/projector.tsv", "header");
  //Projector location (relative to table grid origin)
  projU = projectorLocation.getInt(0, "U"); // Projector U Location
  projV = projectorLocation.getInt(0, "V");  // Projector V Location
  projH = projectorLocation.getInt(0, "H");  // Projector Height
}

void saveProjectorLocation() {
  projectorLocation.setInt(0, "U", (int)projU);  // Projector U Location
  projectorLocation.setInt(0, "V", (int)projV);  // Projector V Location
  projectorLocation.setInt(0, "H", (int)projH);  // Projector Height
  saveTable(projectorLocation, "settings/projector.tsv");
}

