package
{
import org.flixel.*;
import com.hexagonstar.util.debug.Debug;
public class Registry {

	public static var player:Player;

// Notes
	public static var notes:FlxGroup;

// Pills
	public static var pills:FlxGroup;
// huds


	public static var houseHud:FlxGroup;
	[Embed(source="res/anxietybar.png")]  public static var AnxBar:Class;
	[Embed(source="res/bignote.png")] public static var BigNote:Class;
		public static var anxBar:FlxSprite;
//Bignote is a sort of progress meter. it fills in semi-randomly.
		public static var bigNote:FlxSprite;
			public static var bigNote_xs:Array = new Array(5,5,6,5,7,5,5,2,3,4,5,1,2,3,4,5,2,3,4);
			public static var bigNote_ys:Array = new Array(0,1,1,2,2,3,4,5,5,5,5,6,6,6,6,6,7,7,7);
		public static var pillbar:Pillbar;
		public static var noteText:FlxText;
		public static var timeText:FlxText;
// emitter stuff

	
	
// general state
	public static var isNoteStage:Boolean = true;
	public static var houseStage:int = 1;
	public static var notesCollected:Array = new Array(0,0,0,0,0,0);
	public static var times:Array = new Array(0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0);
	public static var stageTime:Number = 0;
	public static var cutscene:int = 0; 
	public static var nrDeaths:int = 0;

	public function Registry() {
	}

	public static function init():void {
		player = new Player;
		pills = new FlxGroup();
		stageTime = 0;
		
	}

	public static function makeHouseHud():void {
		
		pillbar = new Pillbar();

		anxBar = new FlxSprite(pillbar.x-1,pillbar.y-1);
		anxBar.loadGraphic(AnxBar,true,true,322,18);

		noteText = new FlxText(760,8,560,"Notes: "+notesCollected[houseStage].toString()+"/20");
		noteText.scale.x = noteText.scale.y = 2;
		noteText.color = 0xFF000000;

		bigNote = new FlxSprite(FlxG.width - 72,8);	
		bigNote.loadGraphic(BigNote,true,true,64,64);

		timeText  = new FlxText(8,8,160);
		timeText.size = 11;
		timeText.color = 0x000033;
		timeText.text = "Elapsed Time: 0.0s";

		houseHud = new FlxGroup();
		houseHud.add(anxBar);
		houseHud.add(bigNote);
		houseHud.add(pillbar);
		houseHud.add(noteText);
		houseHud.add(timeText);
		houseHud.setAll("scrollFactor",new FlxPoint(0,0));
		
	}

	public static function restart():void {
		if (isNoteStage) {
			Registry.notesCollected[houseStage] = 0;
		}
		init();
	}
		
	//note position data here unless i can do it in dame?
	public static function makeNotes(level:int):void {
		
		notes = new FlxGroup();
		var xs:Array;
		var ys:Array;
		if (level == 1) {
			xs = new Array( 1,36,20,23,30,30,24,20,15,15,19,23,30,36,37,2, 1,5, 1,9);
			ys = new Array(28,26,21,21,21,16,16,16,16,13,13,13,13,13,12,9,12,6,17,6);
		} 

		if (level == 2) {
			xs = new Array( 3 ,6 ,9,12,15,22,34,31,32,48,36,48,36,47,48, 3,17,23,28,11);
			ys = new Array(22,21,22,21,22,11,15,22,28,26,23,19,15, 3, 3, 7, 2, 2, 2, 2);
		}
		for(var i:int = 0; i < xs.length; i++) {
			mn(xs[i],ys[i],i);
		}
		Debug.trace("Made notes");
	}
//i do the x16 scaling in the note class
	public static function mn(x:int,y:int,id:int):void {
		notes.add(new Note(x,y,id));
	}

	public static function makePills(level:int):void {
		var xs:Array;
		var ys:Array;
		if (level == 1 && isNoteStage) {
			xs = new Array(15,6 ,38,20,16,17,18,19);
			ys = new Array(25,14,22,6 ,25,25,25,25);
		} else if (level == 1) {
			xs = new Array(33,19,24);
			ys = new Array(3,26,18);
		} else if (level == 2 && isNoteStage) {
			xs = new Array(26,38,47,10);
			ys = new Array(20,28,11,7);
		}
		
		for (var i:int = 0; i< xs.length; i++) {
			mp(xs[i],ys[i]);
		}
	}
	public static function mp(x:int,y:int):void {
		pills.add(new Pill(16*x,16*y));
	}
	

}

}
