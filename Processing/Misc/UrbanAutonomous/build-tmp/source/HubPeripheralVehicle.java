
import java.util.ArrayList;

import processing.core.PApplet;

public class HubPeripheralVehicle {
	public int x;
	public int y;
	public int streetNumber;
	public boolean isHorizontalStreet;
	public boolean isIntersection;
	public boolean forHubA;

	public ArrayList<Demand> departureList;
	public ArrayList<Demand> reserveArrivalList;
	public ArrayList<Demand> arrivalList;
	public ArrayList<Coord> movingHistoryList;
	PApplet p;
	public PeripheralVehicleStatus status;

	public HubPeripheralVehicle(int _x, int _y, PApplet _p, boolean _forHubA) {
		status = PeripheralVehicleStatus.STOP;
		x = _x;
		y = _y;
		p = _p;
		forHubA = _forHubA;
		departureList = new ArrayList<Demand>();
		arrivalList = new ArrayList<Demand>();
		reserveArrivalList = new ArrayList<Demand>();
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
		switch (status) {
		case STOP:
			break;
		case DEPARTURE:
			eachMove(departureList);
			break;
		case TOHUB:
			if (forHubA)
				goToHub(UrbanAutonomous.hubStack.hubA);
			else
				goToHub(UrbanAutonomous.hubStack.hubB);
			break;
		case ARRIVAL:
			eachMove(arrivalList);
			break;
		default:
			break;
		}
	}

	void movingHistoryUpdate() {
		Coord tmpVehiclePosition = new Coord(x, y);
		if (status == PeripheralVehicleStatus.STOP) {
			if (movingHistoryList.size() > 0)
				movingHistoryList.remove(0);
		} else if (movingHistoryList.size() >= UrbanAutonomous.simParam.vehicleHistorySize)
			movingHistoryList.remove(0);
		else
			movingHistoryList.add(tmpVehiclePosition);
	}

	void eachMove(ArrayList<Demand> tmpList) {
		if (isSamePoint(tmpList.get(0))) {
			tmpList.remove(0);
			if (tmpList.size() == 0)
				if (status == PeripheralVehicleStatus.DEPARTURE)
					status = PeripheralVehicleStatus.TOHUB;
				else if (status == PeripheralVehicleStatus.ARRIVAL)
					status = PeripheralVehicleStatus.STOP;
		} else if (isSameStreet(tmpList.get(0))) {
			if (tmpList.get(0).isHorizontalStreet)
				x += (tmpList.get(0).x - x) / p.abs(tmpList.get(0).x - x);
			else
				y += (tmpList.get(0).y - y) / p.abs(tmpList.get(0).y - y);
		} else {
			if (isIntersection) {
				if (tmpList.get(0).isHorizontalStreet)
					y += (tmpList.get(0).y - y) / p.abs(tmpList.get(0).y - y);
				else
					x += (tmpList.get(0).x - x) / p.abs(tmpList.get(0).x - x);
			} else {
				if (isHorizontalStreet) {
					if (tmpList.get(0).isHorizontalStreet) {
						if (x > 77) {
							x -= 1;
						} else {
							x += 1;
						}
					} else {
						x += (tmpList.get(0).x - x) / p.abs(tmpList.get(0).x - x);
					}
				} else {
					if (tmpList.get(0).isHorizontalStreet) {
						y += (tmpList.get(0).y - y) / p.abs(tmpList.get(0).y - y);
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

	void goToHub(Hub tmpHub) {
		if (isSamePoint(tmpHub)) {
			tmpHub.hubVehicleWaitingList.addAll(reserveArrivalList);
			reserveArrivalList = new ArrayList<Demand>();
			if (tmpHub.unallocatedArrivalList.size() > 0) {
				status = PeripheralVehicleStatus.ARRIVAL;
				while (arrivalList.size() < UrbanAutonomous.simParam.capacityOfPeripheralVehicle
						|| tmpHub.unallocatedArrivalList.size() > 0) {
					arrivalList.add(tmpHub.unallocatedArrivalList.remove(0));
				}
			} else {
				status = PeripheralVehicleStatus.STOP;
			}
		} else if (isSameStreet(tmpHub)) {
			if (tmpHub.isHorizontalStreet)
				x += (tmpHub.x - x) / p.abs(tmpHub.x - x);
			else
				y += (tmpHub.y - y) / p.abs(tmpHub.y - y);
		} else {
			if (isIntersection) {
				if (tmpHub.isHorizontalStreet)
					y += (tmpHub.y - y) / p.abs(tmpHub.y - y);
				else
					x += (tmpHub.x - x) / p.abs(tmpHub.x - x);
			} else {
				if (isHorizontalStreet) {
					if (tmpHub.isHorizontalStreet) {
						if (x > 77) {
							x -= 1;
						} else {
							x += 1;
						}
					} else {
						x += (tmpHub.x - x) / p.abs(tmpHub.x - x);
					}
				} else {
					if (tmpHub.isHorizontalStreet) {
						y += (tmpHub.y - y) / p.abs(tmpHub.y - y);
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

	boolean isSameStreet(Demand tmpDemand) {
		boolean result = false;
		if (tmpDemand.streetNumber == streetNumber && tmpDemand.isHorizontalStreet == isHorizontalStreet)
			result = true;
		else if (isIntersection) {
			if (tmpDemand.isHorizontalStreet) {
				if ((((y - 2 + 5) / 5) - 1) == tmpDemand.streetNumber)
					result = true;
			} else {
				if ((((x - 2 + 5) / 5) - 1) == tmpDemand.streetNumber)
					result = true;
			}
		}
		return result;
	}

	boolean isSamePoint(Demand tmpDemand) {
		boolean result = false;
		if (tmpDemand.x == x && tmpDemand.y == y)
			result = true;
		return result;
	}

	boolean isSameStreet(Hub tmpDemand) {
		boolean result = false;
		if (tmpDemand.streetNumber == streetNumber && tmpDemand.isHorizontalStreet == isHorizontalStreet)
			result = true;
		else if (isIntersection) {
			if (tmpDemand.isHorizontalStreet) {
				if ((((y - 2 + 5) / 5) - 1) == tmpDemand.streetNumber)
					result = true;
			} else {
				if ((((x - 2 + 5) / 5) - 1) == tmpDemand.streetNumber)
					result = true;
			}
		}
		return result;
	}

	boolean isSamePoint(Hub tmpDemand) {
		boolean result = false;
		if (tmpDemand.x == x && tmpDemand.y == y)
			result = true;
		return result;
	}
}
