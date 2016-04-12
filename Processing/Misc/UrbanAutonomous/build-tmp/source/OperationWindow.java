
import processing.core.PApplet;

public class OperationWindow extends PApplet {
	//OperationDisp operationDisp;
	public static OperationDisp operationDisp;

	  public void setup() {
	  	//fullscreen();
		operationDisp = new OperationDisp(this);
		    delay(500);
		    
		  }
		public void draw() {
		    operationDisp.show();  
		}

		public void mousePressed() {
		  	//Vehicle Size
		    if (mouseY >250 && mouseY<300) {
			    if (mouseX >350 && mouseX <850) {
			      UrbanAutonomous.simParam.capacityOfVehicle=(mouseX-350)/10;
			      UrbanAutonomous.simParam.numberOfVehicle=1;
			      UrbanAutonomous.vehicleStack.vehicleGen();
			    }
		    }
		  	//Time
		    else if (mouseY >350 && mouseY<400) {
			    if (mouseX >350 && mouseX <350+1440) {
			      UrbanAutonomous.simParam.currentTime=(mouseX-350)*10 ;
			    }
		    }
		}
	}
