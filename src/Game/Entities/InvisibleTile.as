package Game.Entities 
{
	import org.flixel.*;
	
	public class InvisibleTile extends FlxSprite
	{	
		public function InvisibleTile(x:uint, y:uint) 
		{
			super(x, y);
			this.makeGraphic(65, 65, 0x00000000, true);
			this.immovable = true;
		}
	}
}