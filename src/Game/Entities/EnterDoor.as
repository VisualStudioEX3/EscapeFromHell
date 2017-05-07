package Game.Entities 
{
	import Game.Content.Textures;
	import Game.Global;
	import org.flixel.*;
	
	public class EnterDoor extends FlxSprite
	{
		private var box:FlxSprite;
		
		public function EnterDoor(x:uint, y:uint, flag:uint) 
		{
			super(x - 90 + (flag == 0 ? -65 : 0), y - 94);
			loadGraphic(Textures.door, true, false, 302, 314);
			frame = 0;
			scale = new FlxPoint(0.4, 0.45);
			solid = false;
			
			box = new FlxSprite(x - (flag == 0 ? 65 : 0), y);
			box.makeGraphic(130, 130, 0x00ff0000);
			box.immovable = true;
			
			if (Global.startNewLevel)
			{
				Global.startPosition = new FlxPoint((flag == 0 ? x + 65 : x - 65), y + 80);
				Global.startMirror = (flag == 0 ? 1 : -1);
				Global.startNewLevel = false;
			}
		}
		
		override public function destroy():void 
		{
			box.destroy();
			box = null;
			super.destroy();
		}
		
		override public function update():void 
		{
			if (FlxG.collide(Global.player, box) && Global.doorIsOpen)
			{
				Global.doorIsOpen = false;
				Global.hasKey = false;
			}
			super.update();
		}
	}
}