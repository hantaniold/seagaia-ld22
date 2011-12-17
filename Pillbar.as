package {

import org.flixel.*;
public class Pillbar extends FlxSprite {
	public var timeToFull:Number = 15; //time in sec for bar to empty
	public var timeElapsed:Number = 0; //time since last pill
	public var maxScale:Number = 320;
	public function Pillbar() {
		super();
		makeGraphic(1,16,0xFFFF0000);
		scale.x = 20;
		origin.x = origin.y = 0;
	}

	public function pillGet():void {
		scale.x = 1;
		timeElapsed = 0;
	}

	override public function update():void {
		timeElapsed += FlxG.elapsed;
		if (scale.x <= 320)
			scale.x = maxScale * (timeElapsed/timeToFull);
		if (scale.x > 80 && scale.x <= 160) {
			FlxG.shake(0.0);
		} else if (scale.x > 160) {
			FlxG.shake(0.0);
		} else {
			FlxG.shake(0);
		}
		
	}
}

}
