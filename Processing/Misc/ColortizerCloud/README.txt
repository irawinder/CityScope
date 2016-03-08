Hi All,

For those who develop with input from Colortizer, Karthik made a simple way to pull Colortizer data from the cloud. (Thanks Karthik!) This is useful if you want to program a visualization from the comfort of your own computer instead of standing in the demo area. Also in Karthik's words:

Colortizer Server:
This is a node.js script running on my server for receiving Colortizer data from CityScope Colortizer sketch. It saves data on PORT 33333 and sends this UDP data packet to any client pinging PORT 6666.
Makes it independent of local network and would eliminate the need for Colortizer to send packets to all clients individually. It worked over LTE data on my iPhone as well.


Right now the Riyadh Table is sending Colortizer data in real time to Karthik's server about once per second.  If you ever restart Colortizer, enable the connection to Karthik's server by pressing 'SHIFT+V.' There is a notification in the lower right that reflects the status.  Frame-rates appear unaffected.

The Colortizer server is available to any machine/application via UDP. Just ping the port and it automatically sends you the current status:
IP: 104.131.179.31
Port: 6666

ColortizerCould.pde
I wrote a Processing script, ColortizerCloud (attached) to show an example of how to access this data. Just run the script and press any key to print the server data to console.

CSUdpColortizer.cs
Karthik wrote C# script for Unity that lets you connect directly to Colortizer. I pushed this to UrbanLens Github in its own separate folder.

CityScope Repository
Newest Colortizer, CitySim, Legotizer, and ColortizerCloud code has been pushed to CityScope master on Github. New features features include:
- Enable sending of Colortizer data to Karthik's server (toggle with SHIFT + V)
- Legotizer can receive input from ColortizerServer (toggle with SHIFT + D)

Let Karthik or I know if you have any questions/feature requests. One feature we'll need eventually is for the server to distinguish between different tables.

Best,
Ira (jiw@mit.edu)
