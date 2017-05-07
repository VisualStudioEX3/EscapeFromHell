package Game.Entities 
{
	import Game.Global;
	import org.flixel.*;
	
	public class TileFX extends FlxSprite
	{
		private var timer:FlxTimer;
		private var _flag:uint;
		private var ready:Boolean = false;
		
		public function TileFX(x:uint, y:uint, flag:uint, delay:Number) 
		{
			super(x, y);
			makeGraphic(65, 65, 0xff000000);			
			scale.x = flag;
			_flag = flag;
			timer = new FlxTimer();
			timer.start(delay, 1, timerEvent);
		}
		
		override public function destroy():void 
		{
			timer.destroy();
			timer = null;
			super.destroy();
		}
		
		override public function update():void 
		{
			if (ready) 
			{
				if (_flag == 0 && scale.x < 1)
					scale.x += 0.1;
				else if (_flag == 1 && scale.x > 0.1)
					scale.x -= 0.1;
				else if ((_flag == 0 && scale.x >= 1) || (_flag == 1 && scale.x <= 0.1))
				{
					Global.tileFXCount++;
					active = false;
				}
			}
			super.update();
		}
		
		private function timerEvent(timer:FlxTimer):void
		{
			ready = true;
		}		
	}
}