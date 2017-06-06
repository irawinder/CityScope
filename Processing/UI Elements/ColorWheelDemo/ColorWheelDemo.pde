/**
 * Draw a circular array of colored rectangles, displaying the full range
 * of hues.
 *
 */

final static float kCircleRadius = 50.0;
final static int   kNumRectangles = 300;
final static float kRectLength = 100.0;
final static float kRectWidth = (TWO_PI * kCircleRadius / (float)kNumRectangles) - 5;
final static int   kLabelSize = 28;


ColorWheel wheel, wheelC;
color centerColor = color(255, 0, 0);
float hue = 0.0;   // 0 - 360

color barColorC = color(100);

PGraphics wheelDraw;

color barColor;
PVector origin;
float xc, yc;

PImage eraserIcon, mailIcon;

void setup() {
   size(displayWidth-50, displayHeight-100);
   xc = width/2;
   yc = height/2;
   wheelC = new ColorWheel(xc, yc, kCircleRadius, kNumRectangles, kRectWidth, kRectLength);
}

boolean notStarted = true;

void draw() {
 background(color(barColorC));
  wheelC.draw();
  fill(0);
  
  pushStyle();
  // Change the hue of the center area depending on mouse position
  if ( wheelC.isMouseInRectangle() ) {
    float mouseAngle = wheelC.getMouseAngle();
    hue = map(mouseAngle, 0.0, TWO_PI, 0.0, 360.0);

    colorMode(HSB, 360, 255, 255);
    barColorC = color(hue, 255, 255);
    centerColor = color(hue, 255, 255);
  }
  
  popStyle();

  colorMode(RGB);
  LightBar lightBar = new LightBar(int(xc - 100), int(yc + 170), 100, 50, color(centerColor), color(0, 0, 0), color(255, 255, 255));
  lightBar.drawGradient();

  if(lightBar.isOver()){
     barColorC = get(mouseX, mouseY);

  }
}

