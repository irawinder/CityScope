/*
Modified Slider class based off the Processing.org example from Ben Fry
*/
class Slider {
  //class vars
  float x;
  float y;
  float w, h;
  float initialX;
  boolean lock = false;
  float value;
  float maxwidth;
 
  //constructors
 
  //default
  Slider () {
  }
 
  Slider (float _x, float _y, float _w, float _h, float _maxwidth) {
    x=_x;
    y=_y;
    initialX = x;
    w=_w;
    h=_h;
    maxwidth = _maxwidth;
  }
 
 
  void draw() {
 
    // bad practice have all stuff done in one method...
    float left =initialX;
 
    // map value to change color..
    value = map(x, left, left + maxwidth, 120, 255);
 
 
    //set color as it changes
    color c = color(value);
    fill(c + 10);
 
    // draw base line
    rect(initialX, y, maxwidth, h);
 
    // draw knob
    if(!isOver()){
    fill(0);}
    else{
      fill(255);
    }
    rect(x,y-h/2,w, w);
 
    //get mouseInput and map it
    float my = constrain(mouseX, left, left + maxwidth - w);
    if (lock) x = my;
  }
 
  // is mouse ove knob?
  boolean isOver()
  {
    return (x+w >= mouseX) && (mouseX >= x) && (y+h >= mouseY) && (mouseY >= y-h/2);
  }
}
 
 
//end of class
