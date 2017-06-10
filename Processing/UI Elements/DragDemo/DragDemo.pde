/*
Small demo to show dragging interaction 

Nina Lutz June 2017
*/

int num = 20;

ArrayList<Drag> drags = new ArrayList<Drag>();
ArrayList<Drag> dragGroup = new ArrayList<Drag>();

void setup()
{
  size(400, 400);
  smooth();

  // Create random Drags
  for (int i = 0; i < num; i++)
  {
    int size = int(random(15, 30));
    Drag drag = new Drag(size + random(width - 2 * size), size + random(height - 2 * size), size, size/5, color(0), color(0, 200, 0), color(0, 100, 0), color(200, 0, 0));
    Drag dragG = new Drag(size + random(width - 2 * size), size + random(height - 2 * size), size, size/5, color(0), color(0, 100, 225), color(0, 50, 125), color(200, 0, 0));
    drags.add(drag);
    dragGroup.add(dragG);
  }
}

void draw()
{
  background(255);
  
  //Call this to update the drags
  updateDrags(drags);
  updateDrags(dragGroup);
}


void updateDrags(ArrayList<Drag> drags){
  for(int i = 0; i<drags.size(); i ++){
    boolean dragging = false;
    
    drags.get(i).update(dragging);
    
    if(drags.get(i).m_bDragged){
      dragging = true;
    }
    drags.get(i).display();
  }
}