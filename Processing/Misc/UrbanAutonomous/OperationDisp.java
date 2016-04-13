
import static processing.core.PConstants.CENTER;


import processing.core.PApplet;

public class OperationDisp {
	PApplet p;

	public OperationDisp(PApplet _p) {
		p = _p;
	}

	public void show() {
		UrbanAutonomous.opw.image(UrbanAutonomous.backgroundImg, 0, 0);

		p.noStroke();
		UrbanAutonomous.opw.textSize(35);
		//fill(#006837);
		//Vehicle Size
		p.fill(0,104,55);
		p.rect(350, 250, UrbanAutonomous.simParam.capacityOfVehicle*10, 50);
		//Vehicle Size TEXT
		p.fill(255,255,255);
		String vehicleSizeLabel = Integer.toString(UrbanAutonomous.simParam.capacityOfVehicle);
		UrbanAutonomous.opw.text(vehicleSizeLabel, 360, 295);

		//Time Bar
		p.fill(0,104,55);
		p.rect(350, 350, UrbanAutonomous.simParam.currentTime/10, 50);
		//Time Text
		p.fill(255,255,255);
		UrbanAutonomous.opw.textSize(35);
		int hour = UrbanAutonomous.simParam.currentTime / 600;// 600step = 1hour
		int min = (UrbanAutonomous.simParam.currentTime - hour * 600) / 60;// 60step = // 1min
		String timeLabel = p.nf(hour, 2) + ":" + p.nf(min, 2);
		UrbanAutonomous.opw.text(timeLabel, 360, 395);
		//Demand
		p.fill(0,104,55);
		for(int i=0;i<24;i++){
			p.rect(350+60*i, 500-UrbanAutonomous.simParam.demandSizeArray[i], 60,UrbanAutonomous.simParam.demandSizeArray[i]);
		}
		//Optimal Fleet Size
		p.fill(0,104,55);
		p.rect(350, 700, UrbanAutonomous.simParam.numberOfVehicle * UrbanAutonomous.simParam.capacityOfVehicle, 50);
		//Optimal Fleet Size text
		p.fill(255,255,255);
		String fleetSizeLabel = Integer.toString(UrbanAutonomous.simParam.capacityOfVehicle*UrbanAutonomous.simParam.numberOfVehicle);
		UrbanAutonomous.opw.text(fleetSizeLabel, 360, 745);

		//usage rate text
		p.fill(255,255,255);
		String usageLabel = Integer.toString(UrbanAutonomous.simParam.usagerate);
		usageLabel += "%";
		UrbanAutonomous.opw.text(usageLabel, 360, 895);



		/*
		showBrush();
		showMapGUI();
		showLegendSymbolGUI();

		showFleetGUI();
		showDemandGUI();

		showTimeGUI();
		showUnallocatedDemandSize();
		showMissedDemand();
		showDemandSize();
		//showDemandProbabilityGUI();
		oldshowDemandProbabilityGUI();
		showTotalCongestion();
		*/
	}



///////////////////////////////
	void oldshowBrush() {
		for (int i = 0; i < UrbanAutonomous.mapBlockBrushs.specificBrushs.length; i++) {
			UrbanAutonomous.opw.image(UrbanAutonomous.mapBlockBrushs.specificBrushs[i].pg, 50, 250 + 70 * i);
		}
		for (int i = 0; i < UrbanAutonomous.mapBlockBrushs.numberOfBrush; i++) {
			UrbanAutonomous.opw.image(UrbanAutonomous.mapBlockBrushs.randomBrushs[i].pg, 150, 250 + 70 * i);
		}
	}

	void showBrush() {
		UrbanAutonomous.opw.image(UrbanAutonomous.mapBlockBrushs.pg, 0, 250);
	}

	void showMapGUI() {
		UrbanAutonomous.opw.ellipseMode(CENTER);
		UrbanAutonomous.opw.fill(0);
		if (UrbanAutonomous.simParam.mapType == 0) {
			UrbanAutonomous.opw.ellipse(65, 115, 14, 14);
		} else if (UrbanAutonomous.simParam.mapType == 1) {
			UrbanAutonomous.opw.ellipse(65, 165, 14, 14);
		} else if (UrbanAutonomous.simParam.mapType == 2) {
			UrbanAutonomous.opw.ellipse(65, 215, 14, 14);
		}
	}

	void oldshowLegendSymbolGUI() {
		int offset = 50;
		UrbanAutonomous.opw.stroke(1);

		// LandUse
		UrbanAutonomous.opw.image(UrbanAutonomous.hwImg, offset, 640, 20, 20);
		UrbanAutonomous.opw.image(UrbanAutonomous.lwImg, offset, 660, 20, 20);
		UrbanAutonomous.opw.image(UrbanAutonomous.hrImg, offset, 680, 20, 20);
		UrbanAutonomous.opw.image(UrbanAutonomous.lrImg, offset, 700, 20, 20);

		UrbanAutonomous.opw.ellipseMode(CENTER);
		// allocated departure
		UrbanAutonomous.opw.fill(UrbanAutonomous.allocatedDepartureColor);
		UrbanAutonomous.opw.ellipse(offset + 10, 720 + 10, 10, 10);
		// unallocated departure
		UrbanAutonomous.opw.fill(UrbanAutonomous.unallocatedDepartureColor);
		UrbanAutonomous.opw.ellipse(offset + 10, 740 + 10, 10, 10);
		// allocated arrival
		UrbanAutonomous.opw.fill(UrbanAutonomous.allocatedArrivalColor);
		UrbanAutonomous.opw.ellipse(offset + 10, 760 + 10, 10, 10);
		// unallocated arrival
		UrbanAutonomous.opw.fill(UrbanAutonomous.unallocatedArrivalColor);
		UrbanAutonomous.opw.ellipse(offset + 10, 780 + 10, 10, 10);
		// Vehicle(fleet)
		UrbanAutonomous.opw.fill(UrbanAutonomous.vehicleColor);
		UrbanAutonomous.opw.ellipse(offset + 10, 800 + 10, 10, 10);
	}

	void showLegendSymbolGUI() {
		UrbanAutonomous.opw.image(UrbanAutonomous.legendPg, 50, 640);
	}

	void showFleetGUI() {
		int offset = 580;
		UrbanAutonomous.opw.stroke(0);
		UrbanAutonomous.opw.strokeWeight(3);
		// FleetSize(numberOfVehicle)
		UrbanAutonomous.opw.line(offset + UrbanAutonomous.simParam.numberOfVehicle * 2, 100,
				offset + UrbanAutonomous.simParam.numberOfVehicle * 2, 130);
		// VehicleCapacity
		UrbanAutonomous.opw.line(offset + UrbanAutonomous.simParam.capacityOfVehicle * 2, 170,
				offset + UrbanAutonomous.simParam.capacityOfVehicle * 2, 200);
		// FleetCapacity
		int fleetCapacity = UrbanAutonomous.simParam.capacityOfVehicle * UrbanAutonomous.simParam.numberOfVehicle;
		int fleetCapacityLabel = fleetCapacity / 50;
		UrbanAutonomous.opw.line(offset + fleetCapacityLabel, 240, offset + fleetCapacityLabel, 270);

		// Text
		UrbanAutonomous.opw.textSize(16);
		UrbanAutonomous.opw.text(p.str(UrbanAutonomous.simParam.numberOfVehicle), offset - 70, 132);
		UrbanAutonomous.opw.text(p.str(UrbanAutonomous.simParam.capacityOfVehicle), offset - 70, 202);
		UrbanAutonomous.opw.text(p.str(UrbanAutonomous.simParam.numberOfVehicle * UrbanAutonomous.simParam.capacityOfVehicle), offset - 70,
				272);
	}

	void showDemandGUI() {
		int offset = 580;
		UrbanAutonomous.opw.stroke(0);
		UrbanAutonomous.opw.strokeWeight(3);
		// DemandSize
		// Preset
		UrbanAutonomous.opw.line(offset + UrbanAutonomous.simParam.currentDemandSize * 2, 450,
				offset + UrbanAutonomous.simParam.currentDemandSize * 2, 480);
		// Custom
		if (UrbanAutonomous.simParam.demandSizeCustom) {
			UrbanAutonomous.opw.ellipseMode(CENTER);
			UrbanAutonomous.opw.fill(0);
			UrbanAutonomous.opw.ellipse(315, 535, 14, 14);
		} else {
			UrbanAutonomous.opw.ellipseMode(CENTER);
			UrbanAutonomous.opw.fill(0);
			UrbanAutonomous.opw.ellipse(315, 465, 14, 14);
		}
		UrbanAutonomous.opw.line(offset + UrbanAutonomous.simParam.currentDemandSize * 2, 550,
				offset + UrbanAutonomous.simParam.currentDemandSize * 2, 520);
		// DemandInterval
		UrbanAutonomous.opw.line(offset + UrbanAutonomous.simParam.demandInterval * 2, 630,
				offset + UrbanAutonomous.simParam.demandInterval * 2, 660);

		// DemandLifetime
		UrbanAutonomous.opw.line(offset + UrbanAutonomous.simParam.demandLifetime * 2, 730 - 30,
				offset + UrbanAutonomous.simParam.demandLifetime * 2, 730);
	}

	void showTimeGUI() {
		int offset = 1130;
		UrbanAutonomous.opw.stroke(0);
		UrbanAutonomous.opw.strokeWeight(3);
		// CurrentTime
		int currentTimeLabel = UrbanAutonomous.simParam.currentTime / 20;
		UrbanAutonomous.opw.line(offset + currentTimeLabel, 150 - 10, offset + currentTimeLabel, 150 + 10);
		UrbanAutonomous.opw.stroke(0,0,255,128);
		UrbanAutonomous.opw.line(offset + currentTimeLabel, 150 - 10, offset + currentTimeLabel, 150 + 810);
		// Text
		UrbanAutonomous.opw.textSize(30);
		int hour = UrbanAutonomous.simParam.currentTime / 600;// 600step = 1hour
		int min = (UrbanAutonomous.simParam.currentTime - hour * 600) / 60;// 60step =
																	// 1min
		String timeLabel = p.nf(hour, 2) + ":" + p.nf(min, 2);
		UrbanAutonomous.opw.text(timeLabel, 1050, 80);
	}

	void showUnallocatedDemandSize() {
		int offset = 1130;
		UrbanAutonomous.opw.stroke(0);
		// unallocatedDemandSize
		UrbanAutonomous.opw.strokeWeight(1);
		for (int i = 0; i < 720; i++)
			UrbanAutonomous.opw.line(offset + i, 250 - (UrbanAutonomous.demandStack.unallocatedDemandSizeHistory[i]), offset + i,
					250);

		// Text
		UrbanAutonomous.opw.textSize(16);
		UrbanAutonomous.opw.text(p.str(UrbanAutonomous.demandStack.unallocatedDepartureList.size()), 1070, 250);
	}

	void showMissedDemand() {
		int offset = 1130;
		UrbanAutonomous.opw.stroke(0);

		UrbanAutonomous.opw.strokeWeight(1);
		for (int i = 0; i < 720; i++)
			UrbanAutonomous.opw.line(offset + i, 320 - (UrbanAutonomous.demandStack.missedDemandHistory[i]), offset + i, 320);

		// Text
		UrbanAutonomous.opw.textSize(16);
		UrbanAutonomous.opw.text(p.str(UrbanAutonomous.demandStack.missedDemand), 1070, 320);
	}

	void showDemandSize() {
		int offset = 1130;
		UrbanAutonomous.opw.stroke(0);
		UrbanAutonomous.opw.strokeWeight(1);
		// DemandSize
		for (int i = 0; i < 720; i++)
			UrbanAutonomous.opw.line(offset + i, 390 - (UrbanAutonomous.simParam.demandSizeArray[i / 30]), offset + i, 390);

		// Text
		UrbanAutonomous.opw.textSize(16);
		UrbanAutonomous.opw.text(p.str(UrbanAutonomous.simParam.currentDemandSize), 1070, 390);
	}

	void oldshowDemandProbabilityGUI() {
		int offset = 1130;
		UrbanAutonomous.opw.image(UrbanAutonomous.hwImg, 980, 540, 50, 50);
		UrbanAutonomous.opw.image(UrbanAutonomous.lwImg, 980, 610, 50, 50);
		UrbanAutonomous.opw.image(UrbanAutonomous.hrImg, 980, 680, 50, 50);
		UrbanAutonomous.opw.image(UrbanAutonomous.lrImg, 980, 750, 50, 50);

		for (int i = 0; i < 720; i++) {
			UrbanAutonomous.opw.line(offset + i, 560 - (UrbanAutonomous.basicTile.hwTile.departureProbabilityArray[i / 30] * 100 / 5),
					offset + i, 560);
			UrbanAutonomous.opw.line(offset + i, 590 - (UrbanAutonomous.basicTile.hwTile.arrivalProbabilityArray[i / 30] * 100 / 5),
					offset + i, 590);
			UrbanAutonomous.opw.line(offset + i, 630 - (UrbanAutonomous.basicTile.lwTile.departureProbabilityArray[i / 30] * 100 / 5),
					offset + i, 630);
			UrbanAutonomous.opw.line(offset + i, 660 - (UrbanAutonomous.basicTile.lwTile.arrivalProbabilityArray[i / 30] * 100 / 5),
					offset + i, 660);
			UrbanAutonomous.opw.line(offset + i, 700 - (UrbanAutonomous.basicTile.hrTile.departureProbabilityArray[i / 30] * 100 / 5),
					offset + i, 700);
			UrbanAutonomous.opw.line(offset + i, 730 - (UrbanAutonomous.basicTile.hrTile.arrivalProbabilityArray[i / 30] * 100 / 5),
					offset + i, 730);
			UrbanAutonomous.opw.line(offset + i, 770 - (UrbanAutonomous.basicTile.lrTile.departureProbabilityArray[i / 30] * 100 / 5),
					offset + i, 770);
			UrbanAutonomous.opw.line(offset + i, 800 - (UrbanAutonomous.basicTile.lrTile.arrivalProbabilityArray[i / 30] * 100 / 5),
					offset + i, 800);
		}
	}

	void showDemandProbabilityGUI() {
		UrbanAutonomous.opw.image(UrbanAutonomous.demandPg, 980, 540);
	}

	void showTotalCongestion() {
		int offset = 1130;
		// Text
		UrbanAutonomous.opw.textSize(16);
		UrbanAutonomous.opw.text(p.str(UrbanAutonomous.simParam.currentTotalCongestionLevel), 1070, 460);
		// Graph
		for (int i = 0; i < 720; i++) {
			UrbanAutonomous.opw.line(offset + i, 460 - (UrbanAutonomous.simParam.totalCongestionLevel[i] / 10), offset + i, 460);
		}
	}
}
