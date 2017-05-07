package Game.Entities
{
	import flash.geom.Rectangle;
	import Game.Content.Audio;
	import Game.Content.Textures;
	import Game.Global;
	import org.flixel.*;
	
	public class Trap1 extends FlxSprite
	{
		private var sprite:FlxSprite;
		private var startPos:uint;
		private var yCount:uint;
		private var state:uint = 0;
		private var timer:FlxTimer;
		private var _delay:Number;
		
		private var box:FlxSprite;
		private var punch:FlxSprite;
		
		private var fx_punch:FXSound;
		private var canFXPlay:Boolean = true;
		
		public function Trap1(x:uint, y:uint, delay:Number, flag:uint) 
		{
			super(x + 25, y + 10);
			makeGraphic(90, 130, 0x00ff0000); 
			
			_delay = delay;
			
			sprite = new FlxSprite(x + 15, y + 15 - 7);
			sprite.loadGraphic(Textures.trap1, false, false, 177, 240);
			sprite.addAnimation("", [0, 1, 2], 0, false);
			sprite.setOriginToCorner();
			sprite.scale = new FlxPoint(0.6, 0.6);
			
			box = new FlxSprite(x + 24, 0);
			box.makeGraphic(90, 130, 0x77ff00ff);
			box.immovable = true;
			
			punch = new FlxSprite(x + 24, 0);
			punch.makeGraphic(90, 10, 0x77ffff00);
			
			timer = new FlxTimer();
			timer.start(_delay, 1, timerEvent);
			
			startPos = y;
			
			if (flag == 1) state = 1;
			
			fx_punch = new FXSound(Audio.punch, false);
			fx_punch.volume = 0.5;
		}
		
		override public function destroy():void 
		{
			sprite.destroy();
			sprite = null;
			super.destroy();
		}
		
		override public function update():void 
		{
			if (!FlxG.paused) 
			{
				FlxG.overlap(Global.player, box, null, fixPlayer);
				
				switch (state)
				{
					case 0:
						sprite.frame = 1;
						break;
					case 1:
						sprite.frame = 1;
						yCount+=10;
						y = startPos + yCount;
						if (yCount >= 130)
						{
							FlxG.shake(0.0125, 0.2);
							state++;
							timer.start(_delay, 1, timerEvent);
						}
						if (FlxG.overlap(Global.player, punch)) Global.player.Killing();
						break;
					case 2:
						if (canFXPlay) fx_punch.play();
						canFXPlay = false;
						sprite.frame = 2;
						break;
					case 3:
						canFXPlay = true;
						sprite.frame = 0;
						yCount--;
						y = startPos + yCount;
						if (yCount == 10)
						{
							state = 0;
							timer.start(_delay / 2, 1, timerEvent);
						}
						break;
				}
				sprite.y = y - 7;
				box.y = y;
				punch.y = box.y + box.height - punch.height;
				super.update();
			}
		}
		
		override public function draw():void 
		{
			sprite.draw();
			super.draw();
		}
		
		private function fixPlayer(a:FlxObject, b:FlxObject):void
		{
			var _a:Rectangle = new Rectangle(a.x, a.y, a.width, a.height);
			var _b:Rectangle = new Rectangle(b.x, b.y, b.width, b.height);
			var intRet:Rectangle = _a.intersection(_b);
			if (intRet != null)
			{
				if (Global.player.scale.x == 1)
					Global.player.x -= intRet.width;
				else
					Global.player.x += intRet.width;
			}
		}
		
		private function timerEvent(timer:FlxTimer):void 
		{
			state++;
			if (state > 3) state = 0;
		}
	}
}