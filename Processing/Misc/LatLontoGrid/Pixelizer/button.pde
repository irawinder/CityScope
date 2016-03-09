// Define how many buttons are in the Main Menu and 
// what they are named by editing this String array:
String[] buttonNames = 
{
  "Next City (n)",         // 0
  "Print Screenshot (p)"   // 1
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
  
  //Next City
  if(mainMenu.buttons[0].over()){  
    nextModeIndex();
  }
  
  //Print Screen Shot
  if(mainMenu.buttons[1].over()){ 
    printScreen();
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

void nextModeIndex() {
  modeIndex = next(modeIndex, 1);
  loadData(gridU, gridV, modeIndex);
  println("Mode Index = " + modeIndex + ": " + fileName);
}

void printScreen() {
  String location = "export/" + fileName + "_" + int(gridSize*1000) + ".png";
  save(location);
  println("File saved to " + location);
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
  int x,y,w,h;
  String label;
  int active  = 180;
  int hover   = 160;
  int pressed = 120;
  boolean isPressed = false;
  Button(int x, int y, int w, int h, String label){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
  }
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
  boolean over(){
    if(mouseX >= x  && mouseY >= y && mouseX <= x + 170 && mouseY <= y + 22){
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
