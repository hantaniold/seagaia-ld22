package
{
import org.flixel.*;
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
	public static var times:Array = new Array(0.0,0.0,0.0,0.0,0.0);
	public static var stageTime:Number = 0;
	public static var cutscene:int = 0; 
	public static var nrDeaths:int = 0;
	public static var doAutoPause:Boolean = false;

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
		} else {
			Registry.times[houseStage] = 0.0;
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

		if (level == 3) {
			xs = new Array(53,46, 7,12,36,29,23,10,11,18,25,33, 1,18,24,52,54,39,2,2);
			ys = new Array( 9,11,10,10,11,19,19,19,27,27,27,27,35,35,35,32,27,22,34,35);
		}

		if (level == 4) {
			xs = new Array(22,20,33, 5,15,29,18,24,22,21,41,40,34,32,24,22,16,13,9,4);
			ys = new Array(16,16, 2, 8,16,17, 7, 7,27, 6,44,42,36,41,44,42,36,41,48,48);
		}
		if (level == 5) {
			xs = new Array(1,1);
			ys = new Array(1,1);
		}


		for(var i:int = 0; i < xs.length; i++) {
			mn(xs[i],ys[i],i);
		}
	}
//i do the x16 scaling in the note class
	public static function mn(x:int,y:int,id:int):void {
		notes.add(new Note(x,y,id));
	}

	public static function makePills(level:int):void {
		var xs:Array;
		var ys:Array;
		if (level == 1 && isNoteStage) {
			xs = new Array(6 ,38,20,17);
			ys = new Array(14,22,6 ,25);
		} else if (level == 1) {
			xs = new Array(33,19,24);
			ys = new Array(3,26,18);
		} else if (level == 2 && isNoteStage) {
			xs = new Array(26,38,47,10);
			ys = new Array(20,28,11,7);
		} else if (level == 2) {
			xs = new Array(7,22,34,29);
			ys = new Array(16,31,18,26);
		} else if (level == 3 && isNoteStage) {
			xs = new Array(49,35,16,46,49);
			ys = new Array(13,17,35,30,27);
		} else if (level == 3) {
			xs = new Array(53,56,32,61,37,17,5);
			ys = new Array(35,25,22,21,18,21,8);
		}  else if (level == 4 && isNoteStage) {
			xs = new Array(4,38,22,20,33,46);
			ys = new Array(4,4,8,8,23,48);
		} else if (level == 4) {
			xs = new Array(5,41,46,15,35,62,63,30);
			ys = new Array(5,9,14,14,17,17,22,23);
		}/** else if (level == 5 && isNoteStage) {
			xs = new Array();
			ys = new Array();
		} else if (level == 5) {
			xs = new Array();
			ys = new Array();
		}**/


		
		for (var i:int = 0; i< xs.length; i++) {
			mp(xs[i],ys[i]);
		}
	}
	public static function mp(x:int,y:int):void {
		pills.add(new Pill(16*x,16*y));
	}
	

}

}
