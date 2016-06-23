class Node 
{

  String user;
  String location;
  ArrayList<Msg> messages;
  ArrayList<ArrayList<PVector>> polylines;
  ArrayList<String> polydates;

  boolean toggle;

  Node(String userQ, String locationQ) {
    user = userQ;
    location = locationQ;
    messages = new ArrayList<Msg>();  // Create an empty ArrayList
    polylines = new ArrayList<ArrayList<PVector>>();  // Create an empty ArrayList
    polydates = new ArrayList<String>();

    boolean toggle = true;
  }
}
