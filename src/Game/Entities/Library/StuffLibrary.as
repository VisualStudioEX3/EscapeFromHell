package Game.Entities.Library 
{
	import Game.Entities.Stuff;
	import org.flixel.*;
	
	public class StuffLibrary
	{
		public static function GetObject(index:uint, x:uint, y:uint):FlxObject 
		{
			return new Stuff(index - 1, x, y);
		}	
	}
}