void keyPressed() {
  switch(key) {
    case 'k': // Change horizontal 'slice' layer
      zee = iterate(zee, maxZ);
      println("zee = " + zee);
      break;
    case 'm': // Change simulation mode
      simMode = iterate(simMode, simN-1);
      println("simMode = " + simMode + " " + simNames[simMode]);
      updateArrayJSON("userNodes.json", 1);
      break;
    case 's': // Change simulation mode
      showSim = iterate(showSim);
      println("showSim = " + showSim);
      break;
  }
}

// iterates an integer counter by 1, or resets to zero if at max
int iterate(int i, int max) {
  if (i < max) {
    return i+1;
  } else {
    return 0;
  }
}

// iterates a boolean
boolean iterate(boolean bool) {
  if (bool) {
    return false;
  } else {
    return true;
  }
}
