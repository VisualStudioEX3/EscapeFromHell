package  
{
	import org.flixel.*;
	
	public class FXSound extends FlxSound
	{
		public static var FXEnabled:Boolean = true;
		
		private var timer:FlxTimer;
		
		public function FXSound(asset:Class, loop:Boolean) 
		{
			super();
			loadEmbedded(asset, loop, false);
			timer = new FlxTimer();
			timer.start(0.1, 0, onTimerEvent);
		}
		
		private function onTimerEvent(timer:FlxTimer):void
		{
			if (!FXEnabled) stop();
		}
		
		override public function play(ForceRestart:Boolean = false):void 
		{
			if (FXEnabled) super.play(ForceRestart);
		}
	}
}