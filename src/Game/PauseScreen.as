package Game 
{
	import Hud.Content.Textures;
	import Hud.Button;
	import Hud.Mouse;
	import org.flixel.*;
	
	public class PauseScreen extends FlxSprite 
	{
		private var title:FlxSprite;
		private var frameBox:FlxSprite;
		private var resume:Button;
		private var menu:Button;
		private var mouse:Mouse;
		private var enabled:Boolean;
		private var count:uint = 0;
		
		public function get Enabled():Boolean
		{
			return enabled;
		}
		
		public function set Enabled(value:Boolean):void
		{
			enabled = value;
			if (MusicJukebox.Active) 
			{
				if (value) 
				{
					FlxG.music.volume = 0.2; 
				}
				else
				{
					FlxG.music.volume = 0.7;
				}
			}
		}
		
		public function PauseScreen() 
		{
			super(0, 0);
			makeGraphic(640, 480, 0xff000000);
			alpha = 0.5;
			
			frameBox = new FlxSprite(173, 100, Textures.framePause);
			title = new FlxSprite(frameBox.x + 92, frameBox.y + 60, Textures.txt_pause);
			resume = new Button(238, 215, Textures.btn_resume_on, Textures.btn_resume_off, onResume_Click);
			menu = new Button(238, 260, Textures.btn_menu_on, Textures.btn_menu_off, onMenu_Click);
			
			mouse = new Mouse();
			
			Enabled = false;
		}
		
		override public function destroy():void 
		{
			frameBox.destroy(); frameBox = null;
			title.destroy(); title = null;
			resume.destroy(); resume = null;
			menu.destroy(); menu = null;
			mouse.destroy(); mouse = null;
			super.destroy();
		}
		
		override public function update():void 
		{
			if (Enabled) count++;
			if (FlxG.keys.justPressed("P") && count > 10) 
			{
				FlxG.music.volume = 0.7;
				count = 0;
			}
			resume.preUpdate();
			menu.preUpdate();
			if (enabled) 
			{
				resume.update();
				menu.update();
				mouse.update();			
				super.update();
			}
		}
		
		override public function draw():void 
		{
			if (Enabled) 
			{
				super.draw();
				frameBox.draw();
				title.draw();
				resume.draw();
				menu.draw();
				mouse.draw();
			}
		}
		
		private function onResume_Click():void
		{
			Enabled = false;
			FlxG.paused = false;
		}
		
		private function onMenu_Click():void
		{
			Enabled = false;
			Global.confirmation.Enabled = true;
		}
	}
}