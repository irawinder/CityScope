/*class ButtonPlus{
  int x,y;
  String label;
  ButtonPlus(int x, int y, String label){
    this.x = x;
    this.y = y;
    this.label = label;
  }
  void draw(){
    fill(200, 190);
    noStroke();
    if(over()){
    fill(255, 130);
    }
    rect(x, y, textWidth(label) + 10, 25, 5);
    fill(0);
    text(label, x + 5, y + 15);
  }
  boolean over(){
    if(mouseX >= x && mouseY >= y && mouseX <= x + textWidth(label) && mouseY <= y + 22){
  return true;
    }
    return false;
  }
}


ButtonPlus button9; 
ButtonPlus button10; 

ButtonPlus button21;
ButtonPlus button22;
*/
