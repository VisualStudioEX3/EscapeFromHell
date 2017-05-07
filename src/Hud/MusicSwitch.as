package Hud 
{
	import Hud.Content.Textures;
	import org.flixel.*;
	
	public class MusicSwitch extends FlxButton
	{
		private var _on:FlxSprite;
		private var _off:FlxSprite;
		
		public function MusicSwitch() 
		{
			super(640 - 60, 10, null, onClick);

			_on = new FlxSprite(x, y, Textures.btn_music_on);
			_off = new FlxSprite(x, y, Textures.btn_music_off);
			
			onOver = onOverEvent;
			onOut = onOutEvent;
			
			onOutEvent();
			
			width = 24; height = 24;
		}
		
		override public function draw():void 
		{
			if (!MusicJukebox.Active) _on.draw(); else _off.draw();
		}
		
		private function onClick():void
		{
			MusicJukebox.Active = !MusicJukebox.Active;
		}
		
		private function onOverEvent():Function
		{
			_on.alpha = 1;
			_off.alpha = 1;
			
			return null;
		}
		
		private function onOutEvent():Function
		{
			_on.alpha = 0.8;
			_off.alpha = 0.8;
			
			return null;
		}
	}
}