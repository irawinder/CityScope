class Button {
  String label;
  float x;    // top left corner x position
  float y;    // top left corner y position
  float w;    // width of button
  float h;    // height of button
  color c;
  color CM = color(100);
  color fontcol;
  PImage icon;
  boolean pressed, imagebut;
  
  Button(float xpos, float ypos, float widthB,  float heightB, String labelB) {
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
  }
  
    Button(float xpos, float ypos, float widthB,  float heightB, String labelB, color _c) {
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
    c = _c;
    CM = _c;
  }
  
  Button(float xpos, float ypos, float widthB,  float heightB, String labelB, color _c, color _font) {
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
    c = _c;
    CM = _c;
    fontcol = _font;
  }
  
  Button(float xpos, float ypos, float widthB, float heightB, PImage image){
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
    icon = image;
    imagebut = true;
  }
  
  void Draw() {
    MouseIsOver();
    if(!imagebut){
    if(pressed){
      c = color(100);
    }
    fill(c);
    stroke(141);
    rect(x, y, w, h, 10);
    textAlign(CENTER, CENTER);
    fill(fontcol);
    text(label, x + (w / 2), y + (h / 2));
    }
    if(imagebut){
        image(icon, x, y, w, h);
    }
  }
  
  
  boolean MouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
      c = color(c, 100);
      return true;
    }
    c = color(CM);
    return false;
  }

  
}
