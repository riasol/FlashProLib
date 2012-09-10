package amu.site.events
{
	import amu.site.assets.IRuntimeAssets;
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.display.Loader;

	public class AssetEvent extends CairngormEvent
	{
		public static const EVENT_LOAD_ASSET:String="EVENT_LOAD_ASSET";
		public static const EVENT_ASSET_LOADED:String="EVENT_ASSET_LOADED";
		public static const EVENT_ASSET_LOAD_START:String="EVENT_ASSET_LOAD_START";
		public var assetName:String;
		public var asset:IRuntimeAssets
		public var loader:Loader
		function AssetEvent(type:String){
			super(type)
		}
	}
}