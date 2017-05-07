package Hud 
{
	import org.flixel.*;
	import Hud.Content.Textures;
	
	public class Mouse extends FlxSprite
	{		
		public function Mouse() 
		{
			super(0, 0, Textures.mouse);
		}
		
		override public function update():void 
		{
			x = FlxG.mouse.x;
			y = FlxG.mouse.y;
			super.update();
		}
	}
}