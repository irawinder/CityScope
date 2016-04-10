
ThirdButton button34; //apply
ThirdButton button35; //ok
ThirdButton button36; //cancel

class ThirdButton{
  int x,y;
  String label;
  ThirdButton(int x, int y, String label){
    this.x = x;
    this.y = y;
    this.label = label;
  }
  void draw(PGraphics p){
    p.smooth();
    p.fill(textColor, 180);
    p.noStroke();
    if(over()){
    p.fill(textColor, 160);
    }
    p.rect(x, y, 54, 25, 5);
    p.fill(background);
    p.text(label, x + (25-textWidth(label)/2), y + 15); //text(str, x1, y1, x2, y2) text(label, x + 5, y + 15)
  }
  boolean over(){
    if(mouseX >= x  && mouseY >= y && mouseX <= x + 54  && mouseY <= y + 15){
  return true;
    }
    return false;
  }
}
