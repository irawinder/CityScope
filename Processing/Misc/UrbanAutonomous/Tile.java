
public class Tile {
	  public float [] departureProbabilityArray;
	  public float [] arrivalProbabilityArray;
	  public TileType tileType;
	  Tile(float [] departure, float [] arrival,TileType _tileType) {
	    departureProbabilityArray = departure;
	    arrivalProbabilityArray = arrival;
	    tileType=_tileType;
	  }
	}