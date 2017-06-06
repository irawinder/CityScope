/*
Cleaner and more advanced Button and Menu class implemented by Nina Lutz

Includes support for various colors and image buttons
*/

PImage icon;
Menu menu1, menu2;
ArrayList<Button>buttons = new ArrayList<Button>();
void setup(){
  icon = loadImage("mail.png");
  size(800, 800);
  for(int i = 0; i<5; i++){
    Button button = new Button(100 + i*40, 50 , 30, 20, "HI", color(i*50, i*20, 225), color(255));
    buttons.add(button);
  }
  menu1 = new Menu(buttons);
  
  menu2 = new Menu();
  Button imageButton = new Button(width/2, height/2, 100, 100, icon);
  menu2.buttons.add(imageButton);
}

void draw(){
  background(244);
  
  //you could use bools to hide and show menus
  menu1.draw();
  menu2.draw();
}


void mouseClicked(){
for(int i =0; i<menu1.buttons.size(); i++){
  if(menu1.buttons.get(i).MouseIsOver()){
    menu1.buttons.get(i).pressed = !menu1.buttons.get(i).pressed; //you could also do a one time press trigger or use certain button presses for different bools
     println("Hi I was pressed!");
  }
}

for(int i =0; i<menu2.buttons.size(); i++){
  if(menu2.buttons.get(i).MouseIsOver()){
    menu2.buttons.get(i).pressed = !menu1.buttons.get(i).pressed;
    println("Hi I was pressed!");
  }
}

}


