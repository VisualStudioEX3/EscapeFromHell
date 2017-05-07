package Game.Entities 
{
	import Game.Content.Audio;
	import Game.Content.Textures;
	import Game.Global;
	import org.flixel.*;
	
	public class Demon extends FlxSprite
	{
		private var box:FlxSprite;
		private var punch:FlxSprite;
		private var pathSensor:FlxSprite;
		private var currentAnimation:String = "";
		private var state:uint = 0;
		private var timer:FlxTimer;
		private var killBob:Boolean = false;
		
		private var fx_punch:FXSound;
		
		public function Demon(x:uint, y:uint, mirror:int) 
		{
			super(x - 100, y + 18);
			
			loadGraphic(Textures.demon, true, true, 215, 196);
			addAnimation("idle", Helper.SetArray(0, 60), 20, true);
			addAnimation("walk", Helper.SetArray(64, 101), 20, true);
			addAnimation("punch", Helper.SetArray(104, 117), 20, true);
			play("walk");
			currentAnimation = "walk";
			state = 1;
			
			solid = false;
			scale.x *= mirror;
			origin.x = 215 - 56;
			
			box = new FlxSprite(x + 130 - 100, y + 80);
			box.makeGraphic(60, 116, 0x00ff0000);
			box.immovable = true;
			
			punch = new FlxSprite(x - 60, y + 96);
			punch.makeGraphic(100, 100, 0x00ffff00);
			
			fx_punch = new FXSound(Audio.punch, false);
			fx_punch.volume = 0.5;
			
			timer = new FlxTimer();
		}
		
		override public function destroy():void 
		{
			box.destroy();
			box = null;
			punch.destroy();
			punch = null;
			fx_punch.stop();
			super.destroy();
		}
		
		override public function update():void 
		{
			if (!FlxG.paused) 
			{
				if (!Global.bobIsDead && Helper.Intersect(Global.player, box))
				{
					timer.stop();
					Global.player.Killing();
					state = 4;
					play("idle");
				}
				
				switch (state)
				{	
					case 0:
						if (!killBob && Helper.Contains(Global.player, punch))
						{
							state = 2;
							play("punch");
						}					
						
						break;
					case 1:
						if (FlxG.overlap(box, Global.demonSensors))
						{
							play("idle");
							state = 0;
							timer.stop();
							timer.start(2, 1, timerEvent);
							
							if (scale.x == -1)
							{
								x -= 2;
								box.x -= 2;
								punch.x -= 2;
							}
							else
							{
								x += 2;
								box.x += 2;
								punch.x += 2;
							}
						}
						
						if (scale.x == 1)
						{
							x--;
							box.x--;
							punch.x--;
						}
						else
						{
							x++;
							box.x++;
							punch.x++;
						}
						
						if (!killBob && Helper.Contains(Global.player, punch))
						{
							state = 2;
							fx_punch.play();
							play("punch");
						}
						
						break;
					
					case 2:
						if (frame > 114)
						{
							FlxG.shake(0.0125, 0.2);
							punch.alpha = 1;
							if (Helper.Contains(Global.player, punch))
							{
								killBob = true;
								Global.player.Killing();
							}
								
							if (frame == 116)
							{
								play("idle");
								state = 4;
							}
							else
							{
								play("walk");
								state = 1;
							}
						}
						else
							punch.alpha = 0;
						break;
				}
				super.update();
			}
		}
		
		override public function draw():void 
		{
			this.active = !FlxG.paused;
			punch.draw();
			box.draw();
			super.draw();
		}
		
		private function timerEvent(timer:FlxTimer):void
		{			
			play("walk");
			state = 1;
			
			scale.x *= -1;
			if (scale.x == 1)
			{
				punch.x -= 46 + punch.width;
				x--;
				box.x--;
				punch.x--;
			}
			else
			{
				punch.x += 46 + punch.width;
				x++;
				box.x++;
				punch.x++;
			}
		}
	}
}