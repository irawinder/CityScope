import java.util.ArrayList;


import processing.core.PApplet;

public class HubVehicle {

	public int x;
	public int y;
	public int streetNumber;
	public boolean isHorizontalStreet;
	public boolean isIntersection;
	public boolean toHubA;
	ArrayList<Demand> arrivalList;
	public ArrayList<Coord> movingHistoryList;
	PApplet p;

	public HubVehicle(int _x, int _y, PApplet _p) {
		x = _x;
		y = _y;
		p = _p;
		toHubA = false;
		arrivalList = new ArrayList<Demand>();
		movingHistoryList = new ArrayList<Coord>();
	}

	// Parameter Update
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

	// Vehicle Movement
	public void move() {
		paramUpdate();
		movingHistoryUpdate();
		eachMove();
	}

	void movingHistoryUpdate() {
		Coord tmpVehiclePosition = new Coord(x, y);
		if (!(isInHub()))
			movingHistoryList.add(tmpVehiclePosition);
		if (isInHub() && movingHistoryList.size() > 0)
			movingHistoryList.remove(0);
		if (movingHistoryList.size() >= UrbanAutonomous.simParam.vehicleHistorySize)
			movingHistoryList.remove(0);
	}

	boolean isInHub() {
		boolean result = false;
		if (UrbanAutonomous.hubStack.hubA.y == y && UrbanAutonomous.hubStack.hubA.y == y)
			result = true;
		if (UrbanAutonomous.hubStack.hubB.y == y && UrbanAutonomous.hubStack.hubB.y == y)
			result = true;
		return result;
	}

	void eachMove() {
		if (toHubA)
			eachSubMove(UrbanAutonomous.hubStack.hubA);
		else
			eachSubMove(UrbanAutonomous.hubStack.hubB);
	}

	boolean hubIsNotEmpty() {
		boolean result = false;
		if (UrbanAutonomous.hubStack.hubA.hubVehicleWaitingList.size() > 0
				|| UrbanAutonomous.hubStack.hubB.hubVehicleWaitingList.size() > 0)
			result = true;
		return result;
	}

	void eachSubMove(Hub hubX) {
		if (isSamePoint(hubX)) {
			hubX.unallocatedArrivalList.addAll(arrivalList);
			if (hubIsNotEmpty()) {
				toHubA = !toHubA;
				arrivalList = new ArrayList<Demand>();
				while (arrivalList.size() < UrbanAutonomous.simParam.hubDedicatedVehicleCapacity
						&& hubX.hubVehicleWaitingList.size() != 0) {
					arrivalList.add(hubX.hubVehicleWaitingList.get(0));
				}
			}
		} else if (isSameStreet(hubX)) {
			if (hubX.isHorizontalStreet)
				x += (hubX.x - x) / p.abs(hubX.x - x);
			else
				y += (hubX.y - y) / p.abs(hubX.y - y);
		} else {
			if (isIntersection) {
				if (hubX.isHorizontalStreet)
					y += (hubX.y - y) / p.abs(hubX.y - y);
				else
					x += (hubX.x - x) / p.abs(hubX.x - x);
			} else {
				if (isHorizontalStreet) {
					if (hubX.isHorizontalStreet) {
						if (x > 77) {
							x -= 1;
						} else {
							x += 1;
						}
					} else {
						x += (hubX.x - x) / p.abs(hubX.x - x);
					}
				} else {
					if (hubX.isHorizontalStreet) {
						y += (hubX.y - y) / p.abs(hubX.y - y);
					} else {
						if (y > 77) {
							y -= 1;
						} else {
							y += 1;
						}
					}
				}
			}
		}
	}

	boolean isSameStreet(Hub hubA) {
		boolean result = false;
		if (hubA.streetNumber == streetNumber && hubA.isHorizontalStreet == isHorizontalStreet)
			result = true;
		else if (isIntersection) {
			if (hubA.isHorizontalStreet) {
				if ((((y - 2 + 5) / 5) - 1) == hubA.streetNumber)
					result = true;
			} else {
				if ((((x - 2 + 5) / 5) - 1) == hubA.streetNumber)
					result = true;
			}
		}
		return result;
	}

	boolean isSamePoint(Hub hub) {
		boolean result = false;
		if (hub.x == x && hub.y == y)
			result = true;
		return result;
	}
}
