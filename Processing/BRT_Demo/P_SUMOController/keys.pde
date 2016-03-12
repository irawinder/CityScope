public void keyPressed(){
      
  switch(key) {
    
    // Prints Zoom Level
    case 'g':
      if (debug) {
        debug = false;
      } else {
        debug = true;
      }
      println("debug: " + debug);
      break;
  }
}
