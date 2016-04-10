//laptop resolution 1920 x 1080
//16blocks x 16blocks
//1block = 5tiles x 5tiles
//1tile = 10pixels x  10pixels
//Simulation Window: 800 x 800pixels
//Operation Window: x pixels

//vehicle speed 20km/h 20,000m/60min 2000m/6min 333m/min 33.3m/0.1min
//1block 133.3m -> 1tile 33.3m -> 2.128km-square
//1tile/0.1min
//1 simulation sec = 0.1min -> 10sec = 1min,  600sec(10min)=60min(1h) 240min(4h)=24h
//0.1 simulation sec = 0.1min ->1min=1h 24min = 24h
//1step =0.1min , 10step 1min , 600step 1h, 14400step =24h
//start time 00:00~24:00, 0:00->0step[0.1min](currentTime), 24:00-> 14400step[0.1min](currentTime)

//View
//AllocatedDepartureDemand:pink
//unallocatedDepartureDemand:red
//AllocatedArrivalDemand:light blue
//unallocatedArrivalDemand:blue

int projectorWidth = 1920;
int projectorHeight = 1200;
int projectorOffset = 1842;

int screenWidth = 1842;
int screenHeight = 1026;

int displayU = 18;
int displayV = 22;

int IDMax = 15;

// Table Canvas Width and Height
int TABLE_IMAGE_HEIGHT = 1000;
int TABLE_IMAGE_WIDTH = 1000;

// Arrays that holds ID information of rectilinear tile arrangement.
int tablePieceInput[][][] = new int[displayU][displayV][2];


public static DragStatus dragStatus;
public static OperationWindow opw;
public static Status status;
public static PImage hwImg, lwImg, hrImg, lrImg, roadImg, intersectionImg, noneImg, backgroundImg, congestionImg;
public static Tile[][] simCoordinate;
public static int vehicleColor;
public static int allocatedDepartureColor;
public static int unallocatedDepartureColor;
public static int allocatedArrivalColor;
public static int unallocatedArrivalColor;
public static int hubColor;
public static int hubVehicleColor;
public static int hubPeripheralVehicleColor;
public static int hubEffectiveLengthColor;
public static PGraphics legendPg, demandPg;
public static int brushNumber;

	// Temporary
	public static MapBlock mapBlock;
	public static BasicTile basicTile;
	public static MapBlockBrushs mapBlockBrushs;
	public static MapBlockStack mapBlockStack;
	public static Disp disp;
	public static SimParam simParam;
	public static DemandStack demandStack;
	public static VehicleStack vehicleStack;
	// public static OperationDisp operationDisp;
	public static FileControl fileControl;
	// public static Hub hubA, hubB;
	public static HubStack hubStack;
	// public static HubVehicle hubVehicle;
	public static UDPSocket udpSocket;

	PGraphics captionG,mainG;

	public void setup() {
		mainG=createGraphics(800,800);

		//size(screenWidth, screenHeight, P3D);

  		// Initial Projection-Mapping Canvas
  		initializeProjection2D();

  		// Allows application to receive information from Colortizer via UDP
  		initUDP();


		// SimulationWindow
		size(1000, 1000);

		// OperationWindow
		new PFrame(1000, 0, 1900, 875);

		// Status
		status = Status.CONFIG;
		dragStatus = DragStatus.NORMAL;

		// Load Image
		loadTileImage();
		backgroundImg = loadImage("operationWindow.jpg");

		// Legend Symbol
		vehicleColor = color(255, 128, 0, 255);
		allocatedDepartureColor = color(255, 0, 255, 127);
		unallocatedDepartureColor = color(255, 0, 0, 127);
		allocatedArrivalColor = color(0, 255, 255, 127);
		unallocatedArrivalColor = color(0, 0, 255, 127);
		hubColor = color(0, 255, 0, 200);
		hubEffectiveLengthColor = color(0, 255, 0, 64);
		hubVehicleColor = color(142, 0, 204, 200);
		hubPeripheralVehicleColor = color(200, 255, 200, 200);

		// Temporary
		udpSocket = new UDPSocket(this);

		hubStack = new HubStack(this);

		brushNumber = 0;
		basicTile = new BasicTile();
		mapBlockBrushs = new MapBlockBrushs(this, 4);
		mapBlockStack = new MapBlockStack(this);
		//disp = new Disp(this);
		disp = new Disp(mainG,this);
		simParam = new SimParam();
		demandStack = new DemandStack();
		simCoordinate = new Tile[80][80];
		vehicleStack = new VehicleStack();

		mapBlockStack.loadRuralMap();

		mapBlockStack.updateCoordinate();// reflect change of mapblock to demand
											// generation
		mapBlockStack.mapImgCreation();// map image creation for display
		mapBlockBrushs.brushImgCreation();// brush image creation for operation
											// display
		legendSymbolImgCreation(); // create legend symbol image for operation
									// display
		demandGenerationImgCreation(); // create demand image for operation
		// display
		fileControl = new FileControl();
	}

	public void draw() {
		// Exports table Graphic to Projector
 		projector = get(0, 0, TABLE_IMAGE_WIDTH, TABLE_IMAGE_HEIGHT);

		simParam.update();

		demandStack.demandLifetimeControl();
		demandStack.demandGen(simParam.currentDemandSize, simParam.demandInterval * 10);// numberOfDemand,DemandGenerationInterval(steps)
		demandStack.demandAllocation();
		demandStack.demandHubAllocation();
		vehicleStack.allVehicleMovement();
		hubStack.hubVehicleA.move();
		hubStack.hubPeripheralVehicleA.move();
		hubStack.hubPeripheralVehicleB.move();

		// Display
		disp.show();

		image(mainG,180,0,725,725);
	}

	void loadTileImage() {
		hwImg = loadImage("hwTile.png");
		lwImg = loadImage("lwTile.png");
		hrImg = loadImage("hrTile.png");
		lrImg = loadImage("lrTile.png");
		roadImg = loadImage("roadTile.png");
		intersectionImg = loadImage("intersectionTile.png");
		noneImg = loadImage("noneTile.png");
		congestionImg = loadImage("congestion.png");
	}

	void keyPressed() {
		switch(key) {
   		 case '`': //  "Enable Projection (`)"
   		 toggle2DProjection();
   		 break;
   		}
   	}
   	public void mousePressed() {
   		int x = (int) (mouseX / 50);
   		int y = (int) (mouseY / 50);

   		if (simParam.mapType == 2) {
   			mapBlockStack.mapBlockArray[x][y] = mapBlockBrushs.selectedBrush;
   			fileControl.customMap[16 * y + x] = brushNumber;
			mapBlockStack.updateCoordinate();// reflect change of mapblock to //
												// // demand
			// generation
			mapBlockStack.mapImgCreation();// map image creation for display
		}
		// Hub Relocation
		hubRelocation();
	}

	void hubRelocation() {
		if (dist(hubStack.hubA.x * 10, hubStack.hubA.y * 10, mouseX, mouseY) < 20) {
			dragStatus = DragStatus.HUBA;
		} else if (dist(hubStack.hubB.x * 10, hubStack.hubB.y * 10, mouseX, mouseY) < 20) {
			dragStatus = DragStatus.HUBB;
		}
	}

	public void mouseReleased() {
		if (dragStatus == DragStatus.HUBA) {
			hubStack.ax = modifyHubPoint(mouseX);
			hubStack.ay = modifyHubPoint(mouseY);
			hubStack.init();
		} else if (dragStatus == DragStatus.HUBB) {
			hubStack.bx = modifyHubPoint(mouseX);
			hubStack.by = modifyHubPoint(mouseY);
			hubStack.init();
		}
		dragStatus = DragStatus.NORMAL;
	}

	int modifyHubPoint(int x) {
		int result = 0;
		result = x / 10 / 5 * 5 + 2;
		return result;
	}

	void legendSymbolImgCreation() {
		int offset = 0;
		legendPg = createGraphics(20, 180);
		legendPg.beginDraw();
		legendPg.background(255);
		legendPg.stroke(255);
		legendPg.stroke(1);

		// LandUse
		legendPg.image(hwImg, offset, 0, 20, 20);
		legendPg.image(lwImg, offset, 20, 20, 20);
		legendPg.image(hrImg, offset, 40, 20, 20);
		legendPg.image(lrImg, offset, 60, 20, 20);

		legendPg.ellipseMode(CENTER);
		// allocated departure
		legendPg.fill(allocatedDepartureColor);
		legendPg.ellipse(offset + 10, 90, 10, 10);
		// unallocated departure
		legendPg.fill(unallocatedDepartureColor);
		legendPg.ellipse(offset + 10, 110, 10, 10);
		// allocated arrival
		legendPg.fill(allocatedArrivalColor);
		legendPg.ellipse(offset + 10, 130, 10, 10);
		// unallocated arrival
		legendPg.fill(unallocatedArrivalColor);
		legendPg.ellipse(offset + 10, 150, 10, 10);
		// Vehicle(fleet)
		legendPg.fill(vehicleColor);
		legendPg.ellipse(offset + 10, 170, 10, 10);
		legendPg.endDraw();
	}

	void demandGenerationImgCreation() {
		int offset = 150;
		demandPg = createGraphics(870, 260);
		demandPg.beginDraw();
		// demandPg.background(255);
		demandPg.clear();
		demandPg.stroke(255);
		demandPg.stroke(1);
		demandPg.image(hwImg, 0, 0, 50, 50);
		demandPg.image(lwImg, 0, 70, 50, 50);
		demandPg.image(hrImg, 0, 140, 50, 50);
		demandPg.image(lrImg, 0, 210, 50, 50);

		for (int i = 0; i < 720; i++) {
			demandPg.line(offset + i, 20 - (basicTile.hwTile.departureProbabilityArray[i / 30] * 100 / 5), offset + i,
				20);
			demandPg.line(offset + i, 50 - (basicTile.hwTile.arrivalProbabilityArray[i / 30] * 100 / 5), offset + i,
				50);
			demandPg.line(offset + i, 90 - (basicTile.lwTile.departureProbabilityArray[i / 30] * 100 / 5), offset + i,
				90);
			demandPg.line(offset + i, 120 - (basicTile.lwTile.arrivalProbabilityArray[i / 30] * 100 / 5), offset + i,
				120);
			demandPg.line(offset + i, 160 - (basicTile.hrTile.departureProbabilityArray[i / 30] * 100 / 5), offset + i,
				160);
			demandPg.line(offset + i, 190 - (basicTile.hrTile.arrivalProbabilityArray[i / 30] * 100 / 5), offset + i,
				190);
			demandPg.line(offset + i, 230 - (basicTile.lrTile.departureProbabilityArray[i / 30] * 100 / 5), offset + i,
				230);
			demandPg.line(offset + i, 260 - (basicTile.lrTile.arrivalProbabilityArray[i / 30] * 100 / 5), offset + i,
				260);
		}
		demandPg.endDraw();
	}

