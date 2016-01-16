void setup(){
  size(200,200);
  Helvetica = createFont("Helvetica", 20, true);
  button = new Button(70, 70, "refresh");
  button2 = new Button(100, 80, "help");
}
void draw(){
  background(150);
  button.draw();
  button2.draw();
}
