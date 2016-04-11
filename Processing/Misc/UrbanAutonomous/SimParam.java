
public class SimParam {
	public int maxX;
	public int maxY;

	//Vehicle
	public int numberOfVehicle;
	public int capacityOfVehicle;
	//Congestion
	public int[] totalCongestionLevel;
	public int currentTotalCongestionLevel;
	public int vehicleHistorySize;
	//Time
	public int currentTime; //0-14400
	public int currentTimeZone;
	//Demand
	public int[] demandSizeArray;
	public int currentDemandSize;
	public int demandInterval;// unit:min (=#ofstep/10)
	public int demandLifetime;// unit:min
	public boolean demandSizeCustom;
	//Hub
	public boolean hubEnable;
	public int hubEffectiveLength;
	public int hubDedicatedVehicleCapacity;
	public int capacityOfPeripheralVehicle;
	//Map
	public int mapType;// 0:urban,1:Rural,2:custom

	public SimParam() {
		maxX =18;
		maxY =22;
		hubEnable=false;
		demandSizeCustom = false;
		mapType = 2;
		currentTimeZone = 0;
		currentTime = -1;
		capacityOfVehicle = 4;
		numberOfVehicle = 1;
		currentDemandSize = 0;
		demandInterval = 10;
		vehicleHistorySize = 30;
		currentTotalCongestionLevel = 0;
		totalCongestionLevel = new int[720];
		demandSizeArray = new int[] { 5, 5, 5, 5, 5, 10, 20, 50, 50, 20, 10, 10, 20, 10, 20, 30, 50, 50, 50, 30, 20, 10, 10, 10 };
		demandLifetime = 10;
		hubEffectiveLength = 15;
		hubDedicatedVehicleCapacity = 50;
		capacityOfPeripheralVehicle=10;
	}

	public void init(){
			UrbanAutonomous.vehicleStack.vehicleGen();
			UrbanAutonomous.demandStack.init();
			UrbanAutonomous.hubStack.init();
			currentTime=0;
	}

	public void update() {
		currentTime++;
		if (currentTime >= 14400)
			currentTime = 0;
		// unallocatedDemandSizeHistory
		if (currentTime % 20 == 0)
			UrbanAutonomous.demandStack.unallocatedDemandSizeHistory[currentTime / 20] = UrbanAutonomous.demandStack.unallocatedDepartureList.size();
		currentTimeZone = currentTime / 600;// 600step = 1hour
		if (!demandSizeCustom)
			currentDemandSize = demandSizeArray[currentTimeZone];
	}

}
