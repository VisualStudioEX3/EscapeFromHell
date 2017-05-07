package Game.Entities 
{
	import Game.Content.Textures;
	import Game.Global;
	import org.flixel.*;
	
	public class Platform extends FlxSprite
	{
		private var floor:FlxSprite;
		private var _path:int;
		private var movement:FlxPoint;			
		
		public function Platform(x:uint, y:uint, flag:uint, flag2:uint) 
		{
			super(x, y);
			immovable = true;
			solid = false;
			
			switch (flag)
			{
				case 0: 
					_path = 0;
					movement = new FlxPoint((flag2 == 0 ? 2 : 1), 0);
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
					break;
			}
			
			floor = new FlxSprite(x, y);
			floor.makeGraphic(65, 33, 0xffff0000);
			floor.immovable = true;
		}
		
		override public function draw():void 
		{			
			super.draw();
			floor.draw();
		}
		
		override public function update():void 
		{			
			if (_path == 0)
			{
				x += movement.x;
				if (x < 0 || x > 640 - width || FlxG.collide(floor, Global.tiles))
				{
					movement.x *= -1;
				}
			}
			else
			{
				y += movement.y;
				if (y < 0 || y > 480 - height || FlxG.collide(floor, Global.tiles))
				{
					movement.y *= -1;
				}
			}
			
			floor.x = x;
			
			super.update();
			
			if (FlxG.collide(Global.player, floor))
				Global.player.x = floor.x;
		}
	}
}