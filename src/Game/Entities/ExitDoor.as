package Game.Entities 
{
	import Game.Content.Audio;
	import Game.Content.Textures;
	import Game.Global;
	import org.flixel.*;
	
	public class ExitDoor extends FlxSprite
	{
		private var lock:FlxSprite;
		private var chains:FlxSprite;
		private var box:FlxSprite;
		private var timer:FlxTimer;
		private var fx_door:FXSound;
		
		public function ExitDoor(x:uint, y:uint) 
		{
			super(x - 90, y - 94 - (Global.doorIsOpen ? 100 : 0));
			loadGraphic(Textures.door, true, false, 302, 314);
			addAnimation("default", Helper.SetArray(0, 6), 8, true);
			scale = new FlxPoint(0.4, 0.45);
			solid = false;
			
			if (!Global.doorIsOpen) 
			{
				chains = new FlxSprite(x + 5, y + 30, Textures.chains);
				
				lock = new FlxSprite(x + 40, y + 40);
				lock.loadGraphic(Textures.lock, true, false, 37, 35);
				lock.addAnimation("default", Helper.SetArray(0, 4), 6, true);
				lock.play("default");
			}
			
			fx_door = new FXSound(Audio.door, true);
			box = new FlxSprite(x, y - (Global.doorIsOpen ? 100 : 0));
			box.makeGraphic(130, 130, 0x00ff0000);
			box.immovable = true;
			
			timer = new FlxTimer();
			
			Global.prevExitDoor = true;
		}
		
		override public function destroy():void 
		{
			if (!Global.doorIsOpen) 
			{
				lock.destroy();
				lock = null;
				chains.destroy();
				chains = null;
			}
			
			fx_door.stop();
			
			super.destroy();
		}
		
		
		override public function preUpdate():void 
		{
			super.preUpdate();
		}
		
		override public function update():void 
		{	
			if (!FlxG.paused) 
			{
				if (!Global.doorIsOpen && FlxG.collide(Global.player, box) && Global.hasKey)
				{
					Global.hasKey = false;
					fx_door.play();
					if (Global.player.x > 320 && Global.player.x < 640)
						Global.player.scale.x = 1;
					else
						Global.player.scale.x = -1;
					lock.visible = false;
					chains.visible = false;
					timer.start(0.025, 100, timerEvent);
					Global.doorIsOpen = true;
					Global.startNewLevel = true;
					Global.exitRoom = Global.currentRoom;
				}
				if (lock != null) lock.postUpdate();
				super.update();
			}
		}
		
		override public function draw():void 
		{
			super.draw();
			if (lock != null && chains.visible)
			{
				chains.draw();
				lock.draw();
			}			
		}
		
		private var count:uint;
		private var flag:int = 1;
		private function timerEvent(timer:FlxTimer):void
		{
			if (count > 125) timer.stop();
			y--;
			box.y--;
			count++;
			x += flag;
			flag *= -1;
		}
	}

}