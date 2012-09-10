package amu.site.events
{
	import amu.site.assets.IRuntimeAssets;
	
	import cms2.site.vo.PageRequestVO;
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.display.Loader;

	public class ContentEvent extends CairngormEvent
	{
		public static const EVENT_LOAD_PAGE:String="EVENT_LOAD_PAGE";
		public static const EVENT_LOAD_PAGES:String="EVENT_LOAD_PAGES";
		public static const EVENT_QUERY:String="EVENT_QUERY";
		public static const EVENT_QUERY_RESULT:String="EVENT_QUERY_RESULT";
		public static const EVENT_PAGE_LOADED:String="EVENT_PAGE_LOADED";
		public static const EVENT_PAGES_LOADED:String="EVENT_PAGES_LOADED";
		public static const EVENT_PAGE_AVAILABLE:String="EVENT_PAGE_AVAILABLE";
		public var requestId:String;
		public var pageRequest:PageRequestVO;
		public var pages:Array;
		function ContentEvent(type:String){
			super(type)
		}
	}
}