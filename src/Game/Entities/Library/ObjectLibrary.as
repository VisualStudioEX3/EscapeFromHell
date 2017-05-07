package Game.Entities.Library 
{
	import Game.Entities.*;
	import org.flixel.*;
	
	public class ObjectLibrary 
	{	
		public static function GetObject(index:uint, x:uint, y:uint):FlxObject 
		{
			switch (index)
			{
				case 1: return new Bat(x, y, 0, 0);
				case 2: return new Bat(x, y, 1, 0);
				case 3: return new Bat(x, y, 2, 0);
				case 4: return new Bat(x, y, 3, 0);
				case 5: return new Spikes(x, y, 0);
				case 6: return new Spikes(x, y, 1);
				case 7: return new Bat(x, y, 0, 1);
				case 8: return new Bat(x, y, 1, 1);
				case 9: return new Bat(x, y, 2, 1);
				case 10: return new Bat(x, y, 3, 1);
				
				case 11: return new Demon(x, y, 1);
				case 12: return new DemonPathSensor(x, y);
				
				case 20: return new Trap1(x, y, 2, 0);
				case 21: return new Trap1(x, y, 1, 0);
				case 22: return new Trap1(x, y, 2.5, 0);
				case 23: return new Trap1(x, y, 2, 1);
				case 24: return new Trap1(x, y, 1, 1);
				case 25: return new Trap1(x, y, 2.5, 1);
				
				case 50: return new Skull(x, y, 1);
				case 51: return new Skull(x, y, 2);
				case 52: return new Skull(x, y, 3);
				case 53: return new Skull(x, y, 4);
				case 54: return new Skull(x, y, 5);
				case 55: return new Skull(x, y, 6);
				case 56: return new Skull(x, y, 7);
				case 57: return new Skull(x, y, 8);
				
				case 60: return new Platform(x, y, 0, 1);
				
				case 90: return new Key(x, y);
				case 91: return new ExitDoor(x, y);
				case 92: return new EnterDoor(x, y, 0);
				case 93: return new EnterDoor(x, y, 1);
			}
			return null;
		}	
	}
}