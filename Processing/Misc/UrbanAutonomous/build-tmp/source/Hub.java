
import java.util.ArrayList;

public class Hub {
	public int x;
	public int y;
	public boolean isHorizontalStreet;
	public boolean isIntersection;
	public int streetNumber;
	public ArrayList<Demand> unallocatedArrivalList;
	public ArrayList<Demand> hubVehicleWaitingList;

	public Hub(int _x, int _y) {
		x = _x;
		y = _y;
		unallocatedArrivalList = new ArrayList<Demand>();
		hubVehicleWaitingList = new ArrayList<Demand>();
		paramUpdate();
	}

	void paramUpdate() {
		isHorizontalStreet = false;
		isIntersection = false;
		streetNumber = 0;
		if (isHorizontalStreetCheck()) {
			isHorizontalStreet = true;
			streetNumber = ((y + 5 - 2) / 5) - 1;
		} else {
			streetNumber = ((x + 5 - 2) / 5) - 1;
		}
		if (isVerticalStreetCheck() && isHorizontalStreetCheck())
			isIntersection = true;
	}

	boolean isHorizontalStreetCheck() {
		boolean result = false;
		if ((y - 2 + 5) % 5 == 0)
			result = true;
		return result;
	}

	boolean isVerticalStreetCheck() {
		boolean result = false;
		if ((x - 2 + 5) % 5 == 0)
			result = true;
		return result;
	}
}
