package flashprolib.assetloader
{
	import flash.events.Event;
	
	public class AssetLoaderEvent extends Event
	{
		public static const EVENT_LOADED_ASSET:String='EVENT_LOADED_ASSET';
		public var data:*;
		public function AssetLoaderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}