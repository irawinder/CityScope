
import javax.swing.JFrame;



public class PFrame extends JFrame {
	public PFrame(int _x, int _y, int _width, int _height) {
		setBounds(_x, _y, _width, _height);
		UrbanAutonomous.opw = new OperationWindow();
		add(UrbanAutonomous.opw);
		UrbanAutonomous.opw.init();
		setVisible(true);
	}
}