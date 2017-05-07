package Menu 
{
	import Menu.Content.Textures;
	import org.flixel.*;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	public class Undead extends FlxButton
	{		
		public function Undead() 
		{
			super(640 - 100, 480 - 100, null, onClick);
			loadGraphic(Textures.logoUndeadCode);
			onOutEvent();
			onOver = onOverEvent;
			onOut = onOutEvent;
			antialiasing = true;
		}
		
		private function onClick():void
		{
			navigateToURL(new URLRequest("http://undeadcodestudios.com"), "_blank");
		}
		
		private function onOverEvent():Function
		{	
			scale.x = 1;
			scale.y = 1;
			return null;
		}
		
		private function onOutEvent():Function
		{
			scale.x = 0.9;
			scale.y = 0.9;
			return null;
		}
	}
}