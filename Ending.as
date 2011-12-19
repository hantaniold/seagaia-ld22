package {
import org.flixel.*;

public class Ending extends FlxState{

	override public function create():void {
		var tx:FlxText = new FlxText(80,20,560,"Ending");
		add(tx);
		doEnd();
	}	
	
	public function doEnd():void {
		var title:FlxText = new FlxText(320,0,300);
		title.text = "Hey, you did it. Way to go, champ. I mean Duke. You defeated Davement, I mean, converted them, and you became the leader, having stolen their songs, from their later hit album...but...now you are so alone, so sad. Not like your anxiety got even better. The stage fright is too much. You are alone. You have no friends, no family..you don't exist. You are a ghost. BUT HERE'S THE DITCHPORK REVIEW OF YOUR ALBUM!";
		
		var review:FlxText = new FlxText(0,240,640);
		add(title);
		add(review);
		var sum:int = 0;
		for(var i:int = 0; i < 6; i++) {
			sum += Registry.notesCollected[i];
		}
		var times:Number = 0.0;
		for(var j:int = 0; i < 5; i++) {
			times += Registry.times[j];
		}
		review.text = "OFFICIAL DITCHPORK REVIEW: 4/25/1990";

		if (sum == 0) 
			review.text += "Davement's newest release is quite the postmodern work of art. It succeeds in managing to show everything about the past 40 years of indie rock, while not having a single note! Their lead man, Duke, shall surely lead the pack. ";
		if (sum > 0 && sum < 40) {
			review.text += "Davement's newest release is fuzzy, warm, and decent.";
		} else if (sum >= 40 && sum <= 79) {
			review.text += "Davement is an astounding work of art, which can be likened to a sunny day. Or should I say, a winter's day! Ho ho.";
		}
		if (sum == 80)
			review.text += "DAMN. That's how good this album is. Sorry if you expected something more exciting for 80 notes...";

		if (times < 240) {
			review.text += "Duke's singing sounds just like my Auntie Marie, in a good way, of course. Pick this one up!";
		} else if (times < 300) {
			review.text += "The lead single, Tigger Mutt, sounds like a fusion of 1985 Trip-jazz-hop.";
		} else {	
			review.text += " But actually, I was lying. This album is a piece of trash, in fact all the members seem drugged out or something. AVOID.";
		}

		review.text = review.text+"\n\n\n From the dev: Thanks for playing my Ludum Dare 22 entry! SFX done in bfxr and pxtone, mp3 exporting audacity, coding: vim/mxmlc/as3, painful porting to windows/mac: flashdevelop, music in pxtone, graphics in gimp. You collected "+sum.toString()+" notes out of a possible 80! Congrats, unless it was a mediocre number. It took you a total of "+times.toString()+ " seconds to finish the sleep stages. Way to go...unless, again, that was a bad time. Play again, if you want, there are some different reviews based on how you do.";
		add(review);

	}

}
}
