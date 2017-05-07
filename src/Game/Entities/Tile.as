package Game.Entities 
{
	import Game.Global;
	import Game.Content.Textures;
	import org.flixel.*;
	
	public class Tile extends FlxSprite
	{	
		private var specialTile:Boolean = false;
		private var floor:FlxSprite;
	
        public function Tile(index:uint, x:uint, y:uint) 
		{
			super(x, y);
			this.loadGraphic(Textures.tiles, false, false, 65, 65, true);
			
			if (index > 89 && index < 97)
			{
				switch (index)
				{
					case 90: frame = 0; break;
					case 91: frame = 1; break;
					case 92: frame = 2; break;
					case 93: frame = 6; break;
					case 94: frame = 4; break;
					case 95: frame = 9; break;
					case 96: frame = 14; break;
				}
				
				if (index != 93) 
				{
					var tile:FlxSprite =  new FlxSprite(x, y - 65);
					tile.makeGraphic(65, 130, 0x00ffffff);
					Global.sandTiles.add(tile);
				}
				
				floor = new FlxSprite(x, y + 55);
				floor.makeGraphic(65, 5, 0x00ff0000);
				floor.immovable = true;
				
				specialTile = true;
			}
			else
				frame = index;
				
			this.immovable = true;
		}
		
		override public function destroy():void 
		{
			if (floor != null)
			{
				floor.destroy();
				floor = null;
			}
			super.destroy();
		}
		
		override public function update():void 
		{
			if (specialTile)
			{
				FlxG.collide(Global.player, floor);
				solid = !Global.isBuried;
			}
			super.update();
		}
	}
}