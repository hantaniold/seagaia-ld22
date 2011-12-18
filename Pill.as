package {
//pill class. getting one of these...activates the timer for 
//anxiety or whatever.
import org.flixel.*;
public class Pill extends FlxSprite {

	[Embed(source="res/pill.mp3")] public var PillSound:Class;
	[Embed(source="res/meds.png")] public var PillSprites:Class;
	public function Pill(_x:int, _y:int) {
		super();
		x = _x;
		y = _y;
		loadGraphic(PillSprites,true,true,16,16);
		addAnimation("pill",[0,1,2,3,4,5],4);
		play("pill");

	}

	public function getCollected():void {
		Registry.pillbar.pillGet()
		FlxG.shake(0.02);
		FlxG.play(PillSound);
		//Sets the timer on the bar thing. 
		//player polls the bar to change movement or detect death orw hatever
		kill();
	}
}
}
