package Game.Entities 
{
	import flash.automation.ActionGenerator;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import Game.Content.Audio;
	import Game.Content.Textures;
	import Game.Global;
	import org.flixel.*;
	
	public class Bob extends FlxSprite
	{	
		private var sprite:FlxSprite;
		private var earth:FlxSprite;
		private var goDown:Boolean = false;
		private var goUp:Boolean = false;
		private var timer:FlxTimer;
		private var canGoUp:Boolean = false;
		private var isDead:Boolean;
		private var forceDead:Boolean = false;		
		private var showBuried:Boolean = false;
		
		private var fx_dig:FXSound;
		private var fx_tweets:FXSound;
		private var fx_jump:FXSound;
		
		public static var yCount:uint = 0;
		
		public function Bob(x:uint, y:uint)
		{
			super(x, y);
			makeGraphic(22, 50, 0x00ff0000, true);
			maxVelocity = new FlxPoint(100, 450);
			acceleration.y = 400;
			drag.x = maxVelocity.x * 4;
			
			sprite = new FlxSprite(0, 0);
			sprite.loadGraphic(Textures.bob, true, true, 65, 73);
			sprite.origin.x = 45;
			sprite.offset.x = 4;
			sprite.addAnimation("idle", Helper.SetArray(0, 100), 40, true);
			sprite.addAnimation("run", Helper.SetArray(101, 112), 40, true);
			sprite.addAnimation("jump", Helper.SetArray(121, 134), 40, false);
			sprite.addAnimation("goDown", Helper.SetArray(161, 173), 20, false);
			sprite.addAnimation("goUp", Helper.SetArray(181, 193), 20, false);
			sprite.addAnimation("dead", Helper.SetArray(141, 160), 20, true);
			sprite.addAnimation("buried_idle", Helper.SetArray(201, 301), 40, true);
			sprite.addAnimation("buired_run", Helper.SetArray(193, 200), 40, true);
			sprite.play("idle");
			
			earth = new FlxSprite(0, 0);
			earth.loadGraphic(Textures.earth, true, false, 64, 64);
			earth.addAnimation("idle", [0], 0, false);
			earth.addAnimation("run", [0, 1, 2], 10, true);
			earth.visible = false;
			
			fx_dig = new FXSound(Audio.dig, false);			
			fx_tweets = new FXSound(Audio.tweets, true);
			fx_jump = new FXSound(Audio.jump, false);
			
			timer = new FlxTimer();
			
			Global.isBuried = false;
		}
		
		override public function destroy():void 
		{
			if (fx_tweets != null) 
			{
				fx_tweets.stop(); fx_tweets.destroy(); fx_tweets = null;
			}

			super.destroy();
		}
		
		private var transitionActive:Boolean = false;
		override public function update():void 
		{
			moves = !FlxG.paused;
			
			if (!FlxG.paused) 
			{
				acceleration.x = 0;
				
				if (!Global.bobIsDead && !Global.isBuried) yCount++;
				
				if (!isDead) 
				{
					if (Global.doorIsOpen) 
					{
						if (!transitionActive) FlxG.state.add(new TransitionFX(0));
						transitionActive = true;
						if (sprite.scale.x == 1)
							acceleration.x = maxVelocity.x * 4;
						else
							acceleration.x = -maxVelocity.x * 4;
					}
					else
					{
						if (!Global.isBuried && !goUp && !goDown) 
						{
							if (FlxG.keys.LEFT)
							{
								acceleration.x = -maxVelocity.x * 4;
								scale.x = -1;
								if (isTouching(FlxObject.FLOOR))
								{
									sprite.play("run");
								}
							}
							else if (FlxG.keys.RIGHT)
							{								
								acceleration.x = maxVelocity.x * 4;
								scale.x = 1;
								if (isTouching(FlxObject.FLOOR))
								{
									sprite.play("run");
								}
							}
							else 
							{
								if (isTouching(FlxObject.FLOOR)) sprite.play("idle");
							}
							
							if (FlxG.keys.justPressed("UP") && isTouching(FlxObject.FLOOR))
							{
								fx_jump.play();
								velocity.y = -maxVelocity.y / 1.5;
								sprite.play("jump");
							}
							
							if ((FlxG.overlap(Global.player, Global.sandTiles, null, Helper.Contains) || GetMultipleCollide()) &&
								FlxG.keys.justPressed("DOWN") && isTouching(FlxObject.FLOOR))
							{
								fx_dig.play();
								sprite.play("goDown");
								sprite.immovable = true;
								goDown = true;
								
								timer.start(1, 1, timerEvent);
							}				
							
							if (!FlxG.keys.any() && isTouching(FlxObject.FLOOR))
							{
								sprite.play("idle");
							}
						}
						else if (Global.isBuried && !goUp && !goDown)
						{
							if ((FlxG.overlap(Global.player, Global.sandTiles, null, Helper.Contains) || GetMultipleCollide()) &&
								FlxG.keys.justPressed("UP") && !FlxG.keys.LEFT && !FlxG.keys.RIGHT && 
								!goDown && !goUp && isTouching(FlxObject.FLOOR) && canGoUp)
							{
								fx_dig.play();
								y -= 55;
								sprite.play("goUp");
								sprite.immovable = false;
								goUp = true;
								Global.isBuried = false;
								canGoUp = false;
								earth.visible = false;
							}
							
							if (FlxG.keys.LEFT && earth.visible)
							{
								x--;
								scale.x = -1;
								earth.play("run");						
							}
							else if (FlxG.keys.RIGHT && earth.visible)
							{
								x++;
								scale.x = 1;
								earth.play("run");							
							}
							else 
							{
								if (canGoUp && !goUp && isTouching(FlxObject.FLOOR)) 
								{
									sprite.play("buried_idle");
									earth.play("idle");
									earth.visible = true;
								}
							}
						}
						
						if (goDown && sprite.frame == 172)
						{
							fx_dig.stop();
							Global.isBuried = true;
							sprite.immovable = false;
							goDown = false;
						}
						else if (goUp && sprite.frame == 192)
						{
							fx_dig.stop();
							sprite.immovable = false;
							goUp = false;
						}			
					}
				}	
				else
				{
					if (sprite.frame == 160) { }
				}
				
				sprite.scale.x = scale.x;
				sprite.x = x - 30;
				sprite.y = y - 19;
				sprite.update();
				sprite.postUpdate();
				
				earth.x = sprite.x + 10;
				earth.y = sprite.y - earth.height + 20;			
				earth.update();
				earth.postUpdate();
				
				if (!isDead && !Global.doorIsOpen && FlxG.overlap(Global.player, Global.objects) || forceDead)
				{
					fx_dig.stop();
					fx_tweets.play();
					
					FlxG.fade(0xff000000, 4);
					
					isDead = true;
					Global.bobIsDead = true;
					sprite.play("dead");
					
					if (Global.currentRoom == 40 && Global.continousDeathEnabled) Global.continousDeath++;
					
					timer.start(3, 1, resetLevel);
				}
				
				if (Global.bobRebirth && isDead)
				{
					isDead = false;
					Global.hasKey = false;
					Global.bobIsDead = false;
					Global.bobRebirth = false;
				}
				
				super.update();
			}
		}
		
		private function resetLevel(timer:FlxTimer):void
		{
			Global.resetLevel = true;
		}
		
		public function GetXScale():int
		{
			return sprite.scale.x;
		}
		
		public function SetXScale(value:int):void
		{
			sprite.scale.x = value;
			scale.x = value;
		}
		
		public function Killing():void
		{
			forceDead = true;
		}
		
		private function timerEvent(timer:FlxTimer):void
		{
			canGoUp = true;
		}
		
		override public function draw():void 
		{
			if (earth.visible) earth.draw();
			sprite.draw();
			super.draw();
		}
		
		private function GetMultipleCollide():Boolean
		{
			var count:uint = 0;
			var tile:FlxObject;
			for each (tile in Global.sandTiles.members)
			{
				if (FlxG.overlap(Global.player, tile)) 
				{
					count++;
					if (count == 2) return true;
				}
			}
			return false;
		}
	}
}