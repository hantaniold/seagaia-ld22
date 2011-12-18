package {

import org.flixel.*;
public class Note extends FlxSprite{

	[Embed(source="res/notes.png")] public var NoteSprites:Class;
	[Embed(source="res/notefx1.mp3")] public var fx1:Class;
	[Embed(source="res/notefx2.mp3")] public var fx2:Class;
	[Embed(source="res/notefx3.mp3")] public var fx3:Class;
	[Embed(source="res/notefx4.mp3")] public var fx4:Class;
	[Embed(source="res/notefx5.mp3")] public var fx5:Class;
	public var fxArray:Array = new Array(fx1,fx2,fx3,fx4,fx5);
	public var id:int = -1;

	public function Note(_x:int, _y:int,_id:int) {
		super();
		x = 16*_x;
		y = 16*_y;	
		id = _id;

	//randomly pick what note to look like
		loadGraphic(NoteSprites,true,true,16,16);
		addAnimation("note",[int(Math.random() * 4)]);
		play("note");
	}

	public function getCollected():void {
//update note count for a stage
		FlxG.play(fxArray[int(Math.random() * 5)]);
		Registry.notesCollected[Registry.houseStage] += 1;
		
		Registry.noteText.text = "Notes: "+Registry.notesCollected[Registry.houseStage].toString()+"/20";
		kill();
	}

}
}
