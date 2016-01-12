# CityScope
Arrange a Meeting with Ira Winder [jiw@mit.edu] before making any commits to this repository.

These scripts are compiled and tested with Processing IDE 2.2.1 on Windows 7:

As of August 4, 2015, the following Processing libraries are required.  These should be kept up to date in the repository’s *CityScope/Processing/libraries/* folder:
	**OpenCV** by Greg Borenstein (Colorizer, Legotizer)
	**Keystone** by David Bouchard (Legotizer)
	**UDP** by Stephane Cousot (Colorizer, Legotizer, CitySim)

## branch 'meteor-connect' specific libraries (2016/01/06)
The intense dislike towards PHP and SQL statements directed me to make a processing library for connecting a modern (and popular within ML) javascript framework `MeteorJS` from a sketch. *The framework uses its own way to communicate using a protocol using [DDP](https://www.meteor.com/ddp)* - A RESTful like method sending BSON data via websockets.  

* [**GSON** by Google](https://github.com/google/gson)*1
* [**JAVA-WebSockets** by Nathan Rajlich ](https://github.com/TooTallNate/Java-WebSocket)*1
* [**processing-ddp-client** by Yasushi Sakai](https://github.com/yasushisakai/processing-ddp-client) /  [DL to libraries archive](https://github.com/yasushisakai/processing-ddp-client/releases/download/v0.0.2/ddpclient.zip)

*1: java libraries needs to be renamed and put into a specific type of folder structure that processing likes. Simply add the `ddpclient` folder to the `processing/sketchbook/libraries` directory.

This version modifies the `Colortizer/scanExport.pde` code as little and invasive as possible.

## The <10 lines of code to connect and start logging

### importing and variable declaration

```java
/**
* importing the DDP library and dependencies (2016/01/05 Y.S.)
*
*/
// You dont need this if your not using GSON
import com.google.gson.Gson;

import ddpclient.*;

DDPClient client;
Gson gson; // handy to have one gson converter...
int[][] state_data; // because this object is ment to be json-ized
```

### DDPClient initiation and connect to server
```java
/**
* DDP initiation (2016/01/04 Y.S.)
*
* assuming that this function is called in init
* initiating will automatically connect
*/
ddp = new DDPClient(this,"localhost",3000);
//ddp = new DDPClient(this,"104.131.183.20",80);
gson = new Gson();
```
### Data recording as json
inside `sendData` function

```java
/**
* storing data for web (2016/01/05 Y.S.)
* simplified the data for the sake of example
*/
state_data = (int[][])append(state_data,new int[]{
	tagDecoder[0].id[u][v],
	tagDecoder[0].rotation[u][v]
});
```
and sending it to the server
```java
/**
* sending data via DDP (2016/01/04 Y.S.)
*/
ddp.call("sendCapture",new Object[]{gson.toJson(state_data)});
```

## Things to talk and ask to Ira :)
* gain advise and feedback for this branch
* ask about `Hamburg` Grid info
* ask about data convention, tagDecoder[0], ids... and so on
* discuss about server data structure design, currently
```
{state = [[-1,0],[-1,0],[8,90],[-1,0],,,[-1,0]],
createdAt = Date()}
```
* discuss whether we should record simulations results
`{state,createAt,simulationResults:{blah}}`
* are there repository limits for github CP group maybe for webapps or other platforms??
