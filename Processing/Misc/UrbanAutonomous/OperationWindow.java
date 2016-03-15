
import processing.core.PApplet;

public class OperationWindow extends PApplet {
	//OperationDisp operationDisp;
	public static OperationDisp operationDisp;
	  public void setup() {
		operationDisp = new OperationDisp(this);
		    delay(500);
		  }
		  public void draw() {
		    operationDisp.show();  
		  }

		  public void mousePressed() {
		    //Time
		    if (mouseX >1130 && mouseX <1850) {
		      if (mouseY >150-50 && mouseY<150+50) {
		        UrbanAutonomous.simParam.currentTime=(mouseX-1130)*20 ;
		      }
		    }
		    //save file for custom map
		    if (mouseX > 200 && mouseX<300)
		      if (mouseY> 200 && mouseY<230)
		        UrbanAutonomous.fileControl.outputCSV();   

		    //MAP
		    if (mouseX > 50 && mouseX<200) {
		      if (mouseY> 100 && mouseY<130) {
		        UrbanAutonomous.mapBlockStack.loadUrbanMap();
		        UrbanAutonomous.mapBlockStack.updateCoordinate();// reflect change of mapblock to demand generation
		        UrbanAutonomous.mapBlockStack.mapImgCreation();//map image creation for display
		      } else if (mouseY> 150 && mouseY<180) {
		        UrbanAutonomous.mapBlockStack.loadRuralMap();
		        UrbanAutonomous.mapBlockStack.updateCoordinate();// reflect change of mapblock to demand generation
		        UrbanAutonomous.mapBlockStack.mapImgCreation();//map image creation for display
		      } else if (mouseY> 200 && mouseY<230) {
		        UrbanAutonomous.mapBlockStack.noneMapGen();
		        UrbanAutonomous.mapBlockStack.updateCoordinate();// reflect change of mapblock to demand generation
		        UrbanAutonomous.mapBlockStack.mapImgCreation();//map image creation for display
		      }
		    }
		    //MAP change brush
		    if (mouseX >50 && mouseX <200) {
		      if (mouseY >530 && mouseY<600) {
		        UrbanAutonomous.mapBlockBrushs.randomBrushsGen();
		        UrbanAutonomous.mapBlockBrushs.brushImgCreation();
		      }
		    }
		    //Map Brush select
		    if (mouseX >50 && mouseX <100) {
		      UrbanAutonomous.mapBlockBrushs.brushImgCreation();
		      if (mouseY >250 && mouseY<300) {
		        UrbanAutonomous.mapBlockBrushs.selectedBrush=UrbanAutonomous.mapBlockBrushs.specificBrushs[0];
		        UrbanAutonomous.brushNumber=0;
		      } else if (mouseY >320 && mouseY<370) {
		        UrbanAutonomous.mapBlockBrushs.selectedBrush=UrbanAutonomous.mapBlockBrushs.specificBrushs[1];
		        UrbanAutonomous.brushNumber=1;
		      } else if (mouseY >390 && mouseY<440) {
		        UrbanAutonomous.mapBlockBrushs.selectedBrush=UrbanAutonomous.mapBlockBrushs.specificBrushs[2];
		        UrbanAutonomous.brushNumber=2;
		      } else if (mouseY >460 && mouseY<510) {
		        UrbanAutonomous.mapBlockBrushs.selectedBrush=UrbanAutonomous.mapBlockBrushs.specificBrushs[3];
		        UrbanAutonomous.brushNumber=3;
		      }
		    } else if (mouseX >150 && mouseX <200) {
		      UrbanAutonomous.mapBlockBrushs.brushImgCreation();
		      if (mouseY >250 && mouseY<300) {
		        UrbanAutonomous.mapBlockBrushs.selectedBrush=UrbanAutonomous.mapBlockBrushs.randomBrushs[0];
		      } else if (mouseY >320 && mouseY<370) {
		        UrbanAutonomous.mapBlockBrushs.selectedBrush=UrbanAutonomous.mapBlockBrushs.randomBrushs[1];
		      } else if (mouseY >390 && mouseY<440) {
		        UrbanAutonomous.mapBlockBrushs.selectedBrush=UrbanAutonomous.mapBlockBrushs.randomBrushs[2];
		      } else if (mouseY >460 && mouseY<510) {
		        UrbanAutonomous.mapBlockBrushs.selectedBrush=UrbanAutonomous.mapBlockBrushs.randomBrushs[3];
		      }
		    }


		    int offsetSecond=580;
		    //Fleet Demand

		    if (mouseX > offsetSecond && mouseX<= offsetSecond+200) {
		      //Fleet Size

		      //number of vehicle
		      if (mouseY>100 && mouseY <100+30) {
		        UrbanAutonomous.simParam.numberOfVehicle=(int)((mouseX-offsetSecond)/2);
		        UrbanAutonomous.vehicleStack.vehicleGen();
		      } 

		      //capacity of vehicle
		      else if (mouseY>171 && mouseY<170+30) {
		        UrbanAutonomous.simParam.capacityOfVehicle=(int)((mouseX-offsetSecond)/2);
		        UrbanAutonomous.vehicleStack.vehicleGen();
		      } else if (mouseY>520 && mouseY<520+30) {
		        //currentDemandSize
		        UrbanAutonomous.simParam.currentDemandSize=(int)((mouseX-offsetSecond)/2);
		      } else if (mouseY>630 && mouseY<630+30) {
		        //demandInterval
		        UrbanAutonomous.simParam.demandInterval=(int)((mouseX-offsetSecond)/2);
		      } else if (mouseY>700 && mouseY<700+30) {
		        //demandLifetime
		        UrbanAutonomous.simParam.demandLifetime=(int)((mouseX-offsetSecond)/2);
		      }
		    }

		    //FleetPreset Button
		    if (mouseY>340 && mouseY<340+30) {
		      if (mouseX>420 && mouseX<420+100) {
		        //PEV
		        UrbanAutonomous.simParam.numberOfVehicle=80;
		        UrbanAutonomous.simParam.capacityOfVehicle=1;
		        UrbanAutonomous.vehicleStack.vehicleGen();
		      } else if (mouseX>550 && mouseX<550+100) {
		        //Car
		        UrbanAutonomous.simParam.numberOfVehicle=20;
		        UrbanAutonomous.simParam.capacityOfVehicle=4;
		        UrbanAutonomous.vehicleStack.vehicleGen();
		      } else if (mouseX>680 && mouseX<680+100) {
		        //Bus
		        UrbanAutonomous.simParam.numberOfVehicle=1;
		        UrbanAutonomous.simParam.capacityOfVehicle=80;
		        UrbanAutonomous.vehicleStack.vehicleGen();
		      }
		    }

		    //DemandSize preset
		    if (mouseX>300 && mouseX<780) {
		      if (mouseY > 450 && mouseY<480) {
		        UrbanAutonomous.simParam.demandSizeCustom=false;
		      } else if (mouseY > 520 && mouseY<550) {
		        UrbanAutonomous.simParam.demandSizeCustom=true;
		      }
		    }
		  }
		}
