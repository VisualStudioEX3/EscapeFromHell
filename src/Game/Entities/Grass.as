package Game.Entities 
{
	import Game.Content.Textures;
	import org.flixel.*;

	public class Grass extends FlxObject
	{	
		private var g:FlxSprite;
		private var list:Array;
		
		public function Grass(x:uint, y:uint) 
		{
			super(x, y + 35);
			
			list = new Array();
			
			var f:Array = new Array(); var i:uint; for (i = 0; i < 100; i++) f.push(i);
			
			g = new FlxSprite(x - 11, y + 35);
			g.loadGraphic(Textures.grass, true, false, 50, 35);			
			g.addAnimation("default", f, 40, true);
			g.play("default");
			g.immovable = true;
			g.solid = false;
			g.allowCollisions = NONE;
			g.antialiasing = true;
			g.allowCollisions = NONE;
			g.color = 0xff000000;
			list.push(g);
			
			f = null;
			f = new Array(); 
			for (i = 25; i < 100; i++) f.push(i);
			for (i = 0; i < 75; i++) f.push(i);
			
			g = new FlxSprite(x + 8, y + 33);
			g.loadGraphic(Textures.grass, true, false, 50, 35);			
			g.addAnimation("default", f, 40, true);
			g.play("default");
			g.immovable = true;
			g.solid = false;
			g.antialiasing = true;
			g.allowCollisions = NONE;
			g.color = 0xff000000;
			list.push(g);
			
			f = null;
			f = new Array();
			for (i = 50; i < 100; i++) f.push(i);
			for (i = 0; i < 50; i++) f.push(i);
			
			g = new FlxSprite(x + 21, y + 34);
			g.loadGraphic(Textures.grass, true, false, 50, 35);			
			g.addAnimation("default", f, 40, true);
			g.play("default");
			g.immovable = true;
			g.solid = false;
			g.antialiasing = true;
			g.allowCollisions = NONE;
			g.color = 0xff000000;
			list.push(g);
		}
		
		override public function destroy():void 
		{
			for each (g in list)
			{
				g.destroy();
				g = null;
			}

			list = null;
			super.destroy();
		}
		
		override public function update():void 
		{
			if (!FlxG.paused) 
			{
				for each (g in list) g.postUpdate();
				super.update();
			}
		}
		
		override public function draw():void 
		{
			for each (g in list) g.draw();			
			super.draw();
		}
	}
}