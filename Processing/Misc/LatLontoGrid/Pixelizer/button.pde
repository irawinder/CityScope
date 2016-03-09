// Define how many buttons are in the Main Menu and 
// what they are named by editing this String array:
String[] buttonNames = 
{
  "Next City",  // 0
  "Next Date"   // 1
};

// These Strings are for the hideMenu, formatted as arrays for Menu Class Constructor
String[] hide = {"Hide Main Menu"};
String[] show = {"Show Main Menu"};

// The result of each button click is defined here
void mouseClicked() {
  
  //Hide/Show Menu
  if(hideMenu.buttons[0].over()){  
     showMainMenu = toggle(showMainMenu);
     if (showMainMenu) {
       hideMenu.buttons[0].label = hide[0];
     } else {
       hideMenu.buttons[0].label = show[0];
     }
     println("showMainMenu = " + showMainMenu);
  }
  
  //Next City
  if(mainMenu.buttons[0].over()){  
     modeIndex = next(modeIndex, 1);
     loadData(gridU, gridV, modeIndex);
     println("Mode Index = " + modeIndex + ": " + fileName);
  }
  
  //Next Data 
  if(mainMenu.buttons[1].over()){ 
    println ("No Function!");
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
    p.text(label, x + (85-textWidth(label)/2), y + 0.6*h); //text(str, x1, y1, x2, y2) text(label, x + 5, y + 15)
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
  int w, h, vOffset;
  Menu(int w, int h, int vOffset, String[] names){
    this.names = names;
    this.w = w;
    this.h = h;
    this.vOffset = vOffset;
    
    canvas = createGraphics(w, h);
    buttons = new Button[this.names.length];
    for (int i=0; i<buttons.length; i++) {
      buttons[i] = new Button(w - 180, 10 + this.vOffset*30 + i*30, 170, 25, names[i]);
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
