package Game 
{
	import flash.system.System;
	import adobe.utils.CustomActions;
	import Game.Content.Audio;
	import Game.Entities.Ash;
	import Game.Entities.Bob;
	import Game.Entities.FlashLight;
	import Game.Entities.HUDKey;
	import Game.Entities.InvisibleTile;
	import Game.Entities.Library.*;
	import Game.Entities.TileFX;
	import Game.Entities.TransitionFX;
	import Hud.*;
	import Intro.IntroScreen;
	import org.flixel.*;
	
	import Game.Content.Textures;
	
	public class Scene extends FlxState
	{
		private var left_exit:int;
		private var up_exit:int;
		private var right_exit:int;
		private var down_exit:int;
		
		private var background:Background;		
		private var GameArea:FlxSprite;
		
		private var grassField:FlxGroup;
		
		private var timer:FlxTimer;
		
		private var buttonPause:FlxButton;
		
		public static var ForcePause:Boolean = false;
		public static var CanForcePause:Boolean = false;
		
		override public function create():void 
		{
			super.create();			
			MusicJukebox.Play(Audio.mus_game);
			LoadScene(Global.currentRoom);
			
			CanForcePause = true;
		}
		
		private function clearMemory(list:FlxGroup):void
		{
			var cursor:FlxObject;
			for each (cursor in list)
			{
				cursor.destroy();
				cursor = null;
			}
			list.clear();
			list.destroy();
			list = null;
		}
		
		private function IsStartLevel(index:uint):Boolean
		{
			var indexes:Array = new Array(4, 8, 13, 21, 25, 28, 32, 38, 43);
			var i:uint = 0;
			
			for (i = 0; i < indexes.length; i++)
				if (index == indexes[i])
				{
					return Global.lastRoom < index;
				}
			
			return false;
		}		
		
		public function LoadScene(index:uint):void
		{
			
			if (index >= 0 && index < Scenes.List.length) 
			{					
				Global.currentRoom = index;
				
				try
				{
					background.destroy();
					clearMemory(Global.tiles);
					clearMemory(Global.specialObjects);
					clearMemory(Global.objects);
					clearMemory(Global.stuffs);
					clearMemory(grassField);		
					clearMemory(Global.sandTiles);
					clearMemory(Global.demonSensors);
				}
				catch (error:Error)
				{
				}
				
				clear();
				System.gc();
				
				var data:SceneData = Scenes.List[index];
				
				background = new Background(data.Background, !Helper.NumberExistIn(index, [25, 26, 27, 28, 29, 30, 31, 45, 46, 47, 48]));
				Global.specialObjects = new FlxGroup();
				Global.tiles = new FlxGroup();
				Global.stuffs = new FlxGroup();
				Global.objects = new FlxGroup();
				grassField = new FlxGroup();
				Global.sandTiles = new FlxGroup();
				Global.demonSensors = new FlxGroup();
				
				add(background);
				add(Global.stuffs);
				
				if (!Helper.NumberExistIn(index, [25, 26, 27, 28, 29, 30, 31, 45, 46, 47, 48])) 
				{
					var i:uint = 0;
					for (i = 0; i < 15; i++)
						add(new Ash());
				}
				
				add(Global.specialObjects);
				add(grassField);
				add(Global.tiles);				
				add(Global.objects);
				add(Global.sandTiles);
				add(Global.demonSensors);
				add(new FlxSprite(0, 0, Textures.shadow));
				
				var x:uint = 0;
				var y:uint = 0;

				x = 0; y = 0;
				for (i = 0; i < data.BackLayer.length; i++)
				{
					if (data.BackLayer[i] > 0)
						Global.stuffs.add(StuffLibrary.GetObject(data.BackLayer[i], x * 65, y * 65));

					x++; if (x == 10) { x = 0; y++; if (y == 8) break; }
				}
				

				x = 0; y = 0;
				for (i = 0; i < data.TileLayer.length; i++)
				{
					if (data.TileLayer[i] > 0)
					{
						if (data.TileLayer[i] == 35)
							grassField.add(TileLibrary.GetObject(data.TileLayer[i], x * 65, y * 65));
						else
							Global.tiles.add(TileLibrary.GetObject(data.TileLayer[i], x * 65, y * 65));
					}

					x++; if (x == 10) { x = 0; y++; if (y == 8) break; }
				}
				
				if (index == 0)
				{
					var invisibleWall:FlxSprite = new FlxSprite( -65, 0);
					invisibleWall.makeGraphic(65, 195);
					invisibleWall.immovable = true;
					Global.tiles.add(invisibleWall);
				}
				
				x = 0; y = 0;			
				for (i = 0; i < data.ObjectLayer.length; i++)
				{
					if (data.ObjectLayer[i] > 0)
					{
						if (data.ObjectLayer[i] == 12)
							Global.demonSensors.add(ObjectLibrary.GetObject(data.ObjectLayer[i], x * 65, y * 65));
						else if (Helper.NumberExistIn(data.ObjectLayer[i], [90, 91, 92, 20, 21, 22, 23, 24, 25]))
							Global.specialObjects.add(ObjectLibrary.GetObject(data.ObjectLayer[i], x * 65, y * 65));
						else
							Global.objects.add(ObjectLibrary.GetObject(data.ObjectLayer[i], x * 65, y * 65));
					}

					x++; if (x == 10) { x = 0; y++; if (y == 8) break; }
				}
				
				if (Global.nextLocation == null)
				{
					Global.nextLocation = new FlxPoint();
					Global.currentAceleration = new FlxPoint();
					Global.currentVelocity = new FlxPoint();
					Global.currentMirror = 1;
				}
				
				switch (index)
				{
					case 0:
						var tut:FlxSprite = new FlxSprite(320 - 107 - 8, 100, Textures.tut00);
						tut.alpha = 0.7;
						add(tut);
						break;
					case 1:
						add(new FlxSprite(320 - 107 - 8, 480 - 164 + 5, Textures.tut01));
						break;
					case 2:
						add(new FlxSprite(320 - 107 - 8, 480 - 164 + 40, Textures.tut02));
						break;
					case 3:
						add(new FlxSprite(320 - 107 - 8, 480 - 164 + 5, Textures.tut03));
						break;
				}
				
				if ((index == 0 && Global.startGame) || (Global.continousDeath == 5 && Global.currentRoom == 40))
				{
					if (Global.currentRoom == 40)
					{
						Global.player = new Bob(16, 65);
						Global.player.scale.x = 1;
						Global.nextLocation = new FlxPoint(16, 65);
					}
					else
						Global.player = new Bob(16, 65 * 2);
					add(Global.player);
					Global.startGame = false;
					Global.continousDeath = 0;
					Global.doorIsOpen = false;
					Global.hasKey = false;
				}
				else if (Global.prevExitDoor && Global.doorIsOpen && (Global.currentRoom > Global.lastRoom))
				{
					Global.prevExitDoor = false;
					Global.doorIsOpen = false;
					Global.hasKey = false;
				
					if (Global.player != null) 
					{
						Global.player.destroy();
						Global.player = null;
					}
					Global.player = new Bob(Global.startPosition.x, Global.startPosition.y);
					Global.player.scale.x = Global.startMirror;
					add(Global.player);
					
					Global.nextLocation.x = Global.player.x;
					Global.nextLocation.y = Global.player.y;
					
					add(new TransitionFX(1));
					
					Global.enterWithKey = false;
				}
				else 
				{
					Global.player.destroy();
					Global.player = null;
					if (Global.nextLocation.y > 600) Global.nextLocation.y = -30;
					Global.player = new Bob(Global.nextLocation.x, Global.nextLocation.y);
					Global.player.acceleration = Global.currentAceleration;
					Global.player.velocity = Global.currentVelocity;
					Global.player.scale.x = Global.currentMirror;
					add(Global.player);
					Global.hasKey = Global.enterWithKey;
				}
				
				if (Helper.NumberExistIn(index, [25, 26, 27, 28, 29, 30, 31, 45, 46, 47, 48])) add(new FlashLight());
				
				add(new HUDKey());
				
				left_exit = data.Left;
				right_exit = data.Right;
				up_exit = data.Up;
				down_exit = data.Down;
				
				GameArea = new FlxSprite(5, 5);
				GameArea.makeGraphic(630, 500, 0x77ffffff);
				GameArea.immovable = true;
				GameArea.visible = false;
				add(GameArea);
				
				Global.pauseScreen = new PauseScreen();
				add(Global.pauseScreen);
				Global.confirmation = new Confirmation();
				add(Global.confirmation);			
				
				add(new PauseButton());
				
				add(new FXSwitch());
				add(new MusicSwitch());
				add(new Mouse());
				
				return;
                
				// Debug code. Uses to show in screen some usefull info:
				var label:FlxText;
				
				label = new FlxText(0, 240, 100, data.Left.toString());
				label.size = 20;
				label.color = 0xffffff00;
				label.shadow = 0xffff0000;
				label.antialiasing = true;
				add(label);
				
				label = new FlxText(320, 0, 100, data.Up.toString());
				label.size = 20;
				label.color = 0xffffff00;
				label.shadow = 0xffff0000;
				label.antialiasing = true;
				add(label);

				label = new FlxText(615, 240, 100, data.Right.toString());
				label.size = 20;
				label.color = 0xffffff00;
				label.shadow = 0xffff0000;
				label.antialiasing = true;
				add(label);

				label = new FlxText(320, 438, 100, data.Down.toString());
				label.size = 20;
				label.color = 0xffffff00;
				label.shadow = 0xffff0000;
				label.antialiasing = true;
				add(label);
				
				Global.count++;
				label = new FlxText(0, 0, 100, Global.count.toString());
				label.size = 20;
				label.color = 0xffffff00;
				label.shadow = 0xffff0000;
				label.antialiasing = true;
				add(label);
			}
		}
		
		private function onPause_Click():void
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
        
		private function NextRoom(index:int):void
		{
			if (index >= 0) 
			{
				if (index == 99) 
				{
					FlxG.switchState(new IntroScreen(1));
				}
				else
				{
					Global.continousDeath = 0;
					Global.lastRoom = Global.currentRoom;
					Global.currentRoom = index;
					ResetScene(index);
				}
			}
		}
		
		private function ResetScene(index:int):void
		{
			if (Global.hasKey && Global.doorIsOpen && IsStartLevel(index))
			{
				timer = new FlxTimer();
				timer.start(0.1, 0, timerReset);
			}
			else
				FlxG.resetState();
		}
		
		private function timerReset(timer:FlxTimer):void
		{
			if (Global.tileFXCount == 80) 
				FlxG.resetState();
		}
		
		override public function update():void 
		{	
			if (!MusicJukebox.Active) 
				FlxG.music.stop();
			
			if (ForcePause) 
			{
				ForcePause = false;
				onPause_Click();
			}
			
			if (FlxG.keys.justPressed("P"))
				onPause_Click();
			else if (FlxG.keys.justPressed("M"))
				MusicJukebox.Active = !MusicJukebox.Active;
			else if (FlxG.keys.justPressed("S"))
				FXSound.FXEnabled = !FXSound.FXEnabled;
				
			if (false)
			{
				if (FlxG.keys.SHIFT) 
				{
					if (FlxG.keys.justPressed("LEFT"))
					{
						NextRoom(left_exit);
					}
					else if (FlxG.keys.justPressed("UP"))
					{
						NextRoom(up_exit);
					}
					else if (FlxG.keys.justPressed("DOWN"))
					{
						NextRoom(down_exit);
					}
					else if (FlxG.keys.justPressed("RIGHT"))
					{
						NextRoom(right_exit);
					}
				}
				
				if (FlxG.keys.justPressed("SPACE")) Global.hasKey = true;
				
				if (FlxG.keys.justPressed("F1"))
					NextRoom(0);
				else if (FlxG.keys.justPressed("F2"))
					NextRoom(4);
				else if (FlxG.keys.justPressed("F3"))
					NextRoom(8);
				else if (FlxG.keys.justPressed("F4"))
					NextRoom(13);
				else if (FlxG.keys.justPressed("F5"))
					NextRoom(21);
				else if (FlxG.keys.justPressed("F6"))
					NextRoom(25);
				else if (FlxG.keys.justPressed("F7"))
					NextRoom(28);
				else if (FlxG.keys.justPressed("F8"))
					NextRoom(32);
				else if (FlxG.keys.justPressed("F9"))
					NextRoom(38);
				else if (FlxG.keys.justPressed("F11"))
					NextRoom(43);
			}
			
			if (FlxG.collide(Global.player, Global.tiles) && Global.player.isTouching(FlxObject.FLOOR))
			{
				if (Bob.yCount >= 135) FlxG.shake(0.0115, 0.1);
				Bob.yCount = 0;
			}
			
			if (!Global.bobIsDead && !FlxG.overlap(Global.player, GameArea))
				this.passExit(Global.player, GameArea);
			
			if (Global.bobIsDead && Global.resetLevel)
			{
				Global.resetLevel = false;
				Global.bobIsDead = false;
				Global.bobRebirth = true;
				FlxG.resetState();
			}
				
			super.update();
		}
		
		private var passed:Boolean = false;
		private function passExit(player:FlxSprite, exit:FlxSprite):void
		{	
			if (!passed) 
			{
				passed = true;
				Global.player.moves = false;
				Global.enterWithKey = Global.hasKey;
				
				Global.currentMirror = Global.player.scale.x;
				if (player.x < exit.x && left_exit >= 0)
				{
					Global.nextLocation.x = 640 - Global.player.width;
					Global.nextLocation.y = Global.player.y;
					if (Global.nextLocation.y < 0) Global.nextLocation.y = 0; 
					Global.currentAceleration = Global.player.acceleration;
					Global.currentVelocity = Global.player.velocity;
					
					Global.continousDeathEnabled = false;
					
					NextRoom(left_exit);
				}
				else if (player.x > exit.x + 630 && right_exit >= 0)
				{
					Global.nextLocation.x = 0;
					Global.nextLocation.y = Global.player.y;
					if (Global.nextLocation.y < 0) Global.nextLocation.y = 0;
					Global.currentAceleration = Global.player.acceleration;
					Global.currentVelocity = Global.player.velocity;
					
					Global.continousDeathEnabled = false;
					
					NextRoom(right_exit);
				}
				else if (player.y < exit.y && up_exit >= 0)
				{
					Global.nextLocation.x = Global.player.x;
					Global.nextLocation.y = 480 - Global.player.height - 16;
					Global.currentAceleration = Global.player.acceleration;
					Global.currentVelocity = Global.player.velocity;
					
					Global.continousDeathEnabled = false;
					
					NextRoom(up_exit);
				}
				else if (!Global.isBuried && player.y > exit.y + 470 && down_exit >= 0)
				{
					Global.nextLocation.x = Global.player.x;
					Global.nextLocation.y = 0;
					Global.currentAceleration = Global.player.acceleration;
					Global.currentVelocity = Global.player.velocity;
					
					Global.continousDeathEnabled = (down_exit == 40);
					
					NextRoom(down_exit);
				}
			}
		}
	}
}