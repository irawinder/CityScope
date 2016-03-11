// Define how many buttons are in the Main Menu and 
// what they are named by editing this String array:
String[] buttonNames = 
{
  "Next City (n)",         // 0
  "Print Screenshot (p)",  // 1
  "VOID",                  // 2
  "Delivery Counts (d)",   // 3
  "Tote Counts (t)",       // 4
  "Store Source (o)",      // 5
  "Avg Doorstep Time (a)", // 6
  "VOID",                  // 7
  "Store Locations (s)",   // 8
  "VOID",                  // 9
  "Align Left (l)",        // 10
  "Align Right (r)",       // 11
  "Align Center (c)",      // 12
  "Invert Colors (i)",     // 13
  "VOID",                  // 14
  "2km per pixel (3)",     // 15
  "1km per pixel (2)",     // 16
  "500m per pixel (1)",    // 17
  "VOID",                  // 18
  "Show Basemap (m)",      // 19
};

// These Strings are for the hideMenu, formatted as arrays for Menu Class Constructor
String[] hide = {"Hide Main Menu (h)"};
String[] show = {"Show Main Menu (h)"};

// The result of each button click is defined here
void mouseClicked() {
  
  //Hide/Show Menu
  if(hideMenu.buttons[0].over()){  
    toggleMainMenu();
  }
  
  
  // Main Menu Functions:
  
  //function0
  if(mainMenu.buttons[0].over()){  
    nextModeIndex();
  }
  
  //function1
  if(mainMenu.buttons[1].over()){ 
    printScreen();
  }
  
  //function2
  if(mainMenu.buttons[2].over()){  
    //VOID
  }

  //function3
  if(mainMenu.buttons[3].over()){  
    setDeliveries(3);
  }
  
  //function4
  if(mainMenu.buttons[4].over()){  
    setTotes(4);
  }
  
  //function5
  if(mainMenu.buttons[5].over()){  
    setSource(5);
  }
  
  //function6
  if(mainMenu.buttons[6].over()){  
    setDoorstep(6);
  }
  
  //function7
  if(mainMenu.buttons[7].over()){  
    //VOID
  }
  
  //function8
  if(mainMenu.buttons[8].over()){  
    setStores(8);
  }
  
  //function10
  if(mainMenu.buttons[10].over()){  
    alignLeft();
  }
  
  //function11
  if(mainMenu.buttons[11].over()){ 
    alignRight();
  }
  
  //function12
  if(mainMenu.buttons[12].over()){ 
    alignCenter();
  }
  
  //function13
  if(mainMenu.buttons[13].over()){ 
    invertColors();
  }
  
  //function14
  if(mainMenu.buttons[14].over()){ 
    //VOID
  }
  
  //function15
  if(mainMenu.buttons[15].over()){ 
    setGridSize(2.0, 15);
  }
  
  //function16
  if(mainMenu.buttons[16].over()){ 
    setGridSize(1.0, 16);
  }
  
  //function17
  if(mainMenu.buttons[17].over()){ 
    setGridSize(0.5, 17);
  }
  
  //function18
  if(mainMenu.buttons[18].over()){ 
    //VOID
  }
  
  //function19
  if(mainMenu.buttons[19].over()){ 
    toggleBaseMap(19);
  }
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
  
    case 'd': // "Delivery Counts (d)",   // 3
      setDeliveries(3);
      break;
    case 't': // "Tote Counts (t)",       // 4
      setTotes(4);
      break;
    case 'o': // "Store Source (o)",      // 5
      setSource(5);
      break;
    case 'a': // "Avg Doorstep Time (a)"  // 6
      setDoorstep(6);
      break;
      
    case 's': // "Store Locations (s)"    // 8
      setStores(8);
      break;
      
    case 'l': // "Align Left (l)",        // 10
      alignLeft();
      break;
    case 'r': // "Align Right (r)"        // 11
      alignRight();
      break;
    case 'c': // "Align Center (c)"       // 12
      alignCenter();
      break;
    case 'i': // "Invert Colors (i)"      // 13
      invertColors();
      break;
  
    case '3': // "2km per pixel",         // 15
      setGridSize(2.0, 15);
      break;
    case '2': // "1km per pixel",         // 16
      setGridSize(1.0, 16);
      break;
    case '1': // "500m per pixel",        // 17
      setGridSize(0.5, 17);
      break;
      
    case 'm': // "Show Map (m)",          // 19
      toggleBaseMap(19);
      break;
    
    
    
  }
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
  depressHeatmapButtons(3, 6, button);
  loadData(gridU, gridV, modeIndex);
  println("valueMode: " + valueMode);
}

void setTotes(int button) {
  valueMode = "totes";
  depressHeatmapButtons(3, 6, button);
  loadData(gridU, gridV, modeIndex);
  println("valueMode: " + valueMode);
}

void setSource(int button) {
  valueMode = "source";
  depressHeatmapButtons(3, 6, button);
  loadData(gridU, gridV, modeIndex);
  println("valueMode: " + valueMode);
}

void setDoorstep(int button) {
  valueMode = "doorstep";
  depressHeatmapButtons(3, 6, button);
  loadData(gridU, gridV, modeIndex);
  println("valueMode: " + valueMode);
}

void setStores(int button) {
  showStores = toggle(showStores);
  if (!showStores) {
    mainMenu.buttons[button].isPressed = true;
  } else {
    mainMenu.buttons[button].isPressed = false;
  }
  println("showStores: " + showStores);
}

void setGridSize(float size, int button) {
  gridSize = size;
  depressHeatmapButtons(15, 17, button);
  loadData(gridU, gridV, modeIndex);
  println("gridSize: " + gridSize + "km");
}

void toggleBaseMap(int button) {
  showBasemap = toggle(showBasemap);
  if (showBasemap) {
    mainMenu.buttons[button].isPressed = false;
  } else {
    mainMenu.buttons[button].isPressed = true;
  }
  println("showBasemap = " + showBasemap);
}

// Presses all buttons in a set of mutually exclusive buttons except for the index specified
// min-max specifies a range of button indices; valueMode specifies the currently selected button
void depressHeatmapButtons(int min, int max) {
  
  int button = 3;
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
// min-max specifies a range of button indices; size specifies the currently selected button
void depressHeatmapButtons(int min, int max, float size) {
  
  int button = 15;
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

// Presses all buttons in a set of mutually exclusive buttons except for the index specified
// min-max specifies a range of button indices; "button" specifies the currently selected button
void depressHeatmapButtons(int min, int max, int button) {
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
  loadMenu(width, height);
  println(align);
}

// Aligns Menue to Right
void alignRight() {
  align = "RIGHT";
  loadMenu(width, height);
  println(align);
}

// Aligns Menue to Center
void alignCenter() {
  align = "CENTER";
  loadMenu(width, height);
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
  
  //Button Constructor
  Button(int x, int y, int w, int h, String label){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
  }
  
  //Button Objects are draw to a PGraphics object rather than directly to canvas
  void draw(PGraphics p){
    if (!isVoid) {
      p.smooth();
      p.noStroke();
      if( over() ) {  // Darkens button if hovering mouse over it
        p.fill(textColor, hover);
      } else if (isPressed){
        p.fill(textColor, pressed);
      } else {
        p.fill(textColor, active);
      }
      p.rect(x, y, w, h, 5);
      p.fill(background);
      p.text(label, x + (w/2-textWidth(label)/2), y + 0.6*h); //text(str, x1, y1, x2, y2) text(label, x + 5, y + 15)
    }
  } 
  
  // returns true if mouse hovers in button region
  boolean over(){
    if(mouseX >= x  && mouseY >= y + 5 && mouseX <= x + w && mouseY <= y + 2 + h){
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
  // variables describing canvasWidth, canvas Height, Button Width, Button Height, Verticle Displacement (#buttons down)
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
        buttons[i] = new Button(this.w - this.x - 10, 10 + this.vOffset*(this.y+5) + i*(this.y+5), this.x, this.y, this.names[i]);
      } else if ( this.align.equals("left") || this.align.equals("LEFT") ) { 
        // Left Align
        buttons[i] = new Button(10, 10 + this.vOffset*(this.y+5) + i*(this.y+5), this.x, this.y, names[i]);
      } else if ( this.align.equals("center") || this.align.equals("CENTER") ) { 
        // Center Align
        buttons[i] = new Button( (this.w-this.x)/2, 10 + this.vOffset*(this.y+5) + i*(this.y+5), this.x, this.y, this.names[i]);
      }
      
      // Alows a menu button spacer to be added by setting its string value to "VOID"
      if (this.names[i].equals("void") || this.names[i].equals("VOID") ) {
        buttons[i].isVoid = true;
      }
    }
  }
  
  // Draws the Menu to its own PGraphics canvas
  void draw() {
    canvas.beginDraw();
    canvas.clear();
    for (int i=0; i<buttons.length; i++) {
      buttons[i].draw(canvas);
    }
    canvas.endDraw();
    
    image(canvas, 0, 0);
  }
}
