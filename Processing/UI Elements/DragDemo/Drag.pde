/**
 * A draggable shape; in this case a rectangle, but similar logic for a circle
 * Based off Drag class by Philippe Lhoste's tutorial
 */
class Drag
{

  float m_x, m_y; 
  int m_size; 
  int m_lineWidth;
  color m_colorLine;
  color m_colorFill;
  color m_colorHover;
  color m_colorDrag;

  boolean m_bIsHovered, m_bDragged;
  float m_clickDX, m_clickDY;


//Constructor
  Drag(float x, float y, int size, int lineWidth, color colorLine, color colorFill, color colorHover, color colorDrag)
  {
    m_x = x; m_y = y;
    m_size = size;
    m_lineWidth = lineWidth;
    m_colorLine = colorLine;
    m_colorFill = colorFill;
    m_colorHover = colorHover;
    m_colorDrag = colorDrag;
  }


  //Updates object
  void update(boolean bAlreadyDragging)
  {
    // Check if mouse is over the Drag
    m_bIsHovered = dist(mouseX, mouseY, m_x, m_y) <= m_size / 2;
    
    // If mouse is pressed and it's over, trigger the dragging boolean
    if (!bAlreadyDragging && mousePressed  && m_bIsHovered)
    {
      m_bDragged = true;
      // And memorize the offset of the mouse position from the center of the Drag
      m_clickDX = mouseX - m_x;
      m_clickDY = mouseY - m_y;
      
    }

    // If mouse isn't pressed
    if (!mousePressed)
    {
      // Stop dragging
      m_bDragged = false;
    }
  }


  //update the x and y position
  void move()
  {
    if (m_bDragged)
    {
      m_x = mouseX - m_clickDX;
      m_y = mouseY - m_clickDY;
    }
  }


  //draw the drag each frame
  void display()
  {
    move();
    strokeWeight(2);
    stroke(m_colorLine);
    if (m_bDragged)
    {
      fill(m_colorDrag);
    }
    else if (m_bIsHovered)
    {
      fill(m_colorHover);
    }
    else
    {
      fill(m_colorFill);
    }
    rectMode(CENTER);
    rect(m_x, m_y, m_size, m_size, 5);
  }
}