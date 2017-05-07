package Game.Entities 
{
	import Game.Content.Textures;
	import Game.Global;
	import org.flixel.*;

	public class Skull extends FlxSprite
	{
		public function Skull(x:uint, y:uint, index:uint) 
		{
			var tex:Class;
			switch (index)
			{
				case 0: tex = Textures.skull1; break;
				case 1: tex = Textures.skull2; break;
				case 2: tex = Textures.skull3; break;
				case 3: tex = Textures.skull4; break;
				case 4: tex = Textures.skull5; break;
				case 5: tex = Textures.skull6; break;
				case 6: tex = Textures.skull7; break;
				case 7: tex = Textures.skull8; break;
			}
			
			super(x, y, tex);
			immovable = true;
			solid = false;
		}		
	}
}