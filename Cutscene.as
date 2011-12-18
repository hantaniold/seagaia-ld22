package {
import org.flixel.*;
import com.hexagonstar.util.debug.Debug;
public class Cutscene extends FlxState {

	public var txt:FlxText = new FlxText(0,0,640);
// count how many times we proceed in dialogue
	public var spaceCt:int = 0;

//Dialogue at bottom/

	override public function create():void {
		spaceCt = 0;
		txt.size = 16;
		var ins:FlxText = new FlxText(320,300,250);
		ins.size = 20;
		ins.text = "Press X!"
		add(ins);
		add(txt);	
	}
		
	override public function update():void {
		if (FlxG.keys.justPressed("X"))
			spaceCt += 1;
	
		if (spaceCt == nrLines[Registry.cutscene]) {
			FlxG.switchState(new HouseState());
			Registry.restart();
		} else {
			txt.text = dialogues[Registry.cutscene][spaceCt];
		}
	}

	
	public var introText:Array = new Array(
		"INSTRUCTIONS: Arrow keys move! X to jump! Up array opens doors and does things to beds! Your anxiety meter fills - fill too high and you'll die! Get anxiety meds to alleviate this. Grab music notes on music stages to do better in the end, or something! On night stages, make your way to the bed as fast as possible and press up to win! Yes! Enjoy!",
		"Duke was what you could call a super Davement fan. He took great pleasure in their indie rock aural wonders.",
		"...almost too much pleasure.",
		"In fact, he was such a big fan that he learned how to build a 	time machine in order to travel back to Stockton, CA, 1990, where Davement	released some of their first demos.",
		"Problem is, the time machine broke...and Duke is now stuck	in the past!",
		"Seeing this predicament, Duke did what any self-respecting	Plavement fan would do.",
		"He took his vinyl copy of \"Straight and Disenchanted\", his record player, and the $1,000 in his pants, and went out to buy recording equipment...", 
		"...cyanide injection kits...",
		"...anxiety meds...",
		"...and set out to take over Davement, AND re-record		their first hit album, effectively BECOMING DAVEMENT!",
		"What a plan!",
		"In addition, Duke's anxiety disorder was not alleviated by the cold, hard fact that he was alone in 1990 - his friends did not exist, his parents were kids, and he knew no one.",
		"Only YOU have the power to determine how well Duke pulls this offf.",
		"Will you rise to the challenge?");
	
	public var c1text:Array = new Array(
		"PRESS X TO START CUTSCENE",
		"The band's first song, \"Sliding Rain\", was a hit in 1991. Duke has replicated this song ahead of time successfully! Unfortunately, the drummer, Dary Loung, has heard of your antics and is suspicious.",
		"There is only one thing Duke can do! Break into his house, and TAKE HIM OUT...nonviolently, of course. ");
	public var c2text:Array = new Array(
		"PRESS X TO START CUTSCENE",
		"Ah, that was easy! Dary stood no chance against your, uh, I mean, Duke's sneaking skills...",
		"Back to the studio. You've since used funds to upgrade your house. The next song you'll need to record is \"Apparent Lack of Power of the Wire Fence\".");
	public var c3text:Array = new Array(
		"PRESS X TO START CUTSCENE",
		"Ah, now the bassist of Davement - Dark Eyebold - is catching on! Duke must do likewise as Duke did to Dary...proceed with caution!...Duke.");
	public var c4text:Array = new Array(
		"PRESS X TO START CUTSCENE",
		"Dark Eyebold stood no chance. He has been converted into a member of Duke's Davement. But what about the frontman of Davement?",
		"What will Duke do about him?",
		"Such questions are interesting, but of no use now.",
		"Duke must go record a new song - in his newer home -",
		"Tigger Mutt.");
	public var dialogues:Array = new Array(introText,c1text,c2text,c3text,c4text);
	public var nrLines:Array = new Array(introText.length,c1text.length,c2text.length,c3text.length,c4text.length);

	
} }
