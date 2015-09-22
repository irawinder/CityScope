import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.providers.*;

UnfoldingMap map;

public void setupMap() {
  map = new UnfoldingMap(this, new Microsoft.AerialProvider());
  map.zoomAndPanTo(new Location( lat, lon), zoom);
  MapUtils.createDefaultEventDispatcher(this, map);
}

public void drawMap() {
  map.draw();
}
