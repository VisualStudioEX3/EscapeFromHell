package Menu 
{
	import org.flixel.*;
	import Menu.Content.*;
	
	public class Title extends FlxSprite
	{
		private var timer:FlxTimer;
		private var flag:int = 1;
		
		public function Title() 
		{
			super(160, -15, Textures.title);
			antialiasing = true;
			
			timer = new FlxTimer();			
		}	
		
		override public function update():void 
		{
			super.update();
		}
	}
}