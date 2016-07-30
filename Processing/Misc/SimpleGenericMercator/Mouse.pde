
      
      
// variables for Scroll Bar
int y_0;
int scroll = 0;
int scroll_0 = 0;

//Move Variables for Network
int X_0, Y_0;
int scrollX = 0;
int scrollY = 0;
int scrollX_0 = 0;
int scrollY_0 = 0;

void mousePressed() {
    X_0 = mouseX;
    Y_0 = mouseY;
}

void mouseDragged() {
    scrollX = scrollX_0 + mouseX - X_0;
    scrollY = scrollY_0 + mouseY - Y_0;
}

void mouseReleased() {
    scrollX_0 = scrollX;
    scrollY_0 = scrollY;
}