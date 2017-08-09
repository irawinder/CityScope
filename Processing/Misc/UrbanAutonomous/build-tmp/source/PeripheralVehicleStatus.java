
public enum PeripheralVehicleStatus {
	  STOP(1), 
	  DEPARTURE(2), 
	  TOHUB(3),
	  ARRIVAL(4);

	  private final int id;

	  private PeripheralVehicleStatus(final int id) {
	    this.id = id;
	  }

	  public int getId() {
	    return id;
	  }

}
