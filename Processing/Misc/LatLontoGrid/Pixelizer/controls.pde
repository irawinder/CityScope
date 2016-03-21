// Define the ORDER of the buttons by changing this array
// May only be a subset of buttonNames[]
// May include "VOID" if you which to leave a gap between menu buttons
String[] menuOrder = 
{
  "Next City (n)",
  "VOID",
  "2km per pixel (3)",
  "1km per pixel (2)",
  "500m per pixel (1)",
  "Recenter Grid (R)",
  "VOID",
  "Store Locations (s)",
  "VOID",
  "Show Delivery Data (D)",
  "Delivery Counts (d)",
  "Tote Counts (t)",
  "Store Source (o)",
  "Avg Doorstep Time (a)",
  "VOID",
  "Show Population Data (P)",
  "Population Counts (u)",
  "Household Counts (e)",
  "VOID",
  "Show Basemap (m)",
  "Invert Colors (i)",
  "Show Framerate (f)",
  "Print Screenshot (p)"
};

// Define how many button of which type in this array
// DO NOT CHANGE THE ORDER OF THESE NAMES!
String[] buttonNames = 
{
  "Next City (n)",           // 0
  "Print Screenshot (p)",    // 1
  "Delivery Counts (d)",     // 2
  "Tote Counts (t)",         // 3
  "Store Source (o)",        // 4
  "Avg Doorstep Time (a)",   // 5
  "Store Locations (s)",     // 6
  "Align Left (l)",          // 7
  "Align Right (r)",         // 8
  "Align Center (c)",        // 9
  "Invert Colors (i)",       // 10
  "2km per pixel (3)",       // 11
  "1km per pixel (2)",       // 12
  "500m per pixel (1)",      // 13
  "Show Basemap (m)",        // 14
  "Show Framerate (f)",      // 15
  "Show Delivery Data (D)",  // 16
  "Show Population Data (P)",// 17
  "Population Counts (u)",   // 18
  "Household Counts (e)",    // 19
  "Recenter Grid (R)",       // 20
};

int getButtonIndex(String name) {
  for(int i=0; i<menuOrder.length; i++) {
    if (menuOrder[i].equals(name)) {
      return i;
    }
  }
  return 1;
}

// These Strings are for the hideMenu, formatted as arrays for Menu Class Constructor
String[] hide = {"Hide Main Menu (h)"};
String[] show = {"Show Main Menu (h)"};

// The result of each button click is defined here
void mouseClicked() {
  
  if (!buttonHovering) {
    selectionU = mouseToU();
    selectionV = mouseToV();
  }
  
  //Hide/Show Menu
  if(hideMenu.buttons[0].over()){  
    toggleMainMenu();
  }
  
  
  // Main Menu Functions:
  
  //function0
  if(mainMenu.buttons[getButtonIndex(buttonNames[0])].over()){  
    nextModeIndex();
  }
  
  //function1
  if(mainMenu.buttons[getButtonIndex(buttonNames[1])].over()){ 
    printScreen();
  }

  //function2
  if(mainMenu.buttons[getButtonIndex(buttonNames[2])].over()){  
    setDeliveries(getButtonIndex(buttonNames[2]));
  }
  
  //function3
  if(mainMenu.buttons[getButtonIndex(buttonNames[3])].over()){  
    setTotes(getButtonIndex(buttonNames[3]));
  }
  
  //function4
  if(mainMenu.buttons[getButtonIndex(buttonNames[4])].over()){  
    setSource(getButtonIndex(buttonNames[4]));
  }
  
  //function5
  if(mainMenu.buttons[getButtonIndex(buttonNames[5])].over()){  
    setDoorstep(getButtonIndex(buttonNames[5]));
  }
  
  //function6
  if(mainMenu.buttons[getButtonIndex(buttonNames[6])].over()){  
    setStores(getButtonIndex(buttonNames[6]));
  }
  
  //function7
  if(mainMenu.buttons[getButtonIndex(buttonNames[7])].over()){  
    alignLeft();
  }
  
  //function8
  if(mainMenu.buttons[getButtonIndex(buttonNames[8])].over()){ 
    alignRight();
  }
  
  //function9
  if(mainMenu.buttons[getButtonIndex(buttonNames[9])].over()){ 
    alignCenter();
  }
  
  //function10
  if(mainMenu.buttons[getButtonIndex(buttonNames[10])].over()){ 
    invertColors();
  }
  
  //function11
  if(mainMenu.buttons[getButtonIndex(buttonNames[11])].over()){ 
    setGridSize(2.0, getButtonIndex(buttonNames[11]));
  }
  
  //function12
  if(mainMenu.buttons[getButtonIndex(buttonNames[12])].over()){ 
    setGridSize(1.0, getButtonIndex(buttonNames[12]));
  }
  
  //function13
  if(mainMenu.buttons[getButtonIndex(buttonNames[13])].over()){ 
    setGridSize(0.5, getButtonIndex(buttonNames[13]));
  }
  
  //function14
  if(mainMenu.buttons[getButtonIndex(buttonNames[14])].over()){ 
    toggleBaseMap(getButtonIndex(buttonNames[14]));
  }
  
  //function15
  if(mainMenu.buttons[getButtonIndex(buttonNames[15])].over()){ 
    toggleFramerate(getButtonIndex(buttonNames[15]));
  }
  
  //function16
  if(mainMenu.buttons[getButtonIndex(buttonNames[16])].over()){ 
    toggleDeliveryData(getButtonIndex(buttonNames[16]));
  }
  
  //function17
  if(mainMenu.buttons[getButtonIndex(buttonNames[17])].over()){ 
    togglePopulationData(getButtonIndex(buttonNames[17]));
  }
  
  //function18
  if(mainMenu.buttons[getButtonIndex(buttonNames[18])].over()){ 
    setPop(getButtonIndex(buttonNames[18]));
  }
  
  //function19
  if(mainMenu.buttons[getButtonIndex(buttonNames[19])].over()){ 
    setHousing(getButtonIndex(buttonNames[19]));
  }
  
  //function20
  if(mainMenu.buttons[getButtonIndex(buttonNames[20])].over()){ 
    setGridParameters();
  }
  
  reRender();
}

void keyPressed() {
  switch(key) {
    case 'h': // "Hide Main Menu (h)"     // 0
      toggleMainMenu();
      break;
      
    case 'n': // "Next City (n)"          // 0
      nextModeIndex();
      break;
    case 'p': // "Print Screenshot (p)"   // 1
      printScreen();
      break;
  
    case 'd': // "Delivery Counts (d)",   // 2
      setDeliveries(getButtonIndex(buttonNames[2]));
      break;
    case 't': // "Tote Counts (t)",       // 3
      setTotes(getButtonIndex(buttonNames[3]));
      break;
    case 'o': // "Store Source (o)",      // 4
      setSource(getButtonIndex(buttonNames[4]));
      break;
    case 'a': // "Avg Doorstep Time (a)"  // 5
      setDoorstep(getButtonIndex(buttonNames[5]));
      break;
      
    case 's': // "Store Locations (s)"    // 6
      setStores(getButtonIndex(buttonNames[6]));
      break;
      
    case 'l': // "Align Left (l)",        // 7
      alignLeft();
      break;
    case 'r': // "Align Right (r)"        // 8
      alignRight();
      break;
    case 'c': // "Align Center (c)"       // 9
      alignCenter();
      break;
    case 'i': // "Invert Colors (i)"      // 10
      invertColors();
      break;
  
    case '3': // "2km per pixel",         // 11
      setGridSize(2.0, getButtonIndex(buttonNames[11]));
      break;
    case '2': // "1km per pixel",         // 12
      setGridSize(1.0, getButtonIndex(buttonNames[12]));
      break;
    case '1': // "500m per pixel",        // 13
      setGridSize(0.5, getButtonIndex(buttonNames[13]));
      break;
      
    case 'm': // "Show Map (m)",          // 14
      toggleBaseMap(getButtonIndex(buttonNames[14]));
      break;
    case 'f': // "Show Framerate" (f)",   // 15
      toggleFramerate(getButtonIndex(buttonNames[15]));
      break;
    case 'D': // "Show Delivery Data (D)",  // 16
      toggleDeliveryData(getButtonIndex(buttonNames[16]));
      break;
    case 'P': // "Show Population Data (P)",  // 17
      togglePopulationData(getButtonIndex(buttonNames[17]));
      break;
    case 'u': // "Population Counts (u)",   // 18
      setPop(getButtonIndex(buttonNames[18]));
      break;
    case 'e': // "Household Counts (e)",    // 19
      setHousing(getButtonIndex(buttonNames[19]));
      break;
    case 'R': //  "Recenter Grid (R)",      // 20
      setGridParameters();
      break;
  }
  
  //------arrow keys and how to code keys that aren't characters exactly----- 
  if (key == CODED) { 
    if (keyCode == LEFT) {
      gridPanU++;
    }  
    if (keyCode == RIGHT) {
      gridPanU--;
    }  
    if (keyCode == DOWN) {
      gridPanV--;
    }  
    if (keyCode == UP) {
      gridPanV++;
    }
  }
  
  reRender();
}

// variables for Scroll Bar
int y_0, x_0;
int scroll_y = 0;
int scroll_x = 0;
int scroll_y_0 = 0;
int scroll_x_0 = 0;
int selectionU = gridU/2;
int selectionV = gridV/2;
boolean panChange = false;

void resetMousePan() {
  scroll_y = 0;
  scroll_x = 0;
  scroll_y_0 = 0;
  scroll_x_0 = 0;
  selectionU = gridU/2;
  selectionV = gridV/2;
}

void mousePressed() {
  x_0 = mouseX;
  y_0 = mouseY;
}

void mouseDragged() {
  scroll_x = scroll_x_0 + mouseX - x_0;
  scroll_y = scroll_y_0 + mouseY - y_0;
  
  if (gridPanU != - int(scroll_x*((float)displayU/width)) + (gridU-displayU)/2) {
    gridPanU = - int(scroll_x*((float)displayU/width)) + (gridU-displayU)/2;
    panChange = true;
  }
  
  if (gridPanV != - int(scroll_y*((float)displayV/height)) + (gridV-displayV)/2) {
    gridPanV = - int(scroll_y*((float)displayV/height)) + (gridV-displayV)/2;
    panChange = true;
  }
  
  // On ReRenders if pan direction is changed
  if (panChange) {
  reRender();
  panChange = false;
  }
  
}

void mouseReleased() {
  scroll_x_0 = scroll_x;
  scroll_y_0 = scroll_y;
}

// Show or Hide Main Menu Items 
void toggleMainMenu() {
  showMainMenu = toggle(showMainMenu);
  if (showMainMenu) {
    hideMenu.buttons[0].label = hide[0];
  } else {
    hideMenu.buttons[0].label = show[0];
  }
  println("showMainMenu = " + showMainMenu);
}

// Loads Next Data Set
void nextModeIndex() {
  modeIndex = next(modeIndex, 1);
  loadData(gridU, gridV, modeIndex);
  renderMiniMap(miniMap);
  println("Mode Index = " + modeIndex + ": " + fileName);
}

// Prints Screen to File
void printScreen() {
  String location = "export/" + fileName + "_" + int(gridSize*1000) + ".png";
  save(location);
  println("File saved to " + location);
}

void setDeliveries(int button) {
  valueMode = "deliveries";
  depressHeatmapButtons();
  loadData(gridU, gridV, modeIndex);
  renderMiniMap(miniMap);
  println("valueMode: " + valueMode);
}

void setTotes(int button) {
  valueMode = "totes";
  depressHeatmapButtons();
  loadData(gridU, gridV, modeIndex);
  renderMiniMap(miniMap);
  println("valueMode: " + valueMode);
}

void setSource(int button) {
  valueMode = "source";
  depressHeatmapButtons();
  loadData(gridU, gridV, modeIndex);
  renderMiniMap(miniMap);
  println("valueMode: " + valueMode);
}

void setDoorstep(int button) {
  valueMode = "doorstep";
  depressHeatmapButtons();
  loadData(gridU, gridV, modeIndex);
  renderMiniMap(miniMap);
  println("valueMode: " + valueMode);
}

void setStores(int button) {
  showStores = toggle(showStores);
  pressButton(showStores, button);
  renderMiniMap(miniMap);
  println("showStores: " + showStores);
}

void setPop(int button) {
  popMode = "POP10";
  depressPopulationButtons();
  loadData(gridU, gridV, modeIndex);
  renderMiniMap(miniMap);
  println("popMode: " + popMode);
}

void setHousing(int button) {
  popMode = "HOUSING10";
  depressPopulationButtons();
  loadData(gridU, gridV, modeIndex);
  renderMiniMap(miniMap);
  println("popMode: " + popMode);
}

void setGridSize(float size, int button) {
  gridSize = size;
  setGridParameters();
  depressZoomButtons(size);
  loadData(gridU, gridV, modeIndex);
  miniMap = createGraphics(gridU, gridV);
  renderMiniMap(miniMap);
  println("gridSize: " + gridSize + "km");
}

void toggleBaseMap(int button) {
  showBasemap = toggle(showBasemap);
  renderMiniMap(miniMap);
  pressButton(showBasemap, button);
  println("showBasemap = " + showBasemap);
} 

void toggleFramerate(int button) {
  showFrameRate = toggle(showFrameRate);
  pressButton(showFrameRate, button);
  println("showFrameRate = " + showFrameRate);
} 

void toggleDeliveryData(int button) {
  showDeliveryData = toggle(showDeliveryData);
  renderMiniMap(miniMap);
  pressButton(showDeliveryData, button);
  println("showDeliveryData = " + showDeliveryData);
  
  if (!showDeliveryData) {
    for (int i=2; i<=5; i++) {
      mainMenu.buttons[getButtonIndex(buttonNames[i])].show = false;
    }
  } else {
    for (int i=2; i<=5; i++) {
      mainMenu.buttons[getButtonIndex(buttonNames[i])].show = true;
    }
  }
} 

void togglePopulationData(int button) {
  showPopulationData = toggle(showPopulationData);
  renderMiniMap(miniMap);
  pressButton(showPopulationData, button);
  println("showPopulationData = " + showPopulationData);
  
  if (!showPopulationData) {
    for (int i=18; i<=19; i++) {
      mainMenu.buttons[getButtonIndex(buttonNames[i])].show = false;
    }
  } else {
    for (int i=18; i<=19; i++) {
      mainMenu.buttons[getButtonIndex(buttonNames[i])].show = true;
    }
  }
} 

void pressButton(boolean bool, int button) {
  if (bool) {
    mainMenu.buttons[button].isPressed = false;
  } else {
    mainMenu.buttons[button].isPressed = true;
  }
}

// Presses all buttons in a set of mutually exclusive buttons except for the index specified
// min-max specifies a range of button indices; valueMode specifies the currently selected button
void depressHeatmapButtons() {
  
  int min = getButtonIndex(buttonNames[2]);
  int max = getButtonIndex(buttonNames[5]);
  
  int button = min;
  if (valueMode.equals("deliveries")) {
    button += 0;
  } else if (valueMode.equals("totes")) {
    button += 1;
  } else if (valueMode.equals("source")) {
    button += 2;
  } else if (valueMode.equals("doorstep")) {
    button += 3;
  }
  
  // Turns all buttons off
  for(int i=min; i<=max; i++) { //heatmap buttons min-max are mutually exclusive
    mainMenu.buttons[i].isPressed = true;
  }
  // highlighted the heatmap button that is activated only
  mainMenu.buttons[button].isPressed = false;
}

// Presses all buttons in a set of mutually exclusive buttons except for the index specified
// min-max specifies a range of button indices; valueMode specifies the currently selected button
void depressPopulationButtons() {
  
  int min = getButtonIndex(buttonNames[18]);
  int max = getButtonIndex(buttonNames[19]);
  
  int button = min;
  if (popMode.equals("POP10")) {
    button += 0;
  } else if (popMode.equals("HOUSING10")) {
    button += 1;
  }
  
  // Turns all buttons off
  for(int i=min; i<=max; i++) { //heatmap buttons min-max are mutually exclusive
    mainMenu.buttons[i].isPressed = true;
  }
  // highlighted the heatmap button that is activated only
  mainMenu.buttons[button].isPressed = false;
}

// Presses all buttons withinin a set of mutually exclusive buttons except for the index specified
// min-max specifies a range of button indices; size specifies the currently selected button
void depressZoomButtons(float size) {
  
  int min = getButtonIndex(buttonNames[11]);
  int max = getButtonIndex(buttonNames[13]);
  
  int button = min;
  if (size == 2) {
    button += 0;
  } else if (size == 1) {
    button += 1;
  } else if (size == 0.5) {
    button += 2;
  }
  
  // Turns all buttons off
  for(int i=min; i<=max; i++) { //heatmap buttons min-max are mutually exclusive
    mainMenu.buttons[i].isPressed = true;
  }
  // highlighted the heatmap button that is activated only
  mainMenu.buttons[button].isPressed = false;
}

// Aligns Menue to Left
void alignLeft() {
  align = "LEFT";
  loadMenu(screen.width, screen.height);
  println(align);
}

// Aligns Menue to Right
void alignRight() {
  align = "RIGHT";
  loadMenu(screen.width, screen.height);
  println(align);
}

// Aligns Menue to Center
void alignCenter() {
  align = "CENTER";
  loadMenu(screen.width, screen.height);
  println(align);
}

// Inverts background and text colors
void invertColors() {
  if (background == 0) {
    background = 255;
    textColor = 0;
    mapColor = "color";
    loadBasemap();
  } else {
    background = 0;
    textColor = 255;
    mapColor = "bw";
    loadBasemap();
  }
  renderMiniMap(miniMap);
  println ("background: " + background + ", textColor: " + textColor);
}

// iterates an index parameter
int next(int index, int max) {
  if (index == max) {
    index = 0;
  } else {
    index ++;
  }
  return index;
}

// flips a boolean
boolean toggle(boolean bool) {
  if (bool) {
    return false;
  } else {
    return true;
  }
}

boolean buttonHovering = false;

class Button{
  // variables describing upper left corner of button, width, and height in pixels
  int x,y,w,h;
  // String of the Button Text
  String label;
  // Various Shades of button states (0-255)
  int active  = 180; // lightest
  int hover   = 160;
  int pressed = 120; // darkest
  
  boolean isPressed = false;
  boolean isVoid = false;
  boolean show = true;
  
  //Button Constructor
  Button(int x, int y, int w, int h, String label){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
  }
  
  //Button Objects are draw to a PGraphics object rather than directly to canvas
  void draw(PGraphics graphic){
    if (!isVoid) {
      graphic.smooth();
      graphic.noStroke();
      if( over() ) {  // Darkens button if hovering mouse over it
        graphic.fill(textColor, hover);
        buttonHovering = true;
      } else if (isPressed){
        graphic.fill(textColor, pressed);
      } else {
        graphic.fill(textColor, active);
      }
      graphic.rect(x, y, w, h, 5);
      graphic.fill(background);
      graphic.text(label, x + (w/2-textWidth(label)/2), y + 0.6*h); //text(str, x1, y1, x2, y2) text(label, x + 5, y + 15)
    }
  } 
  
  // returns true if mouse hovers in button region
  boolean over(){
    if(mouseX >= x  && mouseY >= y && mouseX <= x + w && mouseY <= y + 2 + h){
      return true;
    } else {
      return false;
    }
  }
}

class Menu{
  // Button Array Associated with this Menu
  Button[] buttons;
  // Graphics Object to Draw this Menu
  PGraphics canvas;
  // Button Name Array Associated with Menu
  String[] names;
  // Menu Alignment
  String align;
  // variables describing screenWidth, screenHeight, Button Width, Button Height, Verticle Displacement (#buttons down)
  int w, h, x, y, vOffset;
  
  //Constructor
  Menu(int w, int h, int x, int y, int vOffset, String[] names, String align){
    this.names = names;
    this.w = w;
    this.h = h;
    this.vOffset = vOffset;
    this.align = align;
    this.x = x;
    this.y = y;
    
    canvas = createGraphics(w, h);
    // #Buttons defined by Name String Array Length
    buttons = new Button[this.names.length];
    
    // Initializes the button objects
    for (int i=0; i<buttons.length; i++) {
      if ( this.align.equals("right") || this.align.equals("RIGHT") ) {
        // Right Align
        buttons[i] = new Button(this.w - this.x - tablex_0, tabley_0 + this.vOffset*(this.y+5) + i*(this.y+5), this.x, this.y, this.names[i]);
      } else if ( this.align.equals("left") || this.align.equals("LEFT") ) { 
        // Left Align
        buttons[i] = new Button(tablex_0, tabley_0 + this.vOffset*(this.y+5) + i*(this.y+5), this.x, this.y, names[i]);
      } else if ( this.align.equals("center") || this.align.equals("CENTER") ) { 
        // Center Align
        buttons[i] = new Button( (this.w-this.x)/2, tabley_0 + this.vOffset*(this.y+5) + i*(this.y+5), this.x, this.y, this.names[i]);
      }
      
      // Alows a menu button spacer to be added by setting its string value to "VOID"
      if (this.names[i].equals("void") || this.names[i].equals("VOID") ) {
        buttons[i].isVoid = true;
      }
    }
  }
  
  // Draws the Menu to its own PGraphics canvas
  void draw(PGraphics graphic) {
    canvas.beginDraw();
    canvas.clear();
    for (int i=0; i<buttons.length; i++) {
      if (buttons[i].show) {
        buttons[i].draw(canvas);
      }
    }
    canvas.endDraw();
    
    graphic.image(canvas, 0, 0);
  }
}
