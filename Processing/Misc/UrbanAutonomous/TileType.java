
public enum TileType {
	  HW(1), 
	  LW(2), 
	  HR(3), 
	  LR(4),
	  ROAD(5),
	  INTERSECTION(6),
	  NONE(7);

	  private final int id;

	  private TileType(final int id) {
	    this.id = id;
	  }

	  public int getId() {
	    return id;
	  }
	}