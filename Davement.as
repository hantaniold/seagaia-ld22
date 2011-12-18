package 
{
	import org.flixel.*;
	[SWF(width="640", height="480", backgroundColor="#AAAAAA")]
	
	public class Davement extends FlxGame
	{
		public function Davement()
		{
			super(640,480,Intro);
			Registry.init();
		}
	}

}
