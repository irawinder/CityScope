// Simple Decay with two Agents going different ways and changing RGB color space

void setup() {
  size(600, 750);
}


void draw() {
  background(255);
  stroke(0);
  fill(a, b, c);
  ellipse(x, y, 50, 50);
  fill(a2, b2, c2);
  ellipse(x2, y2, 50, 50);

  // Add speed to location.
  y = y + speed;
  y2 = y2 - speed2;

  // Add decay to speed
  speed = speed + decay;
  speed2 = speed2 + decay2;

  // When ellipse reaches bottom, reverse to "bounce" up
  if (y > height) {
    //slowing down the speed and therefore slowly decreasing the height
    speed = speed * -0.95;
    a -= 10;
    b -= 5;
    c += 20;
    y = height;
  }


  // When ellipse reaches top, reverse to "bounce" back
  if (y2 > 750) {
    //this isn't as smooth or intuitive as the last portion
    speed2 = speed2 * -1.0125;
    a2 += 10;
    b2 -= 5;
    c2 -= 10;
    y2 = height;
  }
}
