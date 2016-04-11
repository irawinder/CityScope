
import processing.core.PApplet;
import processing.core.PGraphics;
import static java.lang.System.out;
public class MapBlockStack extends MapBlockBase{
	public MapBlock[][] mapBlockArray;
	public PGraphics pg;
	PApplet p;

	public MapBlockStack(PApplet _p) {
		p=_p;
		mapBlockArray = new MapBlock[UrbanAutonomous.simParam.maxX][UrbanAutonomous.simParam.maxY];
		randomGen();
	}


	public void randomGen() {
		for (int y = 0; y < UrbanAutonomous.simParam.maxY; y++)
			for (int x = 0; x < UrbanAutonomous.simParam.maxX; x++)
				mapBlockArray[x][y] = new MapBlock(this.p,specificTileArrayGen(p));
	}

	public void customMapGen() {
		UrbanAutonomous.simParam.mapType = 2;
		for (int y = 0; y < UrbanAutonomous.simParam.maxY; y++)
			for (int x = 0; x < UrbanAutonomous.simParam.maxX; x++)
				mapBlockArray[x][y] = UrbanAutonomous.mapBlockBrushs.specificBrushs[0];
	}

	public void noneMapGen() {
		//fileControl.customMap[UrbanAutonomous.simParam.maxX * y + x] = brushNumber;
		for (int i = 0; i < UrbanAutonomous.simParam.maxY*UrbanAutonomous.simParam.maxX; i++)
			UrbanAutonomous.fileControl.customMap[i] = 3;
		UrbanAutonomous.simParam.mapType = 2;
		for (int y = 0; y < UrbanAutonomous.simParam.maxY; y++)
			for (int x = 0; x < UrbanAutonomous.simParam.maxX; x++)
				mapBlockArray[x][y] = UrbanAutonomous.mapBlockBrushs.specificBrushs[3];
	}

	public void loadUrbanMap() {
	    UrbanAutonomous.simParam.mapType=0;
	    String lines[] = p.loadStrings("urbanMap.txt");
	    for (int y=0; y<UrbanAutonomous.simParam.maxY; y++)
	      for (int x=0; x<UrbanAutonomous.simParam.maxX; x++)
	        mapBlockArray[x][y]= UrbanAutonomous.mapBlockBrushs.specificBrushs[Integer.parseInt(lines[y*UrbanAutonomous.simParam.maxX+x])];
	  }

	public void loadRuralMap() {
	    UrbanAutonomous.simParam.mapType=1;
	    String lines[] = p.loadStrings("ruralMap.txt");
	    for (int y=0; y<UrbanAutonomous.simParam.maxY; y++)
	      for (int x=0; x<UrbanAutonomous.simParam.maxX; x++)
	        mapBlockArray[x][y]= UrbanAutonomous.mapBlockBrushs.specificBrushs[Integer.parseInt(lines[y*UrbanAutonomous.simParam.maxX+x])];
	  }

	public void updateCoordinate() {
		for (int y = 0; y < UrbanAutonomous.simParam.maxY; y++) {
			for (int x = 0; x < UrbanAutonomous.simParam.maxX; x++) {
				for (int j = 0; j < 5; j++) {
					for (int i = 0; i < 5; i++) {
						//out.print(x*5+i);
						//out.print(',');
						//out.println(y*5+j);

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
		for (int y = 0; y < UrbanAutonomous.simParam.maxY; y++)
			for (int x = 0; x < UrbanAutonomous.simParam.maxX; x++)
				pg.image(UrbanAutonomous.mapBlockStack.mapBlockArray[x][y].pg, x * 50, y * 50);
		pg.endDraw();
	}
}
