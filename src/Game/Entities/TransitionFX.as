package Game.Entities 
{
	import org.flixel.*;
	import Game.*;
	
	public class TransitionFX extends FlxGroup	
	{		
		public function TransitionFX(flag:uint) 
		{
			super();
			Global.tileFXCount = 0;
			var cursor:FlxPoint = new FlxPoint();
			for (cursor.y = 0; cursor.y < 8; cursor.y++)
				for (cursor.x = 0; cursor.x < 10; cursor.x++)
					add(new TileFX(cursor.x * 65, cursor.y * 65, flag, ((cursor.y + 1) + (cursor.x + 1)) / 10));
		}
	}
}