// Define how many buttons are in the Main Menu and 
// what they are named by editing this String array:
String[] buttonNames = 
{
  "Next City (n)",         // 0
  "Print Screenshot (p)",  // 1
  "VOID",                  // 2
  "Align Left (l)",        // 3
  "Align Right (r)",       // 4
  "Align Center (c)",      // 5
  "Invert Colors (i)"      // 6
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
  
  //function3
  if(mainMenu.buttons[3].over()){  
    alignLeft();
  }
  
  //function4
  if(mainMenu.buttons[4].over()){ 
    alignRight();
  }
  
  //function5
  if(mainMenu.buttons[5].over()){ 
    alignCenter();
  }
  
  //function6
  if(mainMenu.buttons[6].over()){ 
    invertColors();
  }
}

void keyPressed() {
  switch(key) {
    case 'h': // "Hide Main Menu (h)"
      toggleMainMenu();
      break;
      
    case 'n': // "Next City (n)"
      nextModeIndex();
      break;
    case 'p': // "Print Screenshot (p)"
      printScreen();
      break;
      
    case 'l': // "Align Left (l)",   // 0
      alignLeft();
      break;
    case 'r': // "Align Right (r)"   // 1
      alignRight();
      break;
    case 'c': // "Align Center (c)"  // 2
      alignCenter();
      break;
    case 'i': // "Invert Colors (i)"  // 4
      invertColors();
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
  } else {
    background = 0;
    textColor = 255;
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
      if (isPressed){
        p.fill(textColor, pressed);
      } else if( over() ) {  // Darkens button if hovering mouse over it
        p.fill(textColor, hover);
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
