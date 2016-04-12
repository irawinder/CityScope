import processing.core.PApplet;
import processing.core.PGraphics;

public class MapBlockBrushs extends MapBlockBase {
	  public MapBlock[] randomBrushs;
	  public MapBlock[] specificBrushs;
	  public MapBlock selectedBrush;
	  public int numberOfBrush;
	  public PGraphics pg;
	  PApplet p;

	  public MapBlockBrushs(PApplet _p,int _numberOfBrush) {
		  p=_p;
	    randomBrushs = new MapBlock[_numberOfBrush];
	    specificBrushs = new MapBlock[_numberOfBrush];
	    numberOfBrush=_numberOfBrush;
	    randomBrushsGen(_numberOfBrush);
	    specificBrushsGen();
	    selectedBrush = specificBrushs[0];
	  }

	  public void randomBrushsGen(int _numberOfBrush) {
	    for (int i=0; i<_numberOfBrush; i++) {
	      randomBrushs[i] = new MapBlock(p,randomTileArrayGen(p));
	    }
	  }
	  public void randomBrushsGen() {
	    for (int i=0; i<numberOfBrush; i++) {
	      randomBrushs[i] = new MapBlock(p,randomTileArrayGen(p));
	    }
	  }

	  public void specificBrushsGen() {
	    for (int i=0; i<5; i++) {
	      specificBrushs[i] = new MapBlock(p,specificTileArrayGen(i));
	    }
	  }

	  public void brushImgCreation() {
	    pg = p.createGraphics(200, 260);
	    pg.beginDraw();
	    pg.background(255);
	    pg.stroke(255);
	    for (int i=0; i<UrbanAutonomous.mapBlockBrushs.specificBrushs.length; i++) {
	      pg.image(UrbanAutonomous.mapBlockBrushs.specificBrushs[i].pg, 50, 70*i);
	    }
	    for (int i=0; i<UrbanAutonomous.mapBlockBrushs.numberOfBrush; i++) {
	      pg.image(UrbanAutonomous.mapBlockBrushs.randomBrushs[i].pg, 150, 70*i);
	    }
	    pg.endDraw();
	  }
	}
	
