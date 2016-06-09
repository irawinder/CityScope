/* ButtonDemo is a script that shows the basic framework for implementing buttons in Processing.
 * It was largely written by Nina Lutz for AgentDemo, but was extracted in it's simplest for by Ira Winder
 * MIT Media Lab, March 2016
 */

// Library needed for ComponentAdapter()
import java.awt.event.*;

// Class that holds a button menu
Menu mainMenu, hideMenu;

// Global Text and Background Color
int textColor = 255;
int background = 0;

// Menu Alignment on Screen
String align = "RIGHT";

// Set this to true to display the main menue upon start
boolean showMainMenu = true;

void setup() {
  size(500, 500);
  
  // Window may be resized after initialized
  frame.setResizable(true);
  
  // Recalculates relative positions of canvas items if screen is resized
  frame.addComponentListener(new ComponentAdapter() { 
     public void componentResized(ComponentEvent e) { 
       if(e.getSource()==frame) { 
         loadMenu(width, height);
       } 
     } 
   }
   );
  
  // Loads and formats menue items
  loadMenu(width, height);
}

void loadMenu(int canvasWidth, int canvasHeight) {
  // Initializes Menu Items (canvas width, canvas height, button width[pix], button height[pix], 
  // number of buttons to offset downward, String[] names of buttons)
  hideMenu = new Menu(canvasWidth, canvasHeight, 170, 25, 0, hide, align);
  mainMenu = new Menu(canvasWidth, canvasHeight, 170, 25, 2, buttonNames, align);
}

void draw() {
  background(background);
  
  // Draws Menu
  hideMenu.draw();
  if (showMainMenu) {
    mainMenu.draw();
  }
}
  
