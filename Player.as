package {

import org.flixel.*;

public class Player extends FlxSprite
{

	public var state:int = 0; //Normal state. 1 = death
	public var jumpState:int = 0; //1 = has jumped once
	public function Player() {
		super();
		makeGraphic(15,32,0xff998833);
		maxVelocity.y = 200;
		velocity.y = 100;
		acceleration.y = 650;

		
	}

	override public function update():void {
		if (state == 1) {
			death();
		} else { 
			normal();
		} 	
	}

	public function normal():void {
		if (FlxG.keys.LEFT) {
			velocity.x = -120;
		} else if (FlxG.keys.RIGHT) {
			velocity.x = 120;
		} else {
			velocity.x = 0;
		}

		if (jumpState == 1) {
			if (isTouching(FlxObject.FLOOR)) 
				jumpState = 0;	
		} else if (FlxG.keys.X && (jumpState == 0)) {
			velocity.y = -280;
			jumpState = 1;
		}

		if (Registry.pillbar.scale.x > 320) { 
			makeGraphic(16,32,0xff000000);
			velocity.x = velocity.y = 0;
			acceleration.y = 0;
			state = 1;
		}
			
	}

	public function death():void {
		if (FlxG.keys.Y) { 
			Registry.notesCollected[Registry.houseStage] = 0;
			FlxG.switchState(new HouseState());
			Registry.init();
		}
				
	}


}

}
