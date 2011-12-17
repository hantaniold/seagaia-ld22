package {

import org.flixel.*;
public class Note extends FlxSprite{

	[Embed(source="res/notes.png")] public var NoteSprites:Class;

	public var id:int = -1;

	public function Note(_x:int, _y:int,_id:int) {
		super();
		x = _x;
		y = _y;	
		id = _id;

	//randomly pick what note to look like
		loadGraphic(NoteSprites,true,true,16,16);
		addAnimation("note",[int(Math.random() * 4)]);
		play("note");
	}

	public function getCollected():void {
//update note count for a stage
		Registry.notesCollected[Registry.houseStage] += 1;
		
		Registry.noteText.text = "Notes: "+Registry.notesCollected[Registry.houseStage].toString()+"/20";
		kill();
	}
}
}
