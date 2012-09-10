package amu.site.events
{
	
	import cms2.site.vo.ImageVO;
	
	import com.adobe.cairngorm.control.CairngormEvent;
	

	public class LogSiteEvent extends CairngormEvent
	{
		public static const EVENT_LOG_MESSAGE:String="EVENT_LOG_MESSAGE";
		public var message:String;
		function LogSiteEvent(type:String){
			super(type)
		}
	}
}