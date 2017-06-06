/**
 * ColorWheel
 *
 * This default implementation draws a spectrum of colored rectangles.
 * It assumes that HSB mode is set like: colorMode(HSB, 360, 100, 100)
 *
 * Be sure to reset the color mode to RGB in your sketch if you need to
 *
 * This doesn't encompass the whole range of saturatioons and brightness 
 *
 */

class ColorWheel {
  float xCenter;
  float yCenter;
  float radius;
  int   numRects;
  float rectWidth;
  float rectLength;
  
  ColorWheel(float xCenter, float yCenter, float radius, int numRects, float rectWidth, float rectLength) {
    this.xCenter = xCenter;
    this.yCenter = yCenter;
    this.radius = radius;
    this.numRects = numRects;
    this.rectWidth = rectWidth;
    this.rectLength = rectLength;
  }
  
  void draw() {
     
    pushStyle();
    colorMode(HSB, 360, 100, 100);
    rectMode(CENTER);
    
    float incrAngle = TWO_PI / (float)numRects;
    for( int i = 0; i < numRects; i++ ) {
      pushMatrix();
      noStroke();
      translate(xCenter, yCenter);
      rotate((float)i * incrAngle);
      drawRect(i);
      popMatrix();
    }
    popStyle();
  }
  
  /**
   * Draw the i-th rectangle in the circle.
   *
   * This method can be overridden to draw each rectangle
   * in a different way.
   */
  void drawRect(int i) {
    fill(getRectColor(i));
    float rectX = radius + rectLength / 2.0;
    rect(rectX, 0.0, rectLength, rectWidth);

      }
  
  /*
   * Default color scheme: assumes HSB mode.
   *
   * This method can be overridden to draw each rectangle using
   * a different color scheme.
   */
  color getRectColor(int i) {
    return color(360 * (float)i / (float)numRects, 100, 100);
  }
  
  /*
  Temporary solution 
  */
  
  boolean isMouseInRectangle() {
    float distFromCenter = dist(xCenter, yCenter, mouseX, mouseY);
    return ( (distFromCenter > radius) && (distFromCenter < radius + rectLength) );
  }
  
  /**
   * Return the angle (in radians) of the mouse point relative to
   * the center of the circle.
   */
  float getMouseAngle() {
    float distFromCenter = dist(xCenter, yCenter, mouseX, mouseY);
    
    // Using arc cosine give x and hypotenuse (dist from center)
    float angle = acos((mouseX - xCenter) / distFromCenter);
    
    // Reverse the angle if it's greater than PI (upper half of the circle
    // if drawing counterclockwise from right).
    //
    // This takes into account the y component of the mouse position: the
    // arccosine function only accounts for the x component.
    //
    if ( (mouseY - yCenter) < 0 ) angle = TWO_PI - angle;
    return angle;
  }
}
