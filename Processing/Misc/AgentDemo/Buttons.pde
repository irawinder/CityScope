//Nina's Button Class; going to implement as pgraphic/pvector in main stuff soon
Button button;

class Button{
  int x,y;
  String label;
  Button(int x, int y, String label){
    this.x = x;
    this.y = y;
    this.label = label;
  }
  void draw(PGraphics p){
    p.fill(200);
    if(over()){
    p.fill(255);
    }
    p.rect(x, y, textWidth(label) + 10, 25);
    p.fill(0);
    p.text(label, x + 5, y + 20);
  }
  boolean over(){
    if(mouseX >= x && mouseY >= y && mouseX <= x + textWidth(label) && mouseY <= y + 22){
  return true;
    }
    return false;
  }
}
