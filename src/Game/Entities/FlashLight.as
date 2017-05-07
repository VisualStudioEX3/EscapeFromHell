package Game.Entities 
{
	import Game.Global;
	import org.flixel.*;
	import Game.Content.Textures;
	import Game.Entities.*;
	
	public class FlashLight extends FlxSprite
	{
		private var up:FlxSprite;
		private var down:FlxSprite;
		private var left:FlxSprite;
		private var right:FlxSprite;
		
		public function FlashLight()
		{
			super(0, 0);
			loadGraphic(Textures.light, false, false, 277, 277);
			
			up = new FlxSprite(0, 0);
			up.makeGraphic(277, 640, 0xff000000);
			
			down = new FlxSprite(0, 0);
			down.makeGraphic(277, 640, 0xff000000);
			
			left = new FlxSprite(0, 0);
			left.makeGraphic(640, 1280, 0xff000000);
			
			right = new FlxSprite(0, 0);
			right.makeGraphic(640, 1280, 0xff000000);
		}
		
		override public function destroy():void 
		{
			up.destroy(); up = null;
			down.destroy(); down = null;
			left.destroy(); left = null;
			right.destroy(); right = null;
			
			super.destroy();
		}
		
		override public function update():void 
		{
			x = Global.player.x - (277 / 2);
			y = Global.player.y - (277 / 2) + 15;
			
			up.x = x; up.y = y - up.height;
			down.x = x; down.y = y + height;
			left.x = x - left.width; left.y = up.y + 100;
			right.x = x + width; right.y = up.y;
			
			super.update();
		}
		
		override public function draw():void 
		{
			super.draw();
			up.draw();			
			down.draw();
			left.draw();
			right.draw();			
		}
	}
}