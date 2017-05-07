package Game.Entities 
{
	import Game.Content.Textures;
	import Game.Global;
	import org.flixel.*;
	
	public class Ash extends FlxSprite
	{
		private var xpeed:uint;
		private var timer:FlxTimer;
		
		public function Ash() 
		{
			super(FlxG.random() * 640 - FlxG.random() * 48, FlxG.random() * 480 - FlxG.random() * 48);
			loadGraphic(Textures.ash3, true, false, 24, 24);
			var scaleFactor:Number = FlxG.random() * 0.8;
			
			scale.x = scaleFactor;
			scale.y = scaleFactor;
			antialiasing = true;
			addAnimation("default", Helper.SetArray(0, 100), 40, true);
			play("default");
			
			timer = new FlxTimer();
			timer.start(Helper.Random(3, 10) / 100, 0, timerEvent);
		}
		
		override public function postUpdate():void 
		{
			if (!FlxG.paused) super.postUpdate();
		}
		
		override public function update():void 
		{
			if (!FlxG.paused) 
			{
				y++;
				if (y > 480) { y = -20; }
				alpha = (Math.abs(y - 480) / 480);
				super.update();
			}
		}
		
		private function timerEvent(timer:FlxTimer):void
		{
			if (!FlxG.paused) 
			{
				x--;			
				if (x < -20) { x = 640; }
			}			
		}
	}
}