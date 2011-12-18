package {
import org.flixel.*;
public class Cutscene extends FlxState {

	public var txt:FlxText = new FlxText(0,0,640);
// count how many times we proceed in dialogue
	public var spaceCt:int = 0;
	public var nrLines:Array = new Array(15,2,2);
//Dialogue at bottom/

	override public function create():void {
		spaceCt = 0;
		txt.size = 16;
		add(txt);	
	}
		
	override public function update():void {
		if (FlxG.keys.justPressed("X"))
			spaceCt += 1;
	
		if (spaceCt == nrLines[Registry.cutscene]) {
			FlxG.switchState(new HouseState());
			Registry.restart();
		}
		txt.text = dialogues[Registry.cutscene][spaceCt];
	}

	
	public var introText:Array = new Array(
		"Duke was what you could call a super Davement fan. He took great pleasure in their indie rock aural wonders.",
		"...almost too much pleasure.",
		"In fact, he was such a big fan that he learned how to build a 	time machine in order to travel back to 1990, where Davement	released some of their first demos.",
		"Problem is, the time machine broke...and Duke is now stuck	in the past!",
		"Seeing this predicament, Duke did what any self-respecting	Plavement fan would do.",
		"He took his vinyl copy of \"Straight and Disenchanted\", his record player, and the $1,000 in his pants, and went out to buy recording equipment...", 
		"...cyanide injection kits...",
		"...anxiety meds...",
		"...and set out to assassinate Davement, AND re-record		their first hit album, effectively BECOMING DAVEMENT!",
		"What a plan!",
		"In addition, Duke's anxiety disorder was not alleviated by the cold, hard fact that he was alone in 1990 - his friends did not exist, his parents were kids, and he knew no one.",
		"Only YOU have the power to determine how well Duke pulls this offf.",
		"Will you rise to the challenge?");
	
	public var c1text:Array = new Array("This is sentence 1",
				  "This is sentence 2.");
	public var c2text:Array = new Array("sentence of cs2, 1!",
		"sentence 2 of cs2, 2!");
	public var dialogues:Array = new Array(introText,c1text,c2text);

	
} }
