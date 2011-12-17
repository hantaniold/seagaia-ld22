package
{
import org.flixel.*;

public class HouseState extends FlxState
{
	[Embed(source="res/houseBG.png")] public var HouseBG:Class;
	[Embed(source="res/foo-bg.png")] public var SleepBG:Class;
// General setup stuff
	[Embed(source="res/houseTiles.png")] public var HouseTiles:Class;
	public var exit:FlxSprite;
	public var bed:FlxSprite;
	public var currentMap:FlxTilemap;

// Stage 1 house setup
	[Embed(source="csv/mapCSV_Group1_Map1.csv", mimeType = "application/octet-stream")] public var house1_CSV:Class;
	public var house_1:String = new house1_CSV();
	
// Stage 1 sleep setup
	[Embed(source="csv/mapCSV_Group1_Sleep1.csv", mimeType = "application/octet-stream")] public var sleep1_CSV:Class;
	public var sleep_1:String = new sleep1_CSV();
	
	override public function create():void
	{
		if (Registry.isNoteStage) {
			var houseBG:FlxSprite = new FlxSprite(0,0,HouseBG);
			add(houseBG);
		} else {
			var sleepBG:FlxSprite = new FlxSprite(0,0,SleepBG);
			add(sleepBG);
		}
			
		currentMap = new FlxTilemap();
		if (Registry.houseStage == 1 || 1) {
			if (Registry.isNoteStage) {
				currentMap.loadMap(house_1,HouseTiles,16,16);
				//11,27 is exit
				exit = new FlxSprite(11*16,27*16);
				exit.makeGraphic(16,32,0xFFABABAB);
				add(exit);
				Registry.player.x = 9*16;
				Registry.player.y = 26*16;
			} else {
				currentMap.loadMap(sleep_1,HouseTiles,16,16);
				bed = new FlxSprite(11*16,19*16);
				bed.makeGraphic(16,32,0xFFABABAB);
				add(bed);
				Registry.player.x =1*16;
				Registry.player.y = 12*16;
			}
		}
		add(currentMap);
		
		FlxG.camera.setBounds(0,0,1280,480,true);
		FlxG.camera.follow(Registry.player,FlxCamera.STYLE_PLATFORMER);

		add(Registry.player);

		Registry.makeNotes(Registry.houseStage);
		add(Registry.notes);
		add(Registry.noteEmitter);

		Registry.makePills(Registry.houseStage);
		add(Registry.pills);

		//hud stuff
		Registry.makeHouseHud();
		add(Registry.houseHud);
	}

	override public function update():void
	{
		
		FlxG.overlap(Registry.player,Registry.notes,collectNote);
		FlxG.overlap(Registry.player,Registry.pills,collectPill);
// Check to exit or not.
		if (Registry.isNoteStage) {
			if (FlxG.overlap(Registry.player,exit) && FlxG.keys.UP) {
				FlxG.switchState(new HouseState());
					Registry.isNoteStage = false;
					Registry.restart();
			}
		} else {
			if (FlxG.overlap(Registry.player,bed) && FlxG.keys.UP) {
				FlxG.switchState(new HouseState());
				Registry.isNoteStage = true;
				Registry.restart();
			}
		}
		super.update();	
		FlxG.collide(Registry.noteEmitter,currentMap);
		FlxG.collide(Registry.player,currentMap);
	}

	public function collectPill(player:Player, pill:Pill):void {
		pill.getCollected();
	}
	public function collectNote(player:Player, note:Note):void {
		Registry.noteEmitter.at(note);
		Registry.noteEmitter.start(true,1);
		note.getCollected();
		
	}
	
}


}
