package Game 
{
	import Game.Content.Textures;
	import org.flixel.*;
	
	public class Background extends FlxObject
	{	
		private var timer:FlxTimer;
		private var background:FlxSprite;
		private var hdr:FlxSprite;
		private var clouds:FlxSprite;
		private var timer2:FlxTimer;
		
		private var cloudPosA:int = 0;
		private var cloudPosB:int = 1280;
		
		public function Background(index:uint, showClouds:Boolean) 
		{
			super();
			
			background = new FlxSprite(0, 0, GetBackground(index));
			
			hdr = new FlxSprite(0, 0, GetHDR(index));
			hdr.alpha = 0.5;
			
			timer = new FlxTimer();
			timer.start(0.1, 0, timerHDR);
			
			if (showClouds) 
			{
				clouds = new FlxSprite(0, 0, Textures.clouds);
				clouds.alpha = 0.7;
				
				timer2 = new FlxTimer();
				timer2.start(0.1, 0, timerScroll);
			}
		}
		
		override public function destroy():void 
		{
			timer.destroy();
			timer = null;	
			
			if (timer2 != null) 
			{
				timer2.destroy();
				timer2 = null;
			}
			
			background.destroy();
			background = null;
			
			hdr.destroy();
			hdr = null;
			
			super.destroy();
		}
		
		override public function draw():void 
		{
			background.draw();
			hdr.draw();
			
			if (clouds != null) 
			{
				clouds.x = cloudPosA;
				clouds.draw();
				
				clouds.x = cloudPosB;
				clouds.draw();
			}
			
			super.draw();
		}
		
		private var flag:int = 1;
		private function timerHDR(timer:FlxTimer):void 
		{
			if (!FlxG.paused) 
			{
				if (flag == 0)
				{
					hdr.alpha += 0.025;
					if (hdr.alpha >= 1) flag = 1;
				}
				else
				{
					hdr.alpha -= 0.025;
					if (hdr.alpha == 0) flag = 0;
				}
			}
		}
		
		private function timerScroll(timer:FlxTimer):void
		{
			if (!FlxG.paused) 
			{
				cloudPosA-=2;
				cloudPosB-=2;
				
				if (cloudPosA == -1280) cloudPosA = 1280;
				if (cloudPosB == -1280) cloudPosB = 1280;
			}
		}
		
		private function GetBackground(index:uint):Class
		{
			switch (index)
			{
				case 0: return Textures.backg00;				
				case 1: return Textures.backg01;
				case 2: return Textures.backg02;				
				case 3: return Textures.backg03;
				case 4: return Textures.backg03;
				default: return null;
			}
		}
		
		private function GetHDR(index:uint):Class
		{
			switch (index)
			{
				case 0: return Textures.backg00hdr;				
				case 1: return Textures.backg01hdr;
				case 2: return Textures.backg02hdr;				
				case 3: return Textures.backg03hdr;
				case 4: return Textures.backg03hdr;
				default: return null;
			}
		}
	}

}