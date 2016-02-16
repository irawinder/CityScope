Button button; //refresh
Button button2; //next network
Button button3; //overview
Button button4; //invert colors
Button button7; //enable/disable pathfinding
Button button8; //next datamode 
Button button10; //new random network
Button button11; //framerate
Button button16; //editor button
Button button17; //sources
Button button18; //agents
Button button19; //traces
Button button20; //edges
Button button23; //print framerate to console
Button button24; //save layout
Button button25; //load saved layout
Button button26; //add obstacle
Button button27; //remove obstacle
Button button28; //jump vertex
Button button29; //remove vertex
Button button32; //directions
Button button33; //next obstacle


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
    fill(textColor, 180);
    noStroke();
    if(over()){
    fill(textColor, 160);
    }
    //if(click){
    //fill(#ff00ff);}
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

