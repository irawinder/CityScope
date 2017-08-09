
import processing.core.PApplet;
import processing.core.PGraphics;

public class MapBlock {
	PApplet p;
	int blockSize;
	Tile[][] tileArray;
	public PGraphics pg;

	public MapBlock() {
	}

	public MapBlock(PApplet _p) {
		p = _p;
	}

	public MapBlock(PApplet _p, Tile[][] _tileArray) {
		p = _p;
		blockSize = 5;
		tileArray = _tileArray;
		gen();
	}

	void gen() {
		if (pg == null)
			pg = p.createGraphics(blockSize * 10, blockSize * 10);
		pg.beginDraw();
		pg.background(255);
		pg.stroke(255);
		for (int y = 0; y < blockSize; y++) {
			for (int x = 0; x < blockSize; x++) {
				//for abstraction, delete road
				if(x==2||y==2)
					tileArray[x][y].tileType=tileArray[0][0].tileType;

				switch (tileArray[x][y].tileType) {
				case HW:
					pg.image(UrbanAutonomous.hwImg, x * 10, y * 10);
					break;
				case LW:
					pg.image(UrbanAutonomous.lwImg, x * 10, y * 10);
					break;
				case HR:
					pg.image(UrbanAutonomous.hrImg, x * 10, y * 10);
					break;
				case LR:
					pg.image(UrbanAutonomous.lrImg, x * 10, y * 10);
					break;
				case ROAD:
					pg.image(UrbanAutonomous.roadImg, x * 10, y * 10);
					break;
				case INTERSECTION:
					pg.image(UrbanAutonomous.intersectionImg, x * 10, y * 10);
					break;
				case NONE:
					pg.image(UrbanAutonomous.noneImg, x * 10, y * 10);
					break;
				default:
					break;
				}
			}
		}
		pg.endDraw();
	}
}
