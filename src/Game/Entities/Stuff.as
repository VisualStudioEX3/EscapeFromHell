package Game.Entities 
{
	import Game.Content.Textures;
	import org.flixel.*;
	
	public class Stuff extends FlxSprite
	{		
		public function Stuff(index:uint, x:uint, y:uint) 
		{
			super(x, y);
			loadGraphic(Textures.stuffs, false, false, 65, 65, true);
			if (index != 2 && index != 5 && index != 18) color = 0xff000000;
			frames = 6;
			frame = index;
			solid = false;
		}
	}
}