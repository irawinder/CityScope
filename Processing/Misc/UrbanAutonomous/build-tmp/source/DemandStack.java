
import java.util.ArrayList;
import java.util.Iterator;


import processing.core.PApplet;

public class DemandStack extends PApplet {
	public ArrayList<Demand> unallocatedArrivalList;
	public ArrayList<Demand> unallocatedDepartureList;
	public ArrayList<Demand> unallocatedHubArrivalList;
	public ArrayList<Demand> unallocatedHubDepartureList;
	boolean isHorizontalStreet;
	public int[] unallocatedDemandSizeHistory;
	public int missedDemand;
	public int[] missedDemandHistory;

	public DemandStack() {
		missedDemand = 0;
		missedDemandHistory = new int[720];
		unallocatedArrivalList = new ArrayList<Demand>();
		unallocatedDepartureList = new ArrayList<Demand>();
		unallocatedHubArrivalList = new ArrayList<Demand>();
		unallocatedHubDepartureList = new ArrayList<Demand>();
		isHorizontalStreet = true;
		unallocatedDemandSizeHistory = new int[720];
		for (int i = 0; i < 720; i++)
			unallocatedDemandSizeHistory[i] = 0;
	}

	public void init() {
		missedDemand = 0;
		missedDemandHistory = new int[720];
		unallocatedArrivalList = new ArrayList<Demand>();
		unallocatedDepartureList = new ArrayList<Demand>();
		unallocatedHubArrivalList = new ArrayList<Demand>();
		unallocatedHubDepartureList = new ArrayList<Demand>();
		isHorizontalStreet = true;
		unallocatedDemandSizeHistory = new int[720];
		for (int i = 0; i < 720; i++)
			unallocatedDemandSizeHistory[i] = 0;
	}

	// Demand Generation
	public void demandGen(int _numberOfDemand, int _updateInterval) {
		//java.lang.System.out.println("test");
		if (UrbanAutonomous.simParam.currentTime % _updateInterval == 0) {
			for (int i = 0; i < _numberOfDemand; i++) {
				isHorizontalStreet = !isHorizontalStreet;
				Demand tmpArrivalDemand = demandCreation(false);
				Demand tmpDepartureDemand = demandCreation(true);
				// Demand Clarification
				if (UrbanAutonomous.simParam.hubEnable) {
					if (isHubEffective(tmpArrivalDemand, tmpDepartureDemand)) {
						unallocatedHubArrivalList.add(tmpArrivalDemand);
						unallocatedHubDepartureList.add(tmpDepartureDemand);// departureDemand
					} else{
					}
				}
				else {
					unallocatedArrivalList.add(tmpArrivalDemand);
					unallocatedDepartureList.add(tmpDepartureDemand);// departureDemand
				}
			}
		}
	}

	// DemandCreation
	Demand demandCreation(boolean isDepartureDemand) {
		while (true) {
			Demand demandCandidate = demandCandidateGen(isHorizontalStreet, isDepartureDemand);
			if (probabilityCheck(demandCandidate)) {
				return demandCandidate;
			}
		}
	}

	// Demand Candidate Generation
	Demand demandCandidateGen(boolean isHorizontalStreet, boolean isDepartureDemand) {
		Demand _demandCandidate;
		if (isHorizontalStreet) {
			int streetNumber = (int) random(UrbanAutonomous.simParam.maxY);
			int y = streetNumber * 5 + 2;
			int x = (int) random(5*UrbanAutonomous.simParam.maxX);
			_demandCandidate = new Demand(x, y, streetNumber, isHorizontalStreet, isDepartureDemand);
		} else {
			int streetNumber = (int) random(UrbanAutonomous.simParam.maxX);
			int x = streetNumber * 5 + 2;
			int y = (int) random(5*UrbanAutonomous.simParam.maxY);
			_demandCandidate = new Demand(x, y, streetNumber, isHorizontalStreet, isDepartureDemand);
		}
		return _demandCandidate;
	}

	// probability check
	boolean probabilityCheck(Demand _demandCandidate) {
		boolean determination = false;
		float sum = 0;
		float avgProbability;
		if (_demandCandidate.isDepartureDemand) {
			if (_demandCandidate.isHorizontalStreet) {
				sum = UrbanAutonomous.simCoordinate[_demandCandidate.x][_demandCandidate.y
						- 2].departureProbabilityArray[UrbanAutonomous.simParam.currentTimeZone]
						+ UrbanAutonomous.simCoordinate[_demandCandidate.x][_demandCandidate.y
								- 1].departureProbabilityArray[UrbanAutonomous.simParam.currentTimeZone]
						+ UrbanAutonomous.simCoordinate[_demandCandidate.x][_demandCandidate.y
								+ 1].departureProbabilityArray[UrbanAutonomous.simParam.currentTimeZone]
						+ UrbanAutonomous.simCoordinate[_demandCandidate.x][_demandCandidate.y
								+ 2].departureProbabilityArray[UrbanAutonomous.simParam.currentTimeZone];
			} else {
				sum = UrbanAutonomous.simCoordinate[_demandCandidate.x
						- 2][_demandCandidate.y].departureProbabilityArray[UrbanAutonomous.simParam.currentTimeZone]
						+ UrbanAutonomous.simCoordinate[_demandCandidate.x
								- 1][_demandCandidate.y].departureProbabilityArray[UrbanAutonomous.simParam.currentTimeZone]
						+ UrbanAutonomous.simCoordinate[_demandCandidate.x
								+ 1][_demandCandidate.y].departureProbabilityArray[UrbanAutonomous.simParam.currentTimeZone]
						+ UrbanAutonomous.simCoordinate[_demandCandidate.x
								+ 2][_demandCandidate.y].departureProbabilityArray[UrbanAutonomous.simParam.currentTimeZone];
			}
		} else {
			if (_demandCandidate.isHorizontalStreet) {
				sum = UrbanAutonomous.simCoordinate[_demandCandidate.x][_demandCandidate.y
						- 2].arrivalProbabilityArray[UrbanAutonomous.simParam.currentTimeZone]
						+ UrbanAutonomous.simCoordinate[_demandCandidate.x][_demandCandidate.y
								- 1].arrivalProbabilityArray[UrbanAutonomous.simParam.currentTimeZone]
						+ UrbanAutonomous.simCoordinate[_demandCandidate.x][_demandCandidate.y
								+ 1].arrivalProbabilityArray[UrbanAutonomous.simParam.currentTimeZone]
						+ UrbanAutonomous.simCoordinate[_demandCandidate.x][_demandCandidate.y
								+ 2].arrivalProbabilityArray[UrbanAutonomous.simParam.currentTimeZone];
			} else {
				sum = UrbanAutonomous.simCoordinate[_demandCandidate.x
						- 2][_demandCandidate.y].arrivalProbabilityArray[UrbanAutonomous.simParam.currentTimeZone]
						+ UrbanAutonomous.simCoordinate[_demandCandidate.x
								- 1][_demandCandidate.y].arrivalProbabilityArray[UrbanAutonomous.simParam.currentTimeZone]
						+ UrbanAutonomous.simCoordinate[_demandCandidate.x
								+ 1][_demandCandidate.y].arrivalProbabilityArray[UrbanAutonomous.simParam.currentTimeZone]
						+ UrbanAutonomous.simCoordinate[_demandCandidate.x
								+ 2][_demandCandidate.y].arrivalProbabilityArray[UrbanAutonomous.simParam.currentTimeZone];
			}
		}
		if (sum != 0) {
			avgProbability = sum * 100 / 4;
			if ((int) random(1 / (avgProbability / 100)) == 0)
				determination = true;
		}
		return determination;
	}

	// DemandAllocation for Hub
	public void demandHubAllocation() {
		if (unallocatedHubListIsNotEmpty()) {
			if (UrbanAutonomous.hubStack.hubPeripheralVehicleA.status == PeripheralVehicleStatus.STOP) {
				for (int i = 0; i < unallocatedHubDepartureList.size(); i++) {
					if (fromHubAtoB(unallocatedHubArrivalList.get(i), unallocatedHubDepartureList.get(i))) {
						UrbanAutonomous.hubStack.hubPeripheralVehicleA.status = PeripheralVehicleStatus.DEPARTURE;
						UrbanAutonomous.hubStack.hubPeripheralVehicleA.departureList
								.add(unallocatedHubDepartureList.remove(i));
						UrbanAutonomous.hubStack.hubPeripheralVehicleA.reserveArrivalList
								.add(unallocatedHubArrivalList.remove(i));
					}
				}
			}
			if (UrbanAutonomous.hubStack.hubPeripheralVehicleB.status == PeripheralVehicleStatus.STOP) {
				for (int i = 0; i < unallocatedHubDepartureList.size(); i++) {
					if (fromHubBtoA(unallocatedHubArrivalList.get(i), unallocatedHubDepartureList.get(i))) {
						UrbanAutonomous.hubStack.hubPeripheralVehicleB.status = PeripheralVehicleStatus.DEPARTURE;
						UrbanAutonomous.hubStack.hubPeripheralVehicleB.departureList
								.add(unallocatedHubDepartureList.remove(i));
						UrbanAutonomous.hubStack.hubPeripheralVehicleB.reserveArrivalList
								.add(unallocatedHubArrivalList.remove(i));
					}
				}
			}
		}
	}

	boolean hubPeripheralVehicleIsEmpty(HubPeripheralVehicle v) {
		boolean result = false;
		if (v.arrivalList.size() == 0 && v.departureList.size() == 0 && v.reserveArrivalList.size() == 0)
			result = true;
		return result;
	}

	boolean unallocatedHubListIsNotEmpty() {
		boolean result = false;
		if (unallocatedHubDepartureList.size() > 0 || unallocatedHubArrivalList.size() > 0) {
			result = true;
		}
		return result;
	}
	//usage rate
	public int usageRateCal(){
		int result=10;
		int totalVehicle=UrbanAutonomous.simParam.numberOfVehicle;
		int usingVehicle=0;
		for (Vehicle vehicle : UrbanAutonomous.vehicleStack.vehicleList) {
			if(vehicle.departureList.size()==0&&vehicle.arrivalList.size()==0)
				;
			else{
				usingVehicle++;
			}
		}
		result = 100* usingVehicle/totalVehicle;

		if(result==0)
			result=100;

		if(result<50){
			if(UrbanAutonomous.simParam.numberOfVehicle>1){
				//UrbanAutonomous.vehicleStack.vehicleList.remove(UrbanAutonomous.vehicleStack.vehicleList.size()-1);
				int tmp=UrbanAutonomous.simParam.numberOfVehicle/3;
				if(tmp>0)
					UrbanAutonomous.simParam.numberOfVehicle=tmp;
				else{
					UrbanAutonomous.simParam.numberOfVehicle=1;
				}

			    UrbanAutonomous.vehicleStack.vehicleGen();
			}
		}

		return result;

	}

	// DemandAllocation except hub
	public void demandAllocation() {
		if (unallocatedDepartureList.size() > 0 || unallocatedArrivalList.size() > 0) {
			for (Vehicle vehicle : UrbanAutonomous.vehicleStack.vehicleList) {
				if (vehicle.arrivalList.size() == 0 && vehicle.departureList.size() == 0) {
					while (vehicle.arrivalList.size() < UrbanAutonomous.simParam.capacityOfVehicle
							&& vehicle.departureList.size() < UrbanAutonomous.simParam.capacityOfVehicle) {
						if (unallocatedDepartureList.size() > 0 || unallocatedArrivalList.size() > 0) {
							vehicle.arrivalList.add(unallocatedArrivalList.get(0));
							vehicle.departureList.add(unallocatedDepartureList.get(0));
							unallocatedArrivalList.remove(0);
							unallocatedDepartureList.remove(0);
						} else {
							break;
						}
					}
				}
			}
		}
	}

	// Hub effectiveCheck
	boolean isHubEffective(Demand arrivalDemand, Demand departureDemand) {
		boolean result = false;
		if (arrivalDemand.x > UrbanAutonomous.hubStack.hubA.x - UrbanAutonomous.simParam.hubEffectiveLength
				&& arrivalDemand.x < UrbanAutonomous.hubStack.hubA.x + UrbanAutonomous.simParam.hubEffectiveLength
				&& arrivalDemand.y > UrbanAutonomous.hubStack.hubA.y - UrbanAutonomous.simParam.hubEffectiveLength
				&& arrivalDemand.y < UrbanAutonomous.hubStack.hubA.y + UrbanAutonomous.simParam.hubEffectiveLength)
			if (departureDemand.x > UrbanAutonomous.hubStack.hubB.x - UrbanAutonomous.simParam.hubEffectiveLength
					&& departureDemand.x < UrbanAutonomous.hubStack.hubB.x + UrbanAutonomous.simParam.hubEffectiveLength
					&& departureDemand.y > UrbanAutonomous.hubStack.hubB.y - UrbanAutonomous.simParam.hubEffectiveLength
					&& departureDemand.y < UrbanAutonomous.hubStack.hubB.y + UrbanAutonomous.simParam.hubEffectiveLength)
				result = true;

		if (arrivalDemand.x > UrbanAutonomous.hubStack.hubB.x - UrbanAutonomous.simParam.hubEffectiveLength
				&& arrivalDemand.x < UrbanAutonomous.hubStack.hubB.x + UrbanAutonomous.simParam.hubEffectiveLength
				&& arrivalDemand.y > UrbanAutonomous.hubStack.hubB.y - UrbanAutonomous.simParam.hubEffectiveLength
				&& arrivalDemand.y < UrbanAutonomous.hubStack.hubB.y + UrbanAutonomous.simParam.hubEffectiveLength)
			if (departureDemand.x > UrbanAutonomous.hubStack.hubA.x - UrbanAutonomous.simParam.hubEffectiveLength
					&& departureDemand.x < UrbanAutonomous.hubStack.hubA.x + UrbanAutonomous.simParam.hubEffectiveLength
					&& departureDemand.y > UrbanAutonomous.hubStack.hubA.y - UrbanAutonomous.simParam.hubEffectiveLength
					&& departureDemand.y < UrbanAutonomous.hubStack.hubA.y + UrbanAutonomous.simParam.hubEffectiveLength)
				result = true;
		return result;
	}

	// fromHubA to fromHubB
	boolean fromHubBtoA(Demand arrivalDemand, Demand departureDemand) {
		boolean result = false;
		if (arrivalDemand.x > UrbanAutonomous.hubStack.hubA.x - UrbanAutonomous.simParam.hubEffectiveLength
				&& arrivalDemand.x < UrbanAutonomous.hubStack.hubA.x + UrbanAutonomous.simParam.hubEffectiveLength
				&& arrivalDemand.y > UrbanAutonomous.hubStack.hubA.y - UrbanAutonomous.simParam.hubEffectiveLength
				&& arrivalDemand.y < UrbanAutonomous.hubStack.hubA.y + UrbanAutonomous.simParam.hubEffectiveLength)
			if (departureDemand.x > UrbanAutonomous.hubStack.hubB.x - UrbanAutonomous.simParam.hubEffectiveLength
					&& departureDemand.x < UrbanAutonomous.hubStack.hubB.x + UrbanAutonomous.simParam.hubEffectiveLength
					&& departureDemand.y > UrbanAutonomous.hubStack.hubB.y - UrbanAutonomous.simParam.hubEffectiveLength
					&& departureDemand.y < UrbanAutonomous.hubStack.hubB.y + UrbanAutonomous.simParam.hubEffectiveLength)
				result = true;
		return result;
	}

	// fromHubA to fromHubB
	boolean fromHubAtoB(Demand arrivalDemand, Demand departureDemand) {
		boolean result = false;
		if (arrivalDemand.x > UrbanAutonomous.hubStack.hubB.x - UrbanAutonomous.simParam.hubEffectiveLength
				&& arrivalDemand.x < UrbanAutonomous.hubStack.hubB.x + UrbanAutonomous.simParam.hubEffectiveLength
				&& arrivalDemand.y > UrbanAutonomous.hubStack.hubB.y - UrbanAutonomous.simParam.hubEffectiveLength
				&& arrivalDemand.y < UrbanAutonomous.hubStack.hubB.y + UrbanAutonomous.simParam.hubEffectiveLength)
			if (departureDemand.x > UrbanAutonomous.hubStack.hubA.x - UrbanAutonomous.simParam.hubEffectiveLength
					&& departureDemand.x < UrbanAutonomous.hubStack.hubA.x + UrbanAutonomous.simParam.hubEffectiveLength
					&& departureDemand.y > UrbanAutonomous.hubStack.hubA.y - UrbanAutonomous.simParam.hubEffectiveLength
					&& departureDemand.y < UrbanAutonomous.hubStack.hubA.y + UrbanAutonomous.simParam.hubEffectiveLength)
				result = true;
		return result;
	}

	// DemandLifeTime
	public void demandLifetimeControl() {
		if (unallocatedArrivalList.size() > 0) {
			Iterator<Demand> iter = unallocatedArrivalList.iterator();
			while (iter.hasNext()) {
				Demand tmpDemand = iter.next();
				if (tmpDemand.lifetime == 0) {
					iter.remove();
					missedDemand++;
					UrbanAutonomous.simParam.numberOfVehicle++;
			        UrbanAutonomous.vehicleStack.vehicleGen();
					// missedDemandHistory[UrbanAutonomous.simParam.currentTime/20]=missedDemand;
				} else {
					tmpDemand.lifetime -= 1;
				}
			}
			missedDemandHistory[UrbanAutonomous.simParam.currentTime / 20] = missedDemand;
			iter = unallocatedDepartureList.iterator();
			while (iter.hasNext()) {
				Demand tmpDemand = iter.next();
				if (tmpDemand.lifetime == 0) {
					iter.remove();
				} else {
					tmpDemand.lifetime -= 1;
				}
			}
		}
	}
}
