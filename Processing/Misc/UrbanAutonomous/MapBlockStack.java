
import processing.core.PApplet;
import processing.core.PGraphics;

public class MapBlockStack extends MapBlockBase{
	public MapBlock[][] mapBlockArray;
	public PGraphics pg;
	PApplet p;

	public MapBlockStack(PApplet _p) {
		p=_p;
		mapBlockArray = new MapBlock[16][16];
		randomGen();
	}


	public void randomGen() {
		for (int y = 0; y < 16; y++)
			for (int x = 0; x < 16; x++)
				mapBlockArray[x][y] = new MapBlock(this.p,specificTileArrayGen(p));
	}

	public void customMapGen() {
		UrbanAutonomous.simParam.mapType = 2;
		for (int y = 0; y < 16; y++)
			for (int x = 0; x < 16; x++)
				mapBlockArray[x][y] = UrbanAutonomous.mapBlockBrushs.specificBrushs[0];
	}

	public void noneMapGen() {
		UrbanAutonomous.simParam.mapType = 2;
		for (int y = 0; y < 16; y++)
			for (int x = 0; x < 16; x++)
				mapBlockArray[x][y] = UrbanAutonomous.mapBlockBrushs.specificBrushs[0];
	}

	public void loadUrbanMap() {
	    UrbanAutonomous.simParam.mapType=0;
	    String lines[] = p.loadStrings("urbanMap.txt");
	    for (int y=0; y<16; y++)
	      for (int x=0; x<16; x++)
	        mapBlockArray[x][y]= UrbanAutonomous.mapBlockBrushs.specificBrushs[Integer.parseInt(lines[y*16+x])];
	  }

	public void loadRuralMap() {
	    UrbanAutonomous.simParam.mapType=1;
	    String lines[] = p.loadStrings("ruralMap.txt");
	    for (int y=0; y<16; y++)
	      for (int x=0; x<16; x++)
	        mapBlockArray[x][y]= UrbanAutonomous.mapBlockBrushs.specificBrushs[Integer.parseInt(lines[y*16+x])];
	  }

	public void updateCoordinate() {
		for (int y = 0; y < 16; y++) {
			for (int x = 0; x < 16; x++) {
				for (int j = 0; j < 5; j++) {
					for (int i = 0; i < 5; i++) {
						UrbanAutonomous.simCoordinate[x * 5 + i][y * 5 + j] = mapBlockArray[x][y].tileArray[i][j];
					}
				}
			}
		}
	}

	public void mapImgCreation() {
		pg = p.createGraphics(800, 800);
		pg.beginDraw();
		pg.background(255);
		pg.stroke(255);
		for (int y = 0; y < 16; y++)
			for (int x = 0; x < 16; x++)
				pg.image(UrbanAutonomous.mapBlockStack.mapBlockArray[x][y].pg, x * 50, y * 50);
		pg.endDraw();
	}
}
