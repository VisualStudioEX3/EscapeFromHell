package 
{
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import Game.*;
	import Menu.MenuScreen;
	import org.flixel.*;
	
	[SWF(width = "640", height = "480", backgroundColor = "#000000")]
	[Frame(factoryClass = "Preloader")]
	
	public class Main extends FlxGame
	{
		public function Main()
		{
			Scenes.CreateScenes();			
			super(640, 480, MenuScreen);			
			this.useSoundHotKeys = false;
		}
		
		override protected function onFocusLost(FlashEvent:Event = null):void 
		{
			if (!FlxG.paused && Scene.CanForcePause) Scene.ForcePause = true;
			super.onFocusLost(FlashEvent);
		}
	}
}