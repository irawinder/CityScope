
import java.util.ArrayList;


import processing.core.PApplet;

public class VehicleStack extends PApplet{
	  public ArrayList <Vehicle> vehicleList;
	  public boolean isHorizontalStreet;
	  public VehicleStack() {
	    vehicleGen();
	    isHorizontalStreet =true;
	  }
	  public void vehicleGen() {
	    vehicleList = new ArrayList <Vehicle>();
	    for (int i=0; i<UrbanAutonomous.simParam.numberOfVehicle; i++) {
	      Vehicle vehicle = createVehicle();
	      vehicleList.add(vehicle);
	    }
	  }
	  
	  public void allVehicleMovement(){
	    for(Vehicle vehicle:vehicleList){
	      vehicle.move();
	    }
	  }

	  public Vehicle createVehicle() {
	    isHorizontalStreet = !isHorizontalStreet;
	    int x=0;
	    int streetNumber=0;
	    int y=0;
	    boolean isIntersection=false;
	    if (isHorizontalStreet) {
	      x = (int)random(80);
	      streetNumber = (int)random(16);
	      y = streetNumber*5+2;
	      if (streetNumber==0) {
	        if ((x-2)==0)
	          isIntersection=true;
	      } else if (streetNumber == (x-2)/5 && (x-2)%5==0 )
	        isIntersection=true;
	    } else {
	      y = (int)random(80);
	      streetNumber = (int)random(16);
	      x = streetNumber*5+2;
	      if (streetNumber==0) {
	        if ((y-2)==0)
	          isIntersection=true;
	      } else if (streetNumber == (y-2)/5 && (y-2)%5==0 )
	        isIntersection=true;
	    }

	    Vehicle tmpVehicle= new Vehicle(x, y, isHorizontalStreet, isIntersection);
	    return tmpVehicle;
	  }

	  void positionUpdate() {
	  }
	}
