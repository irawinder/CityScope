
// Turns true once legotizer_data folder is found and loaded, allows majority of app to run
boolean dataSelected = false;
boolean dataLoaded   = false;

// filepath segments for constructing data references
Table index;
String legotizer_data, demoPrefix, demos[], demoTemplate;

// Function that opens legotizer_data folder
void folderSelected(File selection) {
  if (selection == null) { // Notifies console and closes program
    println("Legotizer cannot run without 'legotizer_data' folder.");
    exit();
  } else { // intitates the rest of the software
    println("User selected " + selection.getAbsolutePath());
    legotizer_data = selection.getAbsolutePath() + "/";
    dataSelected = true;
  }
}

// Uses index file to defines strings for navigating within the legotizer_data folder
void initializePaths() {
  index = loadTable(legotizer_data + "index.tsv");
  demoPrefix = index.getString(0,0);
  demos = new String[index.getRowCount() - 1];
  for (int i=0; i<demos.length; i++) {
    demos[i] = index.getString(i+1, 0) + "/";
  }
  demoTemplate = "template/";
}
