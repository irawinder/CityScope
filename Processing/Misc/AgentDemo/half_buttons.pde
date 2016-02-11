
//HalfButton button11; 
HalfButton button12;
HalfButton button13; 
HalfButton button14; 
HalfButton button15; 

HalfButton button30;
HalfButton button31;

class HalfButton{
  int x,y;
  String label;
  HalfButton(int x, int y, String label){
    this.x = x;
    this.y = y;
    this.label = label;
  }
  void draw(){
    smooth();
    fill(textColor, 150);
    noStroke();
    if(over()){
    fill(textColor, 170);
    }
    rect(x, y, 82, 25, 5);
    fill(background);
    text(label, x + (42-textWidth(label)/2), y + 15); //text(str, x1, y1, x2, y2) text(label, x + 5, y + 15)
  }
  boolean over(){
    if(mouseX >= x  && mouseY >= y && mouseX <= x + 85  && mouseY <= y + 15){
  return true;
    }
    return false;
  }
}

