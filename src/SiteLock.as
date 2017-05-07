package  
{
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	public class SiteLock 
	{
		public static function CheckDomain(url:String, domain:String, redirectURL:String):Boolean
		{
			var _url:String = url;
			var _urlStart:Number = _url.indexOf("://") + 3;		
			var _urlEnd:Number = _url.indexOf("/", _urlStart);
			var _domain:String = _url.substring(_urlStart, _urlEnd);
			
			var _LastDot:Number = _domain.lastIndexOf(".") - 1;
			var _domEnd:Number = _domain.lastIndexOf(".", _LastDot) + 1;
			
			_domain = _domain.substring(_domEnd, _domain.length);
			
			trace(_domain);
			
			if (_domain != domain) 
			{
				navigateToURL(new URLRequest(redirectURL), "_parent");
				return false;
			}
			
			return true;
		}
	}
}