class Menu{
  ArrayList<Button>buttons = new ArrayList<Button>();
  
  boolean show;
  
  Menu(){
  }
  
  Menu(ArrayList<Button>_buttons){
    buttons = _buttons;
  }
  
  void draw(){
    for(int i = 0; i<buttons.size(); i++){
        buttons.get(i).Draw();
    }
  }
}
