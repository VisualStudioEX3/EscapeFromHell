package Hud 
{
	import Menu.Content.Textures;
	import org.flixel.*;
	
	public class Button extends FlxButton
	{	
		private var _onClickEvent:Function;
		private var _buttonOn:FlxSprite;
		private var _buttonPressed:Boolean = false;
		
		public function Button(x:uint, y:uint, buttonOn:Class, buttonOff:Class, onClickEvent:Function) 
		{
			super(x, y, null, onClickEvent);
			loadGraphic(buttonOff, false, false);
			
			_buttonOn = new FlxSprite(x, y, buttonOn);
			_buttonOn.alpha = 0;
			
			centerOffsets();
			antialiasing = true;
			btn_OnOut();		
			_onClickEvent = onClickEvent;
			onOver = btn_OnOver;
			onOut = btn_OnOut;
			onDown = btn_OnDown;
			onUp = btn_OnUp;
		}
		
		override public function draw():void 
		{			
			super.draw();
			_buttonOn.draw();
		}
		
		override public function update():void 
		{
			_buttonOn.x = x; _buttonOn.y = y;
			super.update();
		}
		
		private function btn_OnDown():Function
		{
			_buttonOn.alpha = 0;
			_buttonPressed = true;
			return null;
		}
		
		private function btn_OnUp():Function
		{
			_buttonPressed = false;
			_onClickEvent.call();			
			return null;
		}
		
		private function btn_OnOver():Function
		{
			scale.x = 1.025; scale.y = 1.025;
			_buttonOn.alpha = 1;
			_buttonOn.scale = scale;
			
			return null;
		}
		
		private function btn_OnOut():Function
		{
			scale.x = 1; scale.y = 1;
			_buttonOn.alpha = 0;
			_buttonOn.scale = scale;
			_buttonPressed = false;
			return null;
		}
	}

}