Table SDL_data, SDL_summary;

// Loads Data Exported from SDL's UMI/Rhino Module
void loadSDLData() {
  
  String filename = "../../../../../riyadhgame/SDL_data.tsv";

  File f = new File(sketchPath(filename));
  
  if (f.exists())
  {
    SDL_data = loadTable("../../../../../riyadhgame/SDL_data.tsv");
    //println("'SDL_data.tsv' found in directory sketchPath('../../../../../riyadhgame/SDL_data.tsv')");
  } else {
    SDL_data = loadTable(legotizer_data + demoPrefix + demos[1] + "SDL_data.tsv");
    //println("'SDL_data.tsv' not found in directory sketchPath('../../../../../riyadhgame/SDL_data.tsv')");
    //println("Dummy data loaded from sketchPath(demo_riyadh/SDL_data.tsv)");
  }
  setHeatMap(SDL_data);
}

void loadSDLSummary() {
  
  String filename = "../../../../../riyadhgame/SDL_summary.tsv";

  File f = new File(sketchPath(filename));
  
  if (f.exists())
  {
    SDL_summary = loadTable("../../../../../riyadhgame/SDL_summary.tsv");
    //println("'SDL_summary.tsv' found in directory sketchPath('../../../../../riyadhgame/SDL_summary.tsv')");
  } else {
    SDL_summary = loadTable(legotizer_data + demoPrefix + demos[1] + "SDL_summary.tsv");
    //println("'SDL_summary.tsv' not found in directory sketchPath('../../../../../riyadhgame/SDL_summary.tsv')");
    //println("Dummy data loaded from sketchPath(../legotizer_data/demo_riyadh/SDL_summary.tsv)");
  }
  
  live = SDL_summary.getInt(1,3);
  work = SDL_summary.getInt(1,4);
  
  SDL_summary.removeColumn(4);
  SDL_summary.removeColumn(3);
  
  webScores = new ArrayList<Float>();
  webNames = new ArrayList<String>();
  avgScore = 0;
  
  for (int i=0; i<SDL_summary.getColumnCount(); i++) {
    webNames.add(SDL_summary.getString(0,i));
    webScores.add(SDL_summary.getFloat(1,i));
    avgScore += webScores.get(i);
  }
  
  // For now, reverses energy score because Cody got it wrong, and changing processing on the fly is easier.
  webScores.set(0, 1-webScores.get(0));
  
  avgScore /= webScores.size();
}

// Sets heatmap with values of Table where each row is [Value, u, v].  
//Table also includes Header Row where first column's header is the name of the heat map
void setHeatMap(Table data) { 
  heatMapActive(false);
  heatMapName = data.getString(0,0);
  // Unfortunately, this method is custom to Rhino's data format given the way cody programmed it
  // Consider writing another method for defining input for other simulations into heatmap[][]
  for (int i=0; i<data.getRowCount()-1; i++) {
    heatMap[14-data.getInt(i+1,2)+1][data.getInt(i+1,1)] = data.getFloat(i+1,0);
    heatMapActive[14-data.getInt(i+1,2)+1][data.getInt(i+1,1)] = 1;
  }
}
