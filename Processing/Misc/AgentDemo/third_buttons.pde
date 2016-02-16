
ThirdButton button34;
ThirdButton button35;
ThirdButton button36; 

class ThirdButton{
  int x,y;
  String label;
  ThirdButton(int x, int y, String label){
    this.x = x;
    this.y = y;
    this.label = label;
  }
  void draw(){
    smooth();
    fill(textColor, 180);
    noStroke();
    if(over()){
    fill(textColor, 160);
    }
    rect(x, y, 54, 25, 5);
    fill(background);
    text(label, x + (25-textWidth(label)/2), y + 15); //text(str, x1, y1, x2, y2) text(label, x + 5, y + 15)
  }
  boolean over(){
    if(mouseX >= x  && mouseY >= y && mouseX <= x + 54  && mouseY <= y + 15){
  return true;
    }
    return false;
  }
}
