class MenuButton{
  int x,y;
  String label;
  MenuButton(int x, int y, String label){
    this.x = x;
    this.y = y;
    this.label = label;
  }
  void draw(PGraphics p){
    p.fill(textColor, 180);
    p.noStroke();
    if(over()){
    p.fill(textColor, 160);
    }
    p.rect(x, y, textWidth(label) + 10, 25, 5);
    p.fill(background);
    p.text(label, x + 5, y + 15);
  }
  boolean over(){
    if(mouseX >= x - 20 && mouseY >= y && mouseX <= x + textWidth(label) + 20 && mouseY <= y + 22){
  return true;  
    }
    return false;
  }
}

MenuButton menu; //show menu
MenuButton menu2; //hide menu

MenuButton menu5; //transparency up
MenuButton menu6; //transparency down

MenuButton menu9; //speed up 
MenuButton menu10; //slow down

MenuButton menu21; //speed up
MenuButton menu22; //slow down

