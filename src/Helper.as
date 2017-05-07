package  
{
	import flash.geom.Rectangle;
	import flash.utils.*;
	import org.flixel.*;
	
	public class Helper 
	{		
		public static function SetArray(from:uint, to:uint):Array 
		{
			var f:Array = new Array(); var i:uint; 
			for (i = from; i < to; i++) f.push(i);
			return f;
		}
		
		public static function Contains(a:FlxObject, b:FlxObject):Boolean
		{
			return (a.x >= b.x && a.y >= b.y) && ((a.x + a.width <= b.x + b.width) && (a.y + a.height <= b.y + b.height));
		}
		
		public static function PointInRect(a:FlxObject, x:int, y:int):Boolean
		{
			return (x >= a.x && x <= a.x + a.width) && (y >= a.y && y <= a.y + a.height);
		}
		
		public static function Intersect(a:FlxObject, b:FlxObject):Boolean
		{
			var _a:Rectangle = new Rectangle(a.x, a.y, a.width, a.height);
			var _b:Rectangle = new Rectangle(b.x, b.y, b.width, b.height);
			return _a.intersects(_b);
		}
		
		public static function NumberExistIn(value:Number, list:Array):Boolean
		{
			var i:uint;
			for (i = 0; i < list.length; i++)
				if (value == list[i]) return true;
			return false;
		}
		
		public static function Random(min:Number, max:Number):Number
		{
			return min + (int)(FlxU.srand(getTimer()) * (max - min));
		}
	}
}