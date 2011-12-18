package {

import org.flixel.*;
public class Pillbar extends FlxSprite {
	public var timeToFull:Number = 12; //time in sec for bar to empty
	public var timeElapsed:Number = 0; //time since last pill
	public var maxScale:Number = 320;
	public var dangerSound:FlxSound = new FlxSound();
	public function Pillbar() {
		super(160,10);
		dangerSound.loadStream("res/closetodeath.mp3",false);
		dangerSound.alive = false;
		makeGraphic(1,16,0x88FF0000);
		scale.x = 20;
		origin.x = origin.y = 0;
	}

	public function pillGet():void {
		dangerSound.volume = 0;
		dangerSound.alive = false;
		scale.x = 1;
		timeElapsed = 0;
	}

	override public function update():void {
		timeElapsed += FlxG.elapsed;
		if (scale.x <= 320)
			scale.x = maxScale * (timeElapsed/timeToFull);
		if (scale.x > 160 && scale.x <= 240) {
			if (!dangerSound.alive) {
				dangerSound.volume = 1;
				dangerSound.alive = true;
				dangerSound.play();
			}
			FlxG.shake(0.005);
		} else if ((scale.x  > 240) && (scale.x <= 320)) {
			FlxG.shake(0.01);
		} else if (scale.x > 319){
			FlxG.shake(0);
		} else {
			var foo:int;
		}
			
		
	}
}

}
