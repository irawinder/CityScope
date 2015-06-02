//Static Model Colors
int riverColor  = 0xCC1d2757; // dark blue
int parkColor   = 0xCCa2d938; // green
int roadColor   = 0xCC333333; // gray
//int openColor   = 0xCC3a4d14; // green
int openColor   = 0xCC7e7f3e; // green
int bldgColor   = 0xCCe5c46b; // beige

int lightGray   = 0xCC999999; // light gray
int mediumGray  = 0xCC666666; // medium gray

// Dynamic Model Colors
int retailColor       = 0xCCff00ff; // purple
int officeColor       = 0xCCFF0000; // red
int residentialColor  = 0xCCFFFF00; // yellow
int academicColor     = 0xCC0000ff; // blue
int offColor          = 0xFF333333; // dark gray

void useFill(int use) {
  if (use == 0) {
    fill(openColor);
  } else if (use == 1) {
    fill(roadColor);
  } else if (use == 2) {
    fill(parkColor);
  } else if (use == 3) {
    fill(residentialColor);
  } else if (use == 4) {
    fill(officeColor);
  } else if (use == -1) {
    noFill();
  } else if (use == -2) {
    fill(riverColor);
  }
}

void heatFill(float heat) {
  if (heat < 0) {
    fill(lightGray);
  } else if (heat >= 0 && heat <= 1) {
    fill(255*(1-heat), 255*heat, 0);
  }
}
