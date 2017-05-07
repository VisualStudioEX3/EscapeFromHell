package Game.Entities 
{
	import Game.Global;
	import org.flixel.*;
	import Game.Content.Textures;
	import Game.Entities.*;
	
	public class HUDKey extends FlxSprite
	{
		private var key:FlxSprite;
		
		public function HUDKey() 
		{
			super(300, 5, Textures.hudKey);
			alpha = 0.7;
			
			key = new FlxSprite(x + 5, y + 5);
			key.loadGraphic(Textures.key, true, false, 40, 40);
			key.addAnimation("default", Helper.SetArray(0, 4), 3, true);
			key.play("default");
			key.alpha = 0.8;
		}
		
		override public function destroy():void 
		{
			key.destroy();
			key = null;
			super.destroy();
		}
		
		override public function update():void 
		{
			key.postUpdate();
			super.update();
		}
		
		override public function draw():void 
		{
			super.draw();
			if (Global.hasKey) key.draw();
		}
	}
}