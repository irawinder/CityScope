/*
Simple demo of a draggable slider that controls a value

Written by Nina Lutz June 2017
*/
 
Slider slider;

void setup(){
  size(600,600);
  slider = new Slider(int(width/2), int(height/2), 20, 10, 200);

}

void draw(){
  background(slider.value);
  slider.draw();

}

void mousePressed() {
  if (slider.isOver()){
      slider.lock = true;
  }
}

void mouseReleased(){
  slider.lock = false;
}
