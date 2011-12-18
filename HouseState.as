package {
import org.flixel.*;

public class HouseState extends FlxState {
	[Embed(source="res/houseBG.png")] public var HouseBG:Class;
	[Embed(source="res/foo-bg.png")] public var SleepBG:Class;
	[Embed(source="res/door.png")] public var Door:Class;
// General setup stuff
	[Embed(source="res/houseTiles.png")] public var HouseTiles:Class;
	public var exit:FlxSprite; //Exit for day stages
	public var bed:FlxSprite; //band member location for night stages
	public var currentMap:FlxTilemap;
	public var emitters:FlxGroup;
	public var squares:FlxGroup; //Squares to fill in big note
	public var deathText:FlxText = new FlxText(240,170,200,"Oh man, you got a little too anxious about your quest and position, and couldn't make it to the exit or the meds on time to do anything about it! In doing so, Duke jumped out of a window. Try again? Press \"Y\"!");
	public var deathTextBorder:FlxSprite = new FlxSprite(236,166);
	public var dt:FlxText = new FlxText(FlxG.width/2,400,250);

	public var exciter:FlxText;
		public var exTimer:Number = 0; //Timers for disappear/flash
		public var exFlash:Number = 0;
	
// Stage 1 house setup
	[Embed(source="csv/mapCSV_Group1_Map1.csv", mimeType = "application/octet-stream")] public var house1_CSV:Class;
	public var house_1:String = new house1_CSV();
	
// Stage 1 sleep setup
	[Embed(source="csv/mapCSV_Group1_Sleep1.csv", mimeType = "application/octet-stream")] public var sleep1_CSV:Class;
	public var sleep_1:String = new sleep1_CSV();
	
	override public function create():void	{
		if (Registry.isNoteStage) {
			var houseBG:FlxSprite = new FlxSprite(0,0,HouseBG);
			houseBG.scrollFactor.x = houseBG.scrollFactor.y = 0;
			add(houseBG);
		} else {
			var sleepBG:FlxSprite = new FlxSprite(0,0,SleepBG);
			sleepBG.scrollFactor.x = sleepBG.scrollFactor.y = 0;
			add(sleepBG);
		}
			
		currentMap = new FlxTilemap();
		if (Registry.houseStage == 1) {
			if (Registry.isNoteStage) {
				currentMap.loadMap(house_1,HouseTiles,16,16);
				//11,27 is exit
				exit = new FlxSprite(11*16,27*16);
				exit.loadGraphic(Door,true,true,16,32);
				exit.addAnimation("door",[0,1],10);
				exit.play("door");
				add(exit);
				Registry.player.x = 9*16;
				Registry.player.y = 26*16;
			} else {
				currentMap.loadMap(sleep_1,HouseTiles,16,16);
				bed = new FlxSprite(11*16,19*16);
				bed.makeGraphic(16,32,0xFFABABAB);
				add(bed);
				Registry.player.x =2*16;
				Registry.player.y = 12*16;
			}
		}
		add(currentMap);
		
		FlxG.camera.setBounds(0,0,640,500,true);
		FlxG.camera.follow(Registry.player,FlxCamera.STYLE_PLATFORMER);

		add(Registry.player);

		Registry.makeNotes(Registry.houseStage);
		add(Registry.notes);

		Registry.makePills(Registry.houseStage);
		add(Registry.pills);

		//emitter stuff, so we can separately spawn emitters
		//and still collide them
		emitters = new FlxGroup();
		add(emitters);
		//hud stuff
		Registry.makeHouseHud();
		add(Registry.houseHud);
		//other
		exciter = new FlxText(0,0,100);
		exciter.exists = false;
		exciter.velocity.y = -50;
		add(exciter);
		
		squares = new FlxGroup();
		add(squares);

		deathTextBorder.exists = false;
		deathTextBorder.makeGraphic(200,300,0xCC00FF00);
		add(deathTextBorder);
		deathText.exists = false;
		deathText.size = 12;
		add(deathText);

		//DEBUG TEXT
		dt.scrollFactor = new FlxPoint(0,0);
		dt.exists = true;
		dt.color = 0x000000;
		add(dt);
	}

	override public function update():void
	{
	
		//show debug text, debug text updates
		dt.text = "Deaths: "+Registry.nrDeaths.toString();	
		if (FlxG.keys.justPressed("D")) 
			dt.exists = !dt.exists;	
		//update timer text
		Registry.stageTime += FlxG.elapsed;
		Registry.timeText.text = "Elapsed Time: "+Registry.stageTime.toFixed(2).toString()+"s";
		//pillbar check for death
		if (Registry.pillbar.scale.x > 319)
			deathText.exists = deathTextBorder.exists = true;
			
			
		//exciter text update
		if (exciter.exists) 
			updateExciter();

		FlxG.overlap(Registry.player,Registry.notes,collectNote);
		FlxG.overlap(Registry.player,Registry.pills,collectPill);
// Check to exit or not.
		if (Registry.isNoteStage) {
			if (FlxG.overlap(Registry.player,exit) && FlxG.keys.UP) {
				Registry.cutscene += 1;
				Registry.isNoteStage = false;
				FlxG.switchState(new Cutscene());
			}
		} else {
			if (FlxG.overlap(Registry.player,bed) && FlxG.keys.UP) {
				Registry.cutscene += 1;
			//decomment below hwen have more stages?
			//	Registry.houseStage += 1;
				Registry.isNoteStage = true;
				FlxG.switchState(new Cutscene());
			}
		}
		super.update();	
		FlxG.collide(Registry.player,currentMap);
		FlxG.collide(emitters,currentMap);
	}
		
	public function updateExciter():void {
		exFlash += FlxG.elapsed;
		exTimer += FlxG.elapsed;
		exciter.alpha = 1 - (exTimer/2.0);
		if (exFlash < 0.1) {
			exciter.color = 0x00FF00;
		} else {
			exciter.color = 0x0000FF;
		}
		if (exFlash > 0.2)
			exFlash = 0;
		if (exTimer > 2) {
			exTimer = 0;	
			exciter.exists = false;
		}
		
	}

//do silly things like emit text, particles, shake...
	public function collectPill(player:Player, pill:Pill):void {
		pill.getCollected();

		exciter.x = pill.x - 16;
		exciter.y = pill.y;
		exciter.exists = true;
		var j:Number = Math.random();
		if (j < 0.25) {
			exciter.text = "OH YEAH!";
		} else if (j < 0.5) {
			exciter.text = "ADDICTIVE!";
		} else if (j < 0.75) {
			exciter.text = "CAN'T STOP!!";
		} else {
			exciter.text = "C'MON BABY!";
		}
		var nrParticles:int = 50;
		var em:FlxEmitter = new FlxEmitter(0,0,100);
		em.particleDrag = new FlxPoint(0,0);
		em.gravity = 300;
		for (var i:int = 0; i < 100; i++) {
				var particle:FlxParticle = new FlxParticle();
			if (Math.random() < 0.33) {
				particle.makeGraphic(4,4,0x88e64994);
			} else if (Math.random() < 0.5) {
				particle.makeGraphic(3,3,0x77e68b94);
			} else {
				particle.makeGraphic(4,3,0x99e6bf94);
			}
			particle.lifespan = 5;
			particle.solid = true;
			particle.exists = false;
			em.add(particle);
			
		}
		emitters.add(em);
		em.at(pill);
		em.start(true,1);
	
	}
	public function collectNote(player:Player, note:Note):void {
		note.getCollected();
		//Fancy effects. well, sort of.
		var noteEmitter:FlxEmitter = new FlxEmitter(0,0,50);
		noteEmitter.particleDrag = new FlxPoint(0,0);
		noteEmitter.gravity = 350;
		for (var i:int = 0; i < 50; i++) {
			var particle:FlxParticle = new FlxParticle();
			particle.makeGraphic(3,3,0x88000000);
			particle.lifespan = 2.4;
			particle.solid = true;
			particle.exists = false;
			noteEmitter.add(particle);
		}
		emitters.add(noteEmitter);
		noteEmitter.at(note);
		noteEmitter.start(true,1);
	
		//Update that big note in the top right.
		var square:FlxSprite = new FlxSprite(Registry.bigNote.x + 8*Registry.bigNote_xs[note.id],Registry.bigNote.y + 8*Registry.bigNote_ys[note.id]);
		square.makeGraphic(8,8,0xFF000000);
		square.scrollFactor = new FlxPoint(0,0);
		squares.add(square);	
	}
	
}


}
