package {

import org.flixel.*;

public class Player extends FlxSprite
{
	[Embed(source="res/player.png")] public var PlayerSprite:Class;
	
	[Embed(source="res/deathjingle.mp3")] public var DeathJingle:Class;
	[Embed(source="res/deathsound.mp3")] public var DeathSound:Class;
	public var state:int = 0; //Normal state. 1 = death
	public var jumpState:int = 0; //1 = has jumped once
	public var deathJingle:FlxSound = new FlxSound();
	public var deathSound:FlxSound = new FlxSound();
	public function Player() {
		super();
		loadGraphic(PlayerSprite,true,true,15,30);
		addAnimation("walk",[0,1],5);
		addAnimation("stop",[0],5);
		deathJingle.loadEmbedded(DeathJingle,false);
		deathJingle.alive = false;
		deathSound.loadEmbedded(DeathSound,false);
		maxVelocity.y = 200;
		velocity.y = 100;
		acceleration.y = 650;

		
	}

	override public function update():void {
		if (state == 1) {
			death();
		} else if (state == 0){ 
			normal();
		} 	
	}


	public function normal():void {
		if (FlxG.keys.LEFT) {
			scale.x = -1
			play("walk");
			velocity.x = -120;
		} else if (FlxG.keys.RIGHT) {
			scale.x = 1;
			play("walk");
			velocity.x = 120;
		} else {
			play("still");
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
		if (!deathJingle.alive) {
			HouseState.houseSong.volume = 0;
			deathSound.play();
			deathJingle.play();
			deathJingle.alive = true;
		}

		if (FlxG.keys.Y) { 
			deathJingle.volume = 0;
			Registry.nrDeaths += 1;
			Registry.notesCollected[Registry.houseStage] = 0;
			FlxG.switchState(new HouseState());
			Registry.init();
		}
				
	}


}

}
