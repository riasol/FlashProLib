package amu.site.assets{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	public class AssetConnector extends Sprite{
		public static const EVENT_ASSET_INITIALIZED:String="EVENT_ASSET_INITIALIZED"
		private static var instance:AssetConnector
		public static function getInstance():AssetConnector{
			if(instance==null){ 
				instance=new AssetConnector()
			}
			return instance
		}
		public  function dispatchInitializedEvent():void{
			var ev:Event=new Event(EVENT_ASSET_INITIALIZED)
			dispatchEvent(ev)
		}
	}
}