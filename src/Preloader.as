package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shader;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import org.flixel.system.FlxPreloader;
	import org.flixel.FlxU;
	
	public dynamic class Preloader extends FlxPreloader
	{
		[Embed (source = "../Content/Graphics/preloader.jpg")] private var bg_img:Class;
		[Embed (source = "../Content/Graphics/Game/Backgrounds/shadow.png")] public static var shadow:Class;
		
		private var loading:Bitmap;
		private var _bgBar:Bitmap;
		private var _progressBar:Bitmap;
		
		public function Preloader():void
		{			
			if (SiteLock.CheckDomain(stage.loaderInfo.url, "visualstudioex3.com", "http://portfolio.visualstudioex3.com/2011/12/05/escape-from-hell/")) 
			{
				className = "Main";
				super();
			}
		}
		
		override protected function create():void 
		{
			_buffer = new Sprite();
			addChild(_buffer);
			
			_buffer.addChild(new Bitmap((new bg_img).bitmapData));			
			_buffer.addChild(new Bitmap((new shadow).bitmapData));
			
			_bgBar = new Bitmap(new BitmapData(1,7,false,0xffffff));
			_bgBar.x = 157;
			_bgBar.y = 397;
			_bgBar.width = 326;
			_bgBar.height = 38;
			_buffer.addChild(_bgBar);
			
			_bgBar = new Bitmap(new BitmapData(1,7,false,0x000000));
			_bgBar.x = 158;
			_bgBar.y = 398;
			_bgBar.width = 324;
			_bgBar.height = 36;
			_buffer.addChild(_bgBar);
			
			_progressBar = new Bitmap(new BitmapData(1,7,false,0xffffff));
			_progressBar.x = 160;
			_progressBar.y = 400;
			_progressBar.width = 320;
			_progressBar.height = 32;
			_buffer.addChild(_progressBar);
		}
		
		override protected function update(Percent:Number):void 
		{
			_progressBar.width = 320 * Percent;
			super.update(Percent);
		}
	}
}