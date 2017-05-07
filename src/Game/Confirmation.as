package Game 
{
	import Hud.Content.Textures;
	import Hud.Button;
	import Hud.Mouse;
	import Menu.MenuScreen;
	import org.flixel.*;
	
	public class Confirmation extends FlxSprite 
	{
		private var title:FlxSprite;
		private var frameBox:FlxSprite;
		private var yes:Button;
		private var no:Button;
		private var mouse:Mouse;
		private var enabled:Boolean = true;
		private var canUpdate:Boolean = false;
		private var count:uint = 0;
		
		public function get Enabled():Boolean
		{
			return enabled;
		}
		
		public function set Enabled(value:Boolean):void
		{
			enabled = value;
			if (!value) canUpdate = false;
			
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
		
		public function Confirmation() 
		{
			super(0, 0);
			makeGraphic(640, 480, 0xff000000);
			alpha = 0.5;
			
			frameBox = new FlxSprite(173, 100, Textures.framePause);
			title = new FlxSprite(frameBox.x + 92, frameBox.y + 60, Textures.txt_sure);
			yes = new Button(238, 215, Textures.btn_yes_on, Textures.btn_yes_off, onYes_Click);
			no = new Button(238, 260, Textures.btn_no_on, Textures.btn_no_off, onNo_Click);
			
			mouse = new Mouse();
			
			Enabled = false;
		}
		
		override public function destroy():void 
		{
			frameBox.destroy(); frameBox = null;
			title.destroy(); title = null;
			no.destroy(); no = null;
			yes.destroy(); yes = null;
			mouse.destroy(); mouse = null;
			super.destroy();
		}
		
		override public function update():void 
		{
			if (Enabled) count++;
			if (FlxG.keys.justPressed("P") && count > 10)
			{
				Enabled = false;
				FlxG.music.volume = 0.7;
				count = 0;
			}
			yes.preUpdate();
			no.preUpdate();
			if (Enabled) 
			{				
				yes.update();				
				no.update();
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
				yes.draw();
				no.draw();
				mouse.draw();
				
				canUpdate = true;
			}
		}
		
		private function onYes_Click():void
		{
			if (Enabled && canUpdate) 
			{
				Enabled = false;
				FlxG.paused = false;
				FlxG.music.volume = 0.7; 
				FlxG.switchState(new MenuScreen());
			}
		}
		
		private function onNo_Click():void
		{
			if (Enabled && canUpdate) 
			{
				Enabled = false;
				Global.pauseScreen.Enabled = true;
			}
		}
	}
}