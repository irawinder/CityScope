
HalfButton button12; //agents
HalfButton button13; //traces
HalfButton button14; //edges
HalfButton button15; //paths

HalfButton button30; //sources
HalfButton button31; //swarminfo

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
    fill(textColor, 180);
    noStroke();
    if(over()){
    fill(textColor, 160);
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
