JSONArray context; 

int X_0 = 8*4;
int Y_0 = 44*4;
int X_1 = 22*4;
int Y_1 = 44*4;

void setup() {
  context = loadJSONArray("context.json");
  
  println(context.size());
  JSONObject temp;
  for (int i=0; i<context.size(); i++) {
    temp = context.getJSONObject(i);
    temp.setInt("u", temp.getInt("u") - X_0);
    temp.setInt("v", temp.getInt("v") - Y_0);
  }
  
  for (int i=context.size()-1; i>=0; i--) {
    temp = context.getJSONObject(i);
    if (temp.getInt("u") < 0 || temp.getInt("v") < 0 || temp.getInt("u") > (X_1-1) || temp.getInt("v") > (Y_1-1) ) {
      context.remove(i);
    }
  }
  
  println(context.size());
  
  saveJSONArray(context, "contextFiltered.json");
}
