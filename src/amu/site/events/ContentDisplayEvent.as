package amu.site.events
{
	import amu.site.assets.IRuntimeAssets;
	
	import cms2.site.vo.PageRequestVO;
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.display.Loader;

	public class ContentDisplayEvent extends CairngormEvent
	{
		public static const EVENT_PAGE_SHOW:String="EVENT_PAGE_SHOW";
		public var pageRequest:PageRequestVO;
		function ContentDisplayEvent(type:String){
			super(type)
		}
	}
}