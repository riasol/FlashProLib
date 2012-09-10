package amu.site.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class SitemapEvent extends CairngormEvent
	{
		public static const EVENT_LOAD_SITEMAP:String="EVENT_LOAD_SITEMAP";
		public static const EVENT_SITEMAP_LOADED:String="EVENT_SITEMAP_LOADED";
		public var lang:String
		function SitemapEvent(type:String){
			super(type)
		}
	}
}