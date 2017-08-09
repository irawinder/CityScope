
public class Demand {
	public int streetNumber;
	public int x;
	public int y;
	public boolean isHorizontalStreet;
	public boolean isDepartureDemand;
	public int lifetime;// steps

	public Demand(int _x, int _y, int _streetNumber, boolean _isHorizontalStreet, boolean _isDepartureDemand) {
		x = _x;
		y = _y;
		streetNumber = _streetNumber;
		isHorizontalStreet = _isHorizontalStreet;
		isDepartureDemand = _isDepartureDemand;
		lifetime = UrbanAutonomous.simParam.demandLifetime * 10;// unit:steps (min* 10)
	}

	public Demand(int _x, int _y) {
		x = _x;
		y = _y;
	}
}
