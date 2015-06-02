// This simulation merely tests our ability to set and display a score gradient along the z axis.
void solveTest(JSONArray points) {
  
  clearJSONArray(solutionJSON);
  
  for (int i = 0; i < points.size(); i++) {
    
    // Each input object copied into a temporary object
    JSONObject pt = points.getJSONObject(i); 
    
    // Each solution object pupolated with fields and appendend to solution array
    JSONObject solution = new JSONObject();
    solution.setInt("u", pt.getInt("u"));
    solution.setInt("v", pt.getInt("v"));
    solution.setInt("z", pt.getInt("z"));
    
    // "score" set to number between 0 and 1 based on "z" value
    solution.setFloat("score", ( (maxZ+1) - (pt.getFloat("z")+1) )/(maxZ+1) );
    
    solutionJSON.append(solution);
  }
  
}
