package Game.Entities 
{
	import Game.Content.Textures;
	import Game.Global;
	import org.flixel.*;
	
	public class Brigde extends FlxSprite
	{
		private var img:FlxSprite;
		
		public function Brigde(x:uint, y:uint, flag:uint) 
		{
			var tex:Class;
			var fix:FlxPoint;
			
			super(x, y + 32);
			makeGraphic(65, 10, 0x00ff0000);
			immovable = true;
			allowCollisions = FlxObject.UP;
			fix = new FlxPoint(0, 0);
			
			switch (flag)
			{
				case 0: tex = Textures.bridge_end1; fix = new FlxPoint(0, -2); break;
				case 1: tex = Textures.bridge_end2; fix = new FlxPoint(0, 0); break;
				case 2: tex = Textures.bridge_ext1; fix = new FlxPoint(-3, 0); break;
				case 3: tex = Textures.bridge_ext2; fix = new FlxPoint(3, 0); break;
				case 4: tex = Textures.bridge_ext3; fix = new FlxPoint(-3, 0); break;
				case 5: tex = Textures.bridge_ext4; fix = new FlxPoint(3, 0); break;
				case 6: tex = Textures.bridge_med; fix = new FlxPoint(0, 0); break;
			}
			
			img = new FlxSprite(x + fix.x, y + fix.y, tex);			
		}
		
		override public function destroy():void 
		{
			img.destroy();
			img = null;
			super.destroy();
		}
		
		override public function draw():void 
		{
			img.draw();
			super.draw();
		}
	}
}