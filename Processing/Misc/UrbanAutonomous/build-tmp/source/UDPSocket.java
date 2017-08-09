
import processing.core.PApplet;
import processing.data.JSONObject;

public class UDPSocket {
	UDP udp;
	PApplet p;

	public UDPSocket(PApplet _p) {
		p = _p;
		udp = new UDP(this, 5500);
		udp.log(true); // <-- printout the connection activity
		udp.listen(true);
	}

	public void receive(byte[] data, String ip, int port) { // <-- extended
		String dataStr = new String(data);
		dataStr = new String(p.trim(dataStr));
		 p.println("receive: \"" + dataStr + "\" from " + ip + " on port " + port);
		String[] list = new String[] { dataStr };
		p.saveStrings("json.txt", list);
		JSONObject json = p.loadJSONObject("json.txt");

		mapUpdate(json);
		vehicleUpdate(json);
		demandUpdate(json);
		hubUpdate(json);
		demandGenerationUpdate(json);
		resetUpdate(json);
		timeUpdate(json);
		// UrbanAutonomous.simParam.numberOfVehicle = p.parseInt(dataStr);
		// UrbanAutonomous.vehicleStack.vehicleGen();

	}

	void timeUpdate(JSONObject json) {
		String tmpStr;
		if (!json.isNull("time")) {
			tmpStr = json.getString("time");
			UrbanAutonomous.simParam.currentTime = Integer.parseInt(tmpStr);
		}
	}
	void resetUpdate(JSONObject json) {
		String tmpStr;
		if (!json.isNull("reset")) {
			tmpStr = json.getString("reset");
			if(p.parseBoolean(tmpStr))
				UrbanAutonomous.simParam.init();
		}
	}
	void hubUpdate(JSONObject json) {
		String tmpStr;
		if (!json.isNull("hubDedicatedVehicleCapacity")) {
			tmpStr = json.getString("hubDedicatedVehicleCapacity");
			UrbanAutonomous.simParam.hubDedicatedVehicleCapacity= Integer.parseInt(tmpStr);
			UrbanAutonomous.hubStack.init();
		} else if (!json.isNull("capacityOfPeripheralVehicle")) {
			tmpStr = json.getString("capacityOfPeripheralVehicle");
			UrbanAutonomous.simParam.capacityOfPeripheralVehicle = Integer.parseInt(tmpStr);
			UrbanAutonomous.hubStack.init();
		} else if (!json.isNull("hubA")) {
			tmpStr = json.getString("hubA");
			String[] nums = p.split(tmpStr, ',');
			UrbanAutonomous.hubStack.ax = Integer.parseInt(nums[0])*5+2;
			UrbanAutonomous.hubStack.ay = Integer.parseInt(nums[1])*5+2;
			UrbanAutonomous.hubStack.init();
		} else if (!json.isNull("hubB")) {
			tmpStr = json.getString("hubB");
			String[] nums = p.split(tmpStr, ',');
			UrbanAutonomous.hubStack.bx = Integer.parseInt(nums[0])*5+2;
			UrbanAutonomous.hubStack.by = Integer.parseInt(nums[1])*5+2;
			UrbanAutonomous.hubStack.init();
		}
	}
	void demandUpdate(JSONObject json) {
		String tmpStr;
		if (!json.isNull("demandInterval")) {
			tmpStr = json.getString("demandInterval");
			UrbanAutonomous.simParam.demandInterval = Integer.parseInt(tmpStr);
		} else if (!json.isNull("demandLifetime")) {
			tmpStr = json.getString("demandLifetime");
			UrbanAutonomous.simParam.demandLifetime= Integer.parseInt(tmpStr);
		} else if (!json.isNull("currentDemandSize")) {
			tmpStr = json.getString("currentDemandSize");
			UrbanAutonomous.simParam.currentDemandSize= Integer.parseInt(tmpStr);
		} else if (!json.isNull("demandSizeCustom")) {
			tmpStr = json.getString("demandSizeCustom");
			UrbanAutonomous.simParam.demandSizeCustom= p.parseBoolean(tmpStr);
		}
	}
	void vehicleUpdate(JSONObject json) {
		String tmpStr;
		if (!json.isNull("fleetSize")) {
			tmpStr = json.getString("fleetSize");
			UrbanAutonomous.simParam.numberOfVehicle = Integer.parseInt(tmpStr);
			UrbanAutonomous.vehicleStack.vehicleGen();
		} else if (!json.isNull("vehicleCapacity")) {
			tmpStr = json.getString("vehicleCapacity");
			UrbanAutonomous.simParam.capacityOfVehicle = Integer.parseInt(tmpStr);
			UrbanAutonomous.vehicleStack.vehicleGen();
		} else if (!json.isNull("vehicleHistorySize")) {
			tmpStr = json.getString("vehicleHistorySize");
			UrbanAutonomous.simParam.vehicleHistorySize = Integer.parseInt(tmpStr);
			UrbanAutonomous.vehicleStack.vehicleGen();
		}
	}

	void mapUpdate(JSONObject json) {
		String tmpStr;
		if (!json.isNull("mapType")) {
			tmpStr = json.getString("mapType");
			UrbanAutonomous.simParam.mapType = Integer.parseInt(tmpStr);
			if (UrbanAutonomous.simParam.mapType == 0) {
				UrbanAutonomous.mapBlockStack.loadUrbanMap();
			} else if (UrbanAutonomous.simParam.mapType == 1) {
				UrbanAutonomous.mapBlockStack.loadRuralMap();
			} else if (UrbanAutonomous.simParam.mapType == 2) {
				UrbanAutonomous.mapBlockStack.noneMapGen();
			}
			UrbanAutonomous.mapBlockStack.updateCoordinate();// reflect change of // // // // mapblock to demand // // // // generation
			UrbanAutonomous.mapBlockStack.mapImgCreation(); // map image creation for // // // // display 
		}
	}

	void demandGenerationUpdate(JSONObject json) {
		String tmpStr;
		if (!json.isNull("hwArrival")) {
			tmpStr = json.getString("hwArrival");
			String[] nums = p.split(tmpStr, ',');
			float[] tmp = new float[24];
			for (int i = 0; i < nums.length; i++) {
				UrbanAutonomous.basicTile.hwTile.arrivalProbabilityArray[i] = Float.parseFloat(nums[i]);
			}
		}
		if (!json.isNull("lwArrival")) {
			tmpStr = json.getString("lwArrival");
			String[] nums = p.split(tmpStr, ',');
			float[] tmp = new float[24];
			for (int i = 0; i < nums.length; i++) {
				UrbanAutonomous.basicTile.lwTile.arrivalProbabilityArray[i] = Float.parseFloat(nums[i]);
			}
		}
		if (!json.isNull("hrArrival")) {
			tmpStr = json.getString("hrArrival");
			String[] nums = p.split(tmpStr, ',');
			float[] tmp = new float[24];
			for (int i = 0; i < nums.length; i++) {
				UrbanAutonomous.basicTile.hrTile.arrivalProbabilityArray[i] = Float.parseFloat(nums[i]);
			}
		}
		if (!json.isNull("lrArrival")) {
			tmpStr = json.getString("lrArrival");
			String[] nums = p.split(tmpStr, ',');
			float[] tmp = new float[24];
			for (int i = 0; i < nums.length; i++) {
				UrbanAutonomous.basicTile.lrTile.arrivalProbabilityArray[i] = Float.parseFloat(nums[i]);
			}
		}
		if (!json.isNull("hwDeparture")) {
			tmpStr = json.getString("hwDeparture");
			String[] nums = p.split(tmpStr, ',');
			float[] tmp = new float[24];
			for (int i = 0; i < nums.length; i++) {
				UrbanAutonomous.basicTile.hwTile.departureProbabilityArray[i] = Float.parseFloat(nums[i]);
			}
		}
		if (!json.isNull("lwDeparture")) {
			tmpStr = json.getString("lwDeparture");
			String[] nums = p.split(tmpStr, ',');
			float[] tmp = new float[24];
			for (int i = 0; i < nums.length; i++) {
				UrbanAutonomous.basicTile.lwTile.departureProbabilityArray[i] = Float.parseFloat(nums[i]);
			}
		}
		if (!json.isNull("hrDeparture")) {
			tmpStr = json.getString("hrDeparture");
			String[] nums = p.split(tmpStr, ',');
			float[] tmp = new float[24];
			for (int i = 0; i < nums.length; i++) {
				UrbanAutonomous.basicTile.hrTile.departureProbabilityArray[i] = Float.parseFloat(nums[i]);
			}
		}
		if (!json.isNull("lrDeparture")) {
			tmpStr = json.getString("lrDeparture");
			String[] nums = p.split(tmpStr, ',');
			float[] tmp = new float[24];
			for (int i = 0; i < nums.length; i++) {
				UrbanAutonomous.basicTile.lrTile.departureProbabilityArray[i] = Float.parseFloat(nums[i]);
			}
		}
		if (!json.isNull("totalDemand")) {
			tmpStr = json.getString("totalDemand");
			String[] nums = p.split(tmpStr, ',');
			float[] tmp = new float[24];
			for (int i = 0; i < nums.length; i++) {
				UrbanAutonomous.simParam.demandSizeArray[i] = Integer.parseInt(nums[i]);
			}
		}
	}

}
