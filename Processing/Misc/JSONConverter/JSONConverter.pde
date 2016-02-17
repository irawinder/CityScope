JSONArray context; 
JSONObject temp;
Table staticStructuresTSV;
int counter = 0;

//float scalar = (4*4*11) / 192.0;
float scalar = 1;

void setup() {
  
  staticStructuresTSV = loadTable("staticStructures.tsv");
  context = new JSONArray();

  for (int i=0; i<staticStructuresTSV.getRowCount(); i++) {
    for (int j=0; j<staticStructuresTSV.getColumnCount(); j++) {
      
      int value = staticStructuresTSV.getInt(i, j);
      
      if ( value == 0 || value == -10) {
        temp = new JSONObject();
        temp.setInt("v", int(scalar*j));
        temp.setInt("u", int(scalar*i));
        temp.setInt("use",  0 );
        temp.setInt("z", 0);
        writeObject();
      } else if ( value == -1) {
        temp = new JSONObject();
        temp.setInt("v", int(scalar*j));
        temp.setInt("u", int(scalar*i));
        temp.setInt("use",  1 );
        temp.setInt("z", 0);
        writeObject();
      } else if ( value == -2) {
        temp = new JSONObject();
        temp.setInt("v", int(scalar*j));
        temp.setInt("u", int(scalar*i));
        temp.setInt("use",  2 );
        temp.setInt("z", 0);
        writeObject();
      } else if ( value == -3) {
        temp = new JSONObject();
        temp.setInt("v", int(scalar*j));
        temp.setInt("u", int(scalar*i));
        temp.setInt("use",  -2 );
        temp.setInt("z", 0);
        writeObject();
      } if ( value > 0) {
        for (int k=0; k<value; k++) {
          temp = new JSONObject();
          temp.setInt("v", int(scalar*j));
          temp.setInt("u", int(scalar*i));
//          if (value > 15) {
//            temp.setInt("use",  3 );
//          } else if (k < 2) {
//            temp.setInt("use",  5 );
//          } else {
//            temp.setInt("use",  4 );
//          }
          if (value < 3) {
            temp.setInt("use",  3 );
          } else if (k == 0) {
            temp.setInt("use",  5 );
          } else {
            temp.setInt("use",  4 );
          }
          temp.setInt("z", k+1);
          println(k+1);
          writeObject();
        }
      }
    }
  }
  
  println(counter);
  println(context.size());
  println(16*16*4*4);
  saveJSONArray(context, "context.json");
  
}

void writeObject() {
  context.setJSONObject(counter, temp);
  counter++;
}
