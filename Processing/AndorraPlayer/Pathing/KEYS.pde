void keyPressed() {
  switch(key) {
    case 'r':
      initOD(tableCanvas);
      initPath(finderTest, A, B);
      redraw = true;
      break;
    case 'n':
      initNetwork(tableCanvas, 10, 0.55);
      initPath(finderTest, A, B);
      redraw = true;
      break;
    case 'h':
      showInfo = toggle(showInfo);
      redraw = true;
      break;
    case 'b': //toggle background between black and white
      background = toggleBW(background);
      textColor = toggleBW(textColor);
      redraw = true;
      break;
      
  }
}

boolean toggle(boolean bool) {
  if (bool) {
    return false;
  } else {
    return true;
  }
}

int toggleBW(int col) {
  if (col == 255) {
    return 0;
  } else if (col == 0) {
    return 255;
  } else {
    return 0;
  }
}
