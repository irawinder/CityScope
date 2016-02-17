import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.providers.*;

UnfoldingMap map;

public void setupMap() {
  map = new UnfoldingMap(this, new Microsoft.AerialProvider());
  //map = new UnfoldingMap(this, new Microsoft.HybridProvider());
  //map = new UnfoldingMap(this, new Microsoft.RoadProvider());
  //map = new UnfoldingMap(this, new Google.GoogleMapProvider());
  //map = new UnfoldingMap(this, new StamenMapProvider.WaterColor());
  
  map.zoomAndPanTo(new Location( lat, lon), zoom);
  MapUtils.createDefaultEventDispatcher(this, map);
}

public void drawMap() {
  map.draw();
}

public void resetMap() {
  map.zoomAndPanTo(new Location( lat, lon), zoom);
}
