// Key Commands:
//
//   Data Navigation
//     'D' = Next Data Mode
//         dataMode = 1 for random network
//         dataMode = 0 for empty network and Pathfinder Test OD
//
//   Rendering:
//     '{' - decrease alpha for translucent graphics
//     '}' - increase alpha for translucent graphics
//    case 'b': Toggle Background color black/white
//----AGENT MODE 
Button button; 
Button button2; 
Button button3; 
Button button4;
Button button5; 
Button button6; 
Button button7;
Button button8;
Button button9; 
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
Button button21;
Button button22;
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
    fill(200);
    noStroke();
    if(over()){
    fill(255);
    }
    rect(x, y, textWidth(label) + 10, 25);
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

