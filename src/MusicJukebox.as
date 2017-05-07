package  
{
	import org.flixel.*;
	
	public class MusicJukebox 
	{				
		private static var musicPlaying:Class;
		private static var active:Boolean = true;
		
		public static function get Active():Boolean
		{
			return active;
		}
		
		public static function set Active(value:Boolean):void
		{
			active = value;
			if (!active) 
				FlxG.music.stop(); 
			else 
				FlxG.music.play();
		}
		
		public static function Play(music:Class):void
		{
			if (music != musicPlaying && Active)
			{
				musicPlaying = music;
				FlxG.playMusic(musicPlaying, 0.7);
			}
		}
	}
}