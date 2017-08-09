public enum DragStatus {
	  NORMAL(1), 
	  HUBA(2), 
	  HUBB(3);

	  private final int id;

	  private DragStatus(final int id) {
	    this.id = id;
	  }

	  public int getId() {
	    return id;
	  }

}
