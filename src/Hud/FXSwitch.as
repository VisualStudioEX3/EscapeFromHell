package Hud 
{
	import Hud.Content.Textures;
	import org.flixel.*;
	
	public class FXSwitch extends FlxButton
	{
		private var _on:FlxSprite;
		private var _off:FlxSprite;
		
		public function FXSwitch() 
		{
			super(640 - 30, 10, null, onClick);
			
			_on = new FlxSprite(x, y, Textures.btn_fx_on);
			_off = new FlxSprite(x, y, Textures.btn_fx_off);
			
			onOver = onOverEvent;
			onOut = onOutEvent;
			
			onOutEvent();
			
			width = 24; height = 24;
		}
		
		override public function draw():void 
		{
			if (!FXSound.FXEnabled) _on.draw(); else _off.draw();
		}
		
		private function onClick():void
		{
			FXSound.FXEnabled = !FXSound.FXEnabled;
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