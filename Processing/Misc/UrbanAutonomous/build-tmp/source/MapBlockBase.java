

import processing.core.PApplet;

public class MapBlockBase {
	  MapBlockBase() {}

	  //RandomMapBlock
	  Tile[][] randomTileArrayGen(PApplet p) {
	    Tile[][] tileArray=new Tile[5][5];
	    Tile [] basicTileArray= {
	      UrbanAutonomous.basicTile.hwTile, UrbanAutonomous.basicTile.lwTile, UrbanAutonomous.basicTile.hrTile, UrbanAutonomous.basicTile.lrTile,UrbanAutonomous.basicTile.noneTile }; 
	    for (int y=0; y<5; y++) {
	      for (int x=0; x<5; x++) {
	        if (x==2&&y==2)
	          tileArray[x][y]=UrbanAutonomous.basicTile.intersectionTile;
	        else if (x==2||y==2)
	          tileArray[x][y]=UrbanAutonomous.basicTile.roadTile;
	        else {
	          tileArray[x][y]=basicTileArray[(int) p.random(4)];
	        }
	      }
	    }
	    return tileArray;
	  }

	  //SpecificTile
	  Tile[][] specificTileArrayGen(int number) {
	    Tile[][] tileArray=new Tile[5][5];
	    Tile [] basicTileArray= {
	      UrbanAutonomous.basicTile.hwTile, UrbanAutonomous.basicTile.lwTile, UrbanAutonomous.basicTile.hrTile, UrbanAutonomous.basicTile.lrTile,UrbanAutonomous.basicTile.noneTile
	    }; 
	    for (int y=0; y<5; y++) {
	      for (int x=0; x<5; x++) {
	        if (x==2&&y==2)
	          tileArray[x][y]=UrbanAutonomous.basicTile.intersectionTile;
	        else if (x==2||y==2)
	          tileArray[x][y]=UrbanAutonomous.basicTile.roadTile;
	        else {
	          tileArray[x][y]=basicTileArray[number];
	        }
	      }
	    }
	    return tileArray;
	  }

	  Tile[][] specificTileArrayGen(PApplet p) {
	    int number=(int)p.random(4);
	    Tile[][] tileArray=new Tile[5][5];
	    Tile [] basicTileArray= {
	      UrbanAutonomous.basicTile.hwTile, UrbanAutonomous.basicTile.lwTile, UrbanAutonomous.basicTile.hrTile, UrbanAutonomous.basicTile.lrTile
	    }; 
	    for (int y=0; y<5; y++) {
	      for (int x=0; x<5; x++) {
	        if (x==2&&y==2)
	          tileArray[x][y]=UrbanAutonomous.basicTile.intersectionTile;
	        else if (x==2||y==2)
	          tileArray[x][y]=UrbanAutonomous.basicTile.roadTile;
	        else {
	          tileArray[x][y]=basicTileArray[number];
	        }
	      }
	    }
	    return tileArray;
	  }
	}
