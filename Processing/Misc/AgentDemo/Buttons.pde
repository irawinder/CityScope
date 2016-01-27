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
Button button; //refresh visualization
Button button2; //Show info
Button button3; //Show/hide sinks
Button button4; //show/hide edges
Button button5; //print framerate
Button button6; //show/hide agents
Button button7; //toggle obstacles on/off
Button button8; //heatmap
Button button9; //frame based acceleration
Button button10; //time based acceleration
Button button11; //increase agent speed
Button button12; //decrease agent speed
Button button13; //obstacle editor
Button button14; //add obstacle
Button button15; //remove obstacle
Button button16; //select new obstacle
Button button17; //remove vertex
Button button18; //save locations
Button button19; //load obstacles


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

