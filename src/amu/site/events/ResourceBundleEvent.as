package amu.site.events
{
	
	import com.adobe.cairngorm.control.CairngormEvent;
	

	public class ResourceBundleEvent extends CairngormEvent
	{
		public static const EVENT_LOAD_TRANSLATION_GROUP:String="EVENT_LOAD_TRANSLATION_GROUP";
		public static const EVENT_TRANSLATION_GROUP_LOADED:String="EVENT_TRANSLATION_GROUP_LOADED";
		public var groupId:String;
		function ResourceBundleEvent(type:String){
			super(type)
		}
	}
}