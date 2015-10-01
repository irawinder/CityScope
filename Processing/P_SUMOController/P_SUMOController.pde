
void setup() {
  
  initUDP();
  initializeGrid();
}

void draw() {
  
  if (changeDetected) {
    sendCommand("test command", 6667);
    changeDetected = false;
  }
}
