
import java.util.ArrayList;


import processing.core.PApplet;

public class Vehicle extends PApplet{
	  public int x;
	  public int y;
	  public int streetNumber;
	  public boolean isHorizontalStreet;
	  public boolean isIntersection;
	  public ArrayList <Demand> departureList;
	  public ArrayList <Demand> arrivalList;
	  public ArrayList <Demand> movingHistoryList;

	  Vehicle(int _x, int _y, boolean _isHorizontalStreet, boolean _isIntersection) {
	    x=_x;
	    y=_y;
	    isHorizontalStreet=_isHorizontalStreet;
	    isIntersection=_isIntersection;
	    departureList = new ArrayList <Demand>();
	    arrivalList = new ArrayList <Demand>();
	    movingHistoryList = new ArrayList <Demand>();
	  }

	  //Parameter Update
	  void paramUpdate() {
	    isHorizontalStreet=false;
	    isIntersection=false;
	    streetNumber=0;
	    if (isHorizontalStreetCheck()) {
	      isHorizontalStreet=true;
	      streetNumber=((y+5-2)/5)-1;
	    } else {
	      streetNumber=((x+5-2)/5)-1;
	    }
	    if (isVerticalStreetCheck()&&isHorizontalStreetCheck())
	      isIntersection=true;
	  }

	  boolean isHorizontalStreetCheck() {
	    boolean result=false;
	    if ((y-2+5)%5==0)
	      result = true;
	    return result;
	  }

	  boolean isVerticalStreetCheck() {
	    boolean result=false;
	    if ((x-2+5)%5==0)
	      result = true;
	    return result;
	  }

	  //Vehicle Movement
	  void move() {
	    paramUpdate();
	    movingHistoryUpdate();
	    if (departureList.size()>0 || arrivalList.size()>0) {
	      if (departureList.size()>0) {
	        eachMove(departureList);
	      } else {
	        eachMove(arrivalList);
	      }
	    }
	  }

	  void movingHistoryUpdate() {
	    Demand tmpVehiclePosition=new Demand(x, y);
	    if (!(departureList.size()==0&&arrivalList.size()==0))
	      movingHistoryList.add(tmpVehiclePosition);
	    if (departureList.size()==0&&arrivalList.size()==0&&movingHistoryList.size()>0)
	      movingHistoryList.remove(0);
	    if (movingHistoryList.size()>=UrbanAutonomous.simParam.vehicleHistorySize)
	      movingHistoryList.remove(0);
	  }

	  void eachMove(ArrayList <Demand> tmpList) {
	    if (isSamePoint(tmpList.get(0))) {
	      tmpList.remove(0);
	    } else if (isSameStreet(tmpList.get(0))) {
	      if (tmpList.get(0).isHorizontalStreet)
	        x += (tmpList.get(0).x - x)/ abs(tmpList.get(0).x - x) ;
	      else
	        y += (tmpList.get(0).y - y)/ abs(tmpList.get(0).y - y) ;
	    } else {
	      if (isIntersection) {
	        if (tmpList.get(0).isHorizontalStreet)
	          y += (tmpList.get(0).y - y)/ abs(tmpList.get(0).y - y) ;
	        else
	          x += (tmpList.get(0).x - x)/ abs(tmpList.get(0).x - x) ;
	      } else {
	        if (isHorizontalStreet) {
	          if (tmpList.get(0).isHorizontalStreet) {
	            if (x>77) {
	              x-=1;
	            } else {
	              x+=1;
	            }
	          } else {
	            x += (tmpList.get(0).x - x)/ abs(tmpList.get(0).x - x) ;
	          }
	        } else {
	          if (tmpList.get(0).isHorizontalStreet) {
	            y += (tmpList.get(0).y - y)/ abs(tmpList.get(0).y - y) ;
	          } else {
	            if (y>77) {
	              y-=1;
	            } else {
	              y+=1;
	            }
	          }
	        }
	      }
	    }
	  }

	  boolean isSameStreet(Demand tmpDemand) {
	    boolean result=false;
	    if (tmpDemand.streetNumber==streetNumber && tmpDemand.isHorizontalStreet == isHorizontalStreet)
	      result=true;
	    else if (isIntersection) {
	      if (tmpDemand.isHorizontalStreet) {
	        if ((((y-2+5)/5)-1)==tmpDemand.streetNumber)
	          result=true;
	      } else {
	        if ((((x-2+5)/5)-1)==tmpDemand.streetNumber)
	          result=true;
	      }
	    }
	    return result;
	  }

	  boolean isSamePoint(Demand tmpDemand) {
	    boolean result=false;
	    if (tmpDemand.x==x && tmpDemand.y == y)
	      result=true;
	    return result;
	  }
	}
