package {
//pill class. getting one of these...activates the timer for 
//anxiety or whatever.
import org.flixel.*;
public class Pill extends FlxSprite {
	public function Pill(_x:int, _y:int) {
		super();
		x = _x;
		y = _y;
		makeGraphic(16,16,0xFF666666);
	}

	public function getCollected():void {
		Registry.pillbar.pillGet()
		//Sets the timer on the bar thing. 
		//player polls the bar to change movement or detect death orw hatever
		kill();
	}
}
}
