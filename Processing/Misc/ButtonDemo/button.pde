/* ButtonDemo is a script that shows the basic framework for implementing, aligning, and hiding buttons in Processing.
 * It was largely written by Nina Lutz for AgentDemo, but was extracted in it's simplest for by Ira Winder
 * MIT Media Lab, March 2016
 */
 
// Define how many buttons are in the Main Menu and 
// what they are named by editing this String array:
String[] buttonNames = 
{
  "Align Left (l)",    // 0
  "Align Right (r)",   // 1
  "Align Center (c)",  // 2
  "Invert Colors (i)"  // 3
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
  
  //function0
  if(mainMenu.buttons[0].over()){  
    alignLeft();
  }
  
  //function1
  if(mainMenu.buttons[1].over()){ 
    alignRight();
  }
  
  //function2
  if(mainMenu.buttons[2].over()){ 
    alignCenter();
  }
  
  //function3
  if(mainMenu.buttons[3].over()){ 
    invertColors();
  }
}

void keyPressed() {
  switch(key) {
    case 'h': // "Hide Main Menu (h)"
      toggleMainMenu();
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
    case 'i': // "Invert Colors (i)"  // 3
      invertColors();
      break;
  }
}

void toggleMainMenu() {
  showMainMenu = toggle(showMainMenu);
  if (showMainMenu) {
    hideMenu.buttons[0].label = hide[0];
  } else {
    hideMenu.buttons[0].label = show[0];
  }
  println("showMainMenu = " + showMainMenu);
}

void alignLeft() {
  align = "LEFT";
  loadMenu(width, height);
  println(align);
}

void alignRight() {
  align = "RIGHT";
  loadMenu(width, height);
  println(align);
}

void alignCenter() {
  align = "CENTER";
  loadMenu(width, height);
  println(align);
}

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
  Button[] buttons;
  PGraphics canvas;
  String[] names;
  String align;
  int w, h, x, y, vOffset;
  Menu(int w, int h, int x, int y, int vOffset, String[] names, String align){
    this.names = names;
    this.w = w;
    this.h = h;
    this.vOffset = vOffset;
    this.align = align;
    this.x = x;
    this.y = y;
    
    canvas = createGraphics(w, h);
    buttons = new Button[this.names.length];
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
    }
  }
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
