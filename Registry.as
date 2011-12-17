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
		public static var pillbar:Pillbar;
		public static var noteText:FlxText;
// emitter stuff
	public static var noteEmitter:FlxEmitter;

	
	
// general state
	public static var isNoteStage:Boolean = true;
	public static var houseStage:int = 1;
	public static var notesCollected:Array;

	public function Registry() {
	}

	public static function init():void {
		player = new Player;
		player.x = player.y = 100;
		notesCollected = new Array(0,0,0);
		initEmitters();
		
	}

//note position data here unless i can do it in dame?

	public static function initEmitters():void {
		var nrParticles:int = 50;
		var drag:FlxPoint = new FlxPoint(0,0);
		noteEmitter = new FlxEmitter(0,0,50);
		noteEmitter.particleDrag = drag;
		noteEmitter.gravity = 350;
		for (var i:int = 0; i < nrParticles; i++) {
			var particle:FlxParticle = new FlxParticle();
			particle.makeGraphic(4,4,0xEE000000);
			particle.lifespan = 1;
			particle.solid = true;
			particle.exists = false;
			noteEmitter.add(particle);
		}
	}
	public static function makeNotes(level:int):void {
		
		notes = new FlxGroup();
		if (level == 1 && isNoteStage) {
			notes.add(new Note(420,290,1)); 
			notes.add(new Note(400,290,2));			
			notes.add(new Note(440,290,3));
			notes.add(new Note(420,310,4));
			notes.add(new Note(400,310,5));
			notes.add(new Note(440,310,6));
			notes.add(new Note(420,270,7));
			notes.add(new Note(400,270,8));
			notes.add(new Note(440,270,9));
			notes.add(new Note(420,250,10));
			notes.add(new Note(400,250,11));
			notes.add(new Note(440,250,12));
			notes.add(new Note(420,230,13));
			notes.add(new Note(400,230,14));
			notes.add(new Note(440,230,15));
			notes.add(new Note(420,330,16));
			notes.add(new Note(400,330,17));
			notes.add(new Note(440,330,18));
			notes.add(new Note(420,350,19));
			notes.add(new Note(400,350,20));
				

		}
	}

	public static function makePills(level:int):void {
		pills = new FlxGroup();
		if (level == 1 && isNoteStage) {
			pills.add(new Pill(350,340));
		}
	}
	
	public static function makeHouseHud():void {
		pillbar = new Pillbar();
		noteText = new FlxText(80,20,560,"Notes: "+notesCollected[houseStage].toString()+"/20");
		noteText.color = 0xFF000000;

		houseHud = new FlxGroup();
		houseHud.add(pillbar);
		houseHud.add(noteText);
		houseHud.setAll("scrollFactor",new FlxPoint(0,0));
	}

	public static function restart():void {
		if (isNoteStage) {
			Registry.notesCollected[houseStage] = 0;
		}
		init();
	}
}

}