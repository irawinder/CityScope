//---FOR MOTION WITHIN CONTAINER 0----

/* here's a sample point I took from the CDR csv I had from Naichun: 
    42.50777778  1.5325    42.49666667  1.5125  --> 
    which I converted to 355.4444    213     347.6667  205 to test motion
    I mult decimals of x's by 700 and y's by 400 to have seeable change in scale with picture
*/ 

PVector origin; 
PVector destination; 
PVector velocity;
//was planning on coding conditionals for these, but I soon realized this wasn't the right way to approach things
PVector velocity_ld; 
PVector velocity_lu; 
PVector velocity_rd; 
PVector velocity_ru;


PImage bg; 

//this is an example of a velocity_lu
void setup() {
  size(1200, 426);
  smooth();
  bg = loadImage("crop.png"); 
  background(bg);
  origin = new PVector (355.4444,213.0); 
    //here's where I would add an for, if loop like the one that Ira did for the Andorra player to go through each thing and work with the mercatorMap 
    /*for (int i=0; i<France_zero.getRowCount(); i+=2) { // iterates through each row
    if (France_zero.getInt(i, "origin container") == 0) { // checks if lat-long of point is actually on table <-- this isn't in my code since I don't have map on here
      
      // turns latitude and longitude of a point into canvas location within PGraphic topo <-- not in my code because I don't have map on here
      coord = mercatorMap.getScreenLocation(new PVector(France_zero.getFloat(i, "olat"), France_zero.getFloat(i, "olon")));
      
      // Draw a circle 30 pixels in diameter at geolocation
      tableCanvas.ellipse(coord.x, coord.y, 30, 30); 
    }
  }
    // new PVector(OD_France.getFloat(i, "olat"), OD_France.getFloat(i, "olon"))) <-- THIS I DO WANT
  */
  velocity = new PVector (-1, -.5); 
  destination = new PVector (347.6667, 205); // 
} 

void draw() {

  // Add the current speed to the location to get from origin to destination
  origin.add(velocity);

  if ((origin.x != destination.x)) {
    velocity.x = velocity.x;
  }
  if ((origin.y != destination.y)) {
    velocity.y = velocity.y;
  }
  
  if ((origin.y == destination.y)) {
   velocity.y = 0;
   velocity.x = 0;
   fill(#ff0000);
   stroke(0); 
   //implement a kill code
  } 
  // ellipse code
  noStroke();
  fill(#00ffff);
  if ((origin.y == destination.y)) { 
    fill(0);
    //want to be noFill() but for whatever reason (probably a stupid one I missed) that wasn't working
    //also need to write a kill code for trail, but I realized that this wasn't the right motion anyways 
  }
  ellipse(origin.x, origin.y, 16, 16);
}


