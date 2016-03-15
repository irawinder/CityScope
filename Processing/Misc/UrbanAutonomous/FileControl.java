
import processing.core.PApplet;

public class FileControl extends PApplet {
	  public int [] customMap;

	  public FileControl() {
	    customMap = new int[(16*16)];
	  }

	  public void outputCSV() {
	    String []outData=str(customMap);
	    saveStrings("customMap.txt", outData);
	  }
	}