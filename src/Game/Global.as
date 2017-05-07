package Game 
{
	import Game.Entities.Bob;
	import org.flixel.*;
	
	public class Global
	{	
		public static var stuffs:FlxGroup;
		public static var specialObjects:FlxGroup;
		public static var tiles:FlxGroup;
		public static var objects:FlxGroup;
		public static var demonSensors:FlxGroup;
		
		public static var player:Bob;
		public static var startGame:Boolean = true;
		public static var isBuried:Boolean = false;
		
		public static var count:uint = -1;
		
		public static var sandTiles:FlxGroup;
		
		public static var bobIsDead:Boolean = false;
		public static var bobRebirth:Boolean = false;
		public static var resetLevel:Boolean = false;
		public static var prevExitDoor:Boolean = false;
		
		public static var nextLocation:FlxPoint;
		public static var currentAceleration:FlxPoint;
		public static var currentVelocity:FlxPoint;
		public static var currentMirror:int = -1;
		
		public static var currentRoom:int = 0;
		public static var lastRoom:int = 0;
		public static var exitRoom:int = -1;
		
		public static var hasKey:Boolean = false;
		public static var enterWithKey:Boolean = false;
		public static var doorIsOpen:Boolean = false;
		public static var startNewLevel:Boolean = false;
		public static var startPosition:FlxPoint = new FlxPoint(0, 0);
		public static var startMirror:int = 1;
		
		public static var tileFXCount:uint = 0;
		
		public static var continousDeath:uint = 0;
		public static var continousDeathEnabled:Boolean = false;
		
		public static var pauseScreen:PauseScreen;
		public static var confirmation:Confirmation;
	}
}