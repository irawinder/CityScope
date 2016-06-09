PGraphics plan;

void initializePlan() {
  plan = createGraphics(1920, 1920, P2D);
}

void drawPlan() {
  plan.beginDraw();
  plan.background(0);
  plan.ellipse(plan.width/2, plan.height/2, plan.width, plan.height);
  plan.endDraw();
}
