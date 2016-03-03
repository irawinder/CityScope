int i = 0;
int ncolors = 6;
int[] seeds_x = new int[ncolors];
int[] seeds_y = new int[ncolors];
color[] seed_colors = new color[ncolors];
 
int minDistance = 0;
int minIndex = 0;
 
 // this is run once.
void setup()
{
    size(350, 350);
       
    // smooth edges
    smooth();
    
    noLoop();
 
    seed_colors[0] = color(255, 0, 0); //red
    seed_colors[1] = color(0, 255, 0); //green
    seed_colors[2] = color(0, 0, 255); //blue
    seed_colors[3] = color(255, 255, 0); 
    seed_colors[4] = color(255, 0, 255);
    seed_colors[5] = color(0, 255, 255);
     
    // Set seeds position, random
    for(i=0; i < ncolors; i = i+1)
    {
        seeds_x[0] = (60);
        seeds_y[0] = (70);
        seeds_x[1] = (90);
        seeds_y[1] = (100);
        seeds_x[2] = (50);
        seeds_y[2] = (50);
        seeds_x[3] = (70);
        seeds_y[3] = (30);
        seeds_x[4] = (20);
        seeds_y[4] = (85);
        seeds_x[5] = (300);
        seeds_y[5] = (400);
        
        fill(255);
        ellipse(seeds_x[i], seeds_y[i], 15, 15);
    }
    
    
    
}

void draw()

{  
  
    for(int px = 0; px < width; px++)
    {
      
         for(int py = 0; py < height; py++)
         {
           
             // Check distances to colors
             minDistance = ((px  - seeds_x[0]) * (px - seeds_x[0])) +  ((py  - seeds_y[0]) * (py  - seeds_y[0]));
             minIndex = 0;
 
             for (int nc = 1; nc < ncolors; nc++)
             {
                 int dist = ((px  - seeds_x[nc]) * (px - seeds_x[nc])) +  ((py  - seeds_y[nc]) * (py  - seeds_y[nc]));
                  
                 if (dist <= minDistance)
                 {
                     minDistance = dist;
                     minIndex = nc;
                }
            }
            stroke(seed_colors[minIndex]);
            point(px, py);
        }
        
    }
    
    
    for(int i = 0; i<200; i++){
      float x = random(width);
      float y = random(height);
      
  
      if( (((x  - seeds_x[1]) * (x - seeds_x[1])) +  ((y  - seeds_y[1]) * (y  - seeds_y[1])) <= ((x  - seeds_x[0]) * (x - seeds_x[0])) +  ((y  - seeds_y[0]) * (y  - seeds_y[0]))) && 
      ((x  - seeds_x[1]) * (x - seeds_x[1])) +  ((y  - seeds_y[1]) * (y  - seeds_y[1])) <= ((x  - seeds_x[2]) * (x - seeds_x[2])) +  ((y  - seeds_y[2]) * (y  - seeds_y[2]))
      &&
      ((x  - seeds_x[1]) * (x - seeds_x[1])) +  ((y  - seeds_y[1]) * (y  - seeds_y[1])) <= ((x  - seeds_x[3]) * (x - seeds_x[3])) +  ((y  - seeds_y[3]) * (y  - seeds_y[3]))
      &&
      ((x  - seeds_x[1]) * (x - seeds_x[1])) +  ((y  - seeds_y[1]) * (y  - seeds_y[1])) <= ((x  - seeds_x[4]) * (x - seeds_x[4])) +  ((y  - seeds_y[4]) * (y  - seeds_y[4]))
      &&
      ((x  - seeds_x[1]) * (x - seeds_x[1])) +  ((y  - seeds_y[1]) * (y  - seeds_y[1])) <= ((x  - seeds_x[5]) * (x - seeds_x[5])) +  ((y  - seeds_y[5]) * (y  - seeds_y[5])))
      {
      fill(seed_colors[1]);
      stroke(0);
      }
      
      else if( (((x  - seeds_x[2]) * (x - seeds_x[2])) +  ((y  - seeds_y[2]) * (y  - seeds_y[2])) <= ((x  - seeds_x[0]) * (x - seeds_x[0])) +  ((y  - seeds_y[0]) * (y  - seeds_y[0]))) && 
      ((x  - seeds_x[2]) * (x - seeds_x[2])) +  ((y  - seeds_y[2]) * (y  - seeds_y[2])) <= ((x  - seeds_x[1]) * (x - seeds_x[1])) +  ((y  - seeds_y[1]) * (y  - seeds_y[1]))
      &&
      ((x  - seeds_x[2]) * (x - seeds_x[2])) +  ((y  - seeds_y[2]) * (y  - seeds_y[2])) <= ((x  - seeds_x[3]) * (x - seeds_x[3])) +  ((y  - seeds_y[3]) * (y  - seeds_y[3]))
      &&
      ((x  - seeds_x[2]) * (x - seeds_x[2])) +  ((y  - seeds_y[2]) * (y  - seeds_y[2])) <= ((x  - seeds_x[4]) * (x - seeds_x[4])) +  ((y  - seeds_y[4]) * (y  - seeds_y[4]))
      &&
      ((x  - seeds_x[2]) * (x - seeds_x[2])) +  ((y  - seeds_y[2]) * (y  - seeds_y[2])) <= ((x  - seeds_x[5]) * (x - seeds_x[5])) +  ((y  - seeds_y[5]) * (y  - seeds_y[5])))
      {
      fill(seed_colors[2]);
      stroke(0);
      }
      
      else if( (((x  - seeds_x[3]) * (x - seeds_x[3])) +  ((y  - seeds_y[3]) * (y  - seeds_y[3])) <= ((x  - seeds_x[0]) * (x - seeds_x[0])) +  ((y  - seeds_y[0]) * (y  - seeds_y[0]))) && 
      ((x  - seeds_x[3]) * (x - seeds_x[3])) +  ((y  - seeds_y[3]) * (y  - seeds_y[3])) <= ((x  - seeds_x[1]) * (x - seeds_x[1])) +  ((y  - seeds_y[1]) * (y  - seeds_y[1]))
      &&
      ((x  - seeds_x[3]) * (x - seeds_x[3])) +  ((y  - seeds_y[3]) * (y  - seeds_y[3])) <= ((x  - seeds_x[2]) * (x - seeds_x[2])) +  ((y  - seeds_y[2]) * (y  - seeds_y[2]))
      &&
      ((x  - seeds_x[3]) * (x - seeds_x[3])) +  ((y  - seeds_y[3]) * (y  - seeds_y[3])) <= ((x  - seeds_x[4]) * (x - seeds_x[4])) +  ((y  - seeds_y[4]) * (y  - seeds_y[4]))
      &&
      ((x  - seeds_x[3]) * (x - seeds_x[3])) +  ((y  - seeds_y[3]) * (y  - seeds_y[3])) <= ((x  - seeds_x[5]) * (x - seeds_x[5])) +  ((y  - seeds_y[5]) * (y  - seeds_y[5])))
      {
      fill(seed_colors[3]);
      stroke(0);
      }
      
      else if( (((x  - seeds_x[4]) * (x - seeds_x[4])) +  ((y  - seeds_y[4]) * (y  - seeds_y[4])) <= ((x  - seeds_x[0]) * (x - seeds_x[0])) +  ((y  - seeds_y[0]) * (y  - seeds_y[0]))) && 
      ((x  - seeds_x[4]) * (x - seeds_x[4])) +  ((y  - seeds_y[4]) * (y  - seeds_y[4])) <= ((x  - seeds_x[1]) * (x - seeds_x[1])) +  ((y  - seeds_y[1]) * (y  - seeds_y[1]))
      &&
      ((x  - seeds_x[4]) * (x - seeds_x[4])) +  ((y  - seeds_y[4]) * (y  - seeds_y[4])) <= ((x  - seeds_x[2]) * (x - seeds_x[2])) +  ((y  - seeds_y[2]) * (y  - seeds_y[2]))
      &&
      ((x  - seeds_x[4]) * (x - seeds_x[4])) +  ((y  - seeds_y[4]) * (y  - seeds_y[4])) <= ((x  - seeds_x[3]) * (x - seeds_x[3])) +  ((y  - seeds_y[3]) * (y  - seeds_y[3]))
      &&
      ((x  - seeds_x[4]) * (x - seeds_x[4])) +  ((y  - seeds_y[4]) * (y  - seeds_y[4])) <= ((x  - seeds_x[5]) * (x - seeds_x[5])) +  ((y  - seeds_y[5]) * (y  - seeds_y[5])))
      {
      fill(seed_colors[4]);
      stroke(0);
      }
      
      else if( (((x  - seeds_x[5]) * (x - seeds_x[5])) +  ((y  - seeds_y[5]) * (y  - seeds_y[5])) <= ((x  - seeds_x[0]) * (x - seeds_x[0])) +  ((y  - seeds_y[0]) * (y  - seeds_y[0]))) && 
      ((x  - seeds_x[5]) * (x - seeds_x[5])) +  ((y  - seeds_y[5]) * (y  - seeds_y[5])) <= ((x  - seeds_x[1]) * (x - seeds_x[1])) +  ((y  - seeds_y[1]) * (y  - seeds_y[1]))
      &&
      ((x  - seeds_x[5]) * (x - seeds_x[5])) +  ((y  - seeds_y[5]) * (y  - seeds_y[5])) <= ((x  - seeds_x[2]) * (x - seeds_x[2])) +  ((y  - seeds_y[2]) * (y  - seeds_y[2]))
      &&
      ((x  - seeds_x[5]) * (x - seeds_x[5])) +  ((y  - seeds_y[5]) * (y  - seeds_y[5])) <= ((x  - seeds_x[3]) * (x - seeds_x[3])) +  ((y  - seeds_y[3]) * (y  - seeds_y[3]))
      &&
      ((x  - seeds_x[5]) * (x - seeds_x[5])) +  ((y  - seeds_y[5]) * (y  - seeds_y[5])) <= ((x  - seeds_x[4]) * (x - seeds_x[4])) +  ((y  - seeds_y[4]) * (y  - seeds_y[4])))
      {
      fill(seed_colors[5]);
      stroke(0);
      }
      
      else if( (((x  - seeds_x[0]) * (x - seeds_x[0])) +  ((y  - seeds_y[0]) * (y  - seeds_y[0])) <= ((x  - seeds_x[5]) * (x - seeds_x[5])) +  ((y  - seeds_y[5]) * (y  - seeds_y[5]))) && 
      ((x  - seeds_x[0]) * (x - seeds_x[0])) +  ((y  - seeds_y[0]) * (y  - seeds_y[0])) <= ((x  - seeds_x[1]) * (x - seeds_x[1])) +  ((y  - seeds_y[1]) * (y  - seeds_y[1]))
      &&
      ((x  - seeds_x[0]) * (x - seeds_x[0])) +  ((y  - seeds_y[0]) * (y  - seeds_y[0])) <= ((x  - seeds_x[2]) * (x - seeds_x[2])) +  ((y  - seeds_y[2]) * (y  - seeds_y[2]))
      &&
      ((x  - seeds_x[0]) * (x - seeds_x[0])) +  ((y  - seeds_y[0]) * (y  - seeds_y[0])) <= ((x  - seeds_x[3]) * (x - seeds_x[3])) +  ((y  - seeds_y[3]) * (y  - seeds_y[3]))
      &&
      ((x  - seeds_x[0]) * (x - seeds_x[0])) +  ((y  - seeds_y[0]) * (y  - seeds_y[0])) <= ((x  - seeds_x[4]) * (x - seeds_x[4])) +  ((y  - seeds_y[4]) * (y  - seeds_y[4])))
      {
      fill(seed_colors[0]);
      stroke(0);
      }
      
      
      
      ellipse(x, y, 5, 5);
    }
}

