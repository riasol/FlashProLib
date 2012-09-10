package amu.site.base
{
	import amu.site.events.AssetEvent;
	import amu.site.events.NavigationEvent;
	import amu.site.events.SitemapEvent;
	
	import flash.events.Event;
	
	public interface ISiteApplication
	{
		function evStageResize(e:Event=null):void
		function evSitemapLoaded(e:SitemapEvent):void
		function evAssetLoadStart(e:AssetEvent):void
		function evAssetLoaded(e:AssetEvent):void
	}
}