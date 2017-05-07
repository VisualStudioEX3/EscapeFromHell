package Intro
{
	import Game.Entities.TransitionFX;
	import Game.Global;
	import Game.Scene;
	import Hud.*;
	import Intro.Content.Textures;
	import Menu.MenuScreen;
	import org.flixel.*;
	
	public class IntroScreen extends FlxState
	{
		private var image:FlxSprite;
		private var index:uint;
		private var next:Button;
		private var skip:Button;
		private var playb:Button;
		private var menu:Button;
		
		public function IntroScreen(start:uint = 0)
		{
			if (start == 0) index = 0; else index = 4;
		}
		
		public override function create():void
		{
			super.create();
			image = new FlxSprite(0, 0);
			add(image);
			next = new Button(440, 400, Textures.buttonNextOn, Textures.buttonNextOff, onNext_Click);
			add(next);
			skip = new Button(440, 440, Textures.buttonSkipOn, Textures.buttonSkipOff, onSkip_Click);
			add(skip);
			add(image);
			playb = new Button(390, 350, Textures.buttonPlayOn, Textures.buttonPlayOff, onNext_Click);
			playb.exists = false;
			add(playb);
			menu = new Button(241, 410, Textures.btn_menu_on, Textures.btn_menu_off, onNext_Click);
			menu.exists = false;
			add(menu);
			add(new Mouse());
			
			setIntro(index);
		}
		
		private function setIntro(index:uint):void
		{
			if (index == 3) 
				onSkip_Click();
			else if (index == 6) 
				FlxG.switchState(new MenuScreen());
			else
				switch (index)
				{
					case 0: 
						image.loadGraphic(Textures.intro00); 
						next.y = 387;
						skip.y = 430;
						break;
					case 1: 
						image.loadGraphic(Textures.intro01); 
						break;
					case 2: 
						image.loadGraphic(Textures.intro02); 
						next.exists = false;
						skip.exists = false;
						playb.exists = true;
						break;
					case 4: 
						add(new TransitionFX(1));
						image.loadGraphic(Textures.intro03); 
						skip.exists = false;
						next.x -= 22;
						next.y += 8;
						break;
					case 5: 
						image.loadGraphic(Textures.intro04); 
						next.exists = false;
						menu.exists = true;
						break;
				}
		}
		
		private function onNext_Click():void
		{
			index++;
			setIntro(index);
		}
		
		private function onSkip_Click():void
		{
			Global.startGame = true;
			Global.currentRoom = 0;
			FlxG.switchState(new Scene());
		}
	}
}