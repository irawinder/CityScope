PFont Helvetica;

Button button;
Button button2;

void mousePressed(){
  if(button.over()){
    println("Success.");
  }
  if(button2.over()){
    println("Wow!");
  }
}
class Button{
  int x,y;
  String label;
  Button(int x, int y, String label){
    this.x = x;
    this.y = y;
    this.label = label;
  }
  void draw(){
    fill(200);
    if(over()){
    fill(255);
    }
    rect(x, y, textWidth(label) + 10, 25);
    fill(0);
    text(label, x + 5, y + 20);
  }
  boolean over(){
    if(mouseX >= x && mouseY >= y && mouseX <= x + textWidth(label) && mouseY <= y + 22){
  return true;
    }
    return false;
  }
}
