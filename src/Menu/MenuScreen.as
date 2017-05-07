package Menu 
{
	import Game.Scene;
	import Intro.IntroScreen;
	import Menu.Content.Audio;
	import Menu.Content.Textures;
	import Hud.*;
	import org.flixel.*;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	public class MenuScreen extends FlxState
	{	
		private var bob:FlxSprite;
		
		override public function create():void 
		{
			super.create();
			MusicJukebox.Play(Audio.mus_menu);			
			SetState(0);
			Scene.CanForcePause = false;
		}
		
		private function SetState(index:uint):void
		{
            var object:FlxObject;
				for each (object in this.members)
					object.kill();
				clear();				
				add(new FlxSprite(0, 0, Textures.background));
				switch (index)
				{
					case 0:
						add(new Button(238, 220, Textures.buttonPlayOn, Textures.buttonPlayOff, onPlay_Click));
						add(new Button(238, 220 + 50, Textures.buttonHelpOn, Textures.buttonHelpOff, onHelp_Click));
						add(new Button(238, 220 + 100, Textures.buttonCreditsOn, Textures.buttonCreditsOff, onCredits_Click));
						
						add(new FlxSprite(180, 440, Textures.copyright));
						break;
					
					case 1: 
						add(new FlxSprite(234, 210, Textures.help));					
						add(new Button(238, 430, Textures.buttonBackOn, Textures.buttonBackOff, onBack_Click));
						break;
					
					case 2:
						add(new FlxSprite(224, 200, Textures.credits));
						add(new Button(238, 430, Textures.buttonBackOn, Textures.buttonBackOff, onBack_Click));
						break;
				}			
				
				bob = new FlxSprite(-20, 245);
				bob.loadGraphic(Textures.bob, true, false, 200, 200);
				bob.addAnimation("default", Helper.SetArray(0, 100), 40, true);
				bob.play("default");
				bob.antialiasing = true;
				add(bob);
				
				var grass:FlxSprite;
				var i:uint;
				for (i = 0; i < 4; i++)
				{
					grass = new FlxSprite(i * 50 - 40, 330);
					grass.loadGraphic(Textures.grass, true, false, 100, 100);
					grass.addAnimation("default", Helper.SetArray(0, 100), 40, true);
					grass.color = 0xff000000;
					grass.scale.x = 1.5;
					grass.scale.y = 1.5;
					grass.antialiasing = true;
					grass.play("default");
					add(grass);
				}
				for (i = 9; i < 15; i++)
				{
					grass = new FlxSprite(i * 50 - 35, 330);
					grass.loadGraphic(Textures.grass, true, false, 100, 100);
					grass.addAnimation("default", Helper.SetArray(0, 100), 40, true);
					grass.color = 0xff000000;
					grass.scale.x = 1.5;
					grass.scale.y = 1.5;
					grass.antialiasing = true;
					grass.play("default");
					add(grass);
				}
				
				add(new FlxSprite(0, 0, Textures.shadow));				
				add(new FlxSprite(160, -15, Textures.title));				
				add(new Undead());				
				add(new FXSwitch());
				add(new MusicSwitch());
				add(new Mouse());
		}
		
		override public function update():void 
		{
			if (FlxG.keys.justPressed("M"))
				MusicJukebox.Active = !MusicJukebox.Active;
			else if (FlxG.keys.justPressed("S"))
				FXSound.FXEnabled = !FXSound.FXEnabled;
			super.update();
		}
		
		private function onPlay_Click():void
		{
			FlxG.switchState(new IntroScreen(0));
		}		
		
		private function onHelp_Click():void
		{
			SetState(1);
		}
		
		private function onCredits_Click():void
		{
			SetState(2);
		}
		
		private function onBack_Click():void
		{
			SetState(0);
		}
	}
}