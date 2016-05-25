int i = 0;
int ncolors = 6;
float[] towers_x = new float[ncolors];
float[] towers_y = new float[ncolors];
color[] tower_colors = new color[ncolors];

Table values = new Table
 
float minDistance = 0;
int minIndex = 0;
 
 // this is run once.
void setup()
{
    size(500, 500);
       
    // smooth edges
    smooth();
    
    noLoop();
 
    tower_colors[0] = color(255, 0, 0); //red
    tower_colors[1] = color(0, 255, 0); //green
    tower_colors[2] = color(0, 0, 255); //blue
    tower_colors[3] = color(255, 255, 0); 
    tower_colors[4] = color(255, 0, 255);
    tower_colors[5] = color(0, 255, 255);
     
    // Set towers position, random
    for(i=0; i < ncolors; i++)
    {
        towers_x[i] = random(width);
        towers_y[i] = random(height);
    }
    
    
    
}

void draw()

{  
  
    for(float px = 0; px < width; px++)
    {
      
         for(float py = 0; py < height; py++)
         {
           
             // Check distances to colors
             minDistance = pow((px  - towers_x[0]), 2)  +  pow((py  - towers_y[0]), 2);
             minIndex = 0;
 
             for (int nc = 1; nc < ncolors; nc++)
             {
                 float dist = ((px  - towers_x[nc]) * (px - towers_x[nc])) +  ((py  - towers_y[nc]) * (py  - towers_y[nc]));
                  
                 if (dist <= minDistance)
                 {
                     minDistance = dist;
                     minIndex = nc;
                }
                
            }
            stroke(tower_colors[minIndex]);
            point(px, py);
        }
        
    }
    

    for(int i = 0; i<values.getRowCount(); i++){
      float x = values.getFloat(i, "x");
      float y = values.getFloat(i, "y");
      
      if((pow(x - towers_x[1], 2) + pow(y  - towers_y[1], 2)) <= (pow(x - towers_x[0], 2) + pow(y  - towers_y[0], 2)) &&
        (pow(x - towers_x[1], 2) + pow(y  - towers_y[1], 2))  <= (pow(x - towers_x[2], 2) + pow(y  - towers_y[2], 2)) &&
        (pow(x - towers_x[1], 2) + pow(y  - towers_y[1], 2))  <= (pow(x - towers_x[3], 2) + pow(y  - towers_y[3], 2)) &&
        (pow(x - towers_x[1], 2) + pow(y  - towers_y[1], 2))  <= (pow(x - towers_x[4], 2) + pow(y  - towers_y[4], 2)) &&
        (pow(x - towers_x[1], 2) + pow(y  - towers_y[1], 2))  <= (pow(x - towers_x[5], 2) + pow(y  - towers_y[5], 2))
      )
      {
      fill(tower_colors[1]);
      stroke(0);
      }
      

     else if((pow(x - towers_x[2], 2) + pow(y  - towers_y[2], 2)) <= (pow(x - towers_x[0], 2) + pow(y  - towers_y[0], 2)) &&
        (pow(x - towers_x[2], 2) + pow(y  - towers_y[2], 2))  <= (pow(x - towers_x[1], 2) + pow(y  - towers_y[1], 2)) &&
        (pow(x - towers_x[2], 2) + pow(y  - towers_y[2], 2))  <= (pow(x - towers_x[3], 2) + pow(y  - towers_y[3], 2)) &&
        (pow(x - towers_x[2], 2) + pow(y  - towers_y[2], 2))  <= (pow(x - towers_x[4], 2) + pow(y  - towers_y[4], 2)) &&
        (pow(x - towers_x[2], 2) + pow(y  - towers_y[2], 2))  <= (pow(x - towers_x[5], 2) + pow(y  - towers_y[5], 2))
      )
      {
      fill(tower_colors[2]);
      stroke(0);
      }
      
      else if((pow(x - towers_x[3], 2) + pow(y  - towers_y[3], 2)) <= (pow(x - towers_x[0], 2) + pow(y  - towers_y[0], 2)) &&
        (pow(x - towers_x[3], 2) + pow(y  - towers_y[3], 2))  <= (pow(x - towers_x[1], 2) + pow(y  - towers_y[1], 2)) &&
        (pow(x - towers_x[3], 2) + pow(y  - towers_y[3], 2))  <= (pow(x - towers_x[2], 2) + pow(y  - towers_y[2], 2)) &&
        (pow(x - towers_x[3], 2) + pow(y  - towers_y[3], 2))  <= (pow(x - towers_x[4], 2) + pow(y  - towers_y[4], 2)) &&
        (pow(x - towers_x[3], 2) + pow(y  - towers_y[3], 2))  <= (pow(x - towers_x[5], 2) + pow(y  - towers_y[5], 2))
      )
      {
      fill(tower_colors[3]);
      stroke(0);
      }
      
      else if((pow(x - towers_x[4], 2) + pow(y  - towers_y[4], 2)) <= (pow(x - towers_x[0], 2) + pow(y  - towers_y[0], 2)) &&
        (pow(x - towers_x[4], 2) + pow(y  - towers_y[4], 2))  <= (pow(x - towers_x[1], 2) + pow(y  - towers_y[1], 2)) &&
        (pow(x - towers_x[4], 2) + pow(y  - towers_y[4], 2))  <= (pow(x - towers_x[3], 2) + pow(y  - towers_y[3], 2)) &&
        (pow(x - towers_x[4], 2) + pow(y  - towers_y[4], 2))  <= (pow(x - towers_x[2], 2) + pow(y  - towers_y[2], 2)) &&
        (pow(x - towers_x[4], 2) + pow(y  - towers_y[4], 2))  <= (pow(x - towers_x[5], 2) + pow(y  - towers_y[5], 2))
      )
      {
      fill(tower_colors[4]);
      stroke(0);
      }
      
      else if((pow(x - towers_x[5], 2) + pow(y  - towers_y[5], 2)) <= (pow(x - towers_x[0], 2) + pow(y  - towers_y[0], 2)) &&
        (pow(x - towers_x[5], 2) + pow(y  - towers_y[5], 2))  <= (pow(x - towers_x[1], 2) + pow(y  - towers_y[1], 2)) &&
        (pow(x - towers_x[5], 2) + pow(y  - towers_y[5], 2))  <= (pow(x - towers_x[3], 2) + pow(y  - towers_y[3], 2)) &&
        (pow(x - towers_x[5], 2) + pow(y  - towers_y[5], 2))  <= (pow(x - towers_x[4], 2) + pow(y  - towers_y[4], 2)) &&
        (pow(x - towers_x[5], 2) + pow(y  - towers_y[5], 2))  <= (pow(x - towers_x[2], 2) + pow(y  - towers_y[2], 2))
      )
      {
      fill(tower_colors[5]);
      stroke(0);
      }
      
     else if((pow(x - towers_x[0], 2) + pow(y  - towers_y[0], 2)) <= (pow(x - towers_x[2], 2) + pow(y  - towers_y[2], 2)) &&
        (pow(x - towers_x[0], 2) + pow(y  - towers_y[0], 2))  <= (pow(x - towers_x[1], 2) + pow(y  - towers_y[1], 2)) &&
        (pow(x - towers_x[0], 2) + pow(y  - towers_y[0], 2))  <= (pow(x - towers_x[3], 2) + pow(y  - towers_y[3], 2)) &&
        (pow(x - towers_x[0], 2) + pow(y  - towers_y[0], 2))  <= (pow(x - towers_x[4], 2) + pow(y  - towers_y[4], 2)) &&
        (pow(x - towers_x[0], 2) + pow(y  - towers_y[0], 2))  <= (pow(x - towers_x[5], 2) + pow(y  - towers_y[5], 2))
      )
      {
      fill(tower_colors[0]);
      stroke(0);
      }
      

      ellipse(x, y, 5, 5);
      
      fill(0);
    
    }
    
          for(i=0; i < 6; i = i+1)
    {
        ellipse(towers_x[i], towers_y[i], 10, 10); 
    }
}

void mouseClicked(){
  clear();
  setup();
  redraw();
  
}
