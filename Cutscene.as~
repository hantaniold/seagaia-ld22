package {
import org.flixel.*;
public class Cutscene extends FlxState {

	public var txt:FlxText = new FlxText(50,50,600);
// count how many times we proceed in dialogue
	public var spaceCt:int = 0;
	public var c1text:Array = new Array("This is sentence 1",
				  "This is sentence 2.");
	public var c2text:Array = new Array("sentence of cs2, 1!",
		"sentence 2 of cs2, 2!");
	public var dialogues:Array = new Array("",c1text,c2text);
	override public function create():void {
		spaceCt = 0;
		add(txt);	
	}
		
	override public function update():void {
		if (FlxG.keys.justPressed("X"))
			spaceCt += 1;


		if (Registry.cutscene == 1) {	
			if (spaceCt == 2) { 
				FlxG.switchState(new HouseState());
				Registry.restart();
			}
		}

		if (Registry.cutscene == 2) {
			if (spaceCt == 2) {
				FlxG.switchState(new HouseState());
				Registry.restart();
			}
		}

		txt.text = dialogues[Registry.cutscene][spaceCt];
	}
}

}
