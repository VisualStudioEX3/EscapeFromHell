package Game.Entities.Library 
{
	import Game.Entities.*;
	import org.flixel.*;
	
	public class TileLibrary 
	{	
		public static function GetObject(index:uint, x:uint, y:uint):FlxObject 
		{
			switch (index)
			{
				case 1: return new InvisibleTile(x, y); break;
				case 2: return new Tile(0, x, y); break;
				case 3: return new Tile(1, x, y); break;
				case 4: return new Tile(2, x, y); break;
				case 5: return new Tile(3, x, y); break;
				case 6: return new Tile(4, x, y); break;
				case 7: return new Tile(5, x, y); break;
				case 8: return new Tile(6, x, y); break;
				case 9: return new Tile(7, x, y); break;
				case 10: return new Tile(8, x, y); break;
				case 11: return new Tile(9, x, y); break;
				case 12: return new Tile(10, x, y); break;
				case 13: return new Tile(11, x, y); break;
				case 14: return new Tile(12, x, y); break;
				case 15: return new Tile(13, x, y); break;
				case 16: return new Tile(14, x, y); break;
				case 17: return new Tile(15, x, y); break;
				case 18: return new Tile(16, x, y); break;
				case 19: return new Tile(17, x, y); break;
				case 20: return new Tile(18, x, y); break;
				case 21: return new Tile(19, x, y); break;
				case 22: return new Tile(20, x, y); break;
				case 23: return new Tile(21, x, y); break;
				case 24: return new Tile(22, x, y); break;
				case 25: return new Tile(23, x, y); break;
				case 26: return new Tile(24, x, y); break;
				case 27: return new Tile(25, x, y); break;
				case 28: return new Tile(26, x, y); break;
				case 29: return new Tile(27, x, y); break;
				case 30: return new Tile(28, x, y); break;
				case 31: return new Tile(29, x, y); break;
				case 32: return new Tile(30, x, y); break;
				case 33: return new Tile(31, x, y); break;
				case 34: return new Tile(32, x, y); break;
				case 35: return new Grass(x, y); break;
				case 36: return new Tile(33, x, y); break;
				case 37: return new Tile(34, x, y); break;
				case 38: return new Tile(35, x, y); break;
				
				case 40: return new Brigde(x, y, 0); break;
				case 41: return new Brigde(x, y, 1); break;
				case 42: return new Brigde(x, y, 2); break;
				case 43: return new Brigde(x, y, 3); break;
				case 44: return new Brigde(x, y, 4); break;
				case 45: return new Brigde(x, y, 5); break;
				case 46: return new Brigde(x, y, 6); break;
				
				case 90: return new Tile(90, x, y); break;
				case 91: return new Tile(91, x, y); break;
				case 92: return new Tile(92, x, y); break;
				case 93: return new Tile(93, x, y); break;
				case 94: return new Tile(94, x, y); break;
				case 95: return new Tile(95, x, y); break;
				case 96: return new Tile(96, x, y); break;
			}
			return null;
		}	
	}
}