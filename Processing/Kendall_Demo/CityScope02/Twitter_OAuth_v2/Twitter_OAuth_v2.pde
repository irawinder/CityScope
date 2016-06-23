// import UDP library
import hypermedia.net.*;
UDP udp;  // define the UDP object


void setup()
{
  size(500, 500);
  background(0);
  startHashes();

  udp = new UDP( this, 6556 );
  //udp.log( true );     // <-- printout the connection activity
  udp.listen( false );
}

void draw()
{

  updateHashes();

  if (foundHashTag) {
    foundHashTag=false;
    String message = line+";\n";
    udp.send( message, "localhost", 6100 );
  }
}

