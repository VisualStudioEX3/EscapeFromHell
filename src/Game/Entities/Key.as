package Game.Entities 
{
	import Game.Content.Audio;
	import Game.Content.Textures;
	import Game.Global;
	import org.flixel.*;
	
	public class Key extends FlxSprite 
	{
		private var fx_key:FXSound;
		private var isInit:Boolean;
		
		public function Key(x:uint, y:uint) 
		{
			super(x + 10, y);
			loadGraphic(Textures.key, true, false, 40, 40);
			addAnimation("default", Helper.SetArray(0, 4), 2, true);
			play("default");
			visible = !Global.hasKey;
			fx_key = new FXSound(Audio.getkey, false);
			
			active = !Global.hasKey;
		}
		
		override public function update():void 
		{
			visible = !Global.hasKey;
			postUpdate();
			if (Global.hasKey || FlxG.overlap(Global.player, this))
			{
				if (!Global.enterWithKey) fx_key.play();
				kill();
				Global.hasKey = true;
			}
			super.update();
		}
	}
}