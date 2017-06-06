class LightBar{
  int x, y;
  float w, h;
  color c1, c2,c3;
  
  LightBar(int _x, int _y, float _w, float _h, color _c1, color _c2, color _c3){
    x = _x;
    y = _y; 
    w = _w;
    h = _h;
    c1 = _c1;
    c2 = _c2;
    c3 = _c3;
  }
  
  public boolean isOver(){
    if(mouseX < x + 2*w && mouseX > x && mouseY < y + h && mouseY > y){
      return true;
    }
    return false;
  }
  

  
  void drawGradient() {
      pushStyle();
      colorMode(RGB);
      noFill();
      for (int i = x; i <= x+w; i++) {
        float inter = map(i, x, x+w, 0, 1);
        color c = lerpColor(c2, c1, inter);
        stroke(c);
        line(i, y, i, y+h);
      }

     for (int i = x; i <= x + w; i++) {
        float inter = map(i, x, x+w, 0, 1);
        color c = lerpColor(c1, c3, inter);
        stroke(c);
        line(i+w, y, i+w, y+h);
      }

      popStyle();
}

  
}




