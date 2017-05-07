package Game.Entities 
{
	import org.flixel.*;
	
	public class DemonPathSensor extends FlxSprite
	{	
		public function DemonPathSensor(x:uint, y:uint) 
		{
			super(x + 24, y + 24);
			this.makeGraphic(16, 16, 0x00ff0000, true);
			this.immovable = true;
		}
	}
}