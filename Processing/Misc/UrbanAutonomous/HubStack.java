import processing.core.PApplet;

public class HubStack {
	public PApplet p;
	public Hub hubA;
	public Hub hubB;
	public int ax,ay,bx,by;
	public static HubVehicle hubVehicleA;
	public Hub [] hubArray;
	public HubVehicle [] hubVehicleArray;
	public HubPeripheralVehicle hubPeripheralVehicleA,hubPeripheralVehicleB;

	public HubStack(PApplet _p) {
		p=_p;
		ax=72;
		ay=7;
		bx=7;
		by=72;
		hubA = new Hub(ax, ay);
		hubB = new Hub(bx, by);
		hubArray = new Hub[]{hubA,hubB};
		hubVehicleA = new HubVehicle(0,0,p);
		hubVehicleArray = new HubVehicle[]{hubVehicleA};
		hubPeripheralVehicleA = new HubPeripheralVehicle(0,0,p,true);
		hubPeripheralVehicleB = new HubPeripheralVehicle(0,0,p,false);
	}
	public void init(){
		hubA = new Hub(ax, ay);
		hubB = new Hub(bx, by);
		hubArray = new Hub[]{hubA,hubB};
		hubVehicleA = new HubVehicle(0,0,p);
		hubVehicleArray = new HubVehicle[]{hubVehicleA};
		hubPeripheralVehicleA = new HubPeripheralVehicle(0,0,p,true);
		hubPeripheralVehicleB = new HubPeripheralVehicle(0,0,p,false);
	}
}
