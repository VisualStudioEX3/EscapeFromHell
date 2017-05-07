package Hud 
{
	import Game.Global;
	import Game.Content.Textures;
	import org.flixel.*;
	
	public class PauseButton extends FlxButton
	{
		private var _on:FlxSprite;
		
		public function PauseButton() 
		{
			super(640 - 90, 10, null, onClick);
			
			_on = new FlxSprite(x, y, Textures.btn_pause_off);
			
			onOver = onOverEvent;
			onOut = onOutEvent;
			
			onOutEvent();
			
			width = 24; height = 24;
		}
		
		override public function draw():void 
		{
			_on.draw();
		}
		
		private function onClick():void
		{
			FlxG.resetInput();
			if (!FlxG.paused && !Global.bobIsDead) 
			{
				Global.pauseScreen.Enabled = true;
				FlxG.paused = true;
			}
			else
			{
				Global.pauseScreen.Enabled = false;
				FlxG.paused = false;
			}
		}
		
		private function onOverEvent():Function
		{
			_on.alpha = 1;			
			return null;
		}
		
		private function onOutEvent():Function
		{
			_on.alpha = 0.8;			
			return null;
		}
	}
}