package Game 
{
	public class SceneData 
	{
		public var TileLayer:Array;
		public var BackLayer:Array;
		public var ObjectLayer:Array;
		public var Background:uint;
		public var Left:int;
		public var Right:int;
		public var Up:int;
		public var Down:int;
		
		public function SceneData()
		{
			TileLayer = new Array();
			BackLayer = new Array();
			ObjectLayer = new Array();
			Background = 0;
			Left = 0;
			Right = 0;
			Up = 0;
			Down = 0;
		}		
	}
}