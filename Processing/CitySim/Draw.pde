// Horizontal z slice altitude
int zee = 0;

void drawNode(int u, int v) {
  rect(v*10, u*10, 8, 8);
}

// Draws single layer of OUTPUT nodes at layer "zee"
void drawScore() {
  noStroke();
      
  for (int i = 0; i < solutionJSON.size(); i++) {
    JSONObject node = solutionJSON.getJSONObject(i); 
    if (node.getInt("z") == zee) {
      // draws a layer of the node data set, color-coded to use
      heatFill(node.getFloat("score"));
      drawNode(node.getInt("v"), node.getInt("u"));
    }
  }
}

// Draws single layer of INPUT nodes at layer "zee"
void drawUses() {
  noStroke();
      
  for (int i = 0; i < nodesJSON.size(); i++) {
    JSONObject node = nodesJSON.getJSONObject(i); 
    if (node.getInt("z") == zee) {
      // draws a layer of the node data set, color-coded to use
      useFill(node.getInt("use"));
      drawNode(node.getInt("v"), node.getInt("u"));
    }
  }
}
