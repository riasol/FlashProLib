package amu.site.events
{
	import amu.site.assets.IRuntimeAssets;
	
	import cms2.site.vo.PageRequestVO;
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.display.Loader;

	public class ContentTrackingEvent extends CairngormEvent
	{
		public static const EVENT_ANY_EVENT:String="EVENT_ANY_EVENT";
		public var category:String
		public var action:String
		public var optionalLabel:String
		public var optionalValue:*;
		function ContentTrackingEvent(type:String,category:String,action:String,optionalLabel:String=null,optionalValue:*=null){
			super(type)
			this.category=category
			this.action=action
			this.optionalLabel=optionalLabel
			this.optionalValue=optionalValue
		}
	}
}