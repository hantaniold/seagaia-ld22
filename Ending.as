package {
import org.flixel.*;

public class Ending extends FlxState{

	override public function create():void {
		var tx:FlxText = new FlxText(80,20,560,"Ending");
		add(tx);
	}	

}
}
