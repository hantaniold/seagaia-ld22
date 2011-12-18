package {
import org.flixel.*;
import com.hexagonstar.util.debug.Debug;

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

	public var fgFade:FlxSprite = new FlxSprite(0,0);
	public var exciter:FlxText;
		public var exTimer:Number = 0; //Timers for disappear/flash
		public var exFlash:Number = 0;
	
	public var isReady:Boolean = false; //Must hit x at begin of stage
	
/** Import the CSV map files. **/
	[Embed(source="csv/mapCSV_Group1_Map1.csv", mimeType = "application/octet-stream")] public var house1_CSV:Class;
	[Embed(source="csv/mapCSV_Group1_Map2.csv", mimeType = "application/octet-stream")] public var house2_CSV:Class;
	[Embed(source="csv/mapCSV_Group1_Map3.csv", mimeType = "application/octet-stream")] public var house3_CSV:Class;
//	[Embed(source="csv/mapCSV_Group1_Map4.csv", mimeType = "application/octet-stream")] public var house4_CSV:Class;
//	[Embed(source="csv/mapCSV_Group1_Map5.csv", mimeType = "application/octet-stream")] public var house5_CSV:Class;
	[Embed(source="csv/mapCSV_Group1_Sleep1.csv", mimeType = "application/octet-stream")] public var sleep1_CSV:Class;
	[Embed(source="csv/mapCSV_Group1_Sleep2.csv", mimeType = "application/octet-stream")] public var sleep2_CSV:Class;
	[Embed(source="csv/mapCSV_Group1_Sleep3.csv", mimeType = "application/octet-stream")] public var sleep3_CSV:Class;
//	[Embed(source="csv/mapCSV_Group1_Sleep4.csv", mimeType = "application/octet-stream")] public var sleep4_CSV:Class;
//	[Embed(source="csv/mapCSV_Group1_Sleep5.csv", mimeType = "application/octet-stream")] public var sleep5_CSV:Class;
	public var house_1:String = new house1_CSV();
	public var house_2:String = new house2_CSV();
	public var house_3:String = new house3_CSV();
//	public var house_4:String = new house4_CSV();
//	public var house_5:String = new house5_CSV();
	public var sleep_1:String = new sleep1_CSV();
	public var sleep_2:String = new sleep2_CSV();
	public var sleep_3:String = new sleep3_CSV();
//	public var sleep_4:String = new sleep4_CSV();
//	public var sleep_5:String = new sleep5_CSV();
	override public function create():void	{
		
		//for debuggin/testing
		Registry.isNoteStage = false;
		Registry.houseStage = 3;

		if (Registry.isNoteStage) {
			var houseBG:FlxSprite = new FlxSprite(0,0,HouseBG);
			houseBG.scrollFactor.x = houseBG.scrollFactor.y = 0;
			add(houseBG);
		} else {
			var sleepBG:FlxSprite = new FlxSprite(0,0,HouseBG);
			sleepBG.scrollFactor.x = sleepBG.scrollFactor.y = 0;
			add(sleepBG);
		}
					
		FlxG.camera.setBounds(0,0,640,480,true);
		FlxG.camera.follow(Registry.player,FlxCamera.STYLE_PLATFORMER);

/** Create the correct map depending on what stage we're in **/
		exit = new FlxSprite();
		exit.exists = false;
		exit.loadGraphic(Door,true,true,16,32);
		exit.addAnimation("door",[0,1],10);
		exit.play("door");
		add(exit);
		bed = new FlxSprite();
		bed.exists =false;
		bed.makeGraphic(16,32,0xFFABABAB);
		add(bed);
		currentMap = new FlxTilemap();
		if (Registry.houseStage == 1) {
			if (Registry.isNoteStage) {
				exit.exists = true;
				exit.x = 11*16; exit.y = 27*16;
				currentMap.loadMap(house_1,HouseTiles,16,16);
				Registry.player.x = 9*16; Registry.player.y = 26*16;
			} else {
				bed.exists = true;
				bed.x = 11*16; bed.y = 19*16;
				currentMap.loadMap(sleep_1,HouseTiles,16,16);
				Registry.player.x =2*16; Registry.player.y = 12*16;
			}
		} else if (Registry.houseStage == 2) {
			if (Registry.isNoteStage) {
				exit.exists = true;
				exit.x = 16; exit.y = 27*16;	
				currentMap.loadMap(house_2,HouseTiles,16,16);
				Registry.player.x = 3*16; Registry.player.y = 27*16;
				FlxG.camera.setBounds(0,0,800,480,true);
			} else {
				bed.exists = true;
				bed.x = 16*16; bed.y = 16*9;
				currentMap.loadMap(sleep_2,HouseTiles,16,16);
				Registry.player.x = 7*16; Registry.player.y = 37*16;
				FlxG.camera.setBounds(0,0,640,640,true);
			}
		} else if (Registry.houseStage == 3) {
			if (Registry.isNoteStage) {
				exit.exists = true;
				exit.x = 35*16; exit.y = 19*16;	
				currentMap.loadMap(house_3,HouseTiles,16,16);
				Registry.player.x = 1*16; Registry.player.y = 6*16;
				FlxG.camera.setBounds(0,0,960,640,true);
			} else {
				bed.exists = true;
				bed.x = 65*16; bed.y = 16*6;
				currentMap.loadMap(sleep_3,HouseTiles,16,16);
				Registry.player.x = 1*16; Registry.player.y = 37*16;
				FlxG.camera.setBounds(0,0,70*16,640,true);
			}
		}/** else if (Registry.houseStage == 4) {
			if (Registry.isNoteStage) {
				exit.exists = true;
				exit.x = 16; exit.y = 27*16;	
				currentMap.loadMap(house_4,HouseTiles,16,16);
				Registry.player.x = 3*16; Registry.player.y = 27*16;
				FlxG.camera.setBounds(0,0,800,480,true);
			} else {
				bed.exists = true;
				bed.x = 16*16; bed.y = 16*9;
				currentMap.loadMap(sleep_4,HouseTiles,16,16);
				Registry.player.x = 7*16; Registry.player.y = 37*16;
				FlxG.camera.setBounds(0,0,640,640,true);
			}
else if (Registry.houseStage == 5) {
			if (Registry.isNoteStage) {
				exit.exists = true;
				exit.x = 16; exit.y = 27*16;	
				currentMap.loadMap(house_5,HouseTiles,16,16);
				Registry.player.x = 3*16; Registry.player.y = 27*16;
				FlxG.camera.setBounds(0,0,800,480,true);
			} else {
				bed.exists = true;
				bed.x = 16*16; bed.y = 16*9;
				currentMap.loadMap(sleep_5,HouseTiles,16,16);
				Registry.player.x = 7*16; Registry.player.y = 37*16;
				FlxG.camera.setBounds(0,0,640,640,true);
			}**/


		add(currentMap);
		

		add(Registry.player);
		if (Registry.isNoteStage) {
			Registry.makeNotes(Registry.houseStage);
			add(Registry.notes);
		}

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
//the below should *realy* bein teh hud but whatever
		fgFade.makeGraphic(640,480,0xFF000000);
		fgFade.exists = true;
		fgFade.scrollFactor = new FlxPoint(0,0);
		add(fgFade);
	
		deathTextBorder.exists = false;
		deathTextBorder.makeGraphic(200,200,0xCC00FF00);
		deathTextBorder.scrollFactor = new FlxPoint(0,0)
		add(deathTextBorder);
		deathText.exists = false;
		deathText.size = 12;
		deathText.scrollFactor = new FlxPoint(0,0);
		add(deathText);
	
		//DEBUG TEXT
		dt.scrollFactor = new FlxPoint(0,0);
		dt.exists = true;
		dt.color = 0x000000;
		add(dt);
		
		
	}

	override public function update():void
	{
				
		//update timer text
		Registry.stageTime += FlxG.elapsed;
		Registry.timeText.text = "Elapsed Time: "+Registry.stageTime.toFixed(2).toString()+"s";
		//fgfade on anx. bar.
		if (Registry.pillbar.scale.x > 160) {
			fgFade.alpha = (Registry.pillbar.scale.x - 160) / 240.0;
		} else {
			fgFade.alpha = 0;
		}
			
		//show debug text, debug text updates
		dt.text = "Deaths: "+Registry.nrDeaths.toString();	
		
		if (FlxG.keys.justPressed("D")) 
			dt.exists = !dt.exists;	
		//pillbar check for death
		if (Registry.pillbar.scale.x > 319)
			deathText.exists = deathTextBorder.exists = true;
			
			
		//exciter text update
		if (exciter.exists) 
			updateExciter();

		if (Registry.isNoteStage) 
			FlxG.overlap(Registry.player,Registry.notes,collectNote);
		
		FlxG.overlap(Registry.player,Registry.pills,collectPill);
// Check to exit or not.
		if (Registry.isNoteStage) {
			if (FlxG.overlap(Registry.player,exit) && FlxG.keys.UP) {
				Registry.cutscene += 1;
				Registry.isNoteStage = false;
				Pillbar.dangerSound.volume = 0;
				FlxG.switchState(new Cutscene());
			}
		} else {
			if (FlxG.overlap(Registry.player,bed) && FlxG.keys.UP) {
				Registry.cutscene += 1;
				Registry.houseStage += 1;
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
