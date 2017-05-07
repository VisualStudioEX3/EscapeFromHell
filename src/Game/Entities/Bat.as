package Game.Entities 
{
	import Game.Content.Textures;
	import Game.Global;
	import org.flixel.*;
	
	public class Bat extends FlxSprite
	{
		private var sprite:FlxSprite;
		private var _path:int;
		private var movement:FlxPoint;		
		
		public function Bat(x:uint, y:uint, flag:uint, flag2:uint)
		{
			super(x, y);
			makeGraphic(37, 37, 0x00ff0000);
			
			sprite = new FlxSprite(0, 0);
			sprite.loadGraphic(Textures.bat, true, true, 74, 108);
			sprite.scale = new FlxPoint(0.8, 0.8);
			sprite.addAnimation("default", Helper.SetArray(0, 5), 10, true);
			sprite.play("default");
			sprite.origin = new FlxPoint(30, 50);
			
			switch (flag)
			{
				case 0: 
					_path = 0;
					movement = new FlxPoint((flag2 == 0 ? 2 : 1), 0);
					sprite.scale.x *= -1;
					break;
				case 1:
					_path = 0;
					movement = new FlxPoint((flag2 == 0 ? -2 : -1), 0);
					break;
				case 2:
					_path = -1;
					movement = new FlxPoint(0, (flag2 == 0 ? 2 : 1));
					break;
				case 3:
					_path = -1;
					movement = new FlxPoint(0, (flag2 == 0 ? -2 : -1));
					sprite.scale.x *= -1;
					break;
			}
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
				if (_path == 0)
				{
					x += movement.x;
					if (x < 0 || x > 640 - width || FlxG.collide(this, Global.tiles))
					{
						movement.x *= -1;
						sprite.scale.x *= -1;
					}
				}
				else
				{
					y += movement.y;
					if (y < 0 || y > 480 - height || FlxG.collide(this, Global.tiles))
					{
						movement.y *= -1;
					}
				}
				
				sprite.x = x - 13;
				sprite.y = y - 30;
				sprite.update();
				sprite.postUpdate();
				
				super.update();
			}
		}
		
		override public function draw():void 
		{
			sprite.draw();
			super.draw();
		}
	}

}