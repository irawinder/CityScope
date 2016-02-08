class MenuButton{
  int x,y;
  String label;
  MenuButton(int x, int y, String label){
    this.x = x;
    this.y = y;
    this.label = label;
  }
  void draw(){
    fill(textColor, 150);
    noStroke();
    if(over()){
    fill(textColor, 170);
    }
    rect(x, y, textWidth(label) + 10, 25, 5);
    fill(background);
    text(label, x + 5, y + 15);
  }
  boolean over(){
    if(mouseX >= x && mouseY >= y && mouseX <= x + textWidth(label) && mouseY <= y + 22){
  return true;
    }
    return false;
  }
}

MenuButton menu;
MenuButton menu2;

MenuButton menu5;
MenuButton menu6; 

MenuButton menu9; 
MenuButton menu10; 

MenuButton menu21;
MenuButton menu22;

