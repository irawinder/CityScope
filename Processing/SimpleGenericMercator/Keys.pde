boolean network1 = true;
boolean network2 = true;
boolean network3 = true;

void keyPressed(){
   switch (key) {
//Global buttons for all dataModes    
    case 'c': // Cali Mode
    Coordinates.clear();
    cali = toggle(cali);
    mex = toggle(mex);
    initialized = false;
    break;
    
    case 'm': // mex Mode
    Coordinates.clear();
    cali = toggle(cali);
    mex = toggle(mex);
    initialized = false;
    break;
    
    case 'l': // mex Mode
    lines = toggle(lines);
    initialized = false;
    break;
    
    case 'g': // mex Mode
    gridshow = toggle(gridshow);
    initialized = false;
    break;
    
    case '1': 
    Coordinates.clear();
    network1 = toggle(network1);
    initialized = false;
    break;
    
    case '2':
    Coordinates.clear();
    network2 = toggle(network2);
    initialized = false;
    break;
    
    case '3':
    Coordinates.clear();
    network3 = toggle(network3);
    initialized = false;
    break;
   }
}
   
 boolean toggle(boolean bool) {
  if (bool) {
    return false;
  } else {
    return true;
  }
}