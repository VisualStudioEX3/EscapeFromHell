package Game.Entities 
{
	import Game.Content.Textures;
	import Game.Global;
	import org.flixel.*;
	
	public class Spikes extends FlxSprite
	{	
		private var sprite:FlxSprite;
		private var floor:FlxSprite;
		
		public function Spikes(x:uint, y:uint, flag:uint) 
		{
			super(x, y + (flag == 0 ? 55 : 15));
			makeGraphic(65, 10, 0x00ff0000);	
			
			sprite = new FlxSprite(x, y + 2);
			sprite.loadGraphic(Textures.spikes, false, false, 65, 65);
			sprite.frame = flag;
			
			floor = new FlxSprite(x, y + (flag == 0 ? 56 : 16));
			floor.makeGraphic(65, 10, 0xffff0000);
			floor.immovable = true;
		}		
		
		override public function destroy():void 
		{
			sprite.destroy()
			sprite = null;
			floor.destroy();
			floor = null;
			super.destroy();
		}
		
		override public function update():void 
		{
			FlxG.collide(Global.player, floor);
			super.update();
		}
		
		override public function draw():void 
		{
			sprite.draw();
			super.draw();
		}
	}
}