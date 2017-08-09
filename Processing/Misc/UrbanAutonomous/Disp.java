

import processing.core.PApplet;
import processing.core.PConstants;
import processing.core.PGraphics;
//import com.y;

public class Disp {
	PApplet pa;
	PGraphics p;

	//public Disp(PApplet _pa) {
	public Disp(PGraphics _p,PApplet _pa) {
		p = _p;
		pa = _pa;
	}

	// ShowALl
	public void show() {
		// showMap();
		p.beginDraw();
		oldshowMap();
		showUnallocatedDemand();
		showAllocatedDemand();
		showVehicle();
		showCongestion();
		if (UrbanAutonomous.simParam.hubEnable) {
			showHub();
			showHubVehicle();
			showHubPeripheralVehicle();
			showHubRelocation();
		}
		p.endDraw();
	}
	//ShowHubRelocation
	void showHubRelocation(){
		if (UrbanAutonomous.dragStatus == DragStatus.HUBA || UrbanAutonomous.dragStatus == DragStatus.HUBB) {
			p.ellipseMode(PConstants.CENTER);
			p.stroke(UrbanAutonomous.hubColor);
			p.ellipse(pa.mouseX, pa.mouseY, 10, 10);
		}
	}

	// ShowMap
	void oldshowMap() {
		for (int y = 0; y < UrbanAutonomous.simParam.maxY; y++)
			for (int x = 0; x < UrbanAutonomous.simParam.maxX; x++)
				p.image(UrbanAutonomous.mapBlockStack.mapBlockArray[x][y].pg, x * 50, y * 50);
	}

	void showMap() {
		p.image(UrbanAutonomous.mapBlockStack.pg, 0, 0);
	}

	// ShowDemand
	// ShowUnallocatedDemand
	void showUnallocatedDemand() {
		for (Demand tmpDemand : UrbanAutonomous.demandStack.unallocatedArrivalList) {
			showEachDemand(tmpDemand);
		}
		for (Demand tmpDemand : UrbanAutonomous.demandStack.unallocatedDepartureList) {
			showEachDemand(tmpDemand);
		}
	}

	// ShowAllocatedDemand
	void showAllocatedDemand() {
		for (Vehicle vehicle : UrbanAutonomous.vehicleStack.vehicleList) {
			for (Demand tmpDemand : vehicle.arrivalList) {
				showEachAllocatedDemand(tmpDemand);
			}
			for (Demand tmpDemand : vehicle.departureList) {
				showEachAllocatedDemand(tmpDemand);
			}
		}
	}

	void showEachAllocatedDemand(Demand tmpDemand) {
		p.ellipseMode(PConstants.CENTER);
		if (tmpDemand.isDepartureDemand)
			p.fill(UrbanAutonomous.allocatedDepartureColor);
		else
			p.fill(UrbanAutonomous.allocatedArrivalColor);
		p.ellipse(tmpDemand.x * 10 + 5, tmpDemand.y * 10 + 5, 10,10);
	}

	void showEachDemand(Demand tmpDemand) {
		p.ellipseMode(PConstants.CENTER);
		if (tmpDemand.isDepartureDemand)
			p.fill(UrbanAutonomous.unallocatedDepartureColor);
		else
			p.fill(UrbanAutonomous.unallocatedArrivalColor);
		p.ellipse(tmpDemand.x * 10 + 5, tmpDemand.y * 10 + 5, 10, 10);
	}

	// ShowVehicle
	void showVehicle() {
		for (Vehicle vehicle : UrbanAutonomous.vehicleStack.vehicleList) {
			p.ellipseMode(PConstants.CENTER);
			p.fill(UrbanAutonomous.vehicleColor);
			int vSize= (int)java.lang.Math.sqrt(UrbanAutonomous.simParam.capacityOfVehicle*100) ;
			//p.ellipse(vehicle.x * 10 + 5, vehicle.y * 10 + 5, 5*UrbanAutonomous.simParam.capacityOfVehicle, 5*UrbanAutonomous.simParam.capacityOfVehicle);
			p.ellipse(vehicle.x * 10 + 5, vehicle.y * 10 + 5, vSize,vSize);
		}
	}

	// Show Congestion
	void showCongestion() {
		int totalCongestionLevel = 0;
		// Vehicle
		for (Vehicle vehicle : UrbanAutonomous.vehicleStack.vehicleList) {
			for (Demand position : vehicle.movingHistoryList) {
				p.image(UrbanAutonomous.congestionImg, position.x * 10, position.y * 10);
				totalCongestionLevel++;
			}
		}
		if (UrbanAutonomous.simParam.hubEnable) {
			// HubVehicle
			for (Coord position : UrbanAutonomous.hubStack.hubVehicleArray[0].movingHistoryList) {
				p.image(UrbanAutonomous.congestionImg, position.x * 10, position.y * 10);
				totalCongestionLevel++;
			}
			// HubPeripheralVehicle
			for (Coord position : UrbanAutonomous.hubStack.hubPeripheralVehicleA.movingHistoryList) {
				p.image(UrbanAutonomous.congestionImg, position.x * 10, position.y * 10);
				totalCongestionLevel++;
			}
			for (Coord position : UrbanAutonomous.hubStack.hubPeripheralVehicleB.movingHistoryList) {
				p.image(UrbanAutonomous.congestionImg, position.x * 10, position.y * 10);
				totalCongestionLevel++;
			}
		}
		UrbanAutonomous.simParam.totalCongestionLevel[UrbanAutonomous.simParam.currentTime / 20] = totalCongestionLevel;
		UrbanAutonomous.simParam.currentTotalCongestionLevel = totalCongestionLevel;
	}

	// oldShow Congestion
	void oldshowCongestion() {
		int totalCongestionLevel = 0;
		for (Vehicle vehicle : UrbanAutonomous.vehicleStack.vehicleList) {
			for (Demand position : vehicle.movingHistoryList) {
				p.image(UrbanAutonomous.congestionImg, position.x * 10, position.y * 10);
				totalCongestionLevel++;
			}
		}
		UrbanAutonomous.simParam.totalCongestionLevel[UrbanAutonomous.simParam.currentTime / 20] = totalCongestionLevel;
		UrbanAutonomous.simParam.currentTotalCongestionLevel = totalCongestionLevel;
	}

	// Show Hub
	void showHub() {
		p.ellipseMode(PConstants.CENTER);
		p.rectMode(PConstants.CENTER);
		for (int i = 0; i < UrbanAutonomous.hubStack.hubArray.length; i++) {
			p.fill(UrbanAutonomous.hubColor);
			p.ellipse(UrbanAutonomous.hubStack.hubArray[i].x * 10 + 5, UrbanAutonomous.hubStack.hubArray[i].y * 10 + 5, 15, 15);
			p.fill(UrbanAutonomous.hubEffectiveLengthColor);
			p.rect(UrbanAutonomous.hubStack.hubArray[i].x * 10 + 5, UrbanAutonomous.hubStack.hubArray[i].y * 10 + 5,
					UrbanAutonomous.simParam.hubEffectiveLength * 10 * 2, UrbanAutonomous.simParam.hubEffectiveLength * 10 * 2);
		}
	}

	// Show HubVehicle
	void showHubVehicle() {
		p.ellipseMode(PConstants.CENTER);
		p.fill(UrbanAutonomous.hubVehicleColor);
		for (int i = 0; i < UrbanAutonomous.hubStack.hubVehicleArray.length; i++) {
			p.ellipse(UrbanAutonomous.hubStack.hubVehicleArray[i].x * 10 + 5, UrbanAutonomous.hubStack.hubVehicleArray[i].y * 10 + 5,
					15, 15);
		}
	}

	// Show HubPeripheralVehicle
	void showHubPeripheralVehicle() {
		p.ellipseMode(PConstants.CENTER);
		p.fill(UrbanAutonomous.hubPeripheralVehicleColor);
		p.ellipse(UrbanAutonomous.hubStack.hubPeripheralVehicleA.x * 10 + 5,
				UrbanAutonomous.hubStack.hubPeripheralVehicleA.y * 10 + 5, 15, 15);
		p.ellipse(UrbanAutonomous.hubStack.hubPeripheralVehicleB.x * 10 + 5,
				UrbanAutonomous.hubStack.hubPeripheralVehicleB.y * 10 + 5, 15, 15);
	}
}
