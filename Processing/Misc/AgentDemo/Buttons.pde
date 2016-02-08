Button button; 
Button button2; 
Button button3; 
Button button4;
Button button7;
Button button8;
Button button10;
Button button11; 
Button button12; 
Button button13; 
Button button14; 
Button button15; 
Button button16;
Button button17; 
Button button18; 
Button button19;
Button button20;
Button button23;
Button button24;
Button button25;
Button button26;
Button button27;
Button button28;
Button button29;
Button button30;

class Button{
  int x,y;
  String label;
  Button(int x, int y, String label){
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
    rect(x, y, 170, 25, 5);
    fill(background);
    text(label, x + (85-textWidth(label)/2), y + 15); //text(str, x1, y1, x2, y2) text(label, x + 5, y + 15)
  }
  boolean over(){
    if(mouseX >= x  && mouseY >= y && mouseX <= x + 170 && mouseY <= y + 22){
  return true;
    }
    return false;
  }
}

