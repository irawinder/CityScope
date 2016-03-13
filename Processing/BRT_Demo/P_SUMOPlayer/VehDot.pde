//package com.ansonstewart.sumoplayer;

import de.fhpotsdam.unfolding.geo.Location;
import de.fhpotsdam.unfolding.marker.SimplePointMarker;

public class VehDot {

  public String route;
  public SimplePointMarker marker;
  public float x;
  public float y;
  public float angle;
  public float speed;
  public String type;

  public VehDot(String _route, Float _x, Float _y, Float _angle, Float _speed, String _type) {
    route = _route;
    x = _x;
    y = _y;
    marker = new SimplePointMarker(new Location(_x, _y)); 
    angle = _angle;
    speed = _speed;
    type = _type;
  }

}

