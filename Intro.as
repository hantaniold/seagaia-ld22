package {
import org.flixel.*;

public class Intro extends FlxState {

	private var state:int = 0;
	private var timer:Number = 0;
	private var logoText:FlxText = new FlxText(50,50,300,"A game by seagaia using the Flixel framework");
	private var title:FlxText = new FlxText(50,50,300,"ENSLAVING PLAVEMENT");
	override public function create():void {
		
		add(logoText);
		title.exists = false;
		add(title);
	}
	override public function update():void {
		timer += FlxG.elapsed;
		if (state == 0) {
			logoText.alpha = 1 - (timer/3);
			if (FlxG.keys.justReleased("X") || (timer > 3)) {
				state = 1;
				timer = 0;
				logoText.exists = false;
				title.exists = true;
			}
		} else if (state == 1) {
			title.alpha = 1 - (timer/3);
			if (FlxG.keys.X || (timer > 3)) {
				FlxG.switchState(new Cutscene());
			}	
		}
		super.update();
	}
}	
}
