
public enum Status {
	  CONFIG(1), 
	  RUN(2), 
	  STOP(3);

	  private final int id;

	  private Status(final int id) {
	    this.id = id;
	  }

	  public int getId() {
	    return id;
	  }
	}
